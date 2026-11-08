# Una de las tres webs Next, como servidor autocontenido.
#   docker build -f infra/docker/web.Dockerfile --build-arg APP=web -t fulldays-web .
#   (APP = web | pro-web | central)
FROM node:24-slim AS build
ARG APP
RUN corepack enable
# Detrás de un proxy con certificado propio: --secret id=ca,src=ruta/al/ca.pem
WORKDIR /repo
COPY . .
RUN --mount=type=secret,id=ca,required=false \
  if [ -f /run/secrets/ca ]; then export NODE_EXTRA_CA_CERTS=/run/secrets/ca; fi; \
  pnpm install --frozen-lockfile
ENV NEXT_OUTPUT=standalone NEXT_TELEMETRY_DISABLED=1
RUN pnpm --filter "@fulldays/${APP}..." build
RUN mkdir -p apps/${APP}/public \
  && cp -r apps/${APP}/.next/static apps/${APP}/.next/standalone/apps/${APP}/.next/static \
  && cp -r apps/${APP}/public apps/${APP}/.next/standalone/apps/${APP}/public \
  && mv apps/${APP}/.next/standalone /out && echo "apps/${APP}/server.js" > /out/.entrada

FROM node:24-slim AS runtime
ENV NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 HOSTNAME=0.0.0.0 PORT=3000
WORKDIR /app
COPY --from=build --chown=node:node /out .
USER node
EXPOSE 3000
CMD ["sh", "-c", "exec node $(cat .entrada)"]
