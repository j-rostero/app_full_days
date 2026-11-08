'use client';

import { type ReactNode, useMemo, useState, useTransition } from 'react';
import type { components } from '@fulldays/api-client';
import {
  CANCELLATION_TEMPLATES,
  completeness,
  DESTINATION_PAYMENTS,
  ITEM_MODALITIES,
  ITEM_TYPES,
  LODGING_REGIMES,
  MAX_PHOTOS,
  MEAL_MODES,
  MEAL_MOMENTS,
  PRODUCT_CATEGORIES,
  PRODUCT_STATUS_LABELS,
  PRODUCT_TAGS,
  PRODUCT_TYPE_LABELS,
  type ProductSheet,
  ROOM_TYPES,
  VEHICLES,
} from '@fulldays/shared';
import { uploadFile } from '../../../../../lib/upload';
import { pauseProduct, publishProduct, saveProduct } from '../actions';

type Detail = components['schemas']['ProductDetail'];
type Point = components['schemas']['BoardingPoint'];
type Message = { ok?: string; error?: string; fields?: Record<string, string> };

const newId = () => crypto.randomUUID();
const num = (value: string, fallback = 0) =>
  value.trim() === '' ? fallback : Number(value.replace(',', '.'));
const numOrNull = (value: string) => (value.trim() === '' ? null : Number(value.replace(',', '.')));

/**
 * Editor de la ficha. Toda la ficha vive aquí y se guarda entera con su versión; la
 * completitud se calcula al escribir con la misma regla que usa la API para publicar.
 */
