import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';
import 'package:fulldays_ui/fulldays_ui.dart';

import 'src/config.dart';
import 'src/health_screen.dart';
import 'src/screens/auth_screens.dart';
import 'src/session/session.dart';
import 'src/session/token_store.dart';
import 'src/traveler/traveler_shell.dart';

void main() {
  // El almacenamiento seguro usa canales de plataforma: el binding debe existir antes.
  WidgetsFlutterBinding.ensureInitialized();
  final config = AppConfig.fromEnvironment();
  final session = SessionController(apiUrl: config.apiUrl, store: SecureTokenStore())..restore();
  runApp(FullDaysApp(session: session, flavor: config.flavor));
}

class FullDaysApp extends StatelessWidget {
  const FullDaysApp({super.key, required this.session, required this.flavor});

  final SessionController session;
  final String flavor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FullDays',
      debugShowCheckedModeBanner: flavor != 'prod',
      theme: fdTheme(FdProduct.viajero),
      home: ListenableBuilder(
        listenable: session,
        builder: (context, _) => switch (session.status) {
          SessionStatus.loading => const Scaffold(body: Center(child: CircularProgressIndicator())),
          SessionStatus.signedOut => SignInScreen(
            session: session,
            onHealth: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => HealthScreen(
                  client: ApiClient(basePath: session.client.basePath),
                  flavor: flavor,
                ),
              ),
            ),
          ),
          SessionStatus.signedIn => TravelerShell(session: session),
        },
      ),
    );
  }
}
