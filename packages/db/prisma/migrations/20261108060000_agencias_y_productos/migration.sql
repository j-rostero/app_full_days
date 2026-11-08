-- CreateEnum
CREATE TYPE "provider_kind" AS ENUM ('person', 'company');

-- CreateEnum
CREATE TYPE "provider_status" AS ENUM ('pending', 'in_review', 'approved', 'rejected', 'suspended');

-- CreateEnum
CREATE TYPE "provider_document_type" AS ENUM ('rif', 'representative_id', 'rtn', 'commercial_registry', 'other');

-- CreateEnum
CREATE TYPE "file_kind" AS ENUM ('image', 'document');

-- CreateEnum
CREATE TYPE "file_status" AS ENUM ('pending', 'ready');

-- CreateEnum
CREATE TYPE "product_type" AS ENUM ('fullday', 'tour', 'excursion');

-- CreateEnum
CREATE TYPE "product_status" AS ENUM ('draft', 'in_review', 'published', 'paused');

-- CreateEnum
CREATE TYPE "departure_status" AS ENUM ('open', 'paused', 'closed', 'in_progress', 'finished', 'cancelled');

-- AlterTable
ALTER TABLE "providers" ADD COLUMN     "base_city" TEXT NOT NULL,
ADD COLUMN     "commission_percent" DECIMAL(5,2),
ADD COLUMN     "instagram" TEXT,
ADD COLUMN     "kind" "provider_kind" NOT NULL,
ADD COLUMN     "legal_name" TEXT NOT NULL,
ADD COLUMN     "payment_instructions" TEXT,
ADD COLUMN     "phone" TEXT NOT NULL,
ADD COLUMN     "rif" TEXT NOT NULL,
ADD COLUMN     "rtn" TEXT,
ADD COLUMN     "status" "provider_status" NOT NULL DEFAULT 'pending',
ADD COLUMN     "status_reason" TEXT,
ADD COLUMN     "submitted_at" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "provider_documents" (
    "id" UUID NOT NULL,
    "provider_id" UUID NOT NULL,
    "type" "provider_document_type" NOT NULL,
    "file_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "provider_documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "files" (
    "id" UUID NOT NULL,
    "uploader_id" UUID NOT NULL,
    "kind" "file_kind" NOT NULL,
    "content_type" TEXT NOT NULL,
    "size" INTEGER NOT NULL,
    "key" TEXT NOT NULL,
    "status" "file_status" NOT NULL DEFAULT 'pending',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "destinations" (
    "id" UUID NOT NULL,
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "state" TEXT NOT NULL DEFAULT '',
    "region" TEXT NOT NULL DEFAULT '',
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "parent_id" UUID,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "destinations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "destination_fees" (
    "id" UUID NOT NULL,
    "destination_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "amount_usd" DECIMAL(12,2) NOT NULL,
    "payment" TEXT NOT NULL,

    CONSTRAINT "destination_fees_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "boarding_points" (
    "id" UUID NOT NULL,
    "city" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL DEFAULT '',
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "boarding_points_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" UUID NOT NULL,
    "provider_id" UUID NOT NULL,
    "type" "product_type" NOT NULL,
    "status" "product_status" NOT NULL DEFAULT 'draft',
    "status_reason" TEXT,
    "sheet" JSONB NOT NULL,
    "version" INTEGER NOT NULL DEFAULT 1,
    "featured" BOOLEAN NOT NULL DEFAULT false,
    "status_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "themes" (
    "id" UUID NOT NULL,
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "themes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_themes" (
    "product_id" UUID NOT NULL,
    "theme_id" UUID NOT NULL,

    CONSTRAINT "product_themes_pkey" PRIMARY KEY ("product_id","theme_id")
);

-- CreateTable
CREATE TABLE "departures" (
    "id" UUID NOT NULL,
    "provider_id" UUID NOT NULL,
    "product_id" UUID NOT NULL,
    "date" DATE NOT NULL,
    "status" "departure_status" NOT NULL DEFAULT 'open',
    "capacity" INTEGER NOT NULL,
    "min_capacity" INTEGER NOT NULL DEFAULT 1,
    "reserved" INTEGER NOT NULL DEFAULT 0,
    "adult_price_usd" DECIMAL(12,2),
    "sheet" JSONB NOT NULL,
    "product_type" "product_type" NOT NULL,
    "category" TEXT,
    "destination_id" UUID,
    "price_usd" DECIMAL(12,2) NOT NULL,
    "cities" TEXT[],
    "includes" TEXT[],
    "tags" TEXT[],
    "search_text" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "departures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "departure_guides" (
    "departure_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,

    CONSTRAINT "departure_guides_pkey" PRIMARY KEY ("departure_id","user_id")
);

-- CreateTable
CREATE TABLE "exchange_rates" (
    "date" DATE NOT NULL,
    "bs_per_usd" DECIMAL(14,4) NOT NULL,
    "set_by_id" UUID NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "exchange_rates_pkey" PRIMARY KEY ("date")
);

-- CreateTable
CREATE TABLE "settings" (
    "id" INTEGER NOT NULL DEFAULT 1,
    "value" JSONB NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "settings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "provider_documents_file_id_key" ON "provider_documents"("file_id");

-- CreateIndex
CREATE INDEX "provider_documents_provider_id_idx" ON "provider_documents"("provider_id");

-- CreateIndex
CREATE UNIQUE INDEX "files_key_key" ON "files"("key");

-- CreateIndex
CREATE INDEX "files_uploader_id_idx" ON "files"("uploader_id");

-- CreateIndex
CREATE UNIQUE INDEX "destinations_slug_key" ON "destinations"("slug");

-- CreateIndex
CREATE INDEX "destination_fees_destination_id_idx" ON "destination_fees"("destination_id");

-- CreateIndex
CREATE INDEX "boarding_points_city_idx" ON "boarding_points"("city");

-- CreateIndex
CREATE INDEX "products_provider_id_id_idx" ON "products"("provider_id", "id");

-- CreateIndex
CREATE INDEX "products_status_status_at_idx" ON "products"("status", "status_at");

-- CreateIndex
CREATE UNIQUE INDEX "themes_slug_key" ON "themes"("slug");

-- CreateIndex
CREATE INDEX "departures_provider_id_date_idx" ON "departures"("provider_id", "date");

-- CreateIndex
CREATE INDEX "departures_status_date_idx" ON "departures"("status", "date");

-- CreateIndex
CREATE UNIQUE INDEX "departures_product_id_date_key" ON "departures"("product_id", "date");

-- CreateIndex
CREATE UNIQUE INDEX "providers_rif_key" ON "providers"("rif");

-- CreateIndex
CREATE INDEX "providers_status_submitted_at_idx" ON "providers"("status", "submitted_at");

-- AddForeignKey
ALTER TABLE "provider_documents" ADD CONSTRAINT "provider_documents_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "provider_documents" ADD CONSTRAINT "provider_documents_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "files" ADD CONSTRAINT "files_uploader_id_fkey" FOREIGN KEY ("uploader_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "destinations" ADD CONSTRAINT "destinations_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "destinations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "destination_fees" ADD CONSTRAINT "destination_fees_destination_id_fkey" FOREIGN KEY ("destination_id") REFERENCES "destinations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_themes" ADD CONSTRAINT "product_themes_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_themes" ADD CONSTRAINT "product_themes_theme_id_fkey" FOREIGN KEY ("theme_id") REFERENCES "themes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "departures" ADD CONSTRAINT "departures_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "departures" ADD CONSTRAINT "departures_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "departure_guides" ADD CONSTRAINT "departure_guides_departure_id_fkey" FOREIGN KEY ("departure_id") REFERENCES "departures"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "departure_guides" ADD CONSTRAINT "departure_guides_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;


-- Cupos: lo apartado nunca pasa del cupo ni baja de cero; el mínimo para salir nunca pasa del cupo.
ALTER TABLE "departures" ADD CONSTRAINT "departures_reserved_check" CHECK ("reserved" >= 0 AND "reserved" <= "capacity");
ALTER TABLE "departures" ADD CONSTRAINT "departures_min_capacity_check" CHECK ("min_capacity" >= 1 AND "min_capacity" <= "capacity");
