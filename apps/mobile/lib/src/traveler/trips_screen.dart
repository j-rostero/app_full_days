import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';
import 'claims_screen.dart';
import 'common.dart';
import 'inbox_screen.dart';
import 'trip_screen.dart';

/// Mis viajes: las reservas propias, la más nueva primero.
class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis viajes'),
        actions: [
          IconButton(
            tooltip: 'Reclamos',
            icon: const Icon(Icons.support_agent),
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => ClaimsScreen(session: session))),
          ),
          IconButton(
            tooltip: 'Avisos',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => InboxScreen(session: session))),
          ),
        ],
      ),
      body: Loader<BookingList>(
        load: () => call(() => ReservasApi(session.client).listMyBookings()),
        builder: (context, list, reload) => RefreshIndicator(
          onRefresh: reload,
          child: list.items.isEmpty
              ? ListView(
                  children: const [Padding(padding: EdgeInsets.all(32), child: Text('Aún no tienes reservas.'))],
                )
              : ListView(
                  children: [
                    for (final b in list.items)
                      ListTile(
                        leading: b.product.cover == null
                            ? const Icon(Icons.landscape)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(b.product.cover!.sm, width: 56, fit: BoxFit.cover),
                              ),
                        title: Text(b.product.title),
                        subtitle: Text('${shortDate(b.departure.date)} · ${b.code}'),
                        trailing: Text(bookingStatusLabels[b.status] ?? ''),
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => TripScreen(session: session, bookingId: b.id),
                            ),
                          );
                          await reload();
                        },
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
