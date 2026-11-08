import 'package:flutter/material.dart';

import '../session/session.dart';
import 'auth_form.dart';

const _email = AuthField('email', 'Correo', kind: AuthFieldKind.email);
const _code = AuthField('code', 'Código de 6 dígitos', kind: AuthFieldKind.code);

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.session, this.onHealth});

  final SessionController session;
  final VoidCallback? onHealth;

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: 'Entrar',
      intro: 'Encuentra tu próximo fullday, tour o excursión.',
      submitLabel: 'Entrar',
      fields: const [
        _email,
        AuthField('password', 'Contraseña', kind: AuthFieldKind.password),
      ],
      onSubmit: (v) async {
        try {
          await session.signIn(v['email']!, v['password']!);
        } on FdError catch (e) {
          if (e.code != 'email_not_verified' || !context.mounted) rethrow;
          // La API ya envió un código nuevo.
          await Navigator.of(context).push(_route(VerifyScreen(session: session, email: v['email']!)));
        }
      },
      footer: [
        TextButton(
          onPressed: () => Navigator.of(context).push(_route(RecoverScreen(session: session))),
          child: const Text('Olvidé mi contraseña'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).push(_route(RegisterScreen(session: session))),
          child: const Text('Crear una cuenta'),
        ),
        if (onHealth != null) TextButton(onPressed: onHealth, child: const Text('Estado del servicio')),
      ],
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: 'Crear una cuenta',
      intro: 'Te enviaremos un código para confirmar tu correo.',
      submitLabel: 'Crear cuenta',
      fields: const [
        _email,
        AuthField('password', 'Contraseña (mínimo 8 caracteres)', kind: AuthFieldKind.newPassword),
      ],
      onSubmit: (v) async {
        await session.register(v['email']!, v['password']!);
        if (context.mounted) {
          await Navigator.of(context).pushReplacement(_route(VerifyScreen(session: session, email: v['email']!)));
        }
      },
    );
  }
}

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key, required this.session, required this.email});

  final SessionController session;
  final String email;

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: 'Confirma tu correo',
      intro: 'Escribe el código que enviamos a $email. Vence en 5 minutos.',
      submitLabel: 'Confirmar',
      fields: const [_code],
      onSubmit: (v) async {
        await session.verify(email, v['code']!);
        if (context.mounted) Navigator.of(context).popUntil((r) => r.isFirst);
      },
    );
  }
}

class RecoverScreen extends StatelessWidget {
  const RecoverScreen({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: 'Recuperar contraseña',
      intro: 'Si hay una cuenta con ese correo, te enviaremos un código.',
      submitLabel: 'Enviar código',
      fields: const [_email],
      onSubmit: (v) async {
        await session.recover(v['email']!);
        if (context.mounted) {
          await Navigator.of(context).pushReplacement(_route(ResetScreen(session: session, email: v['email']!)));
        }
      },
    );
  }
}

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key, required this.session, required this.email});

  final SessionController session;
  final String email;

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: 'Contraseña nueva',
      intro: 'Al cambiarla se cierran tus sesiones en otros dispositivos.',
      submitLabel: 'Guardar y entrar',
      fields: const [
        _code,
        AuthField('password', 'Contraseña nueva', kind: AuthFieldKind.newPassword),
      ],
      onSubmit: (v) async {
        await session.reset(email, v['code']!, v['password']!);
        if (context.mounted) Navigator.of(context).popUntil((r) => r.isFirst);
      },
    );
  }
}

Route<void> _route(Widget screen) => MaterialPageRoute<void>(builder: (_) => screen);
