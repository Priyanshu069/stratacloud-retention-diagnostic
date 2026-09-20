USE stratacloud_db;

-- 1. Reset and Recreate Schema
DROP TABLE IF EXISTS fact_support_tickets;
DROP TABLE IF EXISTS fact_subscriptions;
DROP TABLE IF EXISTS dim_customers;
DROP TABLE IF EXISTS dim_plans;

CREATE TABLE dim_plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    monthly_fee DECIMAL(10, 2),
    tier_level INT
);

INSERT INTO dim_plans VALUES
(1, 'Basic', 99.00, 1),
(2, 'Professional', 499.00, 2),
(3, 'Enterprise', 1499.00, 3);

CREATE TABLE dim_customers (
    customer_id INT PRIMARY KEY,
    company_name VARCHAR(100),
    industry VARCHAR(50),
    company_size VARCHAR(50),
    signup_date DATE,
    country VARCHAR(50)
);

CREATE TABLE fact_subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    plan_id INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    discount_pct DECIMAL(5, 2),
    monthly_revenue DECIMAL(10, 2),
    cancellation_reason VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (plan_id) REFERENCES dim_plans(plan_id)
);

CREATE TABLE fact_support_tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    ticket_date DATE,
    category VARCHAR(50),
    resolution_time_hrs DECIMAL(6, 2),
    csat_score INT,
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id)
);

