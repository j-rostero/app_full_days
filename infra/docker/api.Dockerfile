# API y worker: una sola imagen, dos procesos.
#   docker build -f infra/docker/api.Dockerfile -t fulldays-api .
#   docker run fulldays-api                     # API en el puerto 4000
#   docker run fulldays-api node dist/worker.js # worker
#   docker build -f infra/docker/api.Dockerfile --target migrate -t fulldays-migrate .
FROM node:24-slim AS build
RUN corepack enable
# Detrás de un proxy con certificado propio: --secret id=ca,src=ruta/al/ca.pem
WORKDIR /repo
COPY . .
RUN --mount=type=secret,id=ca,required=false \
  if [ -f /run/secrets/ca ]; then export NODE_EXTRA_CA_CERTS=/run/secrets/ca; fi; \
  pnpm install --frozen-lockfile
RUN pnpm --filter @fulldays/api... build
RUN pnpm --filter @fulldays/api deploy --prod --legacy /out

# Aplica las migraciones pendientes y termina. Se corre antes de cada despliegue.
FROM build AS migrate
WORKDIR /repo/packages/db
CMD ["pnpm", "migrate:deploy"]

FROM node:24-slim AS runtime
ENV NODE_ENV=production
WORKDIR /app
COPY --from=build --chown=node:node /out .
USER node
EXPOSE 4000
HEALTHCHECK --interval=15s --timeout=3s --retries=3 \
  CMD node -e "fetch('http://localhost:'+(process.env.PORT||4000)+'/salud').then(r=>process.exit(r.ok?0:1),()=>process.exit(1))"
CMD ["node", "dist/main.js"]
