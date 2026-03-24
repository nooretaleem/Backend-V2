-- Physical dip readings for verification
CREATE TABLE IF NOT EXISTS physical_dip_readings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    daily_entry_id INT,
    tank_id INT,
    dip_level DECIMAL(10,2),
    volume_liters DECIMAL(10,2) DEFAULT 0,
    temperature DECIMAL(5,2),
    reading_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Active TINYINT(4) DEFAULT 1,
    CB varchar(50) NOT NULL,
    MB varchar(50) NOT NULL,
    CD DATETIME DEFAULT CURRENT_TIMESTAMP,
    MD DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (daily_entry_id) REFERENCES daily_sales_entries(id),
    FOREIGN KEY (tank_id) REFERENCES fuel_tanks(id)
);
-- Volume (liters) is stored in fuel_tanks.current_level upon saving dip readings.
