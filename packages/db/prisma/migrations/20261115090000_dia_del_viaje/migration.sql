
-- AlterTable
ALTER TABLE "booking_passengers" ADD COLUMN     "checkin_by_id" UUID,
ADD COLUMN     "meal_picks" JSONB NOT NULL DEFAULT '{}';

-- CreateTable
CREATE TABLE "departure_notices" (
    "id" UUID NOT NULL,
    "provider_id" UUID NOT NULL,
    "departure_id" UUID NOT NULL,
    "author_id" UUID NOT NULL,
    "body" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "departure_notices_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "departure_notices_departure_id_created_at_idx" ON "departure_notices"("departure_id", "created_at");

-- AddForeignKey
ALTER TABLE "departure_notices" ADD CONSTRAINT "departure_notices_departure_id_fkey" FOREIGN KEY ("departure_id") REFERENCES "departures"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "departure_notices" ADD CONSTRAINT "departure_notices_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;


-- Un aviso se lee en una pantalla de teléfono.
ALTER TABLE "departure_notices" ADD CONSTRAINT "departure_notices_body_length" CHECK (char_length(body) BETWEEN 1 AND 1000);
