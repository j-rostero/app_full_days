import 'package:flutter/material.dart';

import '../session/session.dart';

const _roleLabels = {'owner': 'Dueño', 'operations': 'Operaciones', 'finance': 'Finanzas', 'guide': 'Guía'};

/// Inicio con sesión. Las fases siguientes agregan el catálogo y las reservas.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    final me = session.me;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('FullDays'),
        actions: [IconButton(tooltip: 'Salir', icon: const Icon(Icons.logout), onPressed: session.signOut)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Hola, ${me?.name ?? me?.email ?? ''}.', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Pronto verás aquí los próximos fulldays.', style: theme.textTheme.bodyMedium),
          if (me != null && me.memberships.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Tus agencias', style: theme.textTheme.titleMedium),
            for (final m in me.memberships)
              ListTile(
                title: Text(m.providerName),
                subtitle: Text(_roleLabels[m.role.toString()] ?? m.role.toString()),
              ),
          ],
        ],
      ),
    );
  }
}
