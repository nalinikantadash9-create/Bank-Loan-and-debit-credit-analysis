-- BANK DATA ANALYTICS PROJECT
-- FILE 01 : DATA SETUP AND CLEANING
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use BankingDB;

# Create table with proper column names

create table banking_data 
(state_abbr varchar(10),
account_id varchar(50),
age_group varchar(20),
bh_name varchar(100),
bank_name varchar(100),
branch_name varchar(100),
caste varchar(50),
center_id varchar(50),
city varchar(100),
client_id varchar(50),
client_name varchar(100),
close_client varchar(20),
closed_date varchar(30),
credit_officer_name varchar(100),
date_of_birth varchar(30),
disbursed_by varchar(100),
disbursement_date varchar(30),
disbursement_year varchar(20),
gender_id varchar(20),
home_ownership varchar(50),
loan_status varchar(50),
loan_transfer_date varchar(30),
next_meeting_date varchar(30),
product_code varchar(30),
grade varchar(20),
sub_grade varchar(20),
product_id varchar(30),
purpose_category varchar(100),
region_name varchar(100),
religion varchar(50),
verification_status varchar(50),
state_abbr_2 varchar(10),
state_name varchar(100),
transfer_logic varchar(30),
is_delinquent_loan varchar(20),
is_default_loan varchar(20),
age int,
delinquency_2_yrs int,
application_type varchar(30),
loan_amount decimal(15,2),
funded_amount decimal(15,2),
funded_amount_inv decimal(15,2),
loan_term varchar(30),
interest_rate decimal(10,4),
total_payment decimal(15,2),
total_payment_inv decimal(15,2),
total_received_principal decimal(15,2),
total_fees decimal(15,2),
total_received_interest decimal(15,2),
total_received_late_fee decimal(15,2),
recoveries decimal(15,2),
collection_recovery_fee decimal(15,2));

# Import the Excel data using Table Data Import Wizard


# Check data
select *
from banking_data
limit 10;

# Check total records
select count(*) as total_records
from banking_data;

# Check duplicate account ids
select
account_id,
count(*) as record_count
from banking_data
group by account_id
having count(*) > 1;

# Check null values
select
sum(account_id is null) as account_id_null,
sum(client_id is null) as client_id_null,
sum(client_name is null) as client_name_null,
sum(bank_name is null) as bank_name_null,
sum(branch_name is null) as branch_name_null,
sum(loan_status is null) as loan_status_null,
sum(loan_amount is null) as loan_amount_null,
sum(funded_amount is null) as funded_amount_null,
sum(interest_rate is null) as interest_rate_null
from banking_data;

# Check loan status
select
loan_status,
count(*) as loan_count
from banking_data
group by loan_status
order by loan_count desc;

# Check loan terms
select
trim(loan_term) as loan_term,
count(*) as loan_count
from banking_data
group by trim(loan_term);

# Check default loans
select
is_default_loan,
count(*) as loan_count
from banking_data
group by is_default_loan;

# Check delinquent loans
select
is_delinquent_loan,
count(*) as loan_count
from banking_data
group by is_delinquent_loan;

# Check loan amount
select
min(loan_amount) as minimum_loan_amount,
max(loan_amount) as maximum_loan_amount,
avg(loan_amount) as average_loan_amount
from banking_data;

# Check interest rate
select
min(interest_rate) as minimum_interest_rate,
max(interest_rate) as maximum_interest_rate,
avg(interest_rate) as average_interest_rate
from banking_data;

# Clean extra spaces
update banking_data
set
loan_term = trim(loan_term),
age_group = trim(age_group),
state_abbr = trim(state_abbr),
state_name = trim(state_name),
bank_name = trim(bank_name),
branch_name = trim(branch_name),
purpose_category = trim(purpose_category);

# Check distinct banks
select distinct bank_name
from banking_data
order by bank_name;

# Check distinct states
select distinct state_name
from banking_data
order by state_name;

# Check distinct loan purposes
select distinct purpose_category
from banking_data
order by purpose_category;

# Final data check
select *
from banking_data
limit 10;

# Final record count
select count(*) as total_records
from banking_data;