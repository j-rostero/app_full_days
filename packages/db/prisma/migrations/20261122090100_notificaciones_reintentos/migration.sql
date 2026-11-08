-- Reintentos espaciados y envío reservado por instancia.
-- DropIndex


DROP INDEX "notifications_status_created_at_idx";

-- AlterTable
ALTER TABLE "notifications" ADD COLUMN     "next_attempt_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateIndex
CREATE INDEX "notifications_status_next_attempt_at_idx" ON "notifications"("status", "next_attempt_at");

