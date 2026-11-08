import { Logger } from '@nestjs/common';
import { importPKCS8, SignJWT } from 'jose';
import nodemailer, { type Transporter } from 'nodemailer';

export interface OutgoingMessage {
  title: string;
  body: string;
  link: string | null;
}

/** Resultado por token: los inválidos se borran para no reintentar con ellos. */
export interface PushResult {
  delivered: number;
  invalidTokens: string[];
}

export interface PushSender {
  readonly enabled: boolean;
  send(tokens: string[], message: OutgoingMessage): Promise<PushResult>;
}

export interface EmailSender {
  send(to: string, message: OutgoingMessage): Promise<void>;
}

export const PUSH_SENDER = Symbol('PUSH_SENDER');
export const EMAIL_SENDER = Symbol('EMAIL_SENDER');

/** Desarrollo y pruebas: escribe en la salida lo que se enviaría por correo. */
export class LogEmailSender implements EmailSender {
  private readonly logger = new Logger('Correo');
  readonly sent: { to: string; message: OutgoingMessage }[] = [];

  async send(to: string, message: OutgoingMessage): Promise<void> {
    this.sent.push({ to, message });
    this.logger.log(`${to}: ${message.title} — ${message.body}`);
  }
}

export class SmtpEmailSender implements EmailSender {
  private readonly transport: Transporter;

  constructor(
    smtpUrl: string,
    private readonly from: string,
  ) {
    this.transport = nodemailer.createTransport(smtpUrl);
  }

  async send(to: string, message: OutgoingMessage): Promise<void> {
    await this.transport.sendMail({
      from: this.from,
      to,
      subject: message.title,
      text: `${message.body}\n\nAbre la app de FullDays para ver los detalles.`,
    });
  }
}

/** Sin cuenta de Firebase: el mensaje queda en la bandeja de la app. */
export class DisabledPushSender implements PushSender {
  readonly enabled = false;
  async send(): Promise<PushResult> {
    return { delivered: 0, invalidTokens: [] };
  }
}

interface ServiceAccount {
  project_id: string;
  client_email: string;
  private_key: string;
}

/**
 * Firebase Cloud Messaging (API HTTP v1): llega a Android y a iOS (vía APNs configurado en
 * Firebase). Se autentica con la cuenta de servicio firmando un JWT y cambiándolo por un token.
 */
export class FcmPushSender implements PushSender {
  readonly enabled = true;
  private readonly account: ServiceAccount;
  private token: { value: string; expires: number } | null = null;

  constructor(
    raw: string,
    private readonly fetcher: typeof fetch = fetch,
  ) {
    const json = raw.trim().startsWith('{') ? raw : Buffer.from(raw, 'base64').toString('utf8');
    this.account = JSON.parse(json) as ServiceAccount;
  }

  private async accessToken(): Promise<string> {
    if (this.token && this.token.expires > Date.now() + 60_000) return this.token.value;
    const key = await importPKCS8(this.account.private_key, 'RS256');
    const assertion = await new SignJWT({
      scope: 'https://www.googleapis.com/auth/firebase.messaging',
    })
      .setProtectedHeader({ alg: 'RS256', typ: 'JWT' })
      .setIssuer(this.account.client_email)
      .setAudience('https://oauth2.googleapis.com/token')
      .setIssuedAt()
      .setExpirationTime('1h')
      .sign(key);
    const res = await this.fetcher('https://oauth2.googleapis.com/token', {
      method: 'POST',
      headers: { 'content-type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        assertion,
      }),
    });
    if (!res.ok) throw new Error(`Google OAuth respondió ${res.status}`);
    const body = (await res.json()) as { access_token: string; expires_in: number };
    this.token = { value: body.access_token, expires: Date.now() + body.expires_in * 1000 };
    return body.access_token;
  }

  async send(tokens: string[], message: OutgoingMessage): Promise<PushResult> {
    const auth = await this.accessToken();
    const url = `https://fcm.googleapis.com/v1/projects/${this.account.project_id}/messages:send`;
    let delivered = 0;
    const invalidTokens: string[] = [];
    let lastError: string | null = null;
    for (const token of tokens) {
      const res = await this.fetcher(url, {
        method: 'POST',
        headers: { authorization: `Bearer ${auth}`, 'content-type': 'application/json' },
        body: JSON.stringify({
          message: {
            token,
            notification: { title: message.title, body: message.body },
            data: message.link ? { link: message.link } : {},
            android: { priority: 'high' },
            apns: { payload: { aps: { sound: 'default' } } },
          },
        }),
      });
      if (res.ok) delivered++;
      else if (res.status === 404 || res.status === 400) invalidTokens.push(token);
      else lastError = `FCM respondió ${res.status}`;
    }
    if (lastError && delivered === 0) throw new Error(lastError);
    return { delivered, invalidTokens };
  }
}
