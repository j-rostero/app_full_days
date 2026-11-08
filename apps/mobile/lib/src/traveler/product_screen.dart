import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';
import 'book_screen.dart';
import 'common.dart';

/// Ficha publicada: fotos, itinerario, qué incluye, fechas y guardar.
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.session, required this.productId, this.departureId});

  final SessionController session;
  final String productId;
  final String? departureId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool? _saved;

  Future<(PublicProduct, bool)> _load() async {
    final api = CatalogoApi(widget.session.client);
    final product = await call(() => api.getPublicProduct(widget.productId));
    final favorites = await call(() => api.listFavorites());
    return (product, favorites.items.any((f) => f.id == product.id));
  }

  Future<void> _toggle(bool saved) async {
    final api = CatalogoApi(widget.session.client);
    try {
      saved ? await api.removeFavorite(widget.productId) : await api.addFavorite(widget.productId);
      setState(() => _saved = !saved);
    } on Object catch (e) {
      if (mounted) showMessage(context, FdError.from(e).message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Loader<(PublicProduct, bool)>(
      load: _load,
      builder: (context, data, _) {
        final (p, initiallySaved) = data;
        final saved = _saved ?? initiallySaved;
        final s = p.sheet;
        final theme = Theme.of(context);
        final many = s.duration.days > 1;
        Widget section(String title, List<String> items) => items.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    for (final x in items) Text('• $x'),
                  ],
                ),
              );
        return Scaffold(
          appBar: AppBar(
            title: Text(productTypeLabels[p.type.toString()] ?? ''),
            actions: [
              IconButton(
                tooltip: saved ? 'Quitar de guardados' : 'Guardar',
                icon: Icon(saved ? Icons.star : Icons.star_border),
                onPressed: () => _toggle(saved),
              ),
            ],
          ),
          body: ListView(
            children: [
              if (p.photos.isNotEmpty)
                SizedBox(
                  height: 240,
                  child: PageView(children: [for (final ph in p.photos) Image.network(ph.urls.lg, fit: BoxFit.cover)]),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.general.title, style: theme.textTheme.headlineSmall),
                    Text(
                      '${p.provider.name}${p.provider.badge?.toString() == 'verified' ? ' · Agencia verificada' : ''}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Text(s.general.summary, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Text(s.general.description),
                    const SizedBox(height: 16),
                    Text('Fechas', style: theme.textTheme.titleMedium),
                    if (p.departures.isEmpty) const Text('No hay fechas en venta por ahora.'),
                    for (final d in p.departures)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        selected: d.id == widget.departureId,
                        title: Text(shortDate(d.date)),
                        subtitle: Text(
                          '${usd(d.priceUsd)} · ${d.seatsLeft > 0 ? '${d.seatsLeft} puestos' : 'Agotado'}',
                        ),
                        trailing: d.status.toString() == 'open' && d.seatsLeft > 0
                            ? FilledButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => BookScreen(session: widget.session, departureId: d.id),
                                  ),
                                ),
                                child: const Text('Reservar'),
                              )
                            : null,
                      ),
                    const SizedBox(height: 8),
                    Text('Itinerario', style: theme.textTheme.titleMedium),
                    for (final step in s.itinerary)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          '${many ? 'Día ${step.day} · ' : ''}${step.time != null ? '${step.time} · ' : ''}${step.title}'
                          '${step.description.isNotEmpty ? '\n${step.description}' : ''}',
                        ),
                      ),
                    section('Incluye', p.inclusions.included),
                    section('Opcional', p.inclusions.optional),
                    section('Se paga en el destino', p.inclusions.payAtDestination),
                    section('No incluye', p.inclusions.notIncluded),
                    if (p.cashAtDestination.totalUsd > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Lleva ${usd(p.cashAtDestination.totalUsd)} en efectivo para el destino.'),
                      ),
                    section('Qué llevar', s.whatToBring),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