export function Editor({
  providerId,
  product,
  destinations,
  points,
}: {
  providerId: string;
  product: Detail;
  destinations: { id: string; name: string }[];
  points: Point[];
}) {
  const [sheet, setSheet] = useState<ProductSheet>(product.sheet as ProductSheet);
  const [version, setVersion] = useState(product.version);
  const [status, setStatus] = useState(product.status);
  const [photos, setPhotos] = useState(new Map(product.photos.map((p) => [p.id, p.urls.sm])));
  const [dirty, setDirty] = useState(false);
  const [message, setMessage] = useState<Message>({});
  const [pending, start] = useTransition();
  const type = product.type;
  const result = useMemo(() => completeness(type, sheet), [type, sheet]);
  const locked = status === 'in_review';

  const update = (change: (draft: ProductSheet) => void) => {
    setSheet((current) => {
      const draft = structuredClone(current);
      change(draft);
      return draft;
    });
    setDirty(true);
  };

  const afterSave = (detail: Detail) => {
    setVersion(detail.version);
    setStatus(detail.status);
    setPhotos(new Map(detail.photos.map((p) => [p.id, p.urls.sm])));
    setDirty(false);
  };

  const save = () =>
    start(async () => {
      const res = await saveProduct(providerId, product.id, version, sheet);
      if (res.data) afterSave(res.data as Detail);
      setMessage(res);
    });

  const publish = () =>
    start(async () => {
      if (dirty) {
        const saved = await saveProduct(providerId, product.id, version, sheet);
        if (!saved.data) return setMessage(saved);
        afterSave(saved.data as Detail);
      }
      const res = await publishProduct(providerId, product.id);
      if (res.data) setStatus((res.data as Detail).status);
      setMessage(res);
    });

  const pause = () =>
    start(async () => {
      const res = await pauseProduct(providerId, product.id);
      if (res.data) setStatus((res.data as Detail).status);
      setMessage(res);
    });

  const addPhotos = (files: FileList) =>
    start(async () => {
      try {
        for (const file of Array.from(files).slice(0, MAX_PHOTOS - sheet.general.photoIds.length)) {
          const id = await uploadFile(file, 'image');
          setPhotos((current) => new Map(current).set(id, URL.createObjectURL(file)));
          update((d) => void d.general.photoIds.push(id));
        }
        setMessage({ ok: 'Fotos subidas. Guarda para conservarlas.' });
      } catch (error) {
        setMessage({ error: (error as Error).message });
      }
    });

  const g = sheet.general;
  const field = (path: string) => message.fields?.[`sheet.${path}`];

  return (
    <div className="editor">
      <header className="editor-cabecera">
        <div>
          <h2>
            {PRODUCT_TYPE_LABELS[type]}: {g.title || 'Sin título'}
          </h2>
          <p className="suave">
            <span className="fd-pill">{PRODUCT_STATUS_LABELS[status]}</span> · {result.percent} %
            completo
            {dirty ? ' · Cambios sin guardar' : ''}
          </p>
          <div className="fd-progress" aria-label={`${result.percent} % completo`}>
            <span style={{ width: `${result.percent}%` }} />
          </div>
        </div>
        <div className="editor-botones">
          <button
            type="button"
            className="fd-button"
            onClick={save}
            disabled={pending || locked || !dirty}
          >
            Guardar
          </button>
          {status === 'published' ? (
            <button
              type="button"
              className="fd-button fd-button-secundario"
              onClick={pause}
              disabled={pending}
            >
              Pausar venta
            </button>
          ) : (
            <button
              type="button"
              className="fd-button fd-button-secundario"
              onClick={publish}
              disabled={pending || locked || !result.publishable}
            >
              Publicar
            </button>
          )}
        </div>
      </header>
      {product.statusReason ? (
        <p className="fd-form-error">Central: {product.statusReason}</p>
      ) : null}
      {locked ? (
        <p className="suave">
          Central está revisando este producto. Podrás editarlo cuando responda.
        </p>
      ) : null}
      {message.error ? (
        <p className="fd-form-error" role="alert">
          {message.error}
        </p>
      ) : null}
      {message.ok ? (
        <p className="fd-form-ok" role="status">
          {message.ok}
        </p>
      ) : null}

      <fieldset disabled={locked || pending} className="editor-cuerpo">
        <Block
          title="Datos generales"
          missing={result.blocks.find((b) => b.block === 'general')?.missing}
        >
          <Text
            label="Título"
            value={g.title}
            max={120}
            onChange={(v) => update((d) => void (d.general.title = v))}
            error={field('general.title')}
          />
          <Text
            label="Resumen (aparece en el buscador)"
            value={g.summary}
            max={200}
            onChange={(v) => update((d) => void (d.general.summary = v))}
          />
          <Text
            label="Descripción"
            value={g.description}
            max={5000}
            long
            onChange={(v) => update((d) => void (d.general.description = v))}
          />
          <div className="fd-inline">
            <Select
              label="Categoría"
              value={g.category ?? ''}
              options={PRODUCT_CATEGORIES}
              empty="Escoge"
              onChange={(v) => update((d) => void (d.general.category = (v || null) as never))}
            />
            <label className="fd-field">
              <span>Destino</span>
              <select
                value={g.destinationId ?? ''}
                onChange={(e) =>
                  update((d) => void (d.general.destinationId = e.target.value || null))
                }
              >
                <option value="">Escoge</option>
                {destinations.map((x) => (
                  <option key={x.id} value={x.id}>
                    {x.name}
                  </option>
                ))}
              </select>
            </label>
            <NumberField
              label="Edad mínima"
              value={g.minAge}
              onChange={(v) => update((d) => void (d.general.minAge = num(v)))}
            />
          </div>
          <div className="fd-inline">
            <Check
              label="Admite niños"
              checked={g.childrenAllowed}
              onChange={(v) => update((d) => void (d.general.childrenAllowed = v))}
            />
            <Check
              label="Admite mascotas"
              checked={g.petsAllowed}
              onChange={(v) => update((d) => void (d.general.petsAllowed = v))}
            />
          </div>
          <p className="fd-etiqueta">Etiquetas</p>
          <div className="fd-inline">
            {Object.entries(PRODUCT_TAGS).map(([key, label]) => (
              <Check
                key={key}
                label={label}
                checked={g.tags.includes(key as never)}
                onChange={(on) =>
                  update(
                    (d) =>
                      void (d.general.tags = on
                        ? [...d.general.tags, key as never]
                        : d.general.tags.filter((t) => t !== key)),
                  )
                }
              />
            ))}
          </div>
          <p className="fd-etiqueta">
            Fotos ({g.photoIds.length} de {MAX_PHOTOS}; la primera es la portada)
          </p>
          <div className="fotos">
            {g.photoIds.map((id, index) => (
              <figure key={id}>
                {photos.get(id) ? (
                  <img src={photos.get(id)} alt={`Foto ${index + 1}`} />
                ) : (
                  <div className="foto-vacia">Foto</div>
                )}
                <figcaption>
                  {index > 0 ? (
                    <button
                      type="button"
                      onClick={() =>
                        update(
                          (d) =>
                            void d.general.photoIds.unshift(...d.general.photoIds.splice(index, 1)),
                        )
                      }
                    >
                      Portada
                    </button>
                  ) : null}
                  <button
                    type="button"
                    onClick={() => update((d) => void d.general.photoIds.splice(index, 1))}
                  >
                    Quitar
                  </button>
                </figcaption>
              </figure>
            ))}
          </div>
          {g.photoIds.length < MAX_PHOTOS ? (
            <label className="fd-field">
              <span>Agregar fotos (JPG, PNG o WebP)</span>
              <input
                type="file"
                accept="image/jpeg,image/png,image/webp"
                multiple
                onChange={(e) => e.target.files && addPhotos(e.target.files)}
              />
            </label>
          ) : null}
        </Block>

        <Block title="Duración">
          <div className="fd-inline">
            {type === 'tour' ? (
              <>
                <NumberField
                  label="Días"
                  value={sheet.duration.days}
                  onChange={(v) => update((d) => void (d.duration.days = Math.max(1, num(v, 1))))}
                />
                <NumberField
                  label="Noches"
                  value={sheet.duration.nights}
                  onChange={(v) => update((d) => void (d.duration.nights = num(v)))}
                />
              </>
            ) : type === 'excursion' ? (
              <NumberField
                label="Horas"
                value={sheet.duration.hours ?? ''}
                onChange={(v) => update((d) => void (d.duration.hours = numOrNull(v)))}
              />
            ) : (
              <p className="suave">Un fullday dura un día, sin noches.</p>
            )}
          </div>
        </Block>

        <Block
          title="Itinerario"
          missing={result.blocks.find((b) => b.block === 'itinerary')?.missing}
        >
          {sheet.itinerary.map((step, i) => (
            <div className="fd-inline fila" key={i}>
              {sheet.duration.days > 1 ? (
                <NumberField
                  label="Día"
                  value={step.day}
                  onChange={(v) =>
                    update((d) => void (d.itinerary[i]!.day = Math.max(1, num(v, 1))))
                  }
                />
              ) : null}
              <Text
                label="Hora (HH:MM)"
                value={step.time ?? ''}
                onChange={(v) => update((d) => void (d.itinerary[i]!.time = v || null))}
              />
              <Text
                label="Qué pasa"
                value={step.title}
                onChange={(v) => update((d) => void (d.itinerary[i]!.title = v))}
              />
              <Text
                label="Detalle"
                value={step.description}
                onChange={(v) => update((d) => void (d.itinerary[i]!.description = v))}
              />
              <Remove onClick={() => update((d) => void d.itinerary.splice(i, 1))} />
            </div>
          ))}
          <Add
            label="Agregar paso"
            onClick={() =>
              update(
                (d) => void d.itinerary.push({ day: 1, time: null, title: '', description: '' }),
              )
            }
          />
        </Block>

        <Block
          title={type === 'excursion' ? 'Punto de encuentro' : 'Traslado y embarque'}
          missing={result.blocks.find((b) => b.block === 'transfer')?.missing}
        >
          <div className="fd-inline">
            <Select
              label="Vehículo"
              value={sheet.transfer.vehicle ?? ''}
              options={VEHICLES}
              empty="Escoge"
              onChange={(v) => update((d) => void (d.transfer.vehicle = (v || null) as never))}
            />
            <Text
              label="Notas del traslado"
              value={sheet.transfer.notes}
              onChange={(v) => update((d) => void (d.transfer.notes = v))}
            />
          </div>
          {sheet.transfer.boardingPoints.map((b, i) => (
            <div className="fd-inline fila" key={b.id}>
              <label className="fd-field">
                <span>Punto</span>
                <select
                  value={b.boardingPointId ?? ''}
                  onChange={(e) =>
                    update(
                      (d) =>
                        void (d.transfer.boardingPoints[i]!.boardingPointId =
                          e.target.value || null),
                    )
                  }
                >
                  <option value="">Otro (escríbelo)</option>
                  {points.map((p) => (
                    <option key={p.id} value={p.id}>
                      {p.city} · {p.name}
                    </option>
                  ))}
                </select>
              </label>
              {b.boardingPointId ? null : (
                <>
                  <Text
                    label="Nombre"
                    value={b.name}
                    onChange={(v) => update((d) => void (d.transfer.boardingPoints[i]!.name = v))}
                  />
                  <Text
                    label="Ciudad"
                    value={b.city}
                    onChange={(v) => update((d) => void (d.transfer.boardingPoints[i]!.city = v))}
                  />
                  <Text
                    label="Dirección"
                    value={b.address}
                    onChange={(v) =>
                      update((d) => void (d.transfer.boardingPoints[i]!.address = v))
                    }
                  />
                </>
              )}
              <Text
                label="Sale (HH:MM)"
                value={b.departureTime ?? ''}
                onChange={(v) =>
                  update((d) => void (d.transfer.boardingPoints[i]!.departureTime = v || null))
                }
              />
              <Text
                label="Regresa (HH:MM)"
                value={b.returnTime ?? ''}
                onChange={(v) =>
                  update((d) => void (d.transfer.boardingPoints[i]!.returnTime = v || null))
                }
              />
              <NumberField
                label="Ajuste de precio USD"
                value={b.priceDeltaUsd}
                onChange={(v) =>
                  update((d) => void (d.transfer.boardingPoints[i]!.priceDeltaUsd = num(v)))
                }
              />
              <Remove onClick={() => update((d) => void d.transfer.boardingPoints.splice(i, 1))} />
            </div>
          ))}
          <Add
            label="Agregar punto"
            onClick={() =>
              update(
                (d) =>
                  void d.transfer.boardingPoints.push({
                    id: newId(),
                    boardingPointId: null,
                    name: '',
                    address: '',
                    city: '',
                    departureTime: null,
                    returnTime: null,
                    priceDeltaUsd: 0,
                  }),
              )
            }
          />
        </Block>

        <Block title="Comidas" missing={result.blocks.find((b) => b.block === 'meals')?.missing}>
          {sheet.meals.map((meal, i) => (
            <div className="fila-bloque" key={meal.id}>
              <div className="fd-inline">
                {sheet.duration.days > 1 ? (
                  <NumberField
                    label="Día"
                    value={meal.day}
                    onChange={(v) => update((d) => void (d.meals[i]!.day = Math.max(1, num(v, 1))))}
                  />
                ) : null}
                <Select
                  label="Momento"
                  value={meal.moment}
                  options={MEAL_MOMENTS}
                  onChange={(v) => update((d) => void (d.meals[i]!.moment = v as never))}
                />
                <Select
                  label="Modalidad"
                  value={meal.mode}
                  options={MEAL_MODES}
                  onChange={(v) => update((d) => void (d.meals[i]!.mode = v as never))}
                />
                <Text
                  label="Qué se sirve"
                  value={meal.description}
                  onChange={(v) => update((d) => void (d.meals[i]!.description = v))}
                />
                {meal.mode === 'optional' ? (
                  <NumberField
                    label="Precio USD"
                    value={meal.priceUsd}
                    onChange={(v) => update((d) => void (d.meals[i]!.priceUsd = num(v)))}
                  />
                ) : null}
                <Remove onClick={() => update((d) => void d.meals.splice(i, 1))} />
              </div>
              {meal.mode === 'choice' ? (
                <div className="opciones">
                  <NumberField
                    label="Opciones que escoge cada pasajero"
                    value={meal.picksPerPassenger}
                    onChange={(v) =>
                      update((d) => void (d.meals[i]!.picksPerPassenger = Math.max(1, num(v, 1))))
                    }
                  />
                  {meal.options.map((o, j) => (
                    <div className="fd-inline" key={o.id}>
                      <Text
                        label="Opción"
                        value={o.name}
                        onChange={(v) => update((d) => void (d.meals[i]!.options[j]!.name = v))}
                      />
                      <NumberField
                        label="Recargo USD"
                        value={o.priceUsd}
                        onChange={(v) =>
                          update((d) => void (d.meals[i]!.options[j]!.priceUsd = num(v)))
                        }
                      />
                      <NumberField
                        label="Porciones (vacío: sin tope)"
                        value={o.limit ?? ''}
                        onChange={(v) =>
                          update((d) => void (d.meals[i]!.options[j]!.limit = numOrNull(v)))
                        }
                      />
                      <Check
                        label="Por defecto"
                        checked={o.isDefault}
                        onChange={(on) =>
                          update((d) =>
                            d.meals[i]!.options.forEach((x, k) => (x.isDefault = on && k === j)),
                          )
                        }
                      />
                      <Remove
                        onClick={() => update((d) => void d.meals[i]!.options.splice(j, 1))}
                      />
                    </div>
                  ))}
                  <Add
                    label="Agregar opción"
                    onClick={() =>
                      update(
                        (d) =>
                          void d.meals[i]!.options.push({
                            id: newId(),
                            name: '',
                            priceUsd: 0,
                            limit: null,
                            isDefault: d.meals[i]!.options.length === 0,
                          }),
                      )
                    }
                  />
                </div>
              ) : null}
            </div>
          ))}
          <Add
            label="Agregar comida"
            onClick={() =>
              update(
                (d) =>
                  void d.meals.push({
                    id: newId(),
                    day: 1,
                    moment: 'lunch',
                    mode: 'fixed',
                    description: '',
                    options: [],
                    picksPerPassenger: 1,
                    priceUsd: 0,
                  }),
              )
            }
          />
        </Block>

        <Block
          title="Qué incluye, extras y entradas"
          missing={[
            ...(result.blocks.find((b) => b.block === 'essentials')?.missing ?? []),
            ...(result.blocks.find((b) => b.block === 'access')?.missing ?? []),
          ]}
        >
          {sheet.items.map((item, i) => (
            <div className="fd-inline fila" key={item.id}>
              <Select
                label="Tipo"
                value={item.type}
                options={ITEM_TYPES}
                onChange={(v) => update((d) => void (d.items[i]!.type = v as never))}
              />
              <Text
                label="Nombre"
                value={item.name}
                onChange={(v) => update((d) => void (d.items[i]!.name = v))}
              />
              <Select
                label="Modalidad"
                value={item.modality}
                options={ITEM_MODALITIES}
                onChange={(v) => update((d) => void (d.items[i]!.modality = v as never))}
              />
              {item.modality === 'optional' || item.modality === 'pay_at_destination' ? (
                <NumberField
                  label="Precio USD"
                  value={item.priceUsd}
                  onChange={(v) => update((d) => void (d.items[i]!.priceUsd = num(v)))}
                />
              ) : null}
              {item.modality === 'pay_at_destination' ? (
                <Select
                  label="Cómo se paga"
                  value={item.payment ?? ''}
                  options={DESTINATION_PAYMENTS}
                  empty="Escoge"
                  onChange={(v) => update((d) => void (d.items[i]!.payment = (v || null) as never))}
                />
              ) : null}
              <Remove onClick={() => update((d) => void d.items.splice(i, 1))} />
            </div>
          ))}
          <Add
            label="Agregar"
            onClick={() =>
              update(
                (d) =>
                  void d.items.push({
                    id: newId(),
                    type: 'service',
                    name: '',
                    modality: 'included',
                    priceUsd: 0,
                    payment: null,
                  }),
              )
            }
          />
          <Check
            label="No hay entradas ni accesos que pagar"
            checked={sheet.noAccessFees}
            onChange={(v) => update((d) => void (d.noAccessFees = v))}
          />
        </Block>

        {type === 'tour' || sheet.duration.nights > 0 ? (
          <Block
            title="Alojamiento"
            missing={result.blocks.find((b) => b.block === 'lodging')?.missing}
          >
            <div className="fd-inline">
              <Text
                label="Nombre del alojamiento"
                value={sheet.lodging?.name ?? ''}
                onChange={(v) =>
                  update(
                    (d) => void ((d.lodging ??= { name: '', regime: null, rooms: [] }).name = v),
                  )
                }
              />
              <Select
                label="Régimen"
                value={sheet.lodging?.regime ?? ''}
                options={LODGING_REGIMES}
                empty="Escoge"
                onChange={(v) =>
                  update(
                    (d) =>
                      void ((d.lodging ??= { name: '', regime: null, rooms: [] }).regime = (v ||
                        null) as never),
                  )
                }
              />
            </div>
            {(sheet.lodging?.rooms ?? []).map((room, i) => (
              <div className="fd-inline fila" key={room.id}>
                <Select
                  label="Habitación"
                  value={room.type}
                  options={ROOM_TYPES}
                  onChange={(v) => update((d) => void (d.lodging!.rooms[i]!.type = v as never))}
                />
                <NumberField
                  label="Personas"
                  value={room.occupancy}
                  onChange={(v) =>
                    update((d) => void (d.lodging!.rooms[i]!.occupancy = Math.max(1, num(v, 1))))
                  }
                />
                <NumberField
                  label="Disponibles (vacío: sin tope)"
                  value={room.quantity ?? ''}
                  onChange={(v) =>
                    update((d) => void (d.lodging!.rooms[i]!.quantity = numOrNull(v)))
                  }
                />
                <NumberField
                  label="Ajuste de precio USD"
                  value={room.priceDeltaUsd}
                  onChange={(v) =>
                    update((d) => void (d.lodging!.rooms[i]!.priceDeltaUsd = num(v)))
                  }
                />
                <Remove onClick={() => update((d) => void d.lodging!.rooms.splice(i, 1))} />
              </div>
            ))}
            <Add
              label="Agregar habitación"
              onClick={() =>
                update(
                  (d) =>
                    void (d.lodging ??= { name: '', regime: null, rooms: [] }).rooms.push({
                      id: newId(),
                      type: 'double',
                      occupancy: 2,
                      quantity: null,
                      priceDeltaUsd: 0,
                    }),
                )
              }
            />
          </Block>
        ) : null}

        <Block
          title="Qué llevar"
          missing={result.blocks.find((b) => b.block === 'whatToBring')?.missing}
        >
          <Text
            label="Una cosa por línea"
            long
            value={sheet.whatToBring.join('\n')}
            onChange={(v) =>
              update(
                (d) =>
                  void (d.whatToBring = v
                    .split('\n')
                    .map((x) => x.trim())
                    .filter(Boolean)),
              )
            }
          />
        </Block>

        <Block
          title="Precios y condiciones"
          missing={result.blocks.find((b) => b.block === 'pricing')?.missing}
        >
          <div className="fd-inline">
            <NumberField
              label="Adulto USD"
              value={sheet.pricing.fares.adult}
              onChange={(v) => update((d) => void (d.pricing.fares.adult = num(v)))}
            />
            <NumberField
              label="Niño USD (vacío: como adulto)"
              value={sheet.pricing.fares.child ?? ''}
              onChange={(v) => update((d) => void (d.pricing.fares.child = numOrNull(v)))}
            />
            <NumberField
              label="Adulto mayor USD"
              value={sheet.pricing.fares.senior ?? ''}
              onChange={(v) => update((d) => void (d.pricing.fares.senior = numOrNull(v)))}
            />
            <NumberField
              label="Infante USD"
              value={sheet.pricing.fares.infant ?? ''}
              onChange={(v) => update((d) => void (d.pricing.fares.infant = numOrNull(v)))}
            />
          </div>
          <div className="fd-inline">
            <Select
              label="Abono para reservar"
              value={sheet.pricing.deposit?.kind ?? ''}
              options={{ percent: 'Porcentaje del total', amount: 'Monto fijo por puesto (USD)' }}
              empty="Escoge"
              onChange={(v) =>
                update(
                  (d) =>
                    void (d.pricing.deposit = v
                      ? { kind: v as 'percent', value: d.pricing.deposit?.value ?? 30 }
                      : null),
                )
              }
            />
            {sheet.pricing.deposit ? (
              <NumberField
                label={sheet.pricing.deposit.kind === 'percent' ? 'Porcentaje' : 'USD por puesto'}
                value={sheet.pricing.deposit.value}
                onChange={(v) => update((d) => void (d.pricing.deposit!.value = num(v)))}
              />
            ) : null}
            <NumberField
              label="El saldo vence (días antes)"
              value={sheet.pricing.balanceDueDaysBefore ?? ''}
              onChange={(v) => update((d) => void (d.pricing.balanceDueDaysBefore = numOrNull(v)))}
            />
          </div>
          <Select
            label="Política de cancelación"
            value={sheet.pricing.cancellation.template ?? ''}
            options={CANCELLATION_TEMPLATES}
            empty="Escribir la mía"
            onChange={(v) =>
              update((d) => void (d.pricing.cancellation.template = (v || null) as never))
            }
          />
          {sheet.pricing.cancellation.template ? null : (
            <Text
              label="Tu política"
              long
              value={sheet.pricing.cancellation.text ?? ''}
              onChange={(v) => update((d) => void (d.pricing.cancellation.text = v || null))}
            />
          )}
        </Block>
      </fieldset>

      {result.missing.length ? (
        <aside className="tarjeta">
          <h2>Para publicar falta</h2>
          <ul>
            {result.missing.map((m) => (
              <li key={m}>{m}</li>
            ))}
          </ul>
        </aside>
      ) : null}
    </div>
  );
}

