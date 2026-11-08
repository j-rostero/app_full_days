import 'package:flutter/material.dart';

import '../session/session.dart';

/// Pantalla de acceso: título, campos, botón principal y el error de la API arriba.
class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.title,
    required this.fields,
    required this.submitLabel,
    required this.onSubmit,
    this.intro,
    this.footer = const [],
  });

  final String title;
  final String? intro;
  final List<AuthField> fields;
  final String submitLabel;

  /// Recibe los valores por nombre de campo. Un [FdError] se muestra arriba.
  final Future<void> Function(Map<String, String> values) onSubmit;
  final List<Widget> footer;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class AuthField {
  const AuthField(this.name, this.label, {this.kind = AuthFieldKind.text, this.initial, this.validator});

  final String name;
  final String label;
  final AuthFieldKind kind;
  final String? initial;
  final String? Function(String value)? validator;
}

enum AuthFieldKind { email, password, newPassword, code, text }

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers = {
    for (final f in widget.fields) f.name: TextEditingController(text: f.initial),
  };
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await widget.onSubmit({for (final e in _controllers.entries) e.key: e.value.text.trim()});
    } on FdError catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              if (widget.intro != null) ...[
                Text(widget.intro!, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 16),
              ],
              if (_error != null) ...[
                Semantics(
                  liveRegion: true,
                  child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
                ),
                const SizedBox(height: 16),
              ],
              for (final f in widget.fields) ...[_input(f), const SizedBox(height: 16)],
              FilledButton(
                onPressed: _busy ? null : _submit,
                child: _busy
                    ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(widget.submitLabel),
              ),
              const SizedBox(height: 16),
              ...widget.footer,
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(AuthField f) {
    final secret = f.kind == AuthFieldKind.password || f.kind == AuthFieldKind.newPassword;
    return TextFormField(
      key: ValueKey('campo-${f.name}'),
      controller: _controllers[f.name],
      decoration: InputDecoration(labelText: f.label, border: const OutlineInputBorder()),
      obscureText: secret,
      enabled: !_busy,
      keyboardType: switch (f.kind) {
        AuthFieldKind.email => TextInputType.emailAddress,
        AuthFieldKind.code => TextInputType.number,
        _ => TextInputType.text,
      },
      autofillHints: switch (f.kind) {
        AuthFieldKind.email => const [AutofillHints.email],
        AuthFieldKind.password => const [AutofillHints.password],
        AuthFieldKind.newPassword => const [AutofillHints.newPassword],
        AuthFieldKind.code => const [AutofillHints.oneTimeCode],
        AuthFieldKind.text => null,
      },
      maxLength: f.kind == AuthFieldKind.code ? 6 : null,
      validator: (value) {
        final v = (value ?? '').trim();
        if (v.isEmpty) return 'Completa este campo.';
        if (f.kind == AuthFieldKind.email && !v.contains('@')) return 'Escribe un correo válido.';
        if (f.kind == AuthFieldKind.code && !RegExp(r'^\d{6}$').hasMatch(v)) return 'El código tiene 6 dígitos.';
        if (f.kind == AuthFieldKind.newPassword && v.length < 8) {
          return 'La contraseña debe tener al menos 8 caracteres.';
        }
        return f.validator?.call(v);
      },
    );
  }
}
