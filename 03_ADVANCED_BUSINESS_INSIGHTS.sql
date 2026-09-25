-- BANKING TRANSACTION ANALYSIS PROJECT
-- FILE 03 : ADVANCED BUSINESS ANALYSIS
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
use BankingDB;

# 1. CUSTOMER ANALYSIS

# Customers whose total transaction amount is above the average customer transaction amount
with customer_summary as 
(select customer_id,customer_name,sum(amount) as total_transaction_amount
from banking_transactions_raw
group by customer_id,customer_name)
select customer_id,customer_name,total_transaction_amount
from customer_summary
where total_transaction_amount > (select avg(total_transaction_amount) from customer_summary)
order by total_transaction_amount desc;

# Top 10 customers based on total transaction amount
select customer_id,customer_name,
sum(amount) as total_transaction_amount,
rank() over(order by sum(amount) desc) as customer_rank
from banking_transactions_raw
group by customer_id,customer_name
order by customer_rank
limit 10;

# 2. BANK ANALYSIS

# Rank banks based on total transaction amount
select bank_name,
sum(amount) as total_transaction_amount,
rank() over(order by sum(amount) desc) as bank_rank
from banking_transactions_raw
group by bank_name
order by bank_rank;

# Banks whose total transaction amount is above the average bank transaction amount
with bank_summary as 
(select bank_name,sum(amount) as total_transaction_amount
from banking_transactions_raw
group by bank_name)
select bank_name,total_transaction_amount
from bank_summary
where total_transaction_amount > (select avg(total_transaction_amount) from bank_summary)
order by total_transaction_amount desc;

# 3. BRANCH ANALYSIS

# Highest-value transaction in each branch
with branch_transactions as 
(select branch,customer_id,customer_name,transaction_date,
transaction_type,amount,
row_number() over(partition by branch order by amount desc) as transaction_rank
from banking_transactions_raw)
select branch,customer_id,customer_name,transaction_date,
transaction_type,amount
from branch_transactions
where transaction_rank = 1
order by amount desc;

# Rank branches based on total transaction amount
select branch,
sum(amount) as total_transaction_amount,
rank() over(order by sum(amount) desc) as branch_rank
from banking_transactions_raw
group by branch
order by branch_rank;

# 4. HIGH-VALUE TRANSACTION ANALYSIS

# Top 10 largest transactions with ranking
select customer_id,customer_name,transaction_date,
transaction_type,amount,bank_name,branch,
rank() over(order by amount desc) as transaction_rank
from banking_transactions_raw
order by transaction_rank
limit 10;

# Second highest transaction amount
select customer_id,customer_name,transaction_date,
transaction_type,amount
from (select customer_id,customer_name,transaction_date,
transaction_type,amount,
dense_rank() over(order by amount desc) as amount_rank
from banking_transactions_raw) as ranked_transactions
where amount_rank = 2;

# 5. CUSTOMER TRANSACTION BEHAVIOUR

# Largest transaction made by each customer
with customer_transactions as 
(select customer_id,customer_name,transaction_date,
transaction_type,amount,
row_number() over(partition by customer_id order by amount desc) as transaction_rank
from banking_transactions_raw)
select customer_id,customer_name,transaction_date,
transaction_type,amount
from customer_transactions
where transaction_rank = 1
order by amount desc;

# Customers with more than 5 transactions ranked by transaction activity
select customer_id,customer_name,
count(*) as transaction_count,
rank() over(order by count(*) desc) as activity_rank
from banking_transactions_raw
group by customer_id,customer_name
having count(*) > 5
order by activity_rank;

# 6. MONTHLY BUSINESS ANALYSIS

# Highest transaction month based on total transaction amount
with monthly_summary as 
(select year(transaction_date) as transaction_year,
month(transaction_date) as transaction_month,
sum(amount) as total_transaction_amount
from banking_transactions_raw
group by year(transaction_date),month(transaction_date))
select transaction_year,transaction_month,total_transaction_amount,
rank() over(order by total_transaction_amount desc) as month_rank
from monthly_summary
order by month_rank;

# Highest-value transaction in each month
with monthly_transactions as
(select year(transaction_date) as transaction_year,
month(transaction_date) as transaction_month,
customer_id,customer_name,transaction_date,
transaction_type,amount,
row_number() over(
partition by year(transaction_date),month(transaction_date)
order by amount desc) as transaction_rank
from banking_transactions_raw)
select transaction_year,transaction_month,
customer_id,customer_name,transaction_date,
transaction_type,amount
from monthly_transactions
where transaction_rank = 1
order by transaction_year,transaction_month;