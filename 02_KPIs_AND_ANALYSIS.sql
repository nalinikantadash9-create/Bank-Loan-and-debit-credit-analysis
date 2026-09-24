-- BANK DATA ANALYTICS PROJECT
-- FILE 02 : KPIs AND BUSINESS ANALYSIS
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use BankingDB;

# 1. KEY BANKING KPIs

# Total Loan Amount Funded
select sum(funded_amount) as total_loan_amount_funded
from banking_data;

# Total Loans
select count(*) as total_loans
from banking_data;

# Total Collection
select sum(total_payment) as total_collection
from banking_data;

# Total Interest
select sum(total_received_interest) as total_interest
from banking_data;

# 2. BRANCH-WISE PERFORMANCE

# Branch-wise performance
select
branch_name,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
sum(total_received_interest) as total_interest,
sum(total_fees) as total_fees,
sum(total_payment) as total_collection
from banking_data
group by branch_name
order by total_collection desc;


# 3. STATE-WISE LOAN

# State-wise loan distribution
select
state_name,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
avg(loan_amount) as average_loan_amount
from banking_data
group by state_name
order by total_funded_amount desc;


# 4. RELIGION-WISE LOAN

# Religion-wise loan distribution
select
religion,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount
from banking_data
group by religion
order by total_funded_amount desc;


# 5. PRODUCT GROUP-WISE LOAN

# Product-wise loan distribution
select
product_code,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
avg(loan_amount) as average_loan_amount
from banking_data
group by product_code
order by total_funded_amount desc;


# 6. DISBURSEMENT TREND

# Loan disbursement trend by year
select
disbursement_year,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
sum(loan_amount) as total_loan_amount
from banking_data
group by disbursement_year
order by disbursement_year;


# 7. GRADE-WISE LOAN

# Grade-wise loan analysis

select
grade,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
avg(interest_rate) as average_interest_rate
from banking_data
group by grade
order by total_funded_amount desc;


# 8. DEFAULT ANALYSIS

# Default Loan Count
select
count(*) as default_loan_count
from banking_data
where is_default_loan = 'Yes';


# Default Loan Rate
select
count(case when is_default_loan = 'Yes' then 1 end) * 100.0 /
count(*) as default_loan_rate
from banking_data;


# 9. DELINQUENCY ANALYSIS

# Delinquent Client Count
select
count(distinct client_id) as delinquent_client_count
from banking_data
where is_delinquent_loan = 'Yes';


# Delinquent Loan Rate
select
count(case when is_delinquent_loan = 'Yes' then 1 end) * 100.0 /
count(*) as delinquent_loan_rate
from banking_data;


# 10. LOAN STATUS-WISE LOAN

# Loan status distribution
select
loan_status,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
sum(total_payment) as total_collection
from banking_data
group by loan_status
order by total_loans desc;


# 11. AGE GROUP-WISE LOAN

# Age group-wise loan distribution
select
age_group,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
avg(loan_amount) as average_loan_amount
from banking_data
group by age_group
order by total_funded_amount desc;


# 12. LOAN MATURITY

# Loan maturity by term
select
trim(loan_term) as loan_term,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
avg(interest_rate) as average_interest_rate
from banking_data
group by trim(loan_term)
order by total_loans desc;


# 13. NO VERIFIED LOANS

# Loans without verification
select
count(*) as no_verified_loans
from banking_data
where verification_status is null
or trim(verification_status) = '';


# 14. HIGH-VALUE LOANS

# Top 10 highest funded loans
select
account_id,
client_id,
client_name,
bank_name,
branch_name,
state_name,
loan_amount,
funded_amount,
interest_rate,
loan_status
from banking_data
order by funded_amount desc
limit 10;


# 15. PURPOSE-WISE LOAN ANALYSIS

# Loan distribution by purpose
select
purpose_category,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
avg(loan_amount) as average_loan_amount
from banking_data
group by purpose_category
order by total_funded_amount desc;


# 16. BANK-WISE PORTFOLIO

# Bank-wise loan portfolio
select
bank_name,
count(*) as total_loans,
sum(funded_amount) as total_funded_amount,
sum(total_payment) as total_collection,
sum(total_received_interest) as total_interest
from banking_data
group by bank_name
order by total_funded_amount desc;


# 17. RECOVERY ANALYSIS

# Recovery summary
select
sum(recoveries) as total_recoveries,
sum(collection_recovery_fee) as total_recovery_fees,
sum(total_received_principal) as total_received_principal,
sum(total_received_interest) as total_received_interest
from banking_data;


# 18. DELINQUENCY BY GRADE

# Delinquent loans by grade
select
grade,
count(*) as total_loans,
sum(case when is_delinquent_loan = 'Yes' then 1 else 0 end) as delinquent_loans,
sum(case when is_delinquent_loan = 'Yes' then 1 else 0 end) * 100.0 /
count(*) as delinquent_loan_rate
from banking_data
group by grade
order by delinquent_loan_rate desc;


# 19. DEFAULT BY PURPOSE

# Default loans by purpose
select
purpose_category,
count(*) as total_loans,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) as default_loans,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) * 100.0 /
count(*) as default_loan_rate
from banking_data
group by purpose_category
order by default_loan_rate desc;


# 20. STATE-WISE DEFAULT ANALYSIS

# Default rate by state
select
state_name,
count(*) as total_loans,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) as default_loans,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) * 100.0 /
count(*) as default_loan_rate
from banking_data
group by state_name
order by default_loan_rate desc;


# 21. OVERALL BUSINESS SUMMARY

# Overall banking portfolio summary
select
count(*) as total_loans,
sum(funded_amount) as total_loan_amount_funded,
sum(total_payment) as total_collection,
sum(total_received_interest) as total_interest,
sum(case when is_default_loan = 'Yes' then 1 else 0 end) as default_loan_count,
sum(case when is_delinquent_loan = 'Yes' then 1 else 0 end) as delinquent_loan_count,
avg(loan_amount) as average_loan_amount,
avg(interest_rate) as average_interest_rate
from banking_data;