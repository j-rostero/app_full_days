import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';
import 'common.dart';

const claimStatusLabels = {'open': 'Abierto', 'escalated': 'Con FullDays', 'resolved': 'Resuelto'};
const _who = {'traveler': 'Tú', 'agency': 'La agencia', 'central': 'FullDays'};

/// Todos los reclamos propios.
class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis reclamos')),
      body: Loader<ClaimList>(
        load: () => call(() => ReclamosApi(session.client).listMyClaims()),
        builder: (context, list, reload) => RefreshIndicator(
          onRefresh: reload,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (list.items.isEmpty) const Text('No tienes reclamos. Ábrelos desde la reserva.'),
              for (final c in list.items) ClaimThread(session: session, claim: c, onChanged: reload),
            ],
          ),
        ),
      ),
    );
  }
}

/// Conversación de un reclamo con respuesta y escalada.
class ClaimThread extends StatefulWidget {
  const ClaimThread({super.key, required this.session, required this.claim, required this.onChanged});

  final SessionController session;
  final Claim claim;
  final Future<void> Function() onChanged;

  @override
  State<ClaimThread> createState() => _ClaimThreadState();
}

class _ClaimThreadState extends State<ClaimThread> {
  final _body = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  Future<void> _run(Future<Object?> Function() action, String ok) async {
    setState(() => _busy = true);
    try {
      await call(action);
      _body.clear();
      if (mounted) showMessage(context, ok);
      await widget.onChanged();
    } on FdError catch (e) {
      if (mounted) showMessage(context, e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.claim;
    final status = c.status.toString();
    final api = ReclamosApi(widget.session.client);
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(c.subject, style: theme.textTheme.titleMedium),
            Text('${claimStatusLabels[status] ?? status} · ${c.bookingCode} · ${c.providerName}'),
            const Divider(),
            for (final m in c.messages)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_who[m.role.toString()] ?? '', style: theme.textTheme.labelLarge),
                    Text(m.body),
                  ],
                ),
              ),
            if (c.resolution != null) Text('Resolución de FullDays: ${c.resolution}'),
            if (status != 'resolved') ...[
              TextField(
                controller: _body,
                maxLines: 3,
                minLines: 1,
                decoration: const InputDecoration(labelText: 'Escribe un mensaje'),
              ),
              Wrap(
                spacing: 8,
                children: [
                  FilledButton(
                    onPressed: _busy
                        ? null
                        : () {
                            if (_body.text.trim().isEmpty) return;
                            _run(
                              () => api.writeClaim(c.id, ClaimMessageInput(body: _body.text.trim())),
                              'Mensaje enviado.',
                            );
                          },
                    child: const Text('Enviar'),
                  ),
                  if (status == 'open')
                    OutlinedButton(
                      onPressed: _busy
                          ? null
                          : () => _run(() => api.escalateClaim(c.id), 'FullDays revisará tu reclamo.'),
                      child: const Text('Pedir que FullDays intervenga'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Formulario para abrir un reclamo sobre una reserva. Devuelve `true` si se envió.
Future<bool> openClaimDialog(BuildContext context, SessionController session, String bookingId) async {
  final subject = TextEditingController();
  final message = TextEditingController();
  final sent = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Abrir un reclamo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: subject,
            decoration: const InputDecoration(labelText: 'Asunto'),
          ),
          TextField(
            controller: message,
            maxLines: 4,
            minLines: 2,
            decoration: const InputDecoration(labelText: 'Qué pasó'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Volver')),
        FilledButton(
          onPressed: () async {
            try {
              await call(
                () =>
                    ReclamosApi(session.client)
                        .openClaim(bookingId, ClaimInput(subject: subject.text.trim(), message: message.text.trim())),
              );
              if (context.mounted) Navigator.pop(context, true);
            } on FdError catch (e) {
              if (context.mounted) showMessage(context, e.message);
            }
          },
          child: const Text('Enviar a la agencia'),
        ),
      ],
    ),
  );
  subject.dispose();
  message.dispose();
  return sent ?? false;
}
