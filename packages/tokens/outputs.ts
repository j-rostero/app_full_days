/** Dónde se escriben los archivos generados. Se versionan; la prueba comprueba que estén al día. */
export const OUTPUTS = {
  css: new URL('./tokens.css', import.meta.url),
  dart: new URL('../ui_flutter/lib/src/tokens.g.dart', import.meta.url),
};
