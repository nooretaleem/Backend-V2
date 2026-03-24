-- Add Payment Details columns to customer_ledger for recovery entries (Received In account head & Purpose).
-- Run this once if you get "Database missing columns" when saving a recovery.

ALTER TABLE customer_ledger ADD COLUMN received_in VARCHAR(100) NULL;
ALTER TABLE customer_ledger ADD COLUMN purpose VARCHAR(500) NULL;
