import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../session/session.dart';
import 'explore_screen.dart';
import 'favorites_screen.dart';
import 'trips_screen.dart';

/// Modo viajero: explorar, guardados, mis viajes y cuenta.
class TravelerShell extends StatefulWidget {
  const TravelerShell({super.key, required this.session});

  final SessionController session;

  @override
  State<TravelerShell> createState() => _TravelerShellState();
}

class _TravelerShellState extends State<TravelerShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ExploreScreen(session: widget.session),
      FavoritesScreen(session: widget.session),
      TripsScreen(session: widget.session),
      HomeScreen(session: widget.session),
    ];
    return Scaffold(
      body: IndexedStack(index: _tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Explorar'),
          NavigationDestination(icon: Icon(Icons.star_border), selectedIcon: Icon(Icons.star), label: 'Guardados'),
          NavigationDestination(
            icon: Icon(Icons.luggage_outlined),
            selectedIcon: Icon(Icons.luggage),
            label: 'Mis viajes',
          ),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Cuenta'),
        ],
      ),
    );
  }
}