-- 2. Populate 60 Diverse B2B Customers
INSERT INTO dim_customers (customer_id, company_name, industry, company_size, signup_date, country) VALUES
(101, 'Apex Fintech', 'FinTech', 'Enterprise', '2023-01-10', 'USA'),
(102, 'BioHealth Corp', 'HealthTech', 'Enterprise', '2023-01-15', 'USA'),
(103, 'SwiftCommerce', 'Retail', 'Mid-Market', '2023-01-22', 'UK'),
(104, 'Titan Factory', 'Manufacturing', 'Enterprise', '2023-02-05', 'Germany'),
(105, 'Nova Labs', 'HealthTech', 'Startup', '2023-02-18', 'Canada'),
(106, 'PayPulse', 'FinTech', 'Mid-Market', '2023-03-02', 'USA'),
(107, 'CartFlow', 'Retail', 'Startup', '2023-03-14', 'UK'),
(108, 'Precision Gear', 'Manufacturing', 'Mid-Market', '2023-03-25', 'Germany'),
(109, 'OmniHealth', 'HealthTech', 'Mid-Market', '2023-04-04', 'USA'),
(110, 'Quantum Ledger', 'FinTech', 'Startup', '2023-04-19', 'USA'),
(111, 'SmartAssembly', 'Manufacturing', 'Enterprise', '2023-05-08', 'Germany'),
(112, 'UrbanBoutique', 'Retail', 'Startup', '2023-05-20', 'UK'),
(113, 'SecureVault', 'FinTech', 'Enterprise', '2023-06-02', 'USA'),
(114, 'Genomics Plus', 'HealthTech', 'Enterprise', '2023-06-15', 'Canada'),
(115, 'DirectShip Ltd', 'Retail', 'Mid-Market', '2023-07-01', 'UK'),
(116, 'AeroParts Global', 'Manufacturing', 'Enterprise', '2023-07-12', 'Germany'),
(117, 'CarePoint Clinic', 'HealthTech', 'Mid-Market', '2023-07-28', 'USA'),
(118, 'Krypton Pay', 'FinTech', 'Startup', '2023-08-05', 'USA'),
(119, 'TrendVibe', 'Retail', 'Startup', '2023-08-19', 'UK'),
(120, 'Machinery Pro', 'Manufacturing', 'Mid-Market', '2023-09-02', 'Germany'),
(121, 'PulsePoint', 'HealthTech', 'Enterprise', '2023-09-14', 'USA'),
(122, 'Alpha Capital', 'FinTech', 'Enterprise', '2023-09-29', 'USA'),
(123, 'PrimeMarket', 'Retail', 'Enterprise', '2023-10-10', 'UK'),
(124, 'SteelWorks AG', 'Manufacturing', 'Enterprise', '2023-10-25', 'Germany'),
(125, 'Veloce Retail', 'Retail', 'Mid-Market', '2023-11-04', 'Canada'),
(126, 'MedGenetics', 'HealthTech', 'Startup', '2023-11-18', 'Canada'),
(127, 'BlockSettlement', 'FinTech', 'Mid-Market', '2023-12-01', 'USA'),
(128, 'AutoStamping KG', 'Manufacturing', 'Mid-Market', '2023-12-15', 'Germany'),
(129, 'DailyWear', 'Retail', 'Startup', '2024-01-05', 'UK'),
(130, 'Cellular Diagnostics', 'HealthTech', 'Enterprise', '2024-01-18', 'USA'),
(131, 'HedgeTech', 'FinTech', 'Enterprise', '2024-02-02', 'USA'),
(132, 'EuroRobotics', 'Manufacturing', 'Enterprise', '2024-02-14', 'Germany'),
(133, 'ShopStream', 'Retail', 'Mid-Market', '2024-02-28', 'Canada'),
(134, 'PharmaLink', 'HealthTech', 'Mid-Market', '2024-03-10', 'USA'),
(135, 'ClearClearing', 'FinTech', 'Startup', '2024-03-22', 'USA'),
(136, 'Industrial Motion', 'Manufacturing', 'Mid-Market', '2024-04-03', 'Germany'),
(137, 'FastBasket', 'Retail', 'Startup', '2024-04-15', 'UK'),
(138, 'VitalMetrics', 'HealthTech', 'Startup', '2024-04-29', 'Canada'),
(139, 'CapitalShield', 'FinTech', 'Enterprise', '2024-05-12', 'USA'),
(140, 'Foundry Tech', 'Manufacturing', 'Enterprise', '2024-05-25', 'Germany'),
(141, 'MerchantHub', 'Retail', 'Mid-Market', '2024-06-01', 'UK'),
(142, 'ImmunoCare', 'HealthTech', 'Enterprise', '2024-06-12', 'USA'),
(143, 'NeoBank Corp', 'FinTech', 'Mid-Market', '2024-06-25', 'USA'),
(144, 'Precision Plastics', 'Manufacturing', 'Mid-Market', '2024-07-05', 'Germany'),
(145, 'ClickStyle', 'Retail', 'Startup', '2024-07-18', 'Canada'),
(146, 'BioSynthetics', 'HealthTech', 'Mid-Market', '2024-08-01', 'USA'),
(147, 'SurePay Systems', 'FinTech', 'Startup', '2024-08-10', 'USA'),
(148, 'HeavyMilling Ltd', 'Manufacturing', 'Enterprise', '2024-08-20', 'Germany'),
(149, 'NextGen Goods', 'Retail', 'Mid-Market', '2024-08-28', 'UK'),
(150, 'NeuroCare Labs', 'HealthTech', 'Enterprise', '2024-09-05', 'USA'),
(151, 'EquityEdge', 'FinTech', 'Enterprise', '2024-09-15', 'USA'),
(152, 'SmartSensors GmbH', 'Manufacturing', 'Mid-Market', '2024-09-25', 'Germany'),
(153, 'GlobalVendor', 'Retail', 'Enterprise', '2024-10-02', 'UK'),
(154, 'ClinicalTrail Corp', 'HealthTech', 'Startup', '2024-10-12', 'Canada'),
(155, 'LedgerFlow', 'FinTech', 'Mid-Market', '2024-10-22', 'USA'),
(156, 'Advanced Casting', 'Manufacturing', 'Enterprise', '2024-11-01', 'Germany'),
(157, 'BoutiqueDirect', 'Retail', 'Startup', '2024-11-10', 'UK'),
(158, 'HealthTracker Systems', 'HealthTech', 'Mid-Market', '2024-11-20', 'USA'),
(159, 'VenturePay', 'FinTech', 'Startup', '2024-12-01', 'USA'),
(160, 'Apex Tooling', 'Manufacturing', 'Mid-Market', '2024-12-10', 'Germany');

-- 3. Populate Subscriptions (Active, Cancelled, and Tier Upgrades)
INSERT INTO fact_subscriptions (customer_id, plan_id, start_date, end_date, status, discount_pct, monthly_revenue, cancellation_reason) VALUES
-- Cohort 2023 Q1
(101, 3, '2023-01-10', NULL, 'Active', 0.10, 1349.10, NULL),
(102, 3, '2023-01-15', '2023-09-20', 'Cancelled', 0.25, 1124.25, 'Technical Issues & Downtime'),
(103, 2, '2023-01-22', NULL, 'Active', 0.05, 474.05, NULL),
(104, 3, '2023-02-05', NULL, 'Active', 0.15, 1274.15, NULL),
(105, 1, '2023-02-18', '2023-06-30', 'Cancelled', 0.00, 99.00, 'Price Too High'),
(106, 2, '2023-03-02', NULL, 'Active', 0.10, 449.10, NULL),
(107, 1, '2023-03-14', '2023-08-10', 'Cancelled', 0.00, 99.00, 'Poor Support'),
(108, 2, '2023-03-25', NULL, 'Active', 0.00, 499.00, NULL),

