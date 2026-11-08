/** Campos de la agencia, compartidos por el alta y la edición. */
export function ProviderFields({ values }: { values?: Partial<Record<string, unknown>> }) {
  const field = (name: string, label: string, props: Record<string, unknown> = {}) => (
    <label className="fd-field">
      <span>{label}</span>
      <input name={name} defaultValue={String(values?.[name] ?? '')} {...props} />
    </label>
  );
  return (
    <>
      {field('name', 'Nombre comercial', { required: true })}
      {field('legalName', 'Razón social o nombre completo', { required: true })}
      {field('rtn', 'RTN (opcional: con él tu agencia luce como verificada)')}
      {field('baseCity', 'Ciudad desde donde operas', { required: true })}
      {field('phone', 'Teléfono de contacto para FullDays', {
        required: true,
        placeholder: '0414 1234567',
      })}
      {field('instagram', 'Instagram (opcional)', { placeholder: 'tuagencia' })}
      <label className="fd-field">
        <span>Instrucciones de pago para tus viajeros (opcional)</span>
        <textarea
          name="paymentInstructions"
          defaultValue={String(values?.paymentInstructions ?? '')}
        />
      </label>
    </>
  );
}
