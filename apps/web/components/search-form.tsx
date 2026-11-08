import { PRODUCT_CATEGORIES, PRODUCT_TYPE_LABELS, SEARCH_ORDERS } from '@fulldays/shared';

type Values = Partial<Record<string, string>>;

/** Buscador por GET: la URL de resultados se comparte y la indexan los buscadores. */
export function SearchForm({ values = {}, full = false }: { values?: Values; full?: boolean }) {
  return (
    <form action="/buscar" className="buscador">
      <label className="fd-field">
        <span>¿A dónde quieres ir?</span>
        <input name="q" defaultValue={values.q} placeholder="Los Roques, Mochima, Canaima…" />
      </label>
      <label className="fd-field">
        <span>Saliendo de</span>
        <input name="desde" defaultValue={values.desde} placeholder="Caracas" />
      </label>
      <label className="fd-field">
        <span>Desde el</span>
        <input type="date" name="fechaDesde" defaultValue={values.fechaDesde} />
      </label>
      {full ? (
        <>
          <label className="fd-field">
            <span>Hasta el</span>
            <input type="date" name="fechaHasta" defaultValue={values.fechaHasta} />
          </label>
          <label className="fd-field">
            <span>Tipo</span>
            <select name="tipo" defaultValue={values.tipo ?? ''}>
              <option value="">Todos</option>
              {Object.entries(PRODUCT_TYPE_LABELS).map(([k, v]) => (
                <option key={k} value={k}>
                  {v}
                </option>
              ))}
            </select>
          </label>
          <label className="fd-field">
            <span>Categoría</span>
            <select name="categoria" defaultValue={values.categoria ?? ''}>
              <option value="">Todas</option>
              {Object.entries(PRODUCT_CATEGORIES).map(([k, v]) => (
                <option key={k} value={k}>
                  {v}
                </option>
              ))}
            </select>
          </label>
          <label className="fd-field">
            <span>Precio máximo (USD)</span>
            <input name="precioMax" inputMode="decimal" defaultValue={values.precioMax} />
          </label>
          <label className="fd-field">
            <span>Ordenar por</span>
            <select name="orden" defaultValue={values.orden ?? 'recomendados'}>
              {Object.entries(SEARCH_ORDERS).map(([k, v]) => (
                <option key={k} value={k}>
                  {v}
                </option>
              ))}
            </select>
          </label>
          <label className="fd-check">
            <input
              type="checkbox"
              name="verificados"
              value="true"
              defaultChecked={values.verificados === 'true'}
            />{' '}
            Solo agencias verificadas
          </label>
          <label className="fd-check">
            <input
              type="checkbox"
              name="ninos"
              value="true"
              defaultChecked={values.ninos === 'true'}
            />{' '}
            Apto para niños
          </label>
          <label className="fd-check">
            <input
              type="checkbox"
              name="mascotas"
              value="true"
              defaultChecked={values.mascotas === 'true'}
            />{' '}
            Admite mascotas
          </label>
          {values.destino ? <input type="hidden" name="destino" value={values.destino} /> : null}
          {values.tematica ? <input type="hidden" name="tematica" value={values.tematica} /> : null}
        </>
      ) : null}
      <button type="submit" className="fd-button">
        Buscar
      </button>
    </form>
  );
}
