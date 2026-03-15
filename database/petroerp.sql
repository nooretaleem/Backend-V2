
create database petroerp; 
USE petroerp;

-- --------------------------------------------------------
-- Table structure for table `accounts`
-- --------------------------------------------------------

CREATE TABLE `accounts` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `BankID` int(10) UNSIGNED NOT NULL,
  `AccountNo` varchar(100) NOT NULL,
  `AccountTitle` varchar(200) NOT NULL,
  `Balance` decimal(15,2) DEFAULT 0.00,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  `QrImagePath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`ID`, `BankID`, `AccountNo`, `AccountTitle`, `Balance`, `CD`, `MD`, `Active`, `QrImagePath`) VALUES
(10, 5, '00260570700968', 'Naveed Khan', 501.00, '2026-02-03 23:35:53', '2026-02-03 23:48:46', 0, NULL),
(11, 5, '00260570700968', 'Naveed Khan', 1000501.00, '2026-02-03 23:50:07', '2026-02-03 23:50:35', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `advance_balance`
--

CREATE TABLE `advance_balance` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `DepoID` int(10) UNSIGNED NOT NULL,
  `TripID` int(11) DEFAULT NULL,
  `recovery_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `Debit` decimal(15,2) DEFAULT 0.00,
  `Credit` decimal(15,2) DEFAULT 0.00,
  `Date` date DEFAULT NULL,
  `Balance` decimal(15,2) DEFAULT 0.00,
  `MD` date DEFAULT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `CB` varchar(50) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` varchar(150) NOT NULL,
  `Branch` varchar(150) NOT NULL,
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`ID`, `Name`, `Branch`, `cd`, `md`, `active`) VALUES
(5, 'JS Bank', 'Town A', '2026-02-03 23:35:20', '2026-02-03 23:35:20', 1),
(6, 'Bank Alhabib', 'Town D', '2026-02-03 23:49:16', '2026-02-03 23:49:16', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cash_in_hand`
--

