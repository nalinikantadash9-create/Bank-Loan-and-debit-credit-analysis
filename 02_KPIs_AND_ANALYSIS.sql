-- BANKING TRANSACTION ANALYSIS PROJECT
-- FILE 02 : KPIs AND BUSINESS ANALYSIS
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use BankingDB;

# 1. KEY BANKING KPIs

# Total credit amount
select sum(amount) as total_credit_amount from banking_transactions_raw
where transaction_type = 'Credit';


# Total debit amount
select sum(amount) as total_debit_amount from banking_transactions_raw
where transaction_type = 'Debit';


# Credit to debit ratio
select
sum(case when transaction_type = 'Credit' then amount else 0 end) 
/
nullif(sum(case when transaction_type = 'Debit' then amount else 0 end), 0) as credit_to_debit_ratio
from banking_transactions_raw;

# Net transaction amount
select sum(case when transaction_type = 'Credit' then amount else 0 end) 
-
sum(case when transaction_type = 'Debit' then amount else 0 end) as net_transaction_amount
from banking_transactions_raw;


# Account activity ratio
select
count(*) / nullif(avg(balance), 0) as account_activity_ratio from banking_transactions_raw;

# 2. TRANSACTION OVERVIEW
# Overall transaction summary
select
count(*) as total_transactions,count(distinct customer_id) as total_customers,
avg(amount) as average_transaction_amount,max(amount) as highest_transaction_amount,
min(amount) as lowest_transaction_amount,avg(balance) as average_balance
from banking_transactions_raw;


# Transaction count and amount by transaction type
select
transaction_type, count(*) as transaction_count,
sum(amount) as total_amount,avg(amount) as average_amount
from banking_transactions_raw
group by transaction_type
order by transaction_count desc;

# 3. TRANSACTION ACTIVITY OVER TIME

# Transactions per month
select
year(transaction_date) as transaction_year,
month(transaction_date) as transaction_month,
count(*) as transaction_count,
sum(amount) as total_transaction_amount
from banking_transactions_raw
group by year(transaction_date), month(transaction_date)
order by transaction_year, transaction_month;


# 4. BRANCH ANALYSIS

# Total transaction amount by branch
select
branch,
count(*) as transaction_count,
sum(amount) as total_transaction_amount,
avg(amount) as average_transaction_amount
from banking_transactions_raw
group by branch
order by total_transaction_amount desc;


# 5. BANK ANALYSIS
# Transaction volume by bank

select
bank_name,
count(*) as transaction_count,
sum(amount) as total_transaction_amount,
avg(amount) as average_transaction_amount
from banking_transactions_raw
group by bank_name
order by transaction_count desc;


# 6. TRANSACTION METHOD ANALYSIS
# Transaction activity by method
select
transaction_method,
count(*) as transaction_count,
sum(amount) as total_transaction_amount
from banking_transactions_raw
group by transaction_method
order by transaction_count desc;


# 7. CUSTOMER TRANSACTION ANALYSIS

# Customers with the highest transaction activity
select
customer_id,
customer_name,
count(*) as transaction_count,
sum(amount) as total_transaction_amount
from banking_transactions_raw
group by customer_id, customer_name
order by transaction_count desc
limit 10;


# 8. HIGH-VALUE TRANSACTION ANALYSIS

# Top 10 largest transactions

select customer_id,
customer_name,transaction_date,
transaction_type,amount,
bank_name,branch,transaction_method
from banking_transactions_raw
order by amount desc
limit 10;


# Transactions above the average transaction amount
select customer_id,
customer_name,transaction_date,
transaction_type,amount,
bank_name,branch
from banking_transactions_raw
where amount > (select avg(amount) from banking_transactions_raw)
order by amount desc;


# 9. TRANSACTION VALUE CATEGORIZATION

# Categorize transactions as Low, Medium, or High

select
customer_id,transaction_date,transaction_type,amount,
case
when amount < 1000 then 'Low'
when amount between 1000 and 5000 then 'Medium'
else 'High'
end as transaction_category
from banking_transactions_raw
order by amount desc;


# 10. BUSINESS SUMMARY
# Overall banking transaction summary

select
count(*) as total_transactions,
count(distinct customer_id) as total_customers,
sum(case when transaction_type = 'Credit' then amount else 0 end) as total_credit_amount,
sum(case when transaction_type = 'Debit' then amount else 0 end) as total_debit_amount,
sum(case when transaction_type = 'Credit' then amount else 0 end) -
sum(case when transaction_type = 'Debit' then amount else 0 end) as net_transaction_amount,
avg(amount) as average_transaction_amount,
avg(balance) as average_balance
from banking_transactions_raw;