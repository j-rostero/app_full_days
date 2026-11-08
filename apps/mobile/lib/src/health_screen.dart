import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';
import 'package:fulldays_ui/fulldays_ui.dart';

/// Resultado de consultar `/salud`.
sealed class ApiStatus {
  const ApiStatus();
}

class ApiReachable extends ApiStatus {
  const ApiReachable(this.health);
  final Health health;
}

class ApiUnreachable extends ApiStatus {
  const ApiUnreachable();
}

/// Consulta `/salud` con el cliente generado. 503 (degradada) también trae el cuerpo de estado.
Future<ApiStatus> checkApi(ApiClient client) async {
  try {
    final response = await SaludApi(client).getHealthWithHttpInfo();
    if (response.statusCode == 200 || response.statusCode == 503) {
      final health = Health.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      if (health != null) return ApiReachable(health);
    }
    return const ApiUnreachable();
  } catch (_) {
    return const ApiUnreachable();
  }
}

/// Pantalla de la Fase 0: comprueba que la app llega a la API.
class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key, required this.client, required this.flavor});

  final ApiClient client;
  final String flavor;

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  late Future<ApiStatus> _status = checkApi(widget.client);

  void _retry() {
    final next = checkApi(widget.client);
    setState(() {
      _status = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(FdSpace.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('FullDays', style: text.headlineMedium),
              const SizedBox(height: FdSpace.s),
              Text('Entorno: ${widget.flavor} · ${widget.client.basePath}', style: text.bodyMedium),
              const SizedBox(height: FdSpace.xl),
              FutureBuilder<ApiStatus>(
                future: _status,
                builder: (context, snapshot) => switch (snapshot.data) {
                  null => const Center(child: CircularProgressIndicator()),
                  ApiReachable(:final health) => _HealthCard(health: health),
                  ApiUnreachable() => const _Message('No pudimos conectar con la API. Revisa tu conexión.'),
                },
              ),
              const Spacer(),
              FilledButton(onPressed: _retry, child: const Text('Volver a comprobar')),
            ],
          ),
        ),
      ),
    );
  }
}

class _HealthCard extends StatelessWidget {
  const _HealthCard({required this.health});

  final Health health;

  @override
  Widget build(BuildContext context) {
    final ok = health.status == HealthStatusEnum.ok;
    final text = Theme.of(context).textTheme;
    String label(HealthChecksDatabaseEnum? c) => c == HealthChecksDatabaseEnum.ok ? 'en línea' : 'sin respuesta';
    String redis(HealthChecksRedisEnum? c) => c == HealthChecksRedisEnum.ok ? 'en línea' : 'sin respuesta';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(FdSpace.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ok ? 'API conectada' : 'API con problemas', style: text.titleMedium),
            const SizedBox(height: FdSpace.s),
            Text('Base de datos: ${label(health.checks.database)}', style: text.bodyLarge),
            Text('Redis: ${redis(health.checks.redis)}', style: text.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: Theme.of(context).textTheme.bodyLarge);
}
