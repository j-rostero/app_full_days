import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';
import 'claims_screen.dart';
import 'common.dart';
import 'trip_screen.dart';

/// Avisos de la cuenta: pagos, cancelaciones, recordatorios, respuestas.
class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key, required this.session});

  final SessionController session;

  Future<void> _open(BuildContext context, String? link) async {
    if (link == null) return;
    final [kind, id] = link.contains(':') ? link.split(':') : [link, ''];
    final Widget? screen = switch (kind) {
      'reserva' => TripScreen(session: session, bookingId: id),
      'reclamo' => ClaimsScreen(session: session),
      _ => null,
    };
    if (screen != null) await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Loader<Inbox>(
      load: () => call(() => NotificacionesApi(session.client).getInbox()),
      builder: (context, inbox, reload) => Scaffold(
        appBar: AppBar(
          title: const Text('Avisos'),
          actions: [
            if (inbox.unread > 0)
              TextButton(
                onPressed: () async {
                  await NotificacionesApi(session.client).markInboxRead(MarkReadInput());
                  await reload();
                },
                child: const Text('Marcar leídos'),
              ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: reload,
          child: ListView(
            children: [
              if (inbox.items.isEmpty) const Padding(padding: EdgeInsets.all(32), child: Text('No tienes avisos.')),
              for (final n in inbox.items)
                ListTile(
                  leading: Icon(n.read ? Icons.notifications_none : Icons.notifications_active),
                  title: Text(n.title, style: n.read ? null : const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${n.body}\n${shortDate(n.createdAt.toLocal())}'),
                  isThreeLine: true,
                  onTap: () => _open(context, n.link),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
