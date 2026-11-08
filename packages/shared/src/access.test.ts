import { test } from 'node:test';
import assert from 'node:assert/strict';
import {
  PROVIDER_PERMISSIONS,
  providerPermissions,
  staffPermissions,
  STAFF_PERMISSIONS,
} from './access.ts';

test('el dueño tiene todos los permisos de agencia y el guía solo check-in y avisos', () => {
  assert.deepEqual(providerPermissions('owner'), [...PROVIDER_PERMISSIONS]);
  assert.deepEqual(providerPermissions('guide'), ['checkin', 'notices']);
});

test('los roles de Central suman permisos sin duplicar', () => {
  assert.deepEqual(staffPermissions(['support', 'moderation']), [
    'users',
    'bookings',
    'claims',
    'reviews',
    'content',
    'fulldays',
  ]);
  assert.deepEqual(staffPermissions(['super', 'finance']), [...STAFF_PERMISSIONS]);
  assert.deepEqual(staffPermissions([]), []);
});

test('solo super administra el equipo, la auditoría y los ajustes', () => {
  for (const role of ['support', 'moderation', 'content', 'finance'] as const) {
    const permissions = staffPermissions([role]);
    for (const reserved of ['staff', 'audit', 'providers', 'settings'] as const) {
      assert.ok(!permissions.includes(reserved), `${role} no debe tener ${reserved}`);
    }
  }
});
