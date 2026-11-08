import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';
import 'package:fulldays_ui/fulldays_ui.dart';

import 'src/config.dart';
import 'src/health_screen.dart';

void main() {
  final config = AppConfig.fromEnvironment();
  runApp(FullDaysApp(client: ApiClient(basePath: config.apiUrl), flavor: config.flavor));
}

class FullDaysApp extends StatelessWidget {
  const FullDaysApp({super.key, required this.client, required this.flavor});

  final ApiClient client;
  final String flavor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FullDays',
      debugShowCheckedModeBanner: flavor != 'prod',
      theme: fdTheme(FdProduct.viajero),
      home: HealthScreen(client: client, flavor: flavor),
    );
  }
}
