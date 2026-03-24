-- Table to store fuel station customer recovery records (links to customer_ledger, station_cash_in_hand or transactions).
CREATE TABLE IF NOT EXISTS fuel_station_customer_recoveries (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL COMMENT 'fuel_station_customer id',
  amount DECIMAL(18,2) NOT NULL,
  recovery_date DATE NOT NULL,
  purpose VARCHAR(500) NULL,
  received_in VARCHAR(100) NULL COMMENT 'e.g. cash_in_hand, bank_account',
  transaction_id INT NULL COMMENT 'transactions.id for audit',
  station_id INT NULL COMMENT 'station (customer) id when received_in = cash_in_hand',
  CB VARCHAR(100) NULL,
  CD DATETIME NULL,
  MD DATETIME NULL,
  MB VARCHAR(100) NULL,
  active TINYINT DEFAULT 1,
  INDEX idx_customer (customer_id),
  INDEX idx_recovery_date (recovery_date),
  INDEX idx_transaction (transaction_id)
);