-- Cohort 2023 Q2
(109, 2, '2023-04-04', '2023-11-15', 'Cancelled', 0.10, 449.10, 'Technical Issues & Downtime'),
(110, 1, '2023-04-19', NULL, 'Active', 0.00, 99.00, NULL),
(111, 3, '2023-05-08', NULL, 'Active', 0.20, 1199.20, NULL),
(112, 1, '2023-05-20', '2023-09-15', 'Cancelled', 0.00, 99.00, 'Missing Features'),
(113, 3, '2023-06-02', NULL, 'Active', 0.10, 1349.10, NULL),
(114, 3, '2023-06-15', '2024-01-10', 'Cancelled', 0.30, 1049.30, 'Technical Issues & Downtime'),

-- Cohort 2023 Q3
(115, 2, '2023-07-01', NULL, 'Active', 0.05, 474.05, NULL),
(116, 3, '2023-07-12', NULL, 'Active', 0.10, 1349.10, NULL),
(117, 2, '2023-07-28', '2024-02-15', 'Cancelled', 0.15, 424.15, 'Poor Support'),
(118, 1, '2023-08-05', NULL, 'Active', 0.00, 99.00, NULL),
(119, 1, '2023-08-19', '2023-12-05', 'Cancelled', 0.00, 99.00, 'Price Too High'),
(120, 2, '2023-09-02', NULL, 'Active', 0.00, 499.00, NULL),
(121, 3, '2023-09-14', '2024-05-20', 'Cancelled', 0.25, 1124.25, 'Technical Issues & Downtime'),
(122, 3, '2023-09-29', NULL, 'Active', 0.10, 1349.10, NULL),

-- Cohort 2023 Q4
(123, 3, '2023-10-10', NULL, 'Active', 0.15, 1274.15, NULL),
(124, 3, '2023-10-25', NULL, 'Active', 0.10, 1349.10, NULL),
(125, 2, '2023-11-04', '2024-04-10', 'Cancelled', 0.10, 449.10, 'Missing Features'),
(126, 1, '2023-11-18', '2024-03-20', 'Cancelled', 0.00, 99.00, 'Price Too High'),
(127, 2, '2023-12-01', NULL, 'Active', 0.00, 499.00, NULL),
(128, 2, '2023-12-15', NULL, 'Active', 0.05, 474.05, NULL),

-- Cohort 2024 Q1
(129, 1, '2024-01-05', '2024-05-15', 'Cancelled', 0.00, 99.00, 'Price Too High'),
(130, 3, '2024-01-18', '2024-08-20', 'Cancelled', 0.35, 974.35, 'Technical Issues & Downtime'),
(131, 3, '2024-02-02', NULL, 'Active', 0.10, 1349.10, NULL),
(132, 3, '2024-02-14', NULL, 'Active', 0.15, 1274.15, NULL),
(133, 2, '2024-02-28', NULL, 'Active', 0.10, 449.10, NULL),
(134, 2, '2024-03-10', '2024-09-10', 'Cancelled', 0.15, 424.15, 'Poor Support'),
(135, 1, '2024-03-22', NULL, 'Active', 0.00, 99.00, NULL),

-- Cohort 2024 Q2
(136, 2, '2024-04-03', NULL, 'Active', 0.00, 499.00, NULL),
(137, 1, '2024-04-15', '2024-08-30', 'Cancelled', 0.00, 99.00, 'Price Too High'),
(138, 1, '2024-04-29', NULL, 'Active', 0.00, 99.00, NULL),
(139, 3, '2024-05-12', NULL, 'Active', 0.10, 1349.10, NULL),
(140, 3, '2024-05-25', NULL, 'Active', 0.10, 1349.10, NULL),
(141, 2, '2024-06-01', '2024-11-15', 'Cancelled', 0.10, 449.10, 'Missing Features'),
(142, 3, '2024-06-12', '2024-12-05', 'Cancelled', 0.30, 1049.30, 'Technical Issues & Downtime'),
(143, 2, '2024-06-25', NULL, 'Active', 0.05, 474.05, NULL),

-- Cohort 2024 Q3
(144, 2, '2024-07-05', NULL, 'Active', 0.00, 499.00, NULL),
(145, 1, '2024-07-18', '2024-11-20', 'Cancelled', 0.00, 99.00, 'Price Too High'),
(146, 2, '2024-08-01', NULL, 'Active', 0.10, 449.10, NULL),
(147, 1, '2024-08-10', NULL, 'Active', 0.00, 99.00, NULL),
(148, 3, '2024-08-20', NULL, 'Active', 0.15, 1274.15, NULL),
(149, 2, '2024-08-28', NULL, 'Active', 0.05, 474.05, NULL),
(150, 3, '2024-09-05', NULL, 'Active', 0.20, 1199.20, NULL),
(151, 3, '2024-09-15', NULL, 'Active', 0.10, 1349.10, NULL),
(152, 2, '2024-09-25', NULL, 'Active', 0.00, 499.00, NULL),

