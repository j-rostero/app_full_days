import 'package:flutter/material.dart';

import '../session/session.dart';

const _roleLabels = {'owner': 'Dueño', 'operations': 'Operaciones', 'finance': 'Finanzas', 'guide': 'Guía'};

/// La cuenta: datos y agencias de las que la persona es parte.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    final me = session.me;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta'),
        actions: [IconButton(tooltip: 'Salir', icon: const Icon(Icons.logout), onPressed: session.signOut)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Hola, ${me?.name ?? me?.email ?? ''}.', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
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