function Block({
  title,
  missing,
  children,
}: {
  title: string;
  missing?: string[];
  children: ReactNode;
}) {
  return (
    <section className="tarjeta">
      <h2>
        {title} {missing && missing.length === 0 ? <span className="fd-pill">Completo</span> : null}
      </h2>
      {missing?.length ? <p className="suave">Falta: {missing.join(', ')}.</p> : null}
      {children}
    </section>
  );
}

function Text({
  label,
  value,
  onChange,
  long,
  max,
  error,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  long?: boolean;
  max?: number;
  error?: string;
}) {
  return (
    <label className="fd-field">
      <span>{label}</span>
      {long ? (
        <textarea value={value} maxLength={max} onChange={(e) => onChange(e.target.value)} />
      ) : (
        <input
          value={value}
          maxLength={max}
          onChange={(e) => onChange(e.target.value)}
          aria-invalid={error ? true : undefined}
        />
      )}
      {error ? <small className="error">{error}</small> : null}
    </label>
  );
}

function NumberField({
  label,
  value,
  onChange,
}: {
  label: string;
  value: number | string;
  onChange: (v: string) => void;
}) {
  return (
    <label className="fd-field">
      <span>{label}</span>
      <input inputMode="decimal" value={String(value)} onChange={(e) => onChange(e.target.value)} />
    </label>
  );
}

function Select({
  label,
  value,
  options,
  onChange,
  empty,
}: {
  label: string;
  value: string;
  options: Record<string, string>;
  onChange: (v: string) => void;
  empty?: string;
}) {
  return (
    <label className="fd-field">
      <span>{label}</span>
      <select value={value} onChange={(e) => onChange(e.target.value)}>
        {empty !== undefined ? <option value="">{empty}</option> : null}
        {Object.entries(options).map(([key, text]) => (
          <option key={key} value={key}>
            {text}
          </option>
        ))}
      </select>
    </label>
  );
}

function Check({
  label,
  checked,
  onChange,
}: {
  label: string;
  checked: boolean;
  onChange: (v: boolean) => void;
}) {
  return (
    <label className="fd-check">
      <input type="checkbox" checked={checked} onChange={(e) => onChange(e.target.checked)} />
      {label}
    </label>
  );
}

function Add({ label, onClick }: { label: string; onClick: () => void }) {
  return (
    <button type="button" className="fd-button fd-button-secundario boton-chico" onClick={onClick}>
      {label}
    </button>
  );
}

function Remove({ onClick }: { onClick: () => void }) {
  return (
    <button type="button" className="fd-link-button" onClick={onClick}>
      Quitar
    </button>
  );
}