CREATE TABLE `cash_in_hand` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `debit` decimal(15,2) DEFAULT 0.00,
  `credit` decimal(15,2) DEFAULT 0.00,
  `balance` decimal(15,2) DEFAULT 0.00,
  `purpose` varchar(255) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cash_in_hand`
--



-- --------------------------------------------------------

--
-- Table structure for table `cash_management`
--

CREATE TABLE `cash_management` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `cash_from_previous_day` decimal(10,2) DEFAULT 0.00,
  `cash_from_previous_night` decimal(10,0) NOT NULL DEFAULT 0,
  `cash_from_recovery` decimal(10,2) NOT NULL DEFAULT 0.00,
  `other_income` decimal(10,2) DEFAULT 0.00,
  `other_income_description` varchar(500) DEFAULT NULL,
  `total_cash_in_hand` decimal(10,2) DEFAULT NULL,
  `total_cash_outflow` decimal(10,2) DEFAULT NULL,
  `final_cash_in_hand` decimal(10,2) DEFAULT NULL,
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_daily_cash` (`daily_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cash_management`
--



-- --------------------------------------------------------

--
-- Table structure for table `cash_outflow_bank`
--

CREATE TABLE `cash_outflow_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cash_management_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `account_title` varchar(255) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `transaction_type` enum('Transfer','Cheque','Online','Other') NOT NULL,
  `transaction_ref` varchar(100) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `CB` varchar(100) NOT NULL,
  `MB` varchar(100) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `cash_management_id` (`cash_management_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_outflow_net`
--

CREATE TABLE `cash_outflow_net` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cash_management_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `recipient_name` varchar(255) DEFAULT NULL,
  `recipient_role` varchar(100) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `receipt_number` varchar(100) DEFAULT NULL,
  `approved_by` varchar(100) DEFAULT NULL,
  `CB` varchar(100) NOT NULL,
  `MB` varchar(100) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `cash_management_id` (`cash_management_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_outflow_owner`
--

CREATE TABLE `cash_outflow_owner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cash_management_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `person_type` enum('Owner','Partner','Manager','Other') NOT NULL,
  `person_name` varchar(255) NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `approved_by` varchar(100) DEFAULT NULL,
  `CB` varchar(100) NOT NULL,
  `MB` varchar(100) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `cash_management_id` (`cash_management_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cash_outflow_owner`
--


-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `CB` varchar(50) DEFAULT NULL,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `name`, `CD`, `CB`, `MD`, `Active`) VALUES
(1, 'PSO', '2025-12-21 11:28:39', '', '2025-12-21 11:28:39', 1),
(2, 'Allied', NULL, '', NULL, 1),
(3, 'Jinn', NULL, '', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `credit_sales`
--

CREATE TABLE `credit_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) NOT NULL,
  `fuel_station_customer_id` int(11) NOT NULL,
  `customer_vehicle_id` int(11) DEFAULT NULL,
  `fuel_type` enum('Petrol','Diesel','Mobile Oil') NOT NULL,
  `quantity_liters` decimal(10,2) NOT NULL,
  `rate_per_liter` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `price_type` enum('Regular','Specific') DEFAULT 'Regular',
  `specific_price` decimal(10,2) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `payment_status` enum('Pending','Partially Paid','Paid') DEFAULT 'Pending',
  `paid_amount` decimal(10,2) DEFAULT 0.00,
  `remaining_amount` decimal(10,2) DEFAULT NULL,
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fuel_station_customer_id` (`fuel_station_customer_id`),
  KEY `daily_entry_id` (`daily_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `credit_sales`
--

INSERT INTO `credit_sales` (`id`, `daily_entry_id`, `fuel_station_customer_id`, `customer_vehicle_id`, `fuel_type`, `quantity_liters`, `rate_per_liter`, `total_amount`, `price_type`, `specific_price`, `notes`, `payment_status`, `paid_amount`, `remaining_amount`, `cd`, `md`, `CB`, `MB`, `Active`) VALUES
(11, 14, 1, NULL, 'Petrol', 10.00, 300.00, 3000.00, 'Regular', NULL, NULL, 'Pending', 600.00, 2400.00, '2026-02-28 22:35:52', '2026-03-01 11:33:32', 'Waqas', 'Naveed Khan', 1),
(12, 15, 3, 4, 'Petrol', 20.00, 300.00, 6000.00, 'Regular', NULL, NULL, 'Pending', 0.00, 6000.00, '2026-03-01 10:27:08', '2026-03-01 10:27:08', 'Naveed Khan', 'Naveed Khan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `credit_sale_payments`
--

CREATE TABLE `credit_sale_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_sale_id` int(11) NOT NULL,
  `payment_date` date NOT NULL,
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_method` enum('Cash','Bank Transfer','Cheque','Other') DEFAULT 'Cash',
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `credit_sale_id` (`credit_sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `Previous_Dues` bigint(20) NOT NULL DEFAULT 0,
  `active` tinyint(1) DEFAULT 1,
  `CD` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `phone`, `address`, `Previous_Dues`, `active`, `CD`, `MD`, `CB`) VALUES
(1, 'Al Jalal Petroleum', '03004444444', 'Site A Address, Bhalwal', 0, 1, '2025-12-03 16:07:47', '2026-02-05 03:39:14', 'admin'),
(2, 'Client B', '0300-5555555', 'Site B Address, Faisalabad', 0, 1, '2025-12-03 16:07:47', '2026-02-05 03:39:18', 'admin'),
(3, 'Client C', '0300-6666666', 'Site C Address, Faisalabad', 0, 1, '2025-12-03 16:07:47', '2026-02-05 03:39:24', 'admin'),
(8, 'Zeeshan Petroeum', '34559078645', 'Faisalabad', 10, 1, '2025-12-20 11:18:08', '2026-02-05 03:39:28', 'admin'),
(9, 'test', '34559078645', '12', 10000, 0, '2026-02-05 03:52:31', '2026-02-05 03:52:45', 'admin@gmail.com'),
(10, 'My Petroleum', '00000000000', 'jhjhjhj', 1000, 1, '2026-02-05 05:27:01', '2026-02-05 05:27:01', 'System'),
(11, 'New Customer', '00000000000', 'test address', 1000, 0, '2026-02-19 10:51:29', '2026-02-19 10:51:36', 'admin@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `customer_ledger`
--

CREATE TABLE `customer_ledger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `ref_type` enum('SALE','RECOVERY') NOT NULL,
  `received_in` varchar(100) NOT NULL,
  `purpose` varchar(250) NOT NULL,
  `debit` decimal(12,2) DEFAULT 0.00,
  `credit` decimal(12,2) DEFAULT 0.00,
  `balance` decimal(12,2) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_ledger`
--

INSERT INTO `customer_ledger` (`id`, `customer_id`, `ref_type`, `received_in`, `purpose`, `debit`, `credit`, `balance`, `CD`, `MD`, `CB`, `MB`, `Active`) VALUES
(12, 1, 'RECOVERY', 'cash_in_hand', 'Recovery of Credit Fuels', 0.00, 500.00, 500.00, '2026-02-28 23:18:30', '2026-02-28 23:18:30', 'Naveed Khan', '', 1),
(13, 1, 'RECOVERY', 'cash_in_hand', 'Recovery of Credit Fuels', 0.00, 100.00, 600.00, '2026-03-01 11:33:32', '2026-03-01 11:33:32', 'Naveed Khan', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer_types`
--

CREATE TABLE `customer_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `CD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CB` int(11) NOT NULL,
  `MD` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `MB` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_types`
--

INSERT INTO `customer_types` (`id`, `type_name`, `CD`, `CB`, `MD`, `MB`, `active`) VALUES
(1, 'Self', '2026-02-05 08:37:59', 0, NULL, NULL, 1),
(2, 'Customer', '2026-02-05 08:37:59', 0, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `daily_expenses`
--

CREATE TABLE `daily_expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) NOT NULL,
  `expense_category` int(11) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `expense_category` (`expense_category`),
  KEY `daily_entry_id` (`daily_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_expenses`
--

INSERT INTO `daily_expenses` (`id`, `daily_entry_id`, `expense_category`, `Description`, `amount`, `cd`, `md`, `CB`, `MB`, `Active`) VALUES
(10, 14, 7, 'test expense', 1000.00, '2026-02-28 22:35:52', '2026-02-28 22:35:52', 'Waqas', 'Waqas', 1),
(11, 15, 6, 'rent', 1000.00, '2026-03-01 10:27:08', '2026-03-01 10:27:08', 'Naveed Khan', 'Naveed Khan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `daily_sales_entries`
--

CREATE TABLE `daily_sales_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pump_id` int(11) NOT NULL,
  `entry_date` date NOT NULL,
  `status` enum('Draft','Submitted','Approved','Rejected') DEFAULT 'Draft',
  `submitted_at` datetime DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_daily_entry` (`pump_id`,`entry_date`),
  KEY `approved_by` (`approved_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_sales_entries`
--

INSERT INTO `daily_sales_entries` (`id`, `pump_id`, `entry_date`, `status`, `submitted_at`, `approved_at`, `approved_by`, `CB`, `MB`, `cd`, `md`, `Active`) VALUES
(14, 3, '2026-02-28', 'Submitted', '2026-02-28 22:35:52', NULL, NULL, 'Waqas', 'Waqas', '2026-02-28 22:35:52', '2026-02-28 22:35:52', 1),
(15, 3, '2026-03-01', 'Submitted', '2026-03-01 10:27:08', NULL, NULL, 'Naveed Khan', 'Naveed Khan', '2026-03-01 10:27:08', '2026-03-01 10:27:08', 1),
(17, 3, '2026-03-14', 'Draft', '2026-03-14 10:45:33', NULL, NULL, 'naveed770@yahoo.com', 'admin@gmail.com', '2026-03-14 10:45:33', '2026-03-14 19:29:59', 1),
(18, 3, '2026-03-13', 'Draft', '2026-03-14 12:14:50', NULL, NULL, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:14:50', '2026-03-14 12:23:15', 1),
(19, 3, '2026-03-12', 'Draft', '2026-03-14 12:17:00', NULL, NULL, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:17:00', '2026-03-14 12:17:00', 1),
(21, 3, '2026-03-11', 'Draft', '2026-03-14 12:24:03', NULL, NULL, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:24:03', '2026-03-14 12:24:03', 1);

-- --------------------------------------------------------

--
-- Table structure for table `daily_tank_inventory`
--

CREATE TABLE `daily_tank_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) DEFAULT NULL,
  `tank_id` int(11) NOT NULL,
  `opening_level` decimal(10,2) NOT NULL,
  `closing_level` decimal(10,2) DEFAULT NULL,
  `received_quantity` decimal(10,2) DEFAULT 0.00,
  `sold_quantity` decimal(10,2) DEFAULT NULL,
  `purchase_reference` varchar(100) DEFAULT NULL,
  `cd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `md` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_daily_tank` (`daily_entry_id`,`tank_id`),
  KEY `tank_id` (`tank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_tank_inventory`
--

INSERT INTO `daily_tank_inventory` (`id`, `daily_entry_id`, `tank_id`, `opening_level`, `closing_level`, `received_quantity`, `sold_quantity`, `purchase_reference`, `cd`, `md`, `CB`, `MB`, `Active`) VALUES
(4, 19, 1, 4213.00, NULL, NULL, NULL, NULL, '2026-03-14 12:17:00', '2026-03-14 12:17:00', 'naveed770@yahoo.com', 'naveed770@yahoo.com', 1),
(5, 19, 2, 4213.00, NULL, NULL, NULL, NULL, '2026-03-14 12:17:00', '2026-03-14 12:17:00', 'naveed770@yahoo.com', 'naveed770@yahoo.com', 1),
(6, 18, 1, 5174.00, NULL, NULL, NULL, NULL, '2026-03-14 12:23:15', '2026-03-14 12:23:15', 'naveed770@yahoo.com', 'naveed770@yahoo.com', 1),
(7, 18, 2, 5174.00, NULL, NULL, NULL, NULL, '2026-03-14 12:23:15', '2026-03-14 12:23:15', 'naveed770@yahoo.com', 'naveed770@yahoo.com', 1),
(8, 21, 1, 6162.00, NULL, NULL, NULL, NULL, '2026-03-14 12:24:03', '2026-03-14 12:24:03', 'naveed770@yahoo.com', 'naveed770@yahoo.com', 1),
(9, 21, 2, 6162.00, NULL, NULL, NULL, NULL, '2026-03-14 12:24:03', '2026-03-14 12:24:03', 'naveed770@yahoo.com', 'naveed770@yahoo.com', 1),
(10, 17, 1, 3292.00, NULL, NULL, NULL, NULL, '2026-03-14 19:29:59', '2026-03-14 19:29:59', 'admin@gmail.com', 'admin@gmail.com', 1),
(11, 17, 2, 3292.00, NULL, NULL, NULL, NULL, '2026-03-14 19:29:59', '2026-03-14 19:29:59', 'admin@gmail.com', 'admin@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `depo`
--

CREATE TABLE `depo` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(20) NOT NULL,
  `phone_no` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `Balance` bigint(20) DEFAULT 0,
  `Previous_Payables` bigint(20) NOT NULL DEFAULT 0,
  `CD` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `CB` varchar(50) DEFAULT NULL,
  `MD` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `depo`
--

INSERT INTO `depo` (`id`, `name`, `code`, `phone_no`, `address`, `Balance`, `Previous_Payables`, `CD`, `CB`, `MD`, `Active`) VALUES
(17, 'Manzoor', '', '034556787625', 'test address', 4000000, 0, '2025-12-20 11:53:13', '', '2026-01-25 20:08:56', 1),
(18, 'Aleem', 'FSD12345', '034559078645', 'House#144 Main Service Road East Block C, B-18', 4005000, 0, '2025-12-20 11:53:42', '', '2026-02-08 16:15:19', 1),
(21, 'Kasar', '', '034559078645', 'House#144 Main Service Road East Block C, B-17', 4505000, 0, '2025-12-29 14:30:29', 'admin@gmail.com', '2026-02-28 01:26:52', 1),
(23, 'Jalil', '', '03235577081', 'House#144 Main Service Road East Block C, B-17', 4000000, 0, '2026-01-01 18:17:09', 'admin@gmail.com', '2026-02-02 14:04:51', 1),
(25, 'testdealer', '1234fedser', '000000000000', 'jjjkhjkhjk', 500000, 1000, '2026-02-05 03:17:48', 'System', '2026-02-05 03:17:55', 0);

-- --------------------------------------------------------

--
-- Table structure for table `depo_company`
--

CREATE TABLE `depo_company` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL,
  `depo_id` int(10) UNSIGNED NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `CB` varchar(50) DEFAULT NULL,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `depo_company`
--

INSERT INTO `depo_company` (`id`, `company_id`, `depo_id`, `CD`, `CB`, `MD`, `Active`) VALUES
(1, 2, 17, '2025-12-21 11:29:15', '', '2025-12-21 12:17:25', 1),
(2, 1, 18, '2025-12-21 11:29:34', '', '2025-12-21 11:29:34', 1),
(4, 2, 21, '2025-12-29 19:30:29', 'admin@gmail.com', '2025-12-29 19:30:29', 1),
(6, 3, 23, '2026-01-01 23:17:09', 'admin@gmail.com', '2026-01-01 23:17:09', 1),
(7, 1, 24, '2026-01-21 22:02:49', 'System', '2026-01-21 22:03:03', 0),
(8, 1, 25, '2026-02-05 08:17:48', 'System', '2026-02-05 08:17:55', 0);

-- --------------------------------------------------------

--
-- Table structure for table `dip_chart`
--

CREATE TABLE `dip_chart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tank_type_id` int(11) NOT NULL,
  `dip_mm` int(11) NOT NULL,
  `volume_liters` decimal(10,2) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) NOT NULL DEFAULT 'Admin',
  `MB` varchar(50) NOT NULL DEFAULT 'Admin',
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dip_chart`
--

INSERT INTO `dip_chart` (`id`, `tank_type_id`, `dip_mm`, `volume_liters`, `Active`, `CB`, `MB`, `CD`, `MD`) VALUES
(1, 1, 2, 22.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(2, 1, 10, 38.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(3, 1, 20, 63.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(4, 1, 30, 92.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(5, 1, 40, 125.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(6, 1, 50, 160.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(7, 1, 60, 198.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(8, 1, 70, 238.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(9, 1, 80, 281.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(10, 1, 90, 326.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(11, 1, 100, 373.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(12, 1, 110, 422.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(13, 1, 120, 473.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(14, 1, 130, 525.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(15, 1, 140, 580.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(16, 1, 150, 635.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(17, 1, 160, 693.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(18, 1, 170, 752.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(19, 1, 180, 812.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(20, 1, 190, 874.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(21, 1, 200, 937.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(22, 1, 210, 1002.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(23, 1, 220, 1067.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(24, 1, 230, 1134.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(25, 1, 240, 1202.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(26, 1, 250, 1272.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(27, 1, 260, 1342.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(28, 1, 270, 1413.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(29, 1, 280, 1486.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(30, 1, 290, 1559.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(31, 1, 300, 1634.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(32, 1, 310, 1709.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(33, 1, 320, 1785.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(34, 1, 330, 1863.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(35, 1, 340, 1941.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(36, 1, 350, 2020.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(37, 1, 360, 2099.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(38, 1, 370, 2180.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(39, 1, 380, 2261.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(40, 1, 390, 2344.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(41, 1, 400, 2426.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(42, 1, 410, 2510.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(43, 1, 420, 2594.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(44, 1, 430, 2679.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(45, 1, 440, 2765.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(46, 1, 450, 2851.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(47, 1, 460, 2938.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(48, 1, 470, 3026.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(49, 1, 480, 3114.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(50, 1, 490, 3203.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(51, 1, 500, 3292.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(52, 1, 510, 3382.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(53, 1, 520, 3472.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(54, 1, 530, 3563.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(55, 1, 540, 3654.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(56, 1, 550, 3746.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(57, 1, 560, 3839.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(58, 1, 570, 3932.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(59, 1, 580, 4025.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(60, 1, 590, 4119.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(61, 1, 600, 4213.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(62, 1, 610, 4307.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(63, 1, 620, 4402.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(64, 1, 630, 4497.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(65, 1, 640, 4593.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(66, 1, 650, 4689.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(67, 1, 660, 4785.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(68, 1, 670, 4882.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(69, 1, 680, 4979.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(70, 1, 690, 5076.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(71, 1, 700, 5174.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(72, 1, 710, 5271.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(73, 1, 720, 5370.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(74, 1, 730, 5468.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(75, 1, 740, 5566.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(76, 1, 750, 5665.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(77, 1, 760, 5764.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(78, 1, 770, 5863.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(79, 1, 780, 5963.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(80, 1, 790, 6062.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(81, 1, 800, 6162.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(82, 1, 810, 6262.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(83, 1, 820, 6362.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(84, 1, 830, 6462.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(85, 1, 840, 6563.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(86, 1, 850, 6663.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(87, 1, 860, 6764.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(88, 1, 870, 6864.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(89, 1, 880, 6965.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(90, 1, 890, 7066.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(91, 1, 900, 7166.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(92, 1, 910, 7267.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(93, 1, 920, 7368.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(94, 1, 930, 7469.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(95, 1, 940, 7570.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(96, 1, 950, 7671.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(97, 1, 960, 7772.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(98, 1, 970, 7873.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(99, 1, 980, 7973.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(100, 1, 990, 8074.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(101, 1, 1000, 8175.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(102, 1, 1010, 8276.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(103, 1, 1020, 8376.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(104, 1, 1030, 8477.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(105, 1, 1040, 8577.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(106, 1, 1050, 8677.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(107, 1, 1060, 8778.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(108, 1, 1070, 8878.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(109, 1, 1080, 8977.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(110, 1, 1090, 9077.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(111, 1, 1100, 9177.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(112, 1, 1110, 9276.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(113, 1, 1120, 9375.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(114, 1, 1130, 9474.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(115, 1, 1140, 9573.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(116, 1, 1150, 9672.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(117, 1, 1160, 9770.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(118, 1, 1170, 9868.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(119, 1, 1180, 9966.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(120, 1, 1190, 10063.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(121, 1, 1200, 10161.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(122, 1, 1210, 10257.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(123, 1, 1220, 10354.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(124, 1, 1230, 10450.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(125, 1, 1240, 10546.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(126, 1, 1250, 10642.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(127, 1, 1260, 10737.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(128, 1, 1270, 10832.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(129, 1, 1280, 10926.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(130, 1, 1290, 11021.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(131, 1, 1300, 11114.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(132, 1, 1310, 11207.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(133, 1, 1320, 11300.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(134, 1, 1330, 11392.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(135, 1, 1340, 11484.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(136, 1, 1350, 11576.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(137, 1, 1360, 11667.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(138, 1, 1370, 11757.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(139, 1, 1380, 11847.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(140, 1, 1390, 11936.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(141, 1, 1400, 12025.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(142, 1, 1410, 12113.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(143, 1, 1420, 12200.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(144, 1, 1430, 12287.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(145, 1, 1440, 12373.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(146, 1, 1450, 12459.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(147, 1, 1460, 12544.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(148, 1, 1470, 12628.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(149, 1, 1480, 12712.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(150, 1, 1490, 12794.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(151, 1, 1500, 12876.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(152, 1, 1510, 12958.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(153, 1, 1520, 13038.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(154, 1, 1530, 13118.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(155, 1, 1540, 13197.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(156, 1, 1550, 13275.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(157, 1, 1560, 13352.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(158, 1, 1570, 13428.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(159, 1, 1580, 13503.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(160, 1, 1590, 13578.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(161, 1, 1600, 13651.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(162, 1, 1610, 13723.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(163, 1, 1620, 13795.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(164, 1, 1630, 13865.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(165, 1, 1640, 13934.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(166, 1, 1650, 14002.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(167, 1, 1660, 14069.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(168, 1, 1670, 14134.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(169, 1, 1680, 14199.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(170, 1, 1690, 14262.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(171, 1, 1700, 14323.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(172, 1, 1710, 14384.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(173, 1, 1720, 14443.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(174, 1, 1730, 14500.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(175, 1, 1740, 14556.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(176, 1, 1750, 14610.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(177, 1, 1760, 14662.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(178, 1, 1770, 14713.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(179, 1, 1780, 14762.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(180, 1, 1790, 14808.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(181, 1, 1800, 14853.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(182, 1, 1810, 14896.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(183, 1, 1820, 14936.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(184, 1, 1830, 14974.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(185, 1, 1840, 15008.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(186, 1, 1850, 15040.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(187, 1, 1860, 15069.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(188, 1, 1870, 15094.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(189, 1, 1880, 15114.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(190, 1, 1890, 15127.00, 1, 'Admin', 'Admin', '2026-03-09 23:12:24', '2026-03-09 23:12:24'),
(432, 2, 2, 25.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(433, 2, 10, 44.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(434, 2, 20, 72.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(435, 2, 30, 105.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(436, 2, 40, 142.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(437, 2, 50, 183.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(438, 2, 60, 226.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(439, 2, 70, 272.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(440, 2, 80, 321.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(441, 2, 90, 373.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(442, 2, 100, 427.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(443, 2, 110, 483.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(444, 2, 120, 542.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(445, 2, 130, 602.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(446, 2, 140, 665.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(447, 2, 150, 729.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(448, 2, 160, 794.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(449, 2, 170, 854.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(450, 2, 180, 913.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(451, 2, 190, 1005.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(452, 2, 200, 1078.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(453, 2, 210, 1152.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(454, 2, 220, 1228.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(455, 2, 230, 1306.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(456, 2, 240, 1385.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(457, 2, 250, 1465.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(458, 2, 260, 1547.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(459, 2, 270, 1630.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(460, 2, 280, 1714.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(461, 2, 290, 1800.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(462, 2, 300, 1887.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(463, 2, 310, 1974.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(464, 2, 320, 2063.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(465, 2, 330, 2154.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(466, 2, 340, 2245.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(467, 2, 350, 2337.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(468, 2, 360, 2431.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(469, 2, 370, 2525.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(470, 2, 380, 2621.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(471, 2, 390, 2717.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(472, 2, 400, 2814.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(473, 2, 410, 2913.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(474, 2, 420, 3012.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(475, 2, 430, 3112.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(476, 2, 440, 3213.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(477, 2, 450, 3315.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(478, 2, 460, 3418.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(479, 2, 470, 3522.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(480, 2, 480, 3626.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(481, 2, 490, 3731.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(482, 2, 500, 3837.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(483, 2, 510, 3944.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(484, 2, 520, 4051.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(485, 2, 530, 4159.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(486, 2, 540, 4268.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(487, 2, 550, 4378.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(488, 2, 560, 4488.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(489, 2, 570, 4599.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(490, 2, 580, 4711.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(491, 2, 590, 4823.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(492, 2, 600, 4936.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(493, 2, 610, 5049.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(494, 2, 620, 5163.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(495, 2, 630, 5278.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(496, 2, 640, 5393.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(497, 2, 650, 5509.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(498, 2, 660, 5625.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(499, 2, 670, 5742.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(500, 2, 680, 5860.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(501, 2, 690, 5978.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(502, 2, 700, 6096.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(503, 2, 710, 6215.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(504, 2, 720, 6334.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(505, 2, 730, 6454.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(506, 2, 740, 6575.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(507, 2, 750, 6695.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(508, 2, 760, 6817.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(509, 2, 770, 6938.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(510, 2, 780, 7060.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(511, 2, 790, 7183.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(512, 2, 800, 7306.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(513, 2, 810, 7429.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(514, 2, 820, 7552.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(515, 2, 830, 7676.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(516, 2, 840, 7801.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(517, 2, 850, 7925.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(518, 2, 860, 8050.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(519, 2, 870, 8176.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(520, 2, 880, 8301.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(521, 2, 890, 8427.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(522, 2, 900, 8553.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(523, 2, 910, 8680.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(524, 2, 920, 8806.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(525, 2, 930, 8934.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(526, 2, 940, 9061.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(527, 2, 950, 9188.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(528, 2, 960, 9316.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(529, 2, 970, 9444.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(530, 2, 980, 9572.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(531, 2, 990, 9701.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(532, 2, 1000, 9829.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(533, 2, 1010, 9958.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(534, 2, 1020, 10087.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(535, 2, 1030, 10216.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(536, 2, 1040, 10345.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(537, 2, 1050, 10475.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(538, 2, 1060, 10605.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(539, 2, 1070, 10734.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(540, 2, 1080, 10864.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(541, 2, 1090, 10994.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(542, 2, 1100, 11124.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(543, 2, 1110, 11254.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(544, 2, 1120, 11385.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(545, 2, 1130, 11515.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(546, 2, 1140, 11646.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(547, 2, 1150, 11776.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(548, 2, 1160, 11907.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(549, 2, 1170, 12037.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(550, 2, 1180, 12168.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(551, 2, 1190, 12299.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(552, 2, 1200, 12429.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(553, 2, 1210, 12560.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(554, 2, 1220, 12691.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(555, 2, 1230, 12822.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(556, 2, 1240, 12952.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(557, 2, 1250, 13083.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(558, 2, 1260, 13214.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(559, 2, 1270, 13344.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(560, 2, 1280, 13475.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(561, 2, 1290, 13605.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(562, 2, 1300, 13736.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(563, 2, 1310, 13866.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(564, 2, 1320, 13997.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(565, 2, 1330, 14127.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(566, 2, 1340, 14257.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(567, 2, 1350, 14387.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(568, 2, 1360, 14517.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(569, 2, 1370, 14647.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(570, 2, 1380, 14776.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(571, 2, 1390, 14906.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(572, 2, 1400, 15035.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(573, 2, 1410, 15164.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(574, 2, 1420, 15293.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(575, 2, 1430, 15422.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(576, 2, 1440, 15551.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(577, 2, 1450, 15679.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(578, 2, 1460, 15808.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(579, 2, 1470, 15936.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(580, 2, 1480, 16063.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(581, 2, 1490, 16191.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(582, 2, 1500, 16318.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(583, 2, 1510, 16445.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(584, 2, 1520, 16572.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(585, 2, 1530, 16699.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(586, 2, 1540, 16825.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(587, 2, 1550, 16951.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(588, 2, 1560, 17077.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(589, 2, 1570, 17202.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(590, 2, 1580, 17327.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(591, 2, 1590, 17452.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(592, 2, 1600, 17576.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(593, 2, 1610, 17701.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(594, 2, 1620, 17824.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(595, 2, 1630, 17948.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(596, 2, 1640, 18071.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(597, 2, 1650, 18193.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(598, 2, 1660, 18315.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(599, 2, 1670, 18437.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(600, 2, 1680, 18558.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(601, 2, 1690, 18679.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(602, 2, 1700, 18800.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(603, 2, 1710, 18920.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(604, 2, 1720, 19030.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(605, 2, 1730, 19138.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(606, 2, 1740, 19277.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(607, 2, 1750, 19395.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(608, 2, 1760, 19513.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(609, 2, 1770, 19630.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(610, 2, 1780, 19746.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(611, 2, 1790, 19862.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(612, 2, 1800, 19978.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(613, 2, 1810, 20092.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(614, 2, 1820, 20207.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(615, 2, 1830, 20320.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(616, 2, 1840, 20433.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(617, 2, 1850, 20548.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(618, 2, 1860, 20658.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(619, 2, 1870, 20769.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(620, 2, 1880, 20879.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(621, 2, 1890, 20989.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(622, 2, 1900, 21098.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(623, 2, 1910, 21207.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(624, 2, 1920, 21314.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(625, 2, 1930, 21421.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(626, 2, 1940, 21527.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(627, 2, 1950, 21633.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(628, 2, 1960, 21737.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(629, 2, 1970, 21841.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(630, 2, 1980, 21944.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(631, 2, 1990, 22046.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(632, 2, 2000, 22148.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(633, 2, 2010, 22248.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(634, 2, 2020, 22346.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(635, 2, 2030, 22446.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(636, 2, 2040, 22544.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(637, 2, 2050, 22641.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(638, 2, 2060, 22736.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(639, 2, 2070, 22831.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(640, 2, 2080, 22925.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(641, 2, 2090, 23017.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(642, 2, 2100, 23109.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(643, 2, 2110, 23200.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(644, 2, 2120, 23289.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(645, 2, 2130, 23377.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(646, 2, 2140, 23464.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(647, 2, 2150, 23550.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(648, 2, 2160, 23635.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(649, 2, 2170, 23718.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(650, 2, 2180, 23800.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(651, 2, 2190, 23881.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(652, 2, 2200, 23960.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(653, 2, 2210, 24038.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(654, 2, 2220, 24115.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(655, 2, 2230, 24190.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(656, 2, 2240, 24264.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(657, 2, 2250, 24335.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(658, 2, 2260, 24406.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(659, 2, 2270, 24474.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(660, 2, 2280, 24541.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(661, 2, 2290, 24606.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(662, 2, 2300, 24669.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(663, 2, 2310, 24730.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(664, 2, 2320, 24789.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(665, 2, 2330, 24846.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(666, 2, 2340, 24901.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(667, 2, 2350, 24953.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(668, 2, 2360, 25003.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(669, 2, 2370, 25050.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(670, 2, 2380, 25095.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(671, 2, 2390, 25136.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46'),
(672, 2, 2400, 25174.00, 1, 'Admin', 'Admin', '2026-03-09 23:20:46', '2026-03-09 23:20:46');

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `license_number` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`id`, `name`, `phone`, `license_number`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Ahmed Khan', '03001234567', 'DL-001', 'Karachi', 1, '2025-12-03 16:05:10', '2025-12-03 17:27:55'),
(2, 'Muhammad Ali', '03002345678', 'DL-002', 'Lahore', 1, '2025-12-03 16:05:10', '2025-12-03 17:28:08'),
(3, 'Hassan Shah', '03003456789', 'DL-003', 'Islamabad', 1, '2025-12-03 16:05:10', '2025-12-03 17:28:01');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `expense_date` date NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `CB` varchar(50) NOT NULL,
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Active` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_transaction_id` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `expense_type` enum('BUSINESS','PERSONAL') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `name`, `expense_type`, `created_at`, `Active`) VALUES
(1, 'House Rent', 'PERSONAL', '2025-12-20 03:15:27', 1),
(2, 'Electricity Bill', 'PERSONAL', '2025-12-20 03:15:27', 1),
(3, 'Grocery', 'PERSONAL', '2025-12-20 03:15:27', 1),
(4, 'School Fee', 'PERSONAL', '2025-12-20 03:15:27', 1),
(5, 'Medical Expense', 'PERSONAL', '2025-12-20 03:15:27', 1),
(6, 'Office Rent', 'BUSINESS', '2025-12-20 03:15:27', 1),
(7, 'Fuel Expense', 'BUSINESS', '2025-12-20 03:15:27', 1),
(8, 'Vehicle Maintenance', 'BUSINESS', '2025-12-20 03:15:27', 1),
(10, 'Internet Bill', 'BUSINESS', '2025-12-20 03:15:27', 1),
(11, 'Stationery', 'BUSINESS', '2025-12-20 03:15:27', 1),
(12, 'Mobile Bill', 'BUSINESS', '2025-12-20 03:15:27', 1),
(13, 'Test Expense', 'PERSONAL', '2026-02-15 17:05:05', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fuele_station_customer_vehicles`
--

CREATE TABLE `fuele_station_customer_vehicles` (
  `vehicle_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `vehicle_number` varchar(20) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vehicle_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fuele_station_customer_vehicles`
--

INSERT INTO `fuele_station_customer_vehicles` (`vehicle_id`, `customer_id`, `vehicle_number`, `Active`, `CB`, `MB`, `CD`, `MD`) VALUES
(1, 1, 'CAD123', 1, 'Waqas', '', '2026-02-08 18:55:28', '2026-02-08 18:55:28'),
(2, 1, 'AWA-738', 1, 'Waqas', '', '2026-02-28 04:47:47', '2026-02-28 04:47:47'),
(3, 1, 'WSA21', 1, 'Waqas', '', '2026-02-28 04:57:08', '2026-02-28 04:57:08'),
(4, 3, 'FDE-123', 1, 'Waqas', '', '2026-02-28 05:31:10', '2026-02-28 05:31:10'),
(5, 3, 'JKU-200', 1, 'Waqas', '', '2026-02-28 05:31:19', '2026-02-28 05:31:19');

-- --------------------------------------------------------

--
-- Table structure for table `fuel_rates`
--

CREATE TABLE `fuel_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) NOT NULL,
  `fuel_type_id` int(11) NOT NULL,
  `rate_per_liter` decimal(10,2) NOT NULL,
  `effective_date` date NOT NULL,
  `CB` varchar(50) NOT NULL,
  `CD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MB` varchar(50) DEFAULT NULL,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fuel_type_id` (`fuel_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fuel_rates`
--

INSERT INTO `fuel_rates` (`id`, `daily_entry_id`, `fuel_type_id`, `rate_per_liter`, `effective_date`, `CB`, `CD`, `MB`, `MD`, `Active`) VALUES
(1, 0, 2, 280.00, '2026-01-16', 'System', '2026-01-17 18:47:13', NULL, '2026-01-17 18:47:13', 1),
(2, 0, 1, 260.00, '2026-01-16', 'System', '2026-01-17 18:47:24', NULL, '2026-01-17 18:47:24', 1),
(3, 0, 3, 200.00, '2026-01-16', 'System', '2026-01-17 18:47:35', NULL, '2026-01-17 18:47:35', 1),
(4, 0, 2, 200.00, '2026-02-06', 'System', '2026-02-07 10:56:24', NULL, '2026-02-22 10:32:04', 0),
(5, 0, 1, 300.00, '2026-02-07', 'System', '2026-02-07 10:56:52', 'System', '2026-02-07 11:13:05', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fuel_station_customer`
--

CREATE TABLE `fuel_station_customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `customer_type` varchar(20) DEFAULT 'regular',
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fuel_station_customer`
--

INSERT INTO `fuel_station_customer` (`customer_id`, `customer_name`, `phone_number`, `customer_type`, `CB`, `MB`, `CD`, `MD`, `Active`) VALUES
(1, 'Naveed Khan', '00000000000', 'Retail', 'Waqas', '', '2026-02-07 07:45:58', '2026-02-07 07:45:58', 1),
(2, 'Javed', '11111111111', 'Retail', 'Waqas', '', '2026-02-27 10:34:52', '2026-02-27 10:34:52', 1),
(3, 'Rana', '22222222222', 'Retail', 'Waqas', '', '2026-02-27 10:35:01', '2026-02-27 10:35:01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fuel_station_customer_recoveries`
--

CREATE TABLE `fuel_station_customer_recoveries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `transactionID` int(20) NOT NULL,
  `fuel_type` enum('Petrol','Diesel','HOBC') NOT NULL,
  `recovery_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_mode` enum('Cash','Bank','Cheque') DEFAULT 'Cash',
  `reference` varchar(100) DEFAULT NULL,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fuel_station_customer_recoveries`
--

INSERT INTO `fuel_station_customer_recoveries` (`id`, `customer_id`, `station_id`, `transactionID`, `fuel_type`, `recovery_date`, `amount`, `payment_mode`, `reference`, `CB`, `MB`, `CD`, `MD`, `Active`) VALUES
(5, 1, 3, 407, 'Petrol', '2026-02-28', 500.00, 'Cash', 'Recovery of Credit Fuels', 'Naveed Khan', 'Naveed Khan', '2026-02-28 23:18:30', '2026-02-28 23:18:30', 1),
(6, 1, 3, 408, 'Petrol', '2026-03-01', 100.00, 'Cash', 'Recovery of Credit Fuels', 'Naveed Khan', 'Naveed Khan', '2026-03-01 11:33:32', '2026-03-01 11:33:32', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fuel_tanks`
--

CREATE TABLE `fuel_tanks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pump_id` int(11) NOT NULL,
  `capacity` int(11) NOT NULL DEFAULT 0,
  `fuel_type` enum('Petrol','Diesel','Mobile Oil') NOT NULL,
  `tank_type_id` int(11) DEFAULT NULL,
  `current_level` decimal(10,2) DEFAULT 0.00,
  `low_alert_level` decimal(10,2) DEFAULT NULL,
  `tank_number` int(11) DEFAULT NULL,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) DEFAULT NULL,
  `MB` varchar(50) DEFAULT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_tank` (`pump_id`,`fuel_type`,`tank_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fuel_tanks`
--

INSERT INTO `fuel_tanks` (`id`, `pump_id`, `capacity`, `fuel_type`, `tank_type_id`, `current_level`, `low_alert_level`, `tank_number`, `Active`, `CB`, `MB`, `CD`, `MD`) VALUES
(1, 3, 0, 'Petrol', 1, 3292.00, 3000.00, 1, 1, 'System', 'System', '2026-02-10 22:52:38', '2026-03-14 19:29:59'),
(2, 3, 0, 'Diesel', 1, 3292.00, 3000.00, 2, 1, 'System', 'System', '2026-02-10 22:52:38', '2026-03-14 19:29:59'),
(4, 4, 0, 'Petrol', 4, 6000.00, 3000.00, 1, 1, 'System', 'System', '2026-02-10 22:59:38', '2026-02-27 16:30:32'),
(5, 4, 0, 'Diesel', 4, 7000.00, 3000.00, 2, 1, 'System', 'System', '2026-02-10 22:59:38', '2026-02-27 16:30:32'),
(29, 5, 0, 'Petrol', 2, 0.00, 3000.00, 1, 1, 'System', 'System', '2026-02-27 19:30:57', '2026-02-27 19:31:15'),
(30, 5, 0, 'Diesel', 2, 0.00, 3000.00, 2, 1, 'System', 'System', '2026-02-27 19:30:57', '2026-02-27 19:31:15');

-- --------------------------------------------------------

--
-- Table structure for table `fuel_types`
--

CREATE TABLE `fuel_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `CB` varchar(50) NOT NULL,
  `CD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MB` varchar(50) DEFAULT NULL,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fuel_types`
--

INSERT INTO `fuel_types` (`id`, `name`, `CB`, `CD`, `MB`, `MD`, `Active`) VALUES
(1, 'PMG', 'System', '2026-01-17 18:44:28', NULL, '2026-01-17 18:44:28', 1),
(2, 'HSD', 'System', '2026-01-17 18:44:33', NULL, '2026-01-17 18:44:33', 1),
(3, 'Mobile Oil', 'System', '2026-01-17 18:44:42', NULL, '2026-01-17 18:44:42', 1);

-- --------------------------------------------------------

--
-- Table structure for table `machines`
--

CREATE TABLE `machines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pump_id` int(11) NOT NULL,
  `machine_type` enum('Petrol','Diesel') NOT NULL,
  `machine_number` int(11) DEFAULT NULL,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) DEFAULT NULL,
  `MB` varchar(50) DEFAULT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_machine` (`pump_id`,`machine_type`,`machine_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `machines`
--

INSERT INTO `machines` (`id`, `pump_id`, `machine_type`, `machine_number`, `Active`, `CB`, `MB`, `CD`, `MD`) VALUES
(1, 3, 'Petrol', 1, 1, 'System', 'System', '2026-02-10 22:52:38', '2026-02-27 16:31:06'),
(2, 3, 'Diesel', 2, 1, 'System', 'System', '2026-02-10 22:52:38', '2026-02-27 16:31:06'),
(8, 4, 'Petrol', 1, 1, 'System', 'System', '2026-02-27 16:17:41', '2026-02-27 16:30:32'),
(9, 5, 'Petrol', 1, 1, 'System', 'System', '2026-02-27 19:30:57', '2026-02-27 19:31:15');

-- --------------------------------------------------------

--
-- Table structure for table `machine_readings`
--

CREATE TABLE `machine_readings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL,
  `total_digital_sales` decimal(10,2) DEFAULT 0.00,
  `total_mechanical_sales` decimal(10,2) DEFAULT 0.00,
  `total_sales` decimal(10,2) DEFAULT NULL,
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_daily_machine` (`daily_entry_id`,`machine_id`),
  KEY `machine_id` (`machine_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `machine_readings`
--

INSERT INTO `machine_readings` (`id`, `daily_entry_id`, `machine_id`, `total_digital_sales`, `total_mechanical_sales`, `total_sales`, `cd`, `md`, `CB`, `MB`, `Active`) VALUES
(18, 14, 1, 100.00, 100.00, 100.00, '2026-02-28 22:35:52', '2026-02-28 22:35:52', 'Waqas', 'Waqas', 1),
(19, 14, 2, 100.00, 100.00, 100.00, '2026-02-28 22:35:52', '2026-02-28 22:35:52', 'Waqas', 'Waqas', 1),
(20, 15, 1, 100.00, 100.00, 100.00, '2026-03-01 10:27:08', '2026-03-01 10:27:08', 'Naveed Khan', 'Naveed Khan', 1),
(21, 15, 2, 100.00, 100.00, 100.00, '2026-03-01 10:27:08', '2026-03-01 10:27:08', 'Naveed Khan', 'Naveed Khan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `managers`
--

CREATE TABLE `managers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) DEFAULT NULL,
  `MB` varchar(50) DEFAULT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mobile_oil_cash_sales`
--

CREATE TABLE `mobile_oil_cash_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) NOT NULL,
  `liters_sold` decimal(10,2) NOT NULL,
  `rate_per_liter` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `daily_entry_id` (`daily_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mobile_oil_cash_sales`
--

INSERT INTO `mobile_oil_cash_sales` (`id`, `daily_entry_id`, `liters_sold`, `rate_per_liter`, `total_amount`, `cd`, `md`, `CB`, `MB`, `Active`) VALUES
(9, 14, 50.00, 200.00, 10000.00, '2026-02-28 22:35:52', '2026-02-28 22:35:52', 'Waqas', 'Waqas', 1),
(10, 15, 50.00, 200.00, 10000.00, '2026-03-01 10:27:08', '2026-03-01 10:27:08', 'Naveed Khan', 'Naveed Khan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL,
  `imagesrc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `name`, `link`, `imagesrc`) VALUES
(1, 'Dashboard', 'dashboard', '../../../assets/images/dashboard.png'),
(2, 'POL Purchase', 'trips', '../../../assets/images/trips.png'),
(3, 'Customers', 'customers', '../../../assets/images/clients.png'),
(4, 'Vehicles', 'vehicles', '../../../assets/images/vehicles.png'),
(5, 'Drivers', 'drivers', '../../../assets/images/drivers.png'),
(6, 'Dealers', 'managedepo', '../../../assets/images/dealer.jpg'),
(7, 'Transactions', 'transaction', '../../../assets/images/transactions.jpg'),
(8, 'Bank Accounts', 'accounts', '../../../assets/images/Bank.png'),
(9, 'Manage Cash', 'cashinhand', '../../../assets/images/dollar.png'),
(10, 'Rental Payments', 'vehicle-rent', '../../../assets/images/trips.png'),
(11, 'POL Sale', 'pol-sale-history', '../../../assets/images/trips.png'),
(12, 'Add Trip', 'add-trip', '../../../assets/images/trips.png'),
(13, 'Manage Expenses', 'expenses', '../../../assets/images/expenses.png'),
(15, 'Reports', 'reports', '../../../assets/images/inventory.png'),
(16, 'Pump Dashboard', 'fuel-station-dashboard', '../../../assets/images/dashboard.png'),
(17, 'Fuel Daily Sales', 'daily-sales-entry', '../../../assets/images/fuelstation.png'),
(18, 'Manage Petrol Pumps', 'pumps', '../../../assets/images/gas-station.png'),
(20, 'Staff', 'staff', '../../../assets/images/clients.png'),
(21, 'Add Role', 'addrole', ''),
(22, 'Credit Customers', 'fuel-station-customers', '../../../assets/images/clients.png');

-- --------------------------------------------------------

--
-- Table structure for table `modulesassignment`
--

CREATE TABLE `modulesassignment` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `moduleid` int(11) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `modulesassignment`
--

INSERT INTO `modulesassignment` (`id`, `moduleid`, `roleid`) VALUES
(112, 14, 0),
(113, 15, 0),
(149, 16, 3),
(150, 17, 3),
(151, 20, 3),
(152, 22, 3),
(153, 1, 1),
(154, 2, 1),
(155, 3, 1),
(156, 4, 1),
(157, 5, 1),
(158, 6, 1),
(159, 7, 1),
(160, 8, 1),
(161, 9, 1),
(162, 10, 1),
(163, 11, 1),
(164, 12, 1),
(165, 13, 1),
(166, 15, 1),
(167, 16, 1),
(168, 17, 1),
(169, 18, 1),
(170, 20, 1),
(171, 21, 1),
(172, 22, 1);

-- --------------------------------------------------------

--
-- Table structure for table `nozzles`
--

CREATE TABLE `nozzles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `machine_id` int(11) NOT NULL,
  `nozzle_number` int(11) NOT NULL,
  `nozzle_type` varchar(10) NOT NULL,
  `initial_reading_digital` decimal(18,2) DEFAULT 0.00,
  `current_reading_digital` decimal(10,2) DEFAULT 0.00,
  `initial_reading_mechanical` decimal(18,2) DEFAULT 0.00,
  `current_reading_mechanical` decimal(10,2) DEFAULT 0.00,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) DEFAULT NULL,
  `MB` varchar(50) DEFAULT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_nozzle` (`machine_id`,`nozzle_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nozzles`
--

INSERT INTO `nozzles` (`id`, `machine_id`, `nozzle_number`, `nozzle_type`, `initial_reading_digital`, `current_reading_digital`, `initial_reading_mechanical`, `current_reading_mechanical`, `Active`, `CB`, `MB`, `CD`, `MD`) VALUES
(9, 1, 1, 'Petrol', 100.00, 600.00, 200.00, 700.00, 1, 'System', 'Naveed Khan', '2026-02-19 22:39:00', '2026-03-01 10:27:08'),
(10, 2, 1, 'Diesel', 300.00, 800.00, 400.00, 900.00, 1, 'System', 'Naveed Khan', '2026-02-19 22:39:00', '2026-03-01 10:27:08'),
(11, 8, 1, 'Petrol', 1000.00, 2000.00, 2000.00, 3000.00, 1, 'System', 'Waqas', '2026-02-27 16:17:41', '2026-02-27 16:56:56'),
(12, 8, 2, 'Diesel', 3000.00, 4000.00, 4000.00, 6000.00, 1, 'System', 'Waqas', '2026-02-27 16:17:41', '2026-02-27 16:56:56'),
(13, 9, 1, 'Petrol', 100.00, 100.00, 100.00, 100.00, 1, 'System', 'System', '2026-02-27 19:30:57', '2026-02-27 19:31:15'),
(14, 9, 2, 'Diesel', 100.00, 100.00, 100.00, 100.00, 1, 'System', 'System', '2026-02-27 19:30:57', '2026-02-27 19:31:15');

-- --------------------------------------------------------

--
-- Table structure for table `nozzle_readings`
--

CREATE TABLE `nozzle_readings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) NOT NULL,
  `nozzle_id` int(11) NOT NULL,
  `opening_mechanical_reading` decimal(10,2) DEFAULT NULL,
  `closing_mechanical_reading` decimal(10,2) DEFAULT NULL,
  `opening_digital_reading` decimal(10,2) NOT NULL,
  `closing_digital_reading` decimal(10,2) NOT NULL,
  `total_sold` decimal(10,2) DEFAULT NULL,
  `sales_amount` decimal(10,2) DEFAULT NULL,
  `cd` datetime DEFAULT CURRENT_TIMESTAMP,
  `md` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_daily_nozzle` (`daily_entry_id`,`nozzle_id`),
  KEY `nozzle_id` (`nozzle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nozzle_readings`
--

INSERT INTO `nozzle_readings` (`id`, `daily_entry_id`, `nozzle_id`, `opening_mechanical_reading`, `closing_mechanical_reading`, `opening_digital_reading`, `closing_digital_reading`, `total_sold`, `sales_amount`, `cd`, `md`, `CB`, `MB`, `Active`) VALUES
(19, 14, 9, 500.00, 600.00, 400.00, 500.00, 100.00, 30000.00, '2026-02-28 22:35:52', '2026-02-28 22:35:52', 'Waqas', 'Waqas', 1),
(20, 14, 10, 700.00, 800.00, 600.00, 700.00, 100.00, 28000.00, '2026-02-28 22:35:52', '2026-02-28 22:35:52', 'Waqas', 'Waqas', 1),
(21, 15, 9, 600.00, 700.00, 500.00, 600.00, 100.00, 30000.00, '2026-03-01 10:27:08', '2026-03-01 10:27:08', 'Naveed Khan', 'Naveed Khan', 1),
(22, 15, 10, 800.00, 900.00, 700.00, 800.00, 100.00, 28000.00, '2026-03-01 10:27:08', '2026-03-01 10:27:08', 'Naveed Khan', 'Naveed Khan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transactionID` int(11) DEFAULT NULL,
  `trip_id` int(11) DEFAULT NULL,
  `depoid` int(10) UNSIGNED DEFAULT NULL,
  `Amount` decimal(15,2) DEFAULT 0.00,
  `Date` date NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`ID`, `transactionID`, `trip_id`, `depoid`, `Amount`, `Date`, `CD`, `MD`, `Active`) VALUES
(95, 397, NULL, 18, 10000.00, '2026-02-03', '2026-02-03 23:23:39', '2026-02-03 23:23:39', 1);

-- --------------------------------------------------------

--
-- Table structure for table `petrol_pumps`
--

CREATE TABLE `petrol_pumps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `location` varchar(500) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `previous_dues` bigint(20) NOT NULL DEFAULT 0,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) DEFAULT NULL,
  `MB` varchar(50) DEFAULT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `manager_id` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `petrol_pumps`
--

INSERT INTO `petrol_pumps` (`id`, `name`, `location`, `manager_id`, `previous_dues`, `Active`, `CB`, `MB`, `CD`, `MD`) VALUES
(3, 'Zeeshan', 'Bhalwal', 21, 0, 1, 'System', 'System', '2026-02-10 22:52:38', '2026-02-27 16:31:06'),
(4, 'Naveed', 'Lahore', 20, 0, 1, 'System', 'System', '2026-02-10 22:59:38', '2026-02-27 16:30:32'),
(5, 'Faisal', 'Sarodha', 22, 0, 1, 'System', 'System', '2026-02-27 19:30:57', '2026-02-27 19:31:15');

-- --------------------------------------------------------

--
-- Table structure for table `physical_dip_readings`
--

CREATE TABLE `physical_dip_readings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_entry_id` int(11) DEFAULT NULL,
  `tank_id` int(11) DEFAULT NULL,
  `dip_level` decimal(10,2) DEFAULT NULL,
  `volume_liters` decimal(10,2) NOT NULL,
  `temperature` decimal(5,2) DEFAULT NULL,
  `reading_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `physical_dip_readings`
--

INSERT INTO `physical_dip_readings` (`id`, `daily_entry_id`, `tank_id`, `dip_level`, `volume_liters`, `temperature`, `reading_time`, `Active`, `CB`, `MB`, `CD`, `MD`) VALUES
(5, 19, 1, 600.00, 4213.00, NULL, '2026-03-12 07:17:00', 1, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:17:00', '2026-03-14 12:21:28'),
(6, 19, 2, 600.00, 4213.00, NULL, '2026-03-12 07:17:00', 1, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:17:00', '2026-03-14 12:21:11'),
(7, 18, 1, 700.00, 5174.00, NULL, '2026-03-12 19:00:00', 1, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:23:15', '2026-03-14 12:23:15'),
(8, 18, 2, 700.00, 5174.00, NULL, '2026-03-12 19:00:00', 1, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:23:15', '2026-03-14 12:23:15'),
(9, 21, 1, 800.00, 6162.00, NULL, '2026-03-10 19:00:00', 1, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:24:03', '2026-03-14 12:24:03'),
(10, 21, 2, 800.00, 6162.00, NULL, '2026-03-10 19:00:00', 1, 'naveed770@yahoo.com', 'naveed770@yahoo.com', '2026-03-14 12:24:03', '2026-03-14 12:24:03'),
(11, 17, 1, 500.00, 3292.00, NULL, '2026-03-13 19:00:00', 1, 'admin@gmail.com', 'admin@gmail.com', '2026-03-14 19:29:59', '2026-03-14 19:29:59'),
(12, 17, 2, 500.00, 3292.00, NULL, '2026-03-13 19:00:00', 1, 'admin@gmail.com', 'admin@gmail.com', '2026-03-14 19:29:59', '2026-03-14 19:29:59');

-- --------------------------------------------------------

--
-- Table structure for table `pick_up_location`
--

CREATE TABLE `pick_up_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pick_up_location`
--

INSERT INTO `pick_up_location` (`id`, `name`, `CD`, `MD`, `Active`) VALUES
(5, 'Bhalwal', '2026-02-02 14:14:16', '2026-02-02 14:14:16', 1),
(6, 'Faisalabad', '2026-02-02 14:21:27', '2026-02-02 14:21:33', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pol_sale`
--

CREATE TABLE `pol_sale` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `trip_id` int(10) UNSIGNED NOT NULL,
  `trip_product_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `Qty` int(11) DEFAULT 0,
  `container_type` varchar(50) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `fuel` decimal(10,2) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `Discount` int(11) DEFAULT 0,
  `total_amount` bigint(20) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `CD` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  `CB` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pol_sale`
--

INSERT INTO `pol_sale` (`id`, `trip_id`, `trip_product_id`, `client_id`, `Qty`, `container_type`, `capacity`, `fuel`, `rate`, `Discount`, `total_amount`, `date`, `CD`, `MD`, `Active`, `CB`) VALUES
(80, 79, 148, 8, 1000, NULL, NULL, 1000.00, 238.00, 0, 238000, '2026-02-04 19:00:00', '2026-02-05 15:24:17', '2026-02-08 16:15:22', 0, 'admin@gmail.com'),
(81, 80, 149, 3, 500, NULL, NULL, 500.00, 245.00, 0, 122500, '2026-02-16 19:00:00', '2026-02-17 18:58:26', '2026-02-17 18:58:26', 1, 'admin@gmail.com'),
(82, 81, 150, 8, 500, NULL, NULL, 500.00, 250.00, 0, 125000, '2026-02-27 19:00:00', '2026-02-28 01:50:27', '2026-02-28 01:50:27', 1, 'admin@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `pool`
--

CREATE TABLE `pool` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `DepoID` int(10) UNSIGNED NOT NULL,
  `TripID` int(11) DEFAULT NULL,
  `recovery_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `Debit` decimal(15,2) DEFAULT 0.00,
  `Credit` decimal(15,2) DEFAULT 0.00,
  `Date` date DEFAULT NULL,
  `DepoLimit` decimal(15,2) DEFAULT 0.00,
  `MD` date DEFAULT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `CB` varchar(50) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pool`
--

INSERT INTO `pool` (`ID`, `DepoID`, `TripID`, `recovery_id`, `payment_id`, `Debit`, `Credit`, `Date`, `DepoLimit`, `MD`, `CD`, `CB`, `Active`) VALUES
(100, 17, NULL, NULL, NULL, 0.00, 4000000.00, NULL, 4000000.00, NULL, '2025-12-24 18:35:04', '2025-12-24 18:35:26', 1),
(101, 18, NULL, NULL, NULL, 0.00, 4000000.00, NULL, 4000000.00, NULL, '2025-12-24 18:35:04', '2025-12-24 18:35:26', 1),
(138, 21, NULL, NULL, NULL, 0.00, 5000000.00, NULL, 5000000.00, '2025-12-29', '2025-12-29 19:30:29', 'admin@gmail.com', 1),
(165, 23, NULL, NULL, NULL, 0.00, 4000000.00, NULL, 4000000.00, '2026-01-01', '2026-01-01 23:17:09', 'admin@gmail.com', 1),
(321, 18, 78, NULL, NULL, 250000.00, 0.00, NULL, 3750000.00, '2026-02-08', '2026-02-03 22:55:41', 'admin@gmail.com', 0),
(322, 21, 79, NULL, NULL, 476000.00, 0.00, NULL, 4524000.00, '2026-02-08', '2026-02-03 23:01:07', 'admin@gmail.com', 0),
(323, 18, 78, NULL, 95, 0.00, 5000.00, NULL, 4005000.00, NULL, '2026-02-03 23:23:39', NULL, 1),
(325, 25, NULL, NULL, NULL, 0.00, 500000.00, NULL, 500000.00, '2026-02-05', '2026-02-05 08:17:48', 'System', 1),
(326, 21, 80, NULL, NULL, 245000.00, 0.00, NULL, 4755000.00, '2026-02-10', '2026-02-10 19:06:30', 'admin@gmail.com', 1),
(327, 21, 81, NULL, NULL, 250000.00, 0.00, NULL, 4505000.00, '2026-02-28', '2026-02-28 06:26:52', 'admin@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recoveries`
--

CREATE TABLE `recoveries` (
  `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transactionID` int(11) DEFAULT NULL,
  `trip_id` int(11) DEFAULT NULL,
  `ClientID` int(11) NOT NULL,
  `Amount` decimal(15,2) DEFAULT 0.00,
  `Payment_Head` varchar(200) DEFAULT NULL,
  `Date` date NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recoveries`
--

INSERT INTO `recoveries` (`ID`, `transactionID`, `trip_id`, `ClientID`, `Amount`, `Payment_Head`, `Date`, `CD`, `MD`, `Active`) VALUES
(67, 399, NULL, 1, 5000.00, 'Cash in Hand', '2026-02-03', '2026-02-03 00:00:00', '2026-02-04 00:07:07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `roletype` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `roletype`) VALUES
(1, 'Admin'),
(2, 'Staff'),
(3, 'Manager');

-- --------------------------------------------------------

--
-- Table structure for table `settlements`
--

CREATE TABLE `settlements` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `recovery_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `depo_id` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `settlement_type` enum('DIRECT_CLIENT_TO_CONTRACTOR') NOT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `settlement_date` date NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `shift_id` int(11) NOT NULL AUTO_INCREMENT,
  `shift_date` date NOT NULL,
  `shift_name` enum('Morning','Evening','Night') NOT NULL,
  `manager_id` int(11) NOT NULL,
  `opening_digital_meter_reading` decimal(10,2) NOT NULL,
  `closing_digital_meter_reading` decimal(10,2) DEFAULT NULL,
  `opening_mechanical_meter_reading` decimal(10,2) NOT NULL,
  `closing_mechanical_meter_reading` decimal(10,2) DEFAULT NULL,
  `total_fuel_sold_` decimal(10,2) DEFAULT NULL,
  `total_sales_amount` decimal(12,2) DEFAULT 0.00,
  `status` enum('OPEN','CLOSED') DEFAULT 'OPEN',
  `CB` varchar(100) NOT NULL,
  `MB` varchar(100) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`shift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`shift_id`, `shift_date`, `shift_name`, `manager_id`, `opening_digital_meter_reading`, `closing_digital_meter_reading`, `opening_mechanical_meter_reading`, `closing_mechanical_meter_reading`, `total_fuel_sold_`, `total_sales_amount`, `status`, `CB`, `MB`, `CD`, `MD`, `Active`) VALUES
(7, '2026-02-28', 'Morning', 20, 1000.00, 1200.00, 1200.00, 1400.00, 200.00, 68000.00, 'CLOSED', 'Waqas', 'Waqas', '2026-02-28 22:35:52', '2026-02-28 22:35:52', 1),
(8, '2026-03-01', 'Morning', 21, 1200.00, 1400.00, 1400.00, 1600.00, 200.00, 68000.00, 'CLOSED', 'Naveed Khan', 'Naveed Khan', '2026-03-01 10:27:08', '2026-03-01 10:27:08', 1);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staffCode` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `employmentType` varchar(50) DEFAULT NULL,
  `joiningDate` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `pump_id` int(11) DEFAULT NULL,
  `cnic` varchar(20) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `cd` datetime DEFAULT NULL,
  `md` datetime DEFAULT NULL,
  `CB` varchar(50) DEFAULT NULL,
  `MB` varchar(50) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pump_id` (`pump_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `staffCode`, `name`, `phone`, `designation`, `employmentType`, `joiningDate`, `user_id`, `pump_id`, `cnic`, `salary`, `cd`, `md`, `CB`, `MB`, `Active`) VALUES
(1, 'STF001', 'Naveed Khan', '34559078645', 'Manager', 'Full-time', '2026-02-15', 21, 3, '13503-0535616-3', 10000.00, '2026-02-17 21:23:34', '2026-02-17 21:27:14', 'System', 'System', 1),
(2, 'STF002', 'Javed', '00000000', 'Staff', 'Full-time', '2026-02-21', NULL, 3, '13503-0535616-3', 20000.00, '2026-02-21 12:53:52', '2026-02-21 12:53:52', 'Naveed Khan', 'Naveed Khan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `staff_advance_salary`
--

CREATE TABLE `staff_advance_salary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `credit` int(11) NOT NULL,
  `debit` int(11) NOT NULL,
  `reason` varchar(200) NOT NULL,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `CD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_advance_salary`
--

INSERT INTO `staff_advance_salary` (`id`, `staff_id`, `credit`, `debit`, `reason`, `CB`, `MB`, `CD`, `MD`, `Active`) VALUES
(6, 2, 1000, 0, 'advance', 'Naveed Khan', 'Naveed Khan', '2026-03-01 22:18:58', '2026-03-01 22:18:58', 1);

-- --------------------------------------------------------

--
-- Table structure for table `stations`
--

CREATE TABLE `stations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `CB` varchar(50) NOT NULL,
  `CD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MB` varchar(50) DEFAULT NULL,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `station_cash_in_hand`
--

CREATE TABLE `station_cash_in_hand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `debit` decimal(15,2) DEFAULT 0.00,
  `credit` decimal(15,2) DEFAULT 0.00,
  `balance` decimal(15,2) DEFAULT 0.00,
  `purpose` varchar(255) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `CB` varchar(100) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MB` varchar(100) NOT NULL,
  `active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `station_cash_in_hand`
--

INSERT INTO `station_cash_in_hand` (`id`, `customer_id`, `debit`, `credit`, `balance`, `purpose`, `entry_date`, `CB`, `CD`, `MD`, `MB`, `active`) VALUES
(9, 1, 0.00, 500.00, 500.00, 'Recovery of Credit Fuels', '2026-02-28', 'Naveed Khan', '2026-02-28 23:18:30', '2026-02-28 23:18:30', 'Naveed Khan', 1),
(10, 1, 0.00, 100.00, 600.00, 'Recovery of Credit Fuels', '2026-03-01', 'Naveed Khan', '2026-03-01 11:33:32', '2026-03-01 11:33:32', 'Naveed Khan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tank_dip_readings`
--

CREATE TABLE `tank_dip_readings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `tank_id` int(11) NOT NULL,
  `fuel_type_id` int(11) NOT NULL,
  `dip_date` date NOT NULL,
  `dip_time` time DEFAULT NULL,
  `dip_level_mm` decimal(8,2) NOT NULL,
  `dip_quantity_liters` decimal(10,2) NOT NULL,
  `CB` varchar(50) NOT NULL,
  `CD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tank_dip` (`tank_id`,`dip_date`,`dip_time`),
  KEY `idx_station_date` (`station_id`,`dip_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tank_types`
--

CREATE TABLE `tank_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total_capacity_liters` int(11) NOT NULL,
  `radius_mm` decimal(10,2) NOT NULL,
  `length_mm` decimal(10,2) NOT NULL,
  `clearance_base_plate_mm` int(11) NOT NULL,
  `radius_ft_in` varchar(20) DEFAULT NULL,
  `length_ft_in` varchar(20) DEFAULT NULL,
  `max_dip_mm` int(11) NOT NULL,
  `Active` tinyint(4) DEFAULT 1,
  `CB` varchar(50) NOT NULL,
  `MB` varchar(50) NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tank_types`
--

INSERT INTO `tank_types` (`id`, `total_capacity_liters`, `radius_mm`, `length_mm`, `clearance_base_plate_mm`, `radius_ft_in`, `length_ft_in`, `max_dip_mm`, `Active`, `CB`, `MB`, `CD`, `MD`) VALUES
(1, 15000, 954.50, 5286.00, 15, NULL, NULL, 1890, 1, 'Admin', 'Admin', '2026-03-09 22:57:41', '2026-03-09 22:57:41'),
(2, 25000, 1231.50, 5308.00, 15, NULL, NULL, 2400, 1, 'Admin', 'Admin', '2026-03-09 22:57:41', '2026-03-09 22:57:41'),
(3, 50000, 1429.50, 7800.00, 15, NULL, NULL, 2790, 1, 'Admin', 'Admin', '2026-03-09 22:57:41', '2026-03-09 22:57:41'),
(4, 10000, 2774.00, 7520.00, 1410, '9\'-2\"', '24\'-8\"', 2274, 1, 'Admin', 'Admin', '2026-03-09 22:57:41', '2026-03-09 22:57:41');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) DEFAULT NULL,
  `cash_in_hand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `PaymentMode` varchar(100) DEFAULT NULL,
  `ReferenceNo` varchar(100) DEFAULT NULL,
  `Purpose` varchar(255) DEFAULT NULL,
  `Debit` decimal(15,2) DEFAULT 0.00,
  `Credit` decimal(15,2) DEFAULT 0.00,
  `Balance` decimal(15,2) DEFAULT 0.00,
  `AccountID` int(10) UNSIGNED DEFAULT NULL,
  `Date` date NOT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `CB` varchar(50) NOT NULL,
  `MD` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`ID`, `trip_id`, `cash_in_hand_id`, `PaymentMode`, `ReferenceNo`, `Purpose`, `Debit`, `Credit`, `Balance`, `AccountID`, `Date`, `CD`, `CB`, `MD`, `Active`) VALUES
(383, 76, NULL, NULL, NULL, 'Credit from Kasar', 0.00, 240000.00, 240000.00, NULL, '2026-02-02', '2026-02-02 19:22:02', '', '2026-02-03 00:09:59', 0),
(384, 76, 198, 'Cash', NULL, 'Payment Received from Zeeshan Petroeum', 0.00, 50000.00, 0.00, NULL, '2026-02-02', '2026-02-02 19:25:14', '', '2026-02-03 00:09:59', 0),
(385, 77, NULL, NULL, NULL, 'Credit from Aleem', 0.00, 245000.00, 245000.00, NULL, '2026-02-02', '2026-02-02 22:11:03', '', '2026-02-03 00:10:01', 0),
(395, 78, NULL, NULL, NULL, 'Credit from Aleem', 0.00, 250000.00, 250000.00, NULL, '2026-02-03', '2026-02-03 22:55:41', '', '2026-02-08 21:15:19', 0),
(396, 79, NULL, NULL, NULL, 'Credit from Kasar', 0.00, 476000.00, 476000.00, NULL, '2026-02-03', '2026-02-03 23:01:07', '', '2026-02-08 21:15:22', 0),
(397, NULL, 209, 'Cash', NULL, 'Payment to Aleem (5000 applied to previous payables, 5000 to trips/advance)', 10000.00, 0.00, 0.00, NULL, '2026-02-03', '2026-02-03 23:23:39', '', '2026-02-03 23:23:39', 1),
(398, NULL, 210, NULL, NULL, 'Transfer to Bank Account - JS Bank / Naveed Khan (00260570700968)', 0.00, 1000000.00, 0.00, 11, '2026-02-03', '2026-02-03 23:50:35', '', '2026-02-03 23:50:35', 1),
(399, NULL, 211, 'Cash', NULL, 'Payment Received from Al Jalal Petroleum', 0.00, 5000.00, 0.00, NULL, '2026-02-03', '2026-02-04 00:07:07', '', '2026-02-04 00:07:07', 1),
(401, NULL, NULL, NULL, NULL, 'Recovery of Credit Fuels', 0.00, 1000.00, 0.00, NULL, '2026-02-08', '2026-02-08 19:07:20', '', '2026-02-08 19:07:20', 1),
(402, NULL, NULL, NULL, NULL, 'Recovery of Credit Fuels', 0.00, 11111.00, 0.00, NULL, '2026-02-08', '2026-02-08 21:36:42', '', '2026-02-08 21:36:42', 1),
(403, 80, NULL, NULL, NULL, 'Credit from Kasar', 0.00, 245000.00, 245000.00, NULL, '2026-02-10', '2026-02-10 19:06:30', '', '2026-02-10 19:06:30', 1),
(404, NULL, NULL, NULL, NULL, 'Recovery of Credit Fuels', 0.00, 1000.00, 0.00, NULL, '2026-02-28', '2026-02-28 06:03:11', '', '2026-02-28 06:03:11', 1),
(405, NULL, NULL, NULL, NULL, 'Recovery of Credit Fuels', 0.00, 2000.00, 0.00, NULL, '2026-02-28', '2026-02-28 06:20:13', '', '2026-02-28 06:20:13', 1),
(406, 81, NULL, NULL, NULL, 'Credit from Kasar', 0.00, 250000.00, 250000.00, NULL, '2026-02-28', '2026-02-28 06:26:52', '', '2026-02-28 06:26:52', 1),
(407, NULL, NULL, NULL, NULL, 'Recovery of Credit Fuels', 0.00, 500.00, 0.00, NULL, '2026-02-28', '2026-02-28 23:18:30', '', '2026-02-28 23:18:30', 1),
(408, NULL, NULL, NULL, NULL, 'Recovery of Credit Fuels', 0.00, 100.00, 0.00, NULL, '2026-03-01', '2026-03-01 11:33:32', '', '2026-03-01 11:33:32', 1);

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `trip_no` varchar(50) NOT NULL COMMENT 'Trip number',
  `status` varchar(50) DEFAULT 'Pending' COMMENT 'Trip status (Pending, In Progress, Completed, Cancelled)',
  `start_date` timestamp NULL DEFAULT NULL COMMENT 'Trip start date',
  `completed_at` timestamp NULL DEFAULT NULL COMMENT 'Trip completion date',
  `vehicle_id` int(11) NOT NULL COMMENT 'Reference to vehicle (Foreign Key)',
  `total_amount` bigint(20) NOT NULL,
  `amount_collected` decimal(12,2) DEFAULT 0.00 COMMENT 'Amount collected',
  `paid` decimal(12,2) DEFAULT 0.00 COMMENT 'Amount paid',
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `CB` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trips`
--

INSERT INTO `trips` (`id`, `trip_no`, `status`, `start_date`, `completed_at`, `vehicle_id`, `total_amount`, `amount_collected`, `paid`, `CD`, `MD`, `active`, `CB`) VALUES
(76, 'TRIP-000001', 'In Progress', '2026-02-02 14:20:59', NULL, 5, 240000, 50000.00, 0.00, '2026-02-02 14:22:02', '2026-02-02 19:09:59', 0, 'admin@gmail.com'),
(77, 'TRIP-000002', 'In Progress', '2026-02-02 17:10:37', NULL, 5, 245000, 0.00, 0.00, '2026-02-02 17:11:03', '2026-02-02 19:10:01', 0, 'admin@gmail.com'),
(78, 'TRIP-000003', 'In Progress', '2026-02-03 17:55:15', NULL, 5, 250000, 7000.00, 7000.00, '2026-02-03 17:55:41', '2026-02-08 16:15:19', 0, 'admin@gmail.com'),
(79, 'TRIP-000004', 'In Progress', '2026-02-03 18:00:40', NULL, 5, 476000, 0.00, 0.00, '2026-02-03 18:01:07', '2026-02-08 16:15:22', 0, 'admin@gmail.com'),
(80, 'TRIP-000005', 'In Progress', '2026-02-10 14:06:05', NULL, 5, 245000, 0.00, 0.00, '2026-02-10 14:06:30', '2026-02-10 14:06:30', 1, 'admin@gmail.com'),
(81, 'TRIP-000006', 'In Progress', '2026-02-28 01:26:19', NULL, 5, 250000, 0.00, 0.00, '2026-02-28 01:26:52', '2026-02-28 01:26:52', 1, 'admin@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `trip_depos`
--

CREATE TABLE `trip_depos` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `trip_id` int(10) UNSIGNED NOT NULL,
  `depo_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  `CB` varchar(50) NOT NULL,
  `purchase_type` varchar(50) NOT NULL,
  `paid_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payable_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trip_depos`
--

INSERT INTO `trip_depos` (`id`, `trip_id`, `depo_id`, `product_id`, `CD`, `MD`, `Active`, `CB`, `purchase_type`, `paid_amount`, `payable_amount`) VALUES
(166, 76, 21, 145, '2026-02-02 14:22:02', '2026-02-02 19:09:59', 0, 'admin@gmail.com', 'credit', 0.00, 240000.00),
(167, 77, 18, 146, '2026-02-02 17:11:03', '2026-02-02 19:10:01', 0, 'admin@gmail.com', 'credit', 0.00, 245000.00),
(168, 78, 18, 147, '2026-02-03 17:55:41', '2026-02-08 16:15:19', 0, 'admin@gmail.com', 'credit', 5000.00, 250000.00),
(169, 79, 21, 148, '2026-02-03 18:01:07', '2026-02-08 16:15:22', 0, 'admin@gmail.com', 'credit', 0.00, 476000.00),
(170, 80, 21, 149, '2026-02-10 14:06:30', '2026-02-10 14:06:30', 1, 'admin@gmail.com', 'credit', 0.00, 245000.00),
(171, 81, 21, 150, '2026-02-28 01:26:52', '2026-02-28 01:26:52', 1, 'admin@gmail.com', 'credit', 0.00, 250000.00);

-- --------------------------------------------------------

--
-- Table structure for table `trip_payments`
--

CREATE TABLE `trip_payments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `trip_id` int(10) UNSIGNED NOT NULL,
  `depo_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `payment_type` enum('Credit','Full Payment','Partial Payment') NOT NULL,
  `paid_amount` decimal(12,2) DEFAULT 0.00,
  `payable_amount` decimal(12,2) DEFAULT 0.00,
  `CD` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_payment` (`trip_id`,`depo_id`,`product_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trip_products`
--

CREATE TABLE `trip_products` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `trip_id` int(10) UNSIGNED NOT NULL,
  `comp_id` int(10) UNSIGNED NOT NULL,
  `depo_id` int(10) UNSIGNED NOT NULL,
  `pickup_id` int(11) NOT NULL,
  `product_type` enum('PMG','HSD','Mobile/Lube Oil') NOT NULL,
  `quantity_ltr` int(11) NOT NULL,
  `qty_sold` int(11) DEFAULT NULL,
  `invoice_rate` decimal(10,2) NOT NULL,
  `discount` int(11) NOT NULL DEFAULT 0,
  `purchase_amount` decimal(12,2) AS (quantity_ltr * invoice_rate) STORED,
  `container_type` varchar(20) DEFAULT NULL,
  `container_liters` decimal(10,2) DEFAULT NULL,
  `no_of_containers` int(11) DEFAULT NULL,
  `CB` varchar(100) NOT NULL,
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trip_products`
--

INSERT INTO `trip_products` (`id`, `trip_id`, `comp_id`, `depo_id`, `pickup_id`, `product_type`, `quantity_ltr`, `qty_sold`, `invoice_rate`, `discount`, `container_type`, `container_liters`, `no_of_containers`, `CB`, `CD`, `MD`, `Active`) VALUES
(145, 76, 2, 21, 5, 'PMG', 1000, 1000, 240.00, 0, NULL, NULL, NULL, 'admin@gmail.com', '2026-02-02 14:22:02', '2026-02-02 19:09:59', 0),
(146, 77, 1, 18, 6, 'HSD', 1000, 200, 245.00, 0, NULL, NULL, NULL, 'admin@gmail.com', '2026-02-02 17:11:03', '2026-02-02 19:10:01', 0),
(147, 78, 1, 18, 5, 'PMG', 1000, NULL, 250.00, 0, NULL, NULL, NULL, 'admin@gmail.com', '2026-02-03 17:55:41', '2026-02-08 16:15:19', 0),
(148, 79, 2, 21, 5, 'HSD', 2000, 1000, 238.00, 0, NULL, NULL, NULL, 'admin@gmail.com', '2026-02-03 18:01:07', '2026-02-08 16:15:22', 0),
(149, 80, 2, 21, 5, 'PMG', 1000, 500, 245.00, 0, NULL, NULL, NULL, 'admin@gmail.com', '2026-02-10 14:06:30', '2026-02-17 18:58:26', 1),
(150, 81, 2, 21, 5, 'PMG', 1000, 500, 250.00, 0, NULL, NULL, NULL, 'admin@gmail.com', '2026-02-28 01:26:52', '2026-02-28 01:50:27', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `roleid` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `CB` varchar(100) NOT NULL,
  `MB` varchar(100) NOT NULL,
  `CD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `roleid`, `name`, `email`, `password`, `CB`, `MB`, `CD`, `MD`, `Active`) VALUES
(20, 1, 'Waqas', 'admin@gmail.com', '$2b$10$jEjpRkOUSeTWLf7gWcAw2e3zxsXBhCKSs82xzertbz4w5XTqzmgp2', 'admin', 'admin', '2026-02-17 20:03:16', '2026-02-17 20:03:16', 1),
(21, 3, 'Naveed Khan', 'naveed770@yahoo.com', '$2a$12$oTjBRt7B3NUuqUTXpTGTn.0jnir5RaFsE8wiBR4.gpAGASxm0IY.6', '', '', '2026-02-17 21:23:34', '2026-02-17 21:23:34', 1),
(22, 3, 'Zeeshan', 'zeeshan@yahoo.com', '$2a$12$oTjBRt7B3NUuqUTXpTGTn.0jnir5RaFsE8wiBR4.gpAGASxm0IY.6', 'admin', 'admin', '2026-02-17 21:23:34', '2026-02-17 21:23:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL COMMENT 'Vehicle type (e.g., Tanker, Truck)',
  `number` varchar(50) NOT NULL COMMENT 'Vehicle registration number',
  `capacity` decimal(10,2) UNSIGNED DEFAULT NULL COMMENT 'Vehicle capacity',
  `driver_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Reference to driver (Foreign Key)',
  `rent_per_km` decimal(10,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `CB` varchar(50) NOT NULL COMMENT 'Created by',
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created date/time',
  `MD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Modified date/time',
  `Active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = Active, 0 = Inactive',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `type`, `number`, `capacity`, `driver_id`, `rent_per_km`, `CB`, `CD`, `MD`, `Active`) VALUES
(5, 'Private', 'CAD-123', 25000.00, 1, 0.00, 'System', '2026-02-02 14:13:52', '2026-02-02 14:13:52', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_expenses`
--

CREATE TABLE `vehicle_expenses` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(10) UNSIGNED NOT NULL,
  `trip_id` int(10) UNSIGNED DEFAULT NULL,
  `transaction_id` int(10) UNSIGNED DEFAULT NULL,
  `expense_date` date NOT NULL,
  `expense_type` enum('Fuel','Maintenance','Repair','Toll','Parking','Driver Salary','Insurance','Tax','Other') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `MD` date DEFAULT NULL,
  `CD` datetime DEFAULT CURRENT_TIMESTAMP,
  `CB` varchar(50) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle_expenses`
--

INSERT INTO `vehicle_expenses` (`id`, `vehicle_id`, `trip_id`, `transaction_id`, `expense_date`, `expense_type`, `description`, `amount`, `MD`, `CD`, `CB`, `Active`) VALUES
(3, 1, NULL, 322, '2026-01-26', 'Fuel', NULL, 1000.00, '2026-01-26', '2026-01-26 18:45:17', 'admin@gmail.com', 0),
(4, 1, NULL, 323, '2026-01-26', 'Toll', NULL, 1000.00, NULL, '2026-01-26 18:53:58', 'admin@gmail.com', 1),
(5, 3, NULL, 324, '2026-01-26', 'Insurance', NULL, 500.00, NULL, '2026-01-26 18:54:21', 'admin@gmail.com', 1),
(6, 1, 56, 326, '2026-01-26', 'Parking', NULL, 200.00, NULL, '2026-01-26 19:29:33', 'admin@gmail.com', 1),
(7, 1, 57, 333, '2026-01-27', 'Driver Salary', NULL, 100.00, NULL, '2026-01-27 23:50:17', 'admin@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_expense_type`
--

CREATE TABLE `vehicle_expense_type` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `CB` varchar(50) NOT NULL,
  `CD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle_expense_type`
--

INSERT INTO `vehicle_expense_type` (`id`, `name`, `CB`, `CD`, `MD`, `Active`) VALUES
(11, 'Fuel', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1),
(12, 'Maintenance', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1),
(13, 'Repair', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1),
(14, 'Toll', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1),
(15, 'Parking', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1),
(16, 'Driver Salary', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1),
(17, 'Insurance', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1),
(18, 'Tax', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1),
(19, 'Other', 'Admin', '2026-01-27 18:45:33', '2026-01-27 18:45:33', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_rent`
--

CREATE TABLE `vehicle_rent` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `trip_id` int(10) UNSIGNED NOT NULL,
  `transactionID` int(11) DEFAULT NULL,
  `vehicle_id` int(10) UNSIGNED NOT NULL,
  `distance_km` decimal(10,2) NOT NULL,
  `rent_per_km` decimal(10,2) NOT NULL,
  `total_rent` decimal(15,2) NOT NULL,
  `CB` varchar(50) NOT NULL,
  `CD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MD` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Add Foreign Key Constraints
--

ALTER TABLE `cash_management`
  ADD CONSTRAINT `cash_management_ibfk_1` FOREIGN KEY (`daily_entry_id`) REFERENCES `daily_sales_entries` (`id`) ON DELETE CASCADE;

ALTER TABLE `cash_outflow_bank`
  ADD CONSTRAINT `cash_outflow_bank_ibfk_1` FOREIGN KEY (`cash_management_id`) REFERENCES `cash_management` (`id`);

ALTER TABLE `cash_outflow_net`
  ADD CONSTRAINT `cash_outflow_net_ibfk_1` FOREIGN KEY (`cash_management_id`) REFERENCES `cash_management` (`id`);

ALTER TABLE `cash_outflow_owner`
  ADD CONSTRAINT `cash_outflow_owner_ibfk_1` FOREIGN KEY (`cash_management_id`) REFERENCES `cash_management` (`id`);

ALTER TABLE `credit_sales`
  ADD CONSTRAINT `credit_sales_ibfk_1` FOREIGN KEY (`fuel_station_customer_id`) REFERENCES `fuel_station_customer` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `credit_sales_ibfk_2` FOREIGN KEY (`daily_entry_id`) REFERENCES `daily_sales_entries` (`id`) ON DELETE CASCADE;

ALTER TABLE `credit_sale_payments`
  ADD CONSTRAINT `credit_sale_payments_ibfk_1` FOREIGN KEY (`credit_sale_id`) REFERENCES `credit_sales` (`id`) ON DELETE CASCADE;

ALTER TABLE `daily_expenses`
  ADD CONSTRAINT `daily_expenses_ibfk_1` FOREIGN KEY (`expense_category`) REFERENCES `expense_categories` (`id`),
  ADD CONSTRAINT `daily_expenses_ibfk_2` FOREIGN KEY (`daily_entry_id`) REFERENCES `daily_sales_entries` (`id`) ON DELETE CASCADE;

ALTER TABLE `daily_sales_entries`
  ADD CONSTRAINT `daily_sales_entries_ibfk_1` FOREIGN KEY (`pump_id`) REFERENCES `petrol_pumps` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `daily_sales_entries_ibfk_2` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `daily_tank_inventory`
  ADD CONSTRAINT `daily_tank_inventory_ibfk_1` FOREIGN KEY (`daily_entry_id`) REFERENCES `daily_sales_entries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `daily_tank_inventory_ibfk_2` FOREIGN KEY (`tank_id`) REFERENCES `fuel_tanks` (`id`) ON DELETE CASCADE;

ALTER TABLE `fuele_station_customer_vehicles`
  ADD CONSTRAINT `fuele_station_customer_vehicles_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `fuel_station_customer` (`customer_id`) ON DELETE CASCADE;

ALTER TABLE `fuel_rates`
  ADD CONSTRAINT `fuel_rates_ibfk_1` FOREIGN KEY (`fuel_type_id`) REFERENCES `fuel_types` (`id`);

ALTER TABLE `fuel_station_customer_recoveries`
  ADD CONSTRAINT `fuel_station_customer_recoveries_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `fuel_station_customer` (`customer_id`);

ALTER TABLE `fuel_tanks`
  ADD CONSTRAINT `fuel_tanks_ibfk_1` FOREIGN KEY (`pump_id`) REFERENCES `petrol_pumps` (`id`) ON DELETE CASCADE;

ALTER TABLE `machines`
  ADD CONSTRAINT `machines_ibfk_1` FOREIGN KEY (`pump_id`) REFERENCES `petrol_pumps` (`id`) ON DELETE CASCADE;

ALTER TABLE `machine_readings`
  ADD CONSTRAINT `machine_readings_ibfk_1` FOREIGN KEY (`daily_entry_id`) REFERENCES `daily_sales_entries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `machine_readings_ibfk_2` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `mobile_oil_cash_sales`
  ADD CONSTRAINT `mobile_oil_cash_sales_ibfk_1` FOREIGN KEY (`daily_entry_id`) REFERENCES `daily_sales_entries` (`id`) ON DELETE CASCADE;

ALTER TABLE `nozzles`
  ADD CONSTRAINT `nozzles_ibfk_1` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `nozzle_readings`
  ADD CONSTRAINT `nozzle_readings_ibfk_1` FOREIGN KEY (`daily_entry_id`) REFERENCES `daily_sales_entries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `nozzle_readings_ibfk_2` FOREIGN KEY (`nozzle_id`) REFERENCES `nozzles` (`id`) ON DELETE CASCADE;

ALTER TABLE `petrol_pumps`
  ADD CONSTRAINT `petrol_pumps_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`);

ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`pump_id`) REFERENCES `petrol_pumps` (`id`) ON DELETE CASCADE;

ALTER TABLE `station_cash_in_hand`
  ADD CONSTRAINT `station_cash_in_hand_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `fuel_station_customer` (`customer_id`);

COMMIT;