import 'package:flutter/material.dart';

import 'tokens.g.dart';

/// Producto que se está mostrando: cambia el color principal y el fondo.
enum FdProduct { viajero, operador }

/// Construye el tema de Material a partir de los tokens de diseño.
ThemeData fdTheme(FdProduct product) {
  final primary = product == FdProduct.operador ? FdProColors.primario : FdColors.primario;
  final background = product == FdProduct.operador ? FdProColors.fondo : FdColors.fondo;

  final scheme = ColorScheme.fromSeed(
    seedColor: primary,
    primary: primary,
    onPrimary: FdColors.sobrePrimario,
    surface: FdColors.superficie,
    onSurface: FdColors.texto,
    error: FdColors.error,
  );

  TextStyle step(FdTextStep s, Color color) => TextStyle(
        fontSize: s.size,
        height: s.lineHeight / s.size,
        fontWeight: FontWeight.values[(s.weight ~/ 100) - 1],
        color: color,
      );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: background,
    textTheme: TextTheme(
      headlineMedium: step(FdType.titulo, FdColors.texto),
      titleMedium: step(FdType.subtitulo, FdColors.texto),
      bodyLarge: step(FdType.cuerpo, FdColors.texto),
      bodyMedium: step(FdType.pequeno, FdColors.textoSuave),
      labelSmall: step(FdType.etiqueta, FdColors.textoSuave),
    ),
    cardTheme: CardThemeData(
      color: FdColors.superficie,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FdRadius.l),
        side: const BorderSide(color: FdColors.borde),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(FdRadius.m)),
      ),
    ),
  );
}
