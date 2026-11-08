import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';
import 'package:image_picker/image_picker.dart';

import '../session/session.dart';
import 'claims_screen.dart';
import 'common.dart';
import 'review_screen.dart';
import 'uploader.dart';
import 'vouchers_screen.dart';

const _acceptsPayments = {BookingStatus.held, BookingStatus.inReview, BookingStatus.depositPaid};
const _confirmed = {BookingStatus.depositPaid, BookingStatus.paid, BookingStatus.completed, BookingStatus.noShow};

/// Una reserva: estado, precio, cómo pagar, reportar el pago y los vouchers.
class TripScreen extends StatelessWidget {
  const TripScreen({super.key, required this.session, required this.bookingId});

  final SessionController session;
  final String bookingId;

  Future<(Booking, PaymentList, Settings, Rate?, NoticeList?, Cancellation?, ClaimList?)> _load() async {
    final client = session.client;
    final booking = await call(() => ReservasApi(client).getMyBooking(bookingId));
    final payments = await call(() => PagosApi(client).listBookingPayments(bookingId));
    NoticeList? notices;
    try {
      notices = await DiaDelViajeApi(client).listBookingNotices(bookingId);
    } on Object {
      notices = null;
    }
    final settings = await call(() => CatalogosApi(client).getSettings());
    Rate? rate;
    try {
      rate = await CatalogosApi(client).getRate();
    } on Object {
      rate = null;
    }
    Cancellation? quote;
    ClaimList? claims;
    try {
      quote = await ReservasApi(client).previewCancellation(bookingId);
      claims = booking.paidUsd > 0 ? await ReclamosApi(client).listMyClaims(reserva: bookingId) : null;
    } on Object {
      // Sin esto la reserva igual se muestra.
    }
    return (booking, payments, settings, rate, notices, quote, claims);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi reserva')),
      body: Loader<(Booking, PaymentList, Settings, Rate?, NoticeList?, Cancellation?, ClaimList?)>(
        load: _load,
        builder: (context, data, reload) {
          final (b, payments, settings, rate, notices, quote, claims) = data;
          final theme = Theme.of(context);
          final due = (b.totalUsd - b.paidUsd - b.pendingUsd).clamp(0, double.infinity);
          final toDeposit = (b.depositUsd - b.paidUsd - b.pendingUsd).clamp(0, double.infinity);
          return RefreshIndicator(
            onRefresh: reload,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Reserva ${b.code}', style: theme.textTheme.labelLarge),
                Text(b.product.title, style: theme.textTheme.headlineSmall),
                Text('${shortDate(b.departure.date)} · ${b.provider.name}'),
                const SizedBox(height: 8),
                Chip(label: Text(bookingStatusLabels[b.status] ?? b.status.toString())),
                if (b.status == BookingStatus.held && b.heldUntil != null)
                  Text(
                    'Tus puestos están apartados hasta las ${TimeOfDay.fromDateTime(b.heldUntil!.toLocal()).format(context)}. Reporta el pago antes.',
                  ),
                if (b.status == BookingStatus.inReview) const Text('La agencia está revisando tu pago.'),
                for (final n in notices?.items ?? <Notice>[])
                  Card(
                    margin: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: const Icon(Icons.campaign_outlined),
                      title: Text(n.body),
                      subtitle: Text('Aviso de la agencia · ${shortDate(n.createdAt.toLocal())}'),
                    ),
                  ),
                if (_confirmed.contains(b.status))
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: FilledButton.icon(
                      icon: const Icon(Icons.qr_code),
                      label: const Text('Ver vouchers'),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => VouchersScreen(session: session, bookingId: b.id),
                        ),
                      ),
                    ),
                  ),
                const Divider(height: 32),
                for (final l in b.lines)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(l.label)),
                      Text(usd(l.amountUsd)),
                    ],
                  ),
                const SizedBox(height: 8),
                _row('Total', b.totalUsd, theme.textTheme.titleMedium),
                _row('Pagado y confirmado', b.paidUsd),
                if (b.pendingUsd > 0) _row('Reportado, por revisar', b.pendingUsd),
                _row('Saldo', b.balanceUsd, theme.textTheme.titleSmall),
                if (_acceptsPayments.contains(b.status) && due > 0) ...[
                  const Divider(height: 32),
                  Text('Pagar', style: theme.textTheme.titleMedium),
                  Text(b.provider.paymentInstructions ?? '${b.provider.name} te enviará los datos de pago.'),
                  const SizedBox(height: 12),
                  PaymentForm(
                    session: session,
                    bookingId: b.id,
                    methods: [for (final m in settings.paymentMethods) m.toString()],
                    suggestedUsd: (toDeposit > 0 ? toDeposit : due).toDouble(),
                    bsPerUsd: rate?.bsPerUsd.toDouble(),
                    onReported: reload,
                  ),
                ],
                if (payments.items.isNotEmpty) ...[
                  const Divider(height: 32),
                  Text('Pagos', style: theme.textTheme.titleMedium),
                  for (final p in payments.items)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('${paymentMethodLabels[p.method.toString()]} · ${usd(p.amountUsd)}'),
                      subtitle: Text('Ref. ${p.reference}${p.reason != null ? ' · ${p.reason}' : ''}'),
                      trailing: Text(switch (p.status.toString()) {
                        'confirmed' => 'Confirmado',
                        'rejected' => 'Rechazado',
                        _ => 'Por revisar',
                      }),
                    ),
                ],
                if (b.status == BookingStatus.cancelled) ...[
                  const Divider(height: 32),
                  Text('Cancelación', style: theme.textTheme.titleMedium),
                  Text(refundText(b.refund)),
                ],
                if (b.canReview) ...[
                  const Divider(height: 32),
                  FilledButton.icon(
                    icon: const Icon(Icons.rate_review_outlined),
                    label: const Text('Reseñar este viaje'),
                    onPressed: () async {
                      final done = await Navigator.of(context).push<bool>(
                        MaterialPageRoute(
                          builder: (_) => ReviewScreen(session: session, bookingId: b.id, title: b.product.title),
                        ),
                      );
                      if (done == true) await reload();
                    },
                  ),
                ],
                if (b.paidUsd > 0) ...[
                  const Divider(height: 32),
                  Text('Reclamos', style: theme.textTheme.titleMedium),
                  for (final c in claims?.items ?? <Claim>[])
                    ClaimThread(session: session, claim: c, onChanged: reload),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.report_problem_outlined),
                    label: const Text('Abrir un reclamo'),
                    onPressed: () async {
                      if (await openClaimDialog(context, session, b.id)) await reload();
                    },
                  ),
                ],
                if (quote != null && quote.allowed) ...[
                  const Divider(height: 32),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.cancel_outlined),
                    label: const Text('Cancelar reserva'),
                    onPressed: () async {
                      if (await confirmCancel(context, session, b, quote)) await reload();
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _row(String label, num value, [TextStyle? style]) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: style),
      Text(usd(value), style: style),
    ],
  );
}

