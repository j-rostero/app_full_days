// Generado desde packages/tokens/tokens.json con `pnpm tokens`. No editar.
// ignore_for_file: constant_identifier_names

import 'dart:ui';

/// Colores base (producto de viajeros).
abstract final class FdColors {
  static const fondo = Color(0xFFFAFAF7);
  static const superficie = Color(0xFFFFFFFF);
  static const texto = Color(0xFF16201C);
  static const textoSuave = Color(0xFF55615C);
  static const borde = Color(0xFFDDE3E0);
  static const primario = Color(0xFF0B7A5E);
  static const sobrePrimario = Color(0xFFFFFFFF);
  static const acento = Color(0xFFF2A93B);
  static const exito = Color(0xFF1E7F4F);
  static const aviso = Color(0xFFA86400);
  static const error = Color(0xFFB3261E);
}

/// Colores que cambian en el producto `pro`.
abstract final class FdProColors {
  static const primario = Color(0xFF1F4E8C);
  static const fondo = Color(0xFFF5F7FA);
}

/// Colores que cambian en el producto `central`.
abstract final class FdCentralColors {
  static const primario = Color(0xFF5B3E96);
  static const fondo = Color(0xFFF7F5FA);
}

/// Un paso de la escala tipográfica.
final class FdTextStep {
  const FdTextStep(this.size, this.lineHeight, this.weight);
  final double size;
  final double lineHeight;
  final int weight;
}

abstract final class FdType {
  static const family = 'Inter';
  static const titulo = FdTextStep(28, 34, 700);
  static const subtitulo = FdTextStep(20, 26, 600);
  static const cuerpo = FdTextStep(16, 24, 400);
  static const pequeno = FdTextStep(14, 20, 400);
  static const etiqueta = FdTextStep(12, 16, 600);
}

abstract final class FdRadius {
  static const double s = 6;
  static const double m = 10;
  static const double l = 16;
  static const double pildora = 999;
}

abstract final class FdSpace {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
  static const double xxl = 32;
}
