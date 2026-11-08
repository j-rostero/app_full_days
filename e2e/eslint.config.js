import base from '@fulldays/config/eslint.js';

export default [...base, { ignores: ['test-results/**', 'playwright-report/**', '.estado/**'] }];
