-- Add initial reading columns for both digital and mechanical on same nozzle
ALTER TABLE nozzles
  ADD COLUMN initial_reading_digital DECIMAL(18,2) NULL DEFAULT 0 COMMENT 'Initial reading (digital display)' AFTER current_reading,
  ADD COLUMN initial_reading_mechanical DECIMAL(18,2) NULL DEFAULT 0 COMMENT 'Initial reading (mechanical display)' AFTER initial_reading_digital;
