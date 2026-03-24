-- Add reason column to staff_advance_salary table
-- Max length: 200 characters
ALTER TABLE staff_advance_salary 
ADD COLUMN reason VARCHAR(200) NULL COMMENT 'Reason for advance/debit transaction' 
AFTER debit;
