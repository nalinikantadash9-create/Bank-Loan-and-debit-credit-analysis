-- BANKING TRANSACTION ANALYSIS PROJECT
-- FILE 01 : DATA SETUP AND CLEANING
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 1. CREATE DATABASE
create database if not exists BankingDB;
use BankingDB;

# 2. CREATE RAW TABLE
drop table if exists banking_transactions_raw;

create table banking_transactions_raw 
    (customer_id varchar(50),
    customer_name varchar(100),
    account_number varchar(50),
    transaction_date date,
    transaction_type varchar(20),
    amount decimal(12,2),
    balance decimal(12,2),
    description varchar(100),
    branch varchar(100),
    transaction_method varchar(50),
    currency varchar(10),
    bank_name varchar(100));

# 3. IMPORT DATA
-- Import the Excel file using MySQL Workbench:
-- Table Data Import Wizard
-- File: Debit and Credit banking_data.xlsx


# 4. CHECK THE DATA

# Checking all records
select * from banking_transactions_raw;

# Count total records
select count(*) as total_records from banking_transactions_raw;


# Check column values
select 
customer_id,customer_name, account_number,transaction_date,transaction_type,amount,balance,
description,branch,transaction_method,currency,bank_name
from banking_transactions_raw 
limit 10;

# 5. CHECK NULL VALUES
select count(*) as null_customer_id from banking_transactions_raw
where customer_id is null;

select count(*) as null_customer_name from banking_transactions_raw
where customer_name is null;

select count(*) as null_account_number from banking_transactions_raw
where account_number is null;

select count(*) as null_transaction_date from banking_transactions_raw
where transaction_date is null;

select count(*) as null_transaction_type from banking_transactions_raw
where transaction_type is null;

select count(*) as null_amount from banking_transactions_raw
where amount is null;

select count(*) as null_balance from banking_transactions_raw
where balance is null;

# 6. CHECK DUPLICATES
select
customer_id,count(*) as record_count from banking_transactions_raw
group by customer_id
having count(*) > 1;

select account_number, count(*) as record_count from banking_transactions_raw
group by account_number
having count(*) > 1;

# 7. CHECK DISTINCT VALUES
select distinct transaction_type from banking_transactions_raw;

select distinct transaction_method from banking_transactions_raw;

select distinct currency from banking_transactions_raw;

select distinct bank_name from banking_transactions_raw;

select distinct branch from banking_transactions_raw;

select distinct description from banking_transactions_raw;


# 8. CHECK INVALID VALUES
# Check for invalid transaction types
select * from banking_transactions_raw
where transaction_type not in ('Credit', 'Debit');

# Check for zero or negative transaction amounts
select * from banking_transactions_raw
where amount <= 0;

# Check for negative balances
select * from banking_transactions_raw
where balance < 0;

# 9. CHECK DATE RANGE

select
min(transaction_date) as first_transaction_date,
max(transaction_date) as last_transaction_date
from banking_transactions_raw;


# Check transactions by month
select
month(transaction_date) as transaction_month,
count(*) as transaction_count
from banking_transactions_raw
group by month(transaction_date)
order by transaction_month;


# 10. CHECK DATA CONSISTENCY
# Check whether currency contains values other than INR
select * from banking_transactions_raw where currency <> 'INR';


# Check unusually large transaction amounts
select *
from banking_transactions_raw where amount > 5000;




