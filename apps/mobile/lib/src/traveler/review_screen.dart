import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';
import 'common.dart';

const reviewAspectLabels = {
  'punctuality': 'Puntualidad',
  'transport': 'Transporte',
  'food': 'Comida',
  'guide': 'Guía',
  'value': 'Precio-calidad',
};

/// Reseña de un viaje realizado: estrellas, aspectos, si fue como se describió y comentario.
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.session, required this.bookingId, required this.title});

  final SessionController session;
  final String bookingId;
  final String title;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 5;
  final Map<String, int> _aspects = {};
  bool _asDescribed = true;
  final _comment = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await call(
        () => ResenasApi(widget.session.client).reviewBooking(
          widget.bookingId,
          ReviewInput(
            rating: _rating,
            aspects: ReviewInputAspects(
              punctuality: _aspects['punctuality'],
              transport: _aspects['transport'],
              food: _aspects['food'],
              guide: _aspects['guide'],
              value: _aspects['value'],
            ),
            asDescribed: _asDescribed,
            comment: _comment.text.trim(),
          ),
        ),
      );
      if (!mounted) return;
      showMessage(context, '¡Gracias por tu reseña!');
      Navigator.of(context).pop(true);
    } on FdError catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _stars(int value, ValueChanged<int> onPick, {String? label}) => Row(
    children: [
      if (label != null) SizedBox(width: 120, child: Text(label)),
      for (var i = 1; i <= 5; i++)
        IconButton(tooltip: '$i', icon: Icon(i <= value ? Icons.star : Icons.star_border), onPressed: () => onPick(i)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reseñar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text('Calificación general'),
          _stars(_rating, (v) => setState(() => _rating = v)),
          const Divider(),
          for (final e in reviewAspectLabels.entries)
            _stars(_aspects[e.key] ?? 0, (v) => setState(() => _aspects[e.key] = v), label: e.value),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Fue como se describió'),
            value: _asDescribed,
            onChanged: (v) => setState(() => _asDescribed = v),
          ),
          TextField(
            controller: _comment,
            maxLines: 4,
            minLines: 2,
            maxLength: 2000,
            decoration: const InputDecoration(labelText: 'Comentario (opcional)'),
          ),
          if (_error != null) Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          FilledButton(onPressed: _busy ? null : _submit, child: Text(_busy ? 'Enviando…' : 'Publicar reseña')),
        ],
      ),
    );
  }
}
