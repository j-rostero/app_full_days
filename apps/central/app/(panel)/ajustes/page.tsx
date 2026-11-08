import { PAYMENT_METHODS } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../lib/api';
import { saveSettings } from './actions';

const NUMBERS = [
  ['holdMinutes', 'Minutos que se apartan los cupos mientras la persona paga'],
  ['minDepositPercent', 'Abono mínimo que puede pedir una agencia (%)'],
  ['mealChoiceDeadlineHours', 'Horas antes de la salida para elegir comidas'],
  ['platformCommissionPercent', 'Comisión de la plataforma por defecto (%)'],
] as const;

export default async function SettingsPage() {
  const settings = await read((api) => api.GET('/v1/ajustes'));
  return (
    <section className="tarjeta">
      <h2>Reglas de reserva</h2>
      <p className="suave">
        Aplican a las reservas nuevas desde que se guardan. La comisión de cada agencia se puede
        ajustar en su ficha.
      </p>
      <ActionForm action={saveSettings} submit="Guardar ajustes">
        {NUMBERS.map(([name, label]) => (
          <label key={name} className="fd-field">
            <span>{label}</span>
            <input name={name} inputMode="decimal" defaultValue={settings[name]} required />
          </label>
        ))}
        <fieldset className="fd-field">
          <legend>Métodos de pago aceptados</legend>
          {Object.entries(PAYMENT_METHODS).map(([key, label]) => (
            <label key={key} className="fd-check">
              <input
                type="checkbox"
                name="paymentMethods"
                value={key}
                defaultChecked={settings.paymentMethods.includes(key as never)}
              />{' '}
              {label}
            </label>
          ))}
        </fieldset>
      </ActionForm>
    </section>
  );
}
