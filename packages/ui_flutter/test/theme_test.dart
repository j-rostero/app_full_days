import 'package:flutter_test/flutter_test.dart';
import 'package:fulldays_ui/fulldays_ui.dart';

void main() {
  test('cada producto usa su color principal', () {
    expect(fdTheme(FdProduct.viajero).colorScheme.primary, FdColors.primario);
    expect(fdTheme(FdProduct.operador).colorScheme.primary, FdProColors.primario);
  });

  test('la escala tipográfica sale de los tokens', () {
    final theme = fdTheme(FdProduct.viajero);
    expect(theme.textTheme.bodyLarge?.fontSize, FdType.cuerpo.size);
    expect(theme.textTheme.headlineMedium?.fontWeight?.value, FdType.titulo.weight);
  });
}