/// Reporte de pago con comprobante desde la cámara o la galería.
class PaymentForm extends StatefulWidget {
  const PaymentForm({
    super.key,
    required this.session,
    required this.bookingId,
    required this.methods,
    required this.suggestedUsd,
    required this.bsPerUsd,
    required this.onReported,
    this.picker,
  });

  final SessionController session;
  final String bookingId;
  final List<String> methods;
  final double suggestedUsd;
  final double? bsPerUsd;
  final Future<void> Function() onReported;
  final ImagePicker? picker;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  late String _method = widget.methods.first;
  late final _amount = TextEditingController(text: widget.suggestedUsd.toStringAsFixed(2));
  final _reference = TextEditingController();
  XFile? _proof;
  String _key = randomKey();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _reference.dispose();
    super.dispose();
  }

  Future<void> _pick(ImageSource source) async {
    final file = await (widget.picker ?? ImagePicker()).pickImage(source: source, maxWidth: 2000, imageQuality: 80);
    if (file != null) setState(() => _proof = file);
  }

  Future<void> _submit() async {
    final amount = double.tryParse(_amount.text.replaceAll(',', '.'));
    if (amount == null || amount <= 0) return setState(() => _error = 'Escribe el monto en dólares.');
    if (_reference.text.trim().length < 4) return setState(() => _error = 'Escribe la referencia del pago.');
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      String? proofId;
      if (_proof != null) {
        final bytes = await _proof!.readAsBytes();
        final type = _proof!.name.toLowerCase().endsWith('.png') ? 'image/png' : 'image/jpeg';
        proofId = await uploadDocument(widget.session.client, bytes, type);
      }
      await call(
        () => PagosApi(widget.session.client).reportPayment(
          widget.bookingId,
          ReportPaymentInput(
            method: ReportPaymentInputMethodEnum.fromJson(_method)!,
            reference: _reference.text.trim(),
            amountUsd: amount,
            proofFileId: proofId,
            idempotencyKey: _key,
          ),
        ),
      );
      _key = randomKey();
      if (mounted) showMessage(context, 'Pago reportado. La agencia lo revisará.');
      await widget.onReported();
    } on Object catch (e) {
      setState(() => _error = e is FdError ? e.message : e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(_amount.text.replaceAll(',', '.')) ?? 0;
    final inBs = _method == 'mobile_payment' || _method == 'bank_transfer';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          initialValue: _method,
          decoration: const InputDecoration(labelText: 'Método'),
          items: [for (final m in widget.methods) DropdownMenuItem(value: m, child: Text(paymentMethodLabels[m] ?? m))],
          onChanged: (v) => setState(() => _method = v ?? _method),
        ),
        TextField(
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Monto en dólares'),
          onChanged: (_) => setState(() {}),
        ),
        if (inBs && widget.bsPerUsd != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text('Equivale a ${(amount * widget.bsPerUsd!).toStringAsFixed(2)} Bs a la tasa de hoy.'),
          ),
        TextField(
          controller: _reference,
          decoration: const InputDecoration(labelText: 'Referencia'),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () => _pick(ImageSource.camera),
              icon: const Icon(Icons.photo_camera),
              label: const Text('Foto'),
            ),
            OutlinedButton.icon(
              onPressed: () => _pick(ImageSource.gallery),
              icon: const Icon(Icons.image),
              label: const Text('Galería'),
            ),
          ],
        ),
        if (_proof != null) Text('Comprobante: ${_proof!.name}'),
        if (_error != null) Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
        const SizedBox(height: 8),
        FilledButton(onPressed: _busy ? null : _submit, child: Text(_busy ? 'Enviando…' : 'Reportar pago')),
      ],
    );
  }
}

String refundText(BookingRefund? refund) {
  if (refund == null) return 'Esta reserva no tiene reembolso.';
  final paid = refund.status == BookingRefundStatusEnum.paid;
  return 'Te corresponden ${usd(refund.amountUsd)}. ${refund.rule} '
      '${paid ? 'La agencia ya te los devolvió${refund.reference != null ? ' (ref. ${refund.reference})' : ''}.' : 'La agencia te los devolverá.'}';
}

/// Muestra cuánto se devuelve y cancela solo si el viajero confirma.
Future<bool> confirmCancel(BuildContext context, SessionController session, Booking b, Cancellation quote) async {
  final yes = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('¿Cancelar ${b.code}?'),
      content: Text('Te devolverán ${usd(quote.amountUsd)}. ${quote.rule}\n\nNo se puede deshacer.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Volver')),
        FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sí, cancelar')),
      ],
    ),
  );
  if (yes != true) return false;
  try {
    await call(() => ReservasApi(session.client).cancelBooking(b.id));
    if (context.mounted) showMessage(context, 'Reserva cancelada.');
    return true;
  } on FdError catch (e) {
    if (context.mounted) showMessage(context, e.message);
    return false;
  }
}
