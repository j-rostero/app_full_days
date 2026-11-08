import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';
import 'common.dart';
import 'product_screen.dart';

/// Buscar salidas: texto libre y orden; toca una para ver su ficha.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.session});

  final SessionController session;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _query = TextEditingController();
  String _orden = 'recomendados';
  int _version = 0;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<SearchResult> _load() => call(
    () =>
        CatalogoApi(widget.session.client)
            .searchDepartures(q: _query.text.trim().isEmpty ? null : _query.text.trim(), orden: _orden),
  );

  void _search() => setState(() => _version++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explorar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _query,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _search(),
              decoration: InputDecoration(
                hintText: 'Los Roques, Mochima, Canaima…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: PopupMenuButton<String>(
                  tooltip: 'Ordenar',
                  icon: const Icon(Icons.sort),
                  initialValue: _orden,
                  onSelected: (v) {
                    _orden = v;
                    _search();
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'recomendados', child: Text('Recomendados')),
                    PopupMenuItem(value: 'fecha', child: Text('Fecha más cercana')),
                    PopupMenuItem(value: 'precio', child: Text('Menor precio')),
                    PopupMenuItem(value: 'cupos', child: Text('Más puestos libres')),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Loader<SearchResult>(
              key: ValueKey(_version),
              load: _load,
              builder: (context, result, reload) => RefreshIndicator(
                onRefresh: reload,
                child: result.items.isEmpty
                    ? ListView(
                        children: const [
                          Padding(padding: EdgeInsets.all(32), child: Text('No encontramos salidas con esa búsqueda.')),
                        ],
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: result.items.length,
                        itemBuilder: (context, i) => DepartureTile(card: result.items[i], session: widget.session),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DepartureTile extends StatelessWidget {
  const DepartureTile({super.key, required this.card, required this.session});

  final DepartureCard card;
  final SessionController session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final soldOut = card.seatsLeft == 0 || card.status.toString() == 'closed';
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ProductScreen(session: session, productId: card.productId, departureId: card.departureId),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (card.cover != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(card.cover!.md, fit: BoxFit.cover),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${productTypeLabels[card.type.toString()] ?? ''} · ${shortDate(card.date)}${card.featured ? ' · Destacado' : ''}',
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(card.title, style: theme.textTheme.titleMedium),
                  Text(
                    '${card.destination ?? card.cities.join(', ')} · ${card.provider.name}',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Desde ${usd(card.priceUsd)}', style: theme.textTheme.titleSmall),
                      Text(soldOut ? 'Agotado' : '${card.seatsLeft} puestos'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
