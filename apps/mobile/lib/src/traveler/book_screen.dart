import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';
import 'common.dart';
import 'trip_screen.dart';

/// Escoger embarque y pasajeros con el precio de `cotizar`, y apartar.
class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.session, required this.departureId});

  final SessionController session;
  final String departureId;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Availability? _availability;
  String? _boardingId;
  final _counts = {'adult': 1, 'child': 0, 'senior': 0, 'infant': 0};
  final Map<String, int> _rooms = {};
  Quote? _quote;
  String? _error;
  bool _busy = false;
  int _quoteSeq = 0;

  static const _labels = {
    'adult': 'Adultos',
    'child': 'Niños (3 a 11)',
    'senior': 'Adultos mayores',
    'infant': 'Infantes (0 a 2)',
  };

  @override
  void initState() {
    super.initState();
    call(() => CatalogoApi(widget.session.client).getAvailability(widget.departureId)).then((a) {
      setState(() {
        _availability = a;
        _boardingId = a.sheet.transfer.boardingPoints.firstOrNull?.id;
      });
      _requote();
    }, onError: (Object e) => setState(() => _error = FdError.from(e).message));
  }

  BookingSelection get _selection => BookingSelection(
    boardingId: _boardingId ?? '',
    travelers: BookingSelectionTravelers(
      adult: _counts['adult']!,
      child: _counts['child']!,
      senior: _counts['senior']!,
      infant: _counts['infant']!,
    ),
    rooms: [
      for (final e in _rooms.entries)
        if (e.value > 0) BookingSelectionRoomsInner(roomId: e.key, count: e.value),
    ],
  );

  Future<void> _requote() async {
    final seq = ++_quoteSeq;
    try {
      final q = await call(
        () =>
            ReservasApi(widget.session.client)
                .quoteBooking(QuoteInput(departureId: widget.departureId, selection: _selection)),
      );
      if (seq == _quoteSeq) {
        setState(() {
          _quote = q;
          _error = null;
        });
      }
    } on FdError catch (e) {
      if (seq == _quoteSeq) {
        setState(() {
          _quote = null;
          _error = e.message;
        });
      }
    }
  }

  Future<void> _hold() async {
    setState(() => _busy = true);
    try {
      final booking = await call(
        () =>
            ReservasApi(widget.session.client)
                .holdBooking(HoldInput(departureId: widget.departureId, selection: _selection)),
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => TripScreen(session: widget.session, bookingId: booking.id),
        ),
      );
    } on FdError catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _counter(String label, int value, ValueChanged<int> onChanged) => Row(
    children: [
      Expanded(child: Text(label)),
      IconButton(
        onPressed: value > 0 ? () => onChanged(value - 1) : null,
        icon: const Icon(Icons.remove_circle_outline),
      ),
      Text('$value'),
      IconButton(onPressed: value < 20 ? () => onChanged(value + 1) : null, icon: const Icon(Icons.add_circle_outline)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final a = _availability;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Reservar')),
      body: a == null
          ? Center(child: _error != null ? Text(_error!) : const CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(a.title, style: theme.textTheme.titleLarge),
                Text('${shortDate(a.departure.date)} · ${a.provider.name} · ${a.departure.seatsLeft} puestos libres'),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _boardingId,
                  decoration: const InputDecoration(labelText: 'Punto de embarque'),
                  items: [
                    for (final b in a.sheet.transfer.boardingPoints)
                      DropdownMenuItem(
                        value: b.id,
                        child: Text(
                          '${b.name.isEmpty ? b.city : b.name}${b.departureTime != null ? ' · ${b.departureTime}' : ''}',
                        ),
                      ),
                  ],
                  onChanged: (v) {
                    setState(() => _boardingId = v);
                    _requote();
                  },
                ),
                const SizedBox(height: 16),
                for (final type in _labels.keys)
                  if (type == 'adult' || (type != 'senior' && a.sheet.general.childrenAllowed) || type == 'senior')
                    _counter(_labels[type]!, _counts[type]!, (v) {
                      setState(() => _counts[type] = v);
                      _requote();
                    }),
                if (a.sheet.lodging != null && a.sheet.duration.nights > 0)
                  for (final room in a.sheet.lodging!.rooms)
                    _counter(
                      'Habitación ${room.type} (hasta ${room.occupancy})${a.roomsLeft[room.id] != null ? ' · quedan ${a.roomsLeft[room.id]}' : ''}',
                      _rooms[room.id] ?? 0,
                      (v) {
                        setState(() => _rooms[room.id] = v);
                        _requote();
                      },
                    ),
                const Divider(height: 32),
                if (_quote != null) ...[
                  for (final l in _quote!.lines)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(l.label)),
                        Text(usd(l.amountUsd)),
                      ],
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: theme.textTheme.titleMedium),
                      Text(usd(_quote!.totalUsd), style: theme.textTheme.titleMedium),
                    ],
                  ),
                  Text('Para reservar pagas ${usd(_quote!.depositUsd)}.'),
                ],
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
                  ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _busy || _quote == null ? null : _hold,
                  child: Text(_busy ? 'Apartando…' : 'Apartar mis puestos'),
                ),
              ],
            ),
    );
  }
}
