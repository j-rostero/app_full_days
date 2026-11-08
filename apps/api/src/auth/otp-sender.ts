import { Logger } from '@nestjs/common';
import nodemailer, { type Transporter } from 'nodemailer';

export type OtpPurpose = 'verify' | 'reset';

/** Envía un código de un solo uso. */
export interface OtpSender {
  send(email: string, code: string, purpose: OtpPurpose): Promise<void>;
}

export const OTP_SENDER = Symbol('OTP_SENDER');

/** Desarrollo: imprime el código en la salida de la API. Prohibido en producción. */
export class LogOtpSender implements OtpSender {
  private readonly logger = new Logger('Códigos');

  async send(email: string, code: string, purpose: OtpPurpose): Promise<void> {
    const what = purpose === 'verify' ? 'Confirmar correo' : 'Restablecer contraseña';
    this.logger.log(`${what} ${email}: ${code}`);
  }
}

/** Envía el código por SMTP (Mailpit en local). */
export class SmtpOtpSender implements OtpSender {
  private readonly transport: Transporter;

  constructor(
    smtpUrl: string,
    private readonly from: string,
  ) {
    this.transport = nodemailer.createTransport(smtpUrl);
  }

  async send(email: string, code: string, purpose: OtpPurpose): Promise<void> {
    const reason =
      purpose === 'verify' ? 'para confirmar tu correo' : 'para elegir una contraseña nueva';
    await this.transport.sendMail({
      from: this.from,
      to: email,
      subject: `${code} es tu código de FullDays`,
      text: `Tu código ${reason} es ${code}. Vence en 5 minutos.\n\nSi no lo pediste, ignora este correo.`,
    });
  }
}
