import 'package:flutter/material.dart';

import '../operator/operator_screen.dart';
import '../push/push.dart';
import '../screens/home_screen.dart';
import '../session/session.dart';
import 'explore_screen.dart';
import 'favorites_screen.dart';
import 'trips_screen.dart';

/// Modo viajero: explorar, guardados, mis viajes y cuenta.
class TravelerShell extends StatefulWidget {
  const TravelerShell({super.key, required this.session, this.pushTokens});

  final SessionController session;

  /// Por defecto Firebase; las pruebas pasan uno falso.
  final PushTokens? pushTokens;

  @override
  State<TravelerShell> createState() => _TravelerShellState();
}

class _TravelerShellState extends State<TravelerShell> {
  int _tab = 0;
  late final PushRegistration _push = PushRegistration(widget.session, widget.pushTokens ?? FirebasePushTokens());

  @override
  void initState() {
    super.initState();
    _push.start();
  }

  @override
  void dispose() {
    _push.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Quien trabaja en una agencia con check-in ve además la pestaña para pasar lista.
    final operates = checkinMemberships(widget.session.me).isNotEmpty;
    final pages = [
      ExploreScreen(session: widget.session),
      FavoritesScreen(session: widget.session),
      TripsScreen(session: widget.session),
      if (operates) OperatorScreen(session: widget.session),
      HomeScreen(session: widget.session),
    ];
    return Scaffold(
      body: IndexedStack(index: _tab.clamp(0, pages.length - 1), children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab.clamp(0, pages.length - 1),
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.search), label: 'Explorar'),
          const NavigationDestination(
            icon: Icon(Icons.star_border),
            selectedIcon: Icon(Icons.star),
            label: 'Guardados',
          ),
          const NavigationDestination(
            icon: Icon(Icons.luggage_outlined),
            selectedIcon: Icon(Icons.luggage),
            label: 'Mis viajes',
          ),
          if (operates)
            const NavigationDestination(
              icon: Icon(Icons.fact_check_outlined),
              selectedIcon: Icon(Icons.fact_check),
              label: 'Operar',
            ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Cuenta',
          ),
        ],
      ),
    );
  }
}
