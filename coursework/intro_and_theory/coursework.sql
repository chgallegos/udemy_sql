##########################################################
##########################################################
##########################################################

# SQL - MySQL for Data Analytics and Business Intelligence
# Lecture and Exercise Code

##########################################################
##########################################################
##########################################################





##########################################################
##########################################################

-- SECTION: First Steps in SQL

##########################################################
##########################################################


###########
-- LECTURE: Creating a Database - Part I

CREATE DATABASE IF NOT EXISTS Sales;

CREATE SCHEMA IF NOT EXISTS Sales;

-- EXERCISE 1: Creating a Database - Part I
CREATE DATABASE IF NOT EXISTS Sales;

CREATE SCHEMA IF NOT EXISTS Sales;


###########
-- LECTURE: Creating a Database - Part II

USE sales;

-- EXERCISE 1: Creating a Database - Part II
USE Sales;


###########
-- LECTURE: Fixed and Floating-Point Data Types

CREATE TABLE test (
    test DECIMAL(5,3)
);

INSERT test VALUES (10.5);

SELECT 
    *
FROM
    test;

INSERT INTO test VALUES (12.55555);

ALTER TABLE `employees`.`test` 
ADD COLUMN `test_fl` FLOAT(5,3) NULL AFTER `test`;

INSERT INTO test(test_fl) VALUES (14.55555);

INSERT INTO test(test) VALUES (16.55555);


###########
-- LECTURE: Creating a Table

CREATE TABLE sales 
(
	purchase_number INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE NOT NULL,     
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

-- EXERCISE 1: Creating a Table
CREATE TABLE customers				
(
    customer_id INT,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int
);


###########
-- LECTURE: Using Databases and Tables

/* 
CREATE DATABASE IF NOT EXISTS Sales;
USE Sales;
*/

SELECT 
    *
FROM
    customers;

SELECT 
    *
FROM
    sales.customers;

-- EXERCISE 1: Using Databases and Tables
SELECT 
    *
FROM
    sales;

SELECT 
    *
FROM
    sales.sales;


###########
-- LECTURE: Additional Notes on Using Tables

/*
CREATE TABLE sales 
(
	purchase_number INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE NOT NULL,     
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);
*/

DROP TABLE sales;

-- EXERICSE 1: Additional Notes on Using Tables
DROP TABLE sales;





##########################################################
##########################################################

-- SECTION: MySQL Constraints

##########################################################
##########################################################


###########
-- LECTURE: PRIMARY KEY Constraint

/*
CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10)
);
*/

CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);

-- EXERCISE 1: PRIMARY KEY Constraint
DROP TABLE customers;

CREATE TABLE customers				
(
    customer_id INT,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int, 
PRIMARY KEY (customer_id)
);

CREATE TABLE items (
    item_id VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10 , 2 ),
    company_id VARCHAR(255),
PRIMARY KEY (item_id)
);

  CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255),
    headquarters_phone_number INT(12),
PRIMARY KEY (company_id)
);

###########
-- LECTURE: FOREIGN KEY Constraint - Part I

CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);


###########
-- LECTURE: FOREIGN KEY Constraint - Part II

DROP TABLE sales;

CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);

ALTER TABLE sales 
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;

-- EXERCISE 1: FOREIGN KEY Constraint - Part II
DROP TABLE sales;

DROP TABLE customers;

DROP TABLE items;

DROP TABLE companies;


###########
-- LECTURE: UNIQUE KEY Constraint

/*create table customers				
(
    customer_id int,
    first_name varchar(255),
	last_name varchar(255),
	email_address varchar(255),
	number_of_complaints int,
PRIMARY KEY (customer_id)
);
*/

CREATE TABLE customers 
(
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id),
UNIQUE KEY (email_address)
);

DROP TABLE customers;

CREATE TABLE customers 
(
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD UNIQUE KEY (email_address);

-- If you want to drop a unique Key, use following syntax

ALTER TABLE customers
DROP INDEX email_address;

-- UNIQUE Constraint - exercise

DROP TABLE customers;

CREATE TABLE customers(
	customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
	email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD COLUMN gender ENUM('M','F') AFTER last_name;

INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley','M','john.mckinley@365careers.com',0)
;

-- DEFAULT Constraints

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT '0';
-- Check if it worked by adding a record without including the number of compaints

INSERT INTO customers (first_name, last_name, gender, email_address)
VALUES ('Peter', 'Figaro','M','peter.figaro@365careers.com');

INSERT INTO customers (first_name, last_name, gender)
VALUES ('Chris', 'Gallegos','M');

SELECT * FROM customers;

-- If you want to drop DEFAULT constraint

ALTER TABLE customers 
ALTER COLUMN number_of_complaints DROP DEFAULT;

-- DEFAULT Constraint - exercise
-- Recreate the “companies” table

CREATE TABLE companies(
	company_id VARCHAR(255) PRIMARY KEY,
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number VARCHAR(255) UNIQUE
);

-- Another way of doing it
-- CREATE TABLE companies
-- (
--     company_id VARCHAR(255),
--     company_name VARCHAR(255) DEFAULT 'X',
--     headquarters_phone_number VARCHAR(255),
-- PRIMARY KEY (company_id),
-- UNIQUE KEY (headquarters_phone_number)
-- );

DROP TABLE companies;

-- 'Not Null' Constraints Part 1

CREATE TABLE companies(
	company_id INT AUTO_INCREMENT,
    headquarters_phone_number VARCHAR (255),
    company_name VARCHAR (255) NOT NULL,
PRIMARY KEY (company_id)
);

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR (255) NOT NULL;

INSERT INTO companies (headquarters_phone_number)
VALUES ('+1 (202) 555-0196');
-- This gives an error because NOT NULL doesnt allow the INSERT to go throught without a company mane

INSERT INTO companies (headquarters_phone_number, company_name)
VALUES ('+1 (202) 555-0196', 'A');

-- 'Not Null' Constraints Part 2
-- Just because a value is 0 or NONE, it does not necessarilly mean that it is a NULL value




    