-- Cohort 2024 Q4
(153, 3, '2024-10-02', NULL, 'Active', 0.15, 1274.15, NULL),
(154, 1, '2024-10-12', NULL, 'Active', 0.00, 99.00, NULL),
(155, 2, '2024-10-22', NULL, 'Active', 0.05, 474.05, NULL),
(156, 3, '2024-11-01', NULL, 'Active', 0.10, 1349.10, NULL),
(157, 1, '2024-11-10', NULL, 'Active', 0.00, 99.00, NULL),
(158, 2, '2024-11-20', NULL, 'Active', 0.00, 499.00, NULL),
(159, 1, '2024-12-01', NULL, 'Active', 0.00, 99.00, NULL),
(160, 2, '2024-12-10', NULL, 'Active', 0.05, 474.05, NULL);

-- 4. Support Tickets (Structured so you can analyze response-time bottlenecks vs churn)
INSERT INTO fact_support_tickets (customer_id, ticket_date, category, resolution_time_hrs, csat_score) VALUES
(101, '2023-03-10', 'Billing', 3.5, 5),
(101, '2023-08-12', 'Feature Request', 12.0, 4),
(102, '2023-04-15', 'Performance Issue', 52.0, 1),
(102, '2023-06-20', 'Technical Issues', 64.5, 1),
(102, '2023-08-05', 'Technical Issues', 72.0, 1),
(103, '2023-04-02', 'Billing', 4.0, 5),
(103, '2023-09-18', 'Feature Request', 18.0, 4),
(104, '2023-05-11', 'Billing', 2.5, 5),
(105, '2023-03-25', 'Price Inquiry', 8.0, 2),
(105, '2023-05-10', 'Billing', 14.0, 3),
(106, '2023-06-01', 'Feature Request', 9.5, 4),
(107, '2023-05-14', 'Performance Issue', 48.0, 1),
(107, '2023-07-02', 'Technical Issues', 55.0, 2),
(108, '2023-07-19', 'Billing', 3.0, 5),
(109, '2023-06-22', 'Technical Issues', 58.0, 1),
(109, '2023-09-10', 'Performance Issue', 62.5, 1),
(111, '2023-08-14', 'Billing', 4.5, 4),
(112, '2023-07-10', 'Feature Request', 32.0, 2),
(113, '2023-09-05', 'Billing', 2.0, 5),
(114, '2023-08-18', 'Technical Issues', 49.0, 1),
(114, '2023-11-22', 'Performance Issue', 68.0, 1),
(115, '2023-10-10', 'Feature Request', 15.0, 4),
(116, '2023-11-05', 'Billing', 3.0, 5),
(117, '2023-10-15', 'Performance Issue', 44.0, 2),
(117, '2023-12-08', 'Technical Issues', 51.0, 1),
(119, '2023-10-02', 'Billing', 16.0, 2),
(121, '2024-01-12', 'Performance Issue', 56.0, 1),
(121, '2024-03-25', 'Technical Issues', 61.0, 1),
(123, '2024-02-10', 'Billing', 2.5, 5),
(124, '2024-03-01', 'Feature Request', 11.0, 4),
(125, '2024-02-18', 'Feature Request', 28.0, 3),
(126, '2024-01-20', 'Billing', 12.0, 2),
(130, '2024-03-15', 'Performance Issue', 66.0, 1),
(130, '2024-05-18', 'Technical Issues', 70.5, 1),
(130, '2024-07-02', 'Technical Issues', 74.0, 1),
(134, '2024-05-12', 'Technical Issues', 46.0, 2),
(134, '2024-07-19', 'Performance Issue', 50.0, 1),
(137, '2024-06-10', 'Billing', 14.5, 3),
(141, '2024-08-15', 'Feature Request', 30.0, 2),
(142, '2024-08-02', 'Performance Issue', 59.0, 1),
(142, '2024-10-14', 'Technical Issues', 63.0, 1),
(145, '2024-09-08', 'Billing', 15.0, 2);


SELECT 'dim_customers' AS tbl, COUNT(*) AS total_rows FROM dim_customers
UNION ALL
SELECT 'dim_plans', COUNT(*) FROM dim_plans
UNION ALL
SELECT 'fact_subscriptions', COUNT(*) FROM fact_subscriptions
UNION ALL
SELECT 'fact_support_tickets', COUNT(*) FROM fact_support_tickets;