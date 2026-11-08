import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';

String usd(num value) {
  final text = value.toStringAsFixed(2);
  return '${text.endsWith('.00') ? text.substring(0, text.length - 3) : text} USD';
}

const _months = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
const _days = ['lun', 'mar', 'mié', 'jue', 'vie', 'sáb', 'dom'];

/// «sáb 20 dic». Las fechas de la API llegan como día calendario (medianoche).
String shortDate(DateTime d) => '${_days[d.weekday - 1]} ${d.day} ${_months[d.month - 1]}';

String isoDay(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

const bookingStatusLabels = {
  BookingStatus.held: 'Apartada',
  BookingStatus.inReview: 'Pago en revisión',
  BookingStatus.depositPaid: 'Abonada',
  BookingStatus.paid: 'Pagada',
  BookingStatus.expired: 'Vencida',
  BookingStatus.cancelled: 'Cancelada',
  BookingStatus.completed: 'Realizada',
  BookingStatus.noShow: 'No se presentó',
};

const productTypeLabels = {'fullday': 'Fullday', 'tour': 'Tour', 'excursion': 'Excursión'};

const paymentMethodLabels = {
  'mobile_payment': 'Pago móvil',
  'bank_transfer': 'Transferencia bancaria',
  'zelle': 'Zelle',
  'cash_usd': 'Efectivo en dólares',
};

/// Clave aleatoria para que un reintento no duplique un pago.
String randomKey() {
  final r = Random.secure();
  return List.generate(16, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
}

/// Carga asíncrona con estado de error y reintento.
class Loader<T> extends StatefulWidget {
  const Loader({super.key, required this.load, required this.builder});

  final Future<T> Function() load;
  final Widget Function(BuildContext context, T data, Future<void> Function() reload) builder;

  @override
  State<Loader<T>> createState() => _LoaderState<T>();
}

class _LoaderState<T> extends State<Loader<T>> {
  late Future<T> _future = widget.load();

  Future<void> _reload() async {
    final next = widget.load();
    setState(() {
      _future = next;
    });
    await next.then((_) {}, onError: (_) {});
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<T>(
    future: _future,
    builder: (context, snap) {
      if (snap.hasError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(FdError.from(snap.error!).message, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                FilledButton(onPressed: _reload, child: const Text('Reintentar')),
              ],
            ),
          ),
        );
      }
      if (!snap.hasData) return const Center(child: CircularProgressIndicator());
      return widget.builder(context, snap.data as T, _reload);
    },
  );
}

Future<T> call<T>(Future<T?> Function() run) async {
  try {
    final result = await run();
    if (result == null) throw FdError.offline;
    return result;
  } on Object catch (e) {
    throw FdError.from(e);
  }
}

void showMessage(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
