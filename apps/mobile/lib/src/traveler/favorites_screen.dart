import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';
import 'common.dart';
import 'product_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guardados')),
      body: Loader<FavoriteList>(
        load: () => call(() => CatalogoApi(session.client).listFavorites()),
        builder: (context, list, reload) => RefreshIndicator(
          onRefresh: reload,
          child: list.items.isEmpty
              ? ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(32),
                      child: Text('Guarda viajes con la estrella para verlos aquí.'),
                    ),
                  ],
                )
              : ListView(
                  children: [
                    for (final p in list.items)
                      ListTile(
                        leading: p.cover == null
                            ? const Icon(Icons.landscape)
                            : Image.network(p.cover!.sm, width: 56, fit: BoxFit.cover),
                        title: Text(p.title),
                        subtitle: Text(
                          p.nextDate == null
                              ? 'Sin fechas por ahora'
                              : 'Próxima: ${shortDate(p.nextDate!)} · ${usd(p.priceUsd)}',
                        ),
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => ProductScreen(session: session, productId: p.id),
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
