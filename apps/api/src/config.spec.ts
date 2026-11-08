import { test } from 'node:test';
import assert from 'node:assert/strict';
import { loadConfig } from './config.ts';

const production = {
  NODE_ENV: 'production',
  JWT_SECRET: 'x'.repeat(40),
  OTP_SENDER: 'smtp',
  NOTIFICATION_EMAIL: 'smtp',
  VOUCHER_SIGNING_KEY: 'ab'.repeat(32),
  IMGPROXY_KEY: 'a1b2c3d4',
  IMGPROXY_SALT: 'e5f6a7b8',
  S3_SECRET_KEY: 'una-clave-real',
  WEB_SERVER_KEY: 'k'.repeat(40),
};

test('producción arranca con valores propios', () => {
  assert.equal(loadConfig(production).NODE_ENV, 'production');
});

test('producción rechaza cada valor de desarrollo y nombra la variable', () => {
  for (const [key, value] of [
    ['OTP_SENDER', 'log'],
    ['NOTIFICATION_EMAIL', 'log'],
    ['IMGPROXY_SALT', '68656C6C6F'],
    ['S3_SECRET_KEY', 'fulldays-secret'],
    ['WEB_SERVER_KEY', undefined],
    ['OTP_FIXED_CODE', '123456'],
    ['STORAGE_DRIVER', 'memory'],
  ] as const) {
    const env = { ...production, [key]: value };
    if (value === undefined) delete (env as Record<string, unknown>)[key];
    assert.throws(() => loadConfig(env), new RegExp(key), key);
  }
});
