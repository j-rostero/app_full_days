-- CreateEnum
CREATE TYPE "booking_status" AS ENUM ('held', 'in_review', 'deposit_paid', 'paid', 'expired', 'cancelled', 'completed', 'no_show');

-- CreateEnum
CREATE TYPE "booking_source" AS ENUM ('app', 'agency');

-- CreateEnum
CREATE TYPE "passenger_type" AS ENUM ('adult', 'child', 'senior', 'infant');

-- CreateEnum
CREATE TYPE "checkin" AS ENUM ('boarded', 'no_show');

-- CreateEnum
CREATE TYPE "payment_method" AS ENUM ('mobile_payment', 'bank_transfer', 'zelle', 'cash_usd');

-- CreateEnum
CREATE TYPE "payment_status" AS ENUM ('pending', 'confirmed', 'rejected');

-- CreateTable
CREATE TABLE "departure_quotas" (
    "departure_id" UUID NOT NULL,
    "key" TEXT NOT NULL,
    "limit" INTEGER NOT NULL,
    "taken" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "departure_quotas_pkey" PRIMARY KEY ("departure_id","key")
);

-- CreateTable
CREATE TABLE "bookings" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "provider_id" UUID NOT NULL,
    "departure_id" UUID NOT NULL,
    "user_id" UUID,
    "source" "booking_source" NOT NULL DEFAULT 'app',
    "status" "booking_status" NOT NULL DEFAULT 'held',
    "selection" JSONB NOT NULL,
    "lines" JSONB NOT NULL,
    "seats" INTEGER NOT NULL,
    "total_usd" DECIMAL(12,2) NOT NULL,
    "deposit_usd" DECIMAL(12,2) NOT NULL,
    "paid_usd" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "balance_due_date" DATE NOT NULL,
    "held_until" TIMESTAMP(3),
    "contact_name" TEXT,
    "contact_phone" TEXT,
    "contact_email" TEXT,
    "cancelled_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "bookings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "booking_passengers" (
    "id" UUID NOT NULL,
    "booking_id" UUID NOT NULL,
    "position" INTEGER NOT NULL,
    "type" "passenger_type" NOT NULL,
    "name" TEXT,
    "cedula" TEXT,
    "birth_date" DATE,
    "restrictions" TEXT,
    "checkin" "checkin",
    "checkin_at" TIMESTAMP(3),

    CONSTRAINT "booking_passengers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" UUID NOT NULL,
    "provider_id" UUID NOT NULL,
    "booking_id" UUID NOT NULL,
    "method" "payment_method" NOT NULL,
    "reference" TEXT NOT NULL,
    "amount_usd" DECIMAL(12,2) NOT NULL,
    "bs_per_usd" DECIMAL(14,4),
    "amount_bs" DECIMAL(16,2),
    "proof_file_id" UUID,
    "status" "payment_status" NOT NULL DEFAULT 'pending',
    "reason" TEXT,
    "idempotency_key" TEXT NOT NULL,
    "reported_by_id" UUID,
    "reviewed_by_id" UUID,
    "reviewed_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ledger_entries" (
    "id" UUID NOT NULL,
    "transaction_id" UUID NOT NULL,
    "provider_id" UUID NOT NULL,
    "booking_id" UUID,
    "payment_id" UUID,
    "account" TEXT NOT NULL,
    "debit_usd" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "credit_usd" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ledger_entries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "favorites" (
    "user_id" UUID NOT NULL,
    "product_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "favorites_pkey" PRIMARY KEY ("user_id","product_id")
);

-- CreateTable
CREATE TABLE "search_log" (
    "id" UUID NOT NULL,
    "text" TEXT,
    "filters" JSONB NOT NULL,
    "results" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "search_log_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "bookings_code_key" ON "bookings"("code");

-- CreateIndex
CREATE INDEX "bookings_provider_id_departure_id_idx" ON "bookings"("provider_id", "departure_id");

-- CreateIndex
CREATE INDEX "bookings_user_id_created_at_idx" ON "bookings"("user_id", "created_at");

-- CreateIndex
CREATE INDEX "bookings_status_held_until_idx" ON "bookings"("status", "held_until");

-- CreateIndex
CREATE UNIQUE INDEX "booking_passengers_booking_id_position_key" ON "booking_passengers"("booking_id", "position");

-- CreateIndex
CREATE UNIQUE INDEX "payments_reference_key" ON "payments"("reference");

-- CreateIndex
CREATE INDEX "payments_provider_id_status_created_at_idx" ON "payments"("provider_id", "status", "created_at");

-- CreateIndex
CREATE UNIQUE INDEX "payments_booking_id_idempotency_key_key" ON "payments"("booking_id", "idempotency_key");

-- CreateIndex
CREATE INDEX "ledger_entries_provider_id_created_at_idx" ON "ledger_entries"("provider_id", "created_at");

-- CreateIndex
CREATE INDEX "ledger_entries_transaction_id_idx" ON "ledger_entries"("transaction_id");

-- CreateIndex
CREATE INDEX "search_log_created_at_idx" ON "search_log"("created_at");

-- AddForeignKey
ALTER TABLE "departure_quotas" ADD CONSTRAINT "departure_quotas_departure_id_fkey" FOREIGN KEY ("departure_id") REFERENCES "departures"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_departure_id_fkey" FOREIGN KEY ("departure_id") REFERENCES "departures"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "booking_passengers" ADD CONSTRAINT "booking_passengers_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "bookings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "bookings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_proof_file_id_fkey" FOREIGN KEY ("proof_file_id") REFERENCES "files"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger_entries" ADD CONSTRAINT "ledger_entries_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;


-- Un cupo nunca pasa de su límite; el apartado lo toma con UPDATE condicionado.
ALTER TABLE "departure_quotas" ADD CONSTRAINT "departure_quotas_taken_check" CHECK ("taken" >= 0 AND "taken" <= "limit");
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_money_check" CHECK ("paid_usd" >= 0 AND "deposit_usd" <= "total_usd");
ALTER TABLE "payments" ADD CONSTRAINT "payments_amount_check" CHECK ("amount_usd" > 0);
ALTER TABLE "ledger_entries" ADD CONSTRAINT "ledger_entries_side_check" CHECK ("debit_usd" >= 0 AND "credit_usd" >= 0);

-- Búsqueda de texto con similitud de trigramas sobre el texto normalizado de cada salida.
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX "departures_search_text_trgm" ON "departures" USING gin ("search_text" gin_trgm_ops);
