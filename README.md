# Bank-Loan-and-debit-credit-analysis
This repository contains two end-to-end Banking Data Analytics projects focused on analyzing loan performance and customer debit/credit transactions using data analytics and visualization techniques.


# Questions(KPIs)
## Loan Dashboard KPI Description 
**1. Total Loan Amount Funded:** Measures the total value of loans disbursed.\

**2. Total Loans:**  Tracks the number of loans issued.\

**3. Total Collection:**  Reflects repayment performance, including principal and interest.\

**4. Total Interest:**   Captures revenue from loan interest.\

**5. Branch-Wise Performance:**  Analyzes revenue (interest, fees, total) by branch.\

**6. State-Wise Loan:**  Shows geographic distribution of loans.\

**7. Religion-Wise Loan:**  Monitors loan distribution across religious demographics.\

**8. Product Group-Wise Loan:**  Categorizes loans by product types (e.g., personal, auto)\

**9. Disbursement Trend:**  Tracks changes in loan disbursements over time.\

**10. Grade-Wise Loan:**  Assesses portfolio risk by borrower credit grades.\

**11. Default Loan Count:**  Counts loans in default.\

**12. Delinquent Client Count:**  Tracks borrowers with missed payments.\

**13. Delinquent Loan Rate:**  Percentage of loans overdue in the portfolio.\

**14. Default Loan Rate:**  Proportion of defaulted loans to the total portfolio.\

**15. Loan Status-Wise Loan:**  Breaks down loans by status (active, delinquent, closed).\

**16. Age Group-Wise Loan:**  Categorizes loans by borrowers’ age groups.\

**17. Loan Maturity:**  Tracks the timeline until full repayment. \

**18. No Verified Loans:**  Identifies loans without proper verification.\

## Bank Debit and Credit Dashboard KPI Description 
**1.Total Credit Amount:**  Sum of the Amount column where Transaction Type = "Credit".

**2.Total Debit Amount:** Sum of the Amount column where Transaction Type = "Debit".

**3.Credit to Debit Ratio:**  Total Credit Amount ÷ Total Debit Amount.

**4.Net Transaction Amount:** Total Credit Amount - Total Debit Amount.
 
**5.Account Activity Ratio:** Number of transactions ÷ Account balance.

**6.Transactions per Day/Week/Month:** Number of transactions occurring per day, week, or month.

**7.Total Transaction Amount by Branch:** Sum of the Amount column grouped by Branch.
 
**8.Transaction Volume by Bank:** Sum of the Amount column grouped by Bank Name.

**9.Transaction Method Distribution:** Count or percentage of transactions grouped by Transaction Method (Bank Transfer, Debit Card, Credit Card, etc.)

**10.Branch Transaction Growth:** Percentage change in the total transaction amount or volume at each branch over a defined period. 

**11.High-Risk Transaction Flag:** Flag transactions that exceed a predefined amount or show irregular activity (e.g., large withdrawals or deposits).

**12.Suspicious Transaction Frequency:** Count of flagged high-risk transactions over a period.



# ✅ Tools Used:
- Excel – for initial data exploration and dashboards
- Power BI – for interactive KPI dashboards
- Tableau – for advanced data storytelling
- MySQL – for writing custom queries and KPI calculations

# 🔁 Project Workflow:
**1. 📥 Data Collection & Understanding:**
- Collected raw bank data including:Loan application data , Credit and debit transaction records
- Cleaned and pre-processed data for consistency.

**2. 📊 Excel Dashboard:**
- Created initial dashboards in Excel
- Performed basic analysis: totals, trends, pivot tables
- Shared Excel version with stakeholders for early feedback.

 ## Dashboards ( Excel )

### 1. Bank Loan Analytics Dashboard
![Bank Loan Analytics Dashboard](images/bank_loan_dashboard.png)

### 2. Bank Debit & Credit Dashboard
![Bank Debit and Credit Dashboard](images/debit_credit_dashboard.png)

**3. 📈 Power BI Dashboard:**
- Imported cleaned data into Power BI
- Created visual dashboards for: Monthly loan applications, Credit vs debit transaction trends , Branch-wise performance
- Added slicers for dynamic filtering by branch, date, and transaction type

**4. 📉 Tableau Dashboard:** 
- Developed a more advanced dashboard using Tableau
- Focused on better visual storytelling and interactivity
- Enhanced the UI with filters and calculated fields.

**5. 🧮 SQL Queries for KPIs (MySQL):** 
- Connected data to MySQL database
- Wrote custom queries to calculate KPIs such as: Loan approval rate, Credit-to-debit ratio, Branch-wise growth in transactions , Monthly and quarterly summaries.

#  Insights & Key Takeaways
### 🔍 Insights from Loan Data:
**1. Loan Applications Trend:**\
There is a steady rise in loan applications in the first half of the year, with a slight drop during Q3.

**2. Approval Rate:**\
Certain branches consistently have a higher approval rate, indicating stronger customer profiling or fewer defaults.

**3. Top Performing Branches:**\
A few urban branches contribute to a significant portion of loan disbursements, highlighting regional financial behavior.

### 💳 Insights from Credit & Debit Transactions:
**1. Credit to Debit Ratio:**  Most branches maintain a balanced ratio, but some show higher debit activity, indicating spending-heavy regions.

**2. Branch-wise Activity:**  Metro city branches show higher transaction volumes compared to rural branches.

**3. Peak Transaction Periods:** End-of-month spikes in debit transactions align with salary disbursal cycles.

### ✅ Key Takeaways
- Early dashboards in Excel helped identify critical KPIs and served as a prototype.
- Power BI added interactivity, slicing, and drill-down capabilities for stakeholder-specific views.
- Tableau enhanced visual storytelling, especially for high-level managerial presentations.
- Writing SQL queries for KPIs gave better control and performance over calculated metrics.


# Next Steps
- **Integrate Real-time Data:**  Use APIs or scheduled database imports to keep dashboards updated.
- **Advanced Analytics:** Apply machine learning to predict loan defaults or customer churn.
- **Deploy Dashboards Online:** Publish dashboards using Power BI Service or Tableau Public for broader access.
- **Add Role-based Access:** Ensure secure viewing based on user roles (Manager, Analyst, etc.).
- **Document Data Dictionary:** Maintain metadata for all columns used in KPIs for transparency and reusability.

# Final Conclusion
This Bank Analytics Project demonstrates the full cycle of data analysis — from raw data to insightful dashboards — across multiple tools. It enabled data-driven decision-making by offering actionable KPIs on loans, credit, and debit transactions. With future improvements like real-time analytics and predictive models, this project can scale to enterprise-grade financial intelligence solutions




