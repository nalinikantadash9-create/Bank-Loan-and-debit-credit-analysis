-- BANK DATA ANALYTICS PROJECT
-- FILE 03 : ADVANCED BUSINESS ANALYSIS
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use BankingDB;

# 1. CUSTOMER ANALYSIS

# Customers whose loan exposure is above the average customer exposure
with customer_summary as (select
client_id,
client_name,
sum(funded_amount) as total_funded_amount
from banking_data
group by client_id,client_name)
select
client_id,
client_name,
total_funded_amount
from customer_summary
where total_funded_amount > (select avg(total_funded_amount)
from customer_summary)
order by total_funded_amount desc;


# Top 10 customers based on loan exposure
select
client_id,
client_name,
sum(funded_amount) as total_funded_amount,
rank() over(order by sum(funded_amount) desc) as customer_rank
from banking_data
group by client_id,client_name
order by customer_rank
limit 10;


# 2. BANK ANALYSIS

# Rank banks based on total funded amount
select
bank_name,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
rank() over(order by sum(funded_amount) desc) as bank_rank
from banking_data
group by bank_name
order by bank_rank;


# Banks with funded amount above the average bank portfolio
with bank_summary as 
(select
bank_name,
sum(funded_amount) as total_funded_amount
from banking_data
group by bank_name)
select
bank_name,
total_funded_amount
from bank_summary
where total_funded_amount > (select avg(total_funded_amount) from bank_summary)
order by total_funded_amount desc;


# 3. BRANCH ANALYSIS

# Highest funded loan in each branch
with branch_loans as 
(select
branch_name,
account_id,
client_id,
client_name,
funded_amount,
loan_status,
row_number() over(partition by branch_name order by funded_amount desc) as loan_rank
from banking_data)
select
branch_name,
account_id,
client_id,
client_name,
funded_amount,
loan_status
from branch_loans
where loan_rank = 1
order by funded_amount desc;


# Top 10 branches based on funded amount
select
branch_name,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
rank() over(order by sum(funded_amount) desc) as branch_rank
from banking_data
group by branch_name
order by branch_rank
limit 10;


# 4. STATE AND BRANCH ANALYSIS

# Highest funded branch within each state
with state_branches as 
(select
state_name,
branch_name,
sum(funded_amount) as total_funded_amount,
rank() over(partition by state_name order by sum(funded_amount) desc) as branch_rank
from banking_data
group by state_name,branch_name)
select
state_name,
branch_name,
total_funded_amount
from state_branches
where branch_rank = 1
order by state_name;


# 5. LOAN RISK ANALYSIS

# Loan purposes with default rate above the overall default rate
with purpose_summary as (
select
purpose_category,
count(*) as total_loans,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) as default_loans,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) * 100.0 / count(*) as default_rate
from banking_data
group by purpose_category)
select
purpose_category,
total_loans,
default_loans,
default_rate
from purpose_summary
where default_rate > 
(select sum(case when is_default_loan = 'Yes' then 1 else 0 end) * 100.0 
/
count(*)
from banking_data)
order by default_rate desc;


# 6. GRADE RISK ANALYSIS

# Grades with delinquency rate above the overall delinquency rate
with grade_summary as 
(select grade,
count(*) as total_loans,
sum(case when is_delinquent_loan = 'Yes' then 1 else 0 end) as delinquent_loans,
sum(case when is_delinquent_loan = 'Yes' then 1 else 0 end) * 100.0 /
count(*) as delinquency_rate
from banking_data
group by grade)
select
grade,
total_loans,
delinquent_loans,
delinquency_rate
from grade_summary
where delinquency_rate > 
(select sum(case when is_delinquent_loan = 'Yes' then 1 else 0 end) * 100.0 
/
count(*)
from banking_data)
order by delinquency_rate desc;


# 7. STATE RISK ANALYSIS

# States with the highest default rate
select
state_name,
count(*) as total_loans,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) as default_loans,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) * 100.0 /
count(*) as default_rate,
rank() over(order by sum(case when is_default_loan = 'Yes' then 1 else 0 end) * 100.0 
/
count(*) desc) as state_rank
from banking_data
group by state_name
order by state_rank;


# 8. HIGH-VALUE LOAN ANALYSIS

# Highest funded loan in each bank
with bank_loans as 
(select
bank_name,
account_id,
client_id,
client_name,
funded_amount,
loan_amount,
interest_rate,
loan_status,
row_number() over(partition by bank_name order by funded_amount desc) as loan_rank
from banking_data)
select
bank_name,
account_id,
client_id,
client_name,
loan_amount,
funded_amount,
interest_rate,
loan_status
from bank_loans
where loan_rank = 1
order by funded_amount desc;


# 9. LOAN PERFORMANCE ANALYSIS

# Loan statuses with above-average funded amount
with status_summary as 
(select
loan_status,
count(*) as total_loans,
avg(funded_amount) as average_funded_amount
from banking_data
group by loan_status)
select
loan_status,
total_loans,
average_funded_amount
from status_summary
where average_funded_amount > (select avg(funded_amount) from banking_data)
order by average_funded_amount desc;


# 10. YEAR-WISE PERFORMANCE

# Rank disbursement years based on funded amount
with yearly_summary as 
(select
disbursement_year,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount
from banking_data
group by disbursement_year)
select
disbursement_year,
total_loans,
total_funded_amount,
rank() over(order by total_funded_amount desc) as year_rank
from yearly_summary
order by year_rank;


# 11. HIGH-RISK LOANS

# Loans that are both delinquent and defaulted
select
account_id,client_id,
client_name,loan_amount,
funded_amount,interest_rate,
grade,loan_status,
is_delinquent_loan,is_default_loan
from banking_data
where is_delinquent_loan = 'Yes'
and is_default_loan = 'Yes'
order by funded_amount desc;


# 12. CUSTOMER LOAN BEHAVIOUR

# Customers with multiple loans and total exposure
select
client_id,
client_name,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
avg(interest_rate) as average_interest_rate,
rank() over(order by sum(funded_amount) desc) as exposure_rank
from banking_data
group by client_id,client_name
having count(*) > 1
order by exposure_rank;