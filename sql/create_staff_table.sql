-- Staff table for POL app (fuel station staff management)
CREATE TABLE IF NOT EXISTS staff (
  id INT AUTO_INCREMENT PRIMARY KEY,
  staffCode VARCHAR(50) NOT NULL,
  name VARCHAR(150) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  designation VARCHAR(100) NOT NULL,
  employmentType VARCHAR(50) NOT NULL,
  joiningDate DATE NOT NULL,
  user_id INT NULL COMMENT 'Linked user account for login',
  pump_id INT NULL COMMENT 'Assigned petrol pump/station',
  cnic VARCHAR(20) NULL COMMENT 'National ID/CNIC',
  salary DECIMAL(18,2) NULL,
  CB VARCHAR(100) NULL COMMENT 'Created By',
  CD DATETIME NULL COMMENT 'Created Date',
  MB VARCHAR(100) NULL COMMENT 'Modified By',
  MD DATETIME NULL COMMENT 'Modified Date',
  Active TINYINT DEFAULT 1,
  UNIQUE KEY uk_staffCode (staffCode),
  INDEX idx_pump (pump_id),
  INDEX idx_user (user_id),
  INDEX idx_active (Active)
);
