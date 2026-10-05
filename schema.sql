-- ==========================================================
-- GreenNest Database Initialization Script
-- Compatible with MySQL 8.x (Local and Railway / Cloud MySQL)
-- ==========================================================

CREATE DATABASE IF NOT EXISTS greennest;
USE greennest;

-- 1. Admin Table
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. Users Table
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. Products Table
CREATE TABLE IF NOT EXISTS `products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `category` VARCHAR(50) DEFAULT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 4. Orders Table
CREATE TABLE IF NOT EXISTS `orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` VARCHAR(30) NOT NULL,
  `customer_name` VARCHAR(100) DEFAULT NULL,
  `phone` VARCHAR(15) DEFAULT NULL,
  `address` VARCHAR(255) DEFAULT NULL,
  `city` VARCHAR(100) DEFAULT NULL,
  `pincode` VARCHAR(10) DEFAULT NULL,
  `payment_method` VARCHAR(50) DEFAULT NULL,
  `total` DECIMAL(10,2) DEFAULT NULL,
  `order_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_email` VARCHAR(100) DEFAULT NULL,
  `status` VARCHAR(30) DEFAULT 'Order Placed',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ==========================================================
-- Starter Seed Data
-- ==========================================================

-- Default Administrator (admin@greennest.com / admin123)
INSERT INTO `admin` (`admin_id`, `name`, `email`, `password`)
VALUES (1, 'Admin', 'admin@greennest.com', 'admin123')
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`);

-- Starter Plants Catalog
INSERT INTO `products` (`id`, `name`, `category`, `price`, `description`) VALUES
(1, 'Snake Plant', 'Indoor', 299.00, 'Low maintenance and air purifying upright indoor plant.'),
(2, 'Money Plant', 'Indoor', 199.00, 'Easy to grow and beautiful trailing foliage plant.'),
(3, 'Aloe Vera', 'Succulent', 149.00, 'Medicinal succulent needing minimal watering.'),
(4, 'Peace Lily', 'Flowering', 349.00, 'Elegant plant with lush leaves and white blooms.'),
(5, 'Areca Palm', 'Indoor', 399.00, 'Tropical air-purifying indoor palm plant.'),
(6, 'Hibiscus', 'Balcony', 249.00, 'Vibrant flowering balcony and garden plant.'),
(7, 'Lemon Plant', 'Fruit', 249.00, 'Citrus fruit-bearing plant for sunny balconies.')
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`);
