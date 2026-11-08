import { test } from 'node:test';
import assert from 'node:assert/strict';
import {
  CedulaSchema,
  EmailSchema,
  OtpCodeSchema,
  PassengerInputSchema,
  PasswordSchema,
  PhoneSchema,
} from './identity.ts';

test('el correo se normaliza a minúsculas sin espacios', () => {
  assert.equal(EmailSchema.parse('  Ana@Ejemplo.COM '), 'ana@ejemplo.com');
  assert.equal(EmailSchema.safeParse('ana@').success, false);
});

test('contraseña de 8 a 128 caracteres', () => {
  assert.equal(PasswordSchema.safeParse('1234567').success, false);
  assert.equal(PasswordSchema.safeParse('12345678').success, true);
  assert.equal(PasswordSchema.safeParse('x'.repeat(129)).success, false);
});

test('código de 6 dígitos', () => {
  assert.equal(OtpCodeSchema.parse(' 123456 '), '123456');
  assert.equal(OtpCodeSchema.safeParse('12345a').success, false);
});

test('teléfonos venezolanos e internacionales en E.164', () => {
  assert.equal(PhoneSchema.parse('0414-123.45.67'), '+584141234567');
  assert.equal(PhoneSchema.parse('58 424 1234567'), '+584241234567');
  assert.equal(PhoneSchema.parse('+1 305 555 0100'), '+13055550100');
  assert.equal(PhoneSchema.parse('0034 600 123 456'), '+34600123456');
  assert.equal(PhoneSchema.safeParse('0212 1234567').success, false, 'fijo de Caracas');
  assert.equal(PhoneSchema.safeParse('3055550100').success, false, 'sin prefijo internacional');
});

test('cédula con o sin letra', () => {
  assert.equal(CedulaSchema.parse('12.345.678'), 'V-12345678');
  assert.equal(CedulaSchema.parse('e-81234567'), 'E-81234567');
  assert.equal(CedulaSchema.safeParse('V-123').success, false);
});

test('pasajero frecuente: fecha real, no futura', () => {
  const ok = PassengerInputSchema.parse({ name: 'Ana Pérez', birthDate: '1990-05-01' });
  assert.equal(ok.cedula, null);
  assert.equal(
    PassengerInputSchema.safeParse({ name: 'Ana', birthDate: '2999-01-01' }).success,
    false,
  );
  assert.equal(
    PassengerInputSchema.safeParse({ name: 'Ana', birthDate: '1990-02-30' }).success,
    false,
  );
  assert.equal(
    PassengerInputSchema.safeParse({ name: 'Ana', birthDate: '1990-01-01', extra: 1 }).success,
    false,
    'campos desconocidos',
  );
});
