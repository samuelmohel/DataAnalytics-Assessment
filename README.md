# DataAnalytics-Assessment
# Cowrywise Data Analyst Assessment

Welcome to my SQL submission for the Cowrywise Data Analyst role. This repository contains my solutions to four SQL-based business case questions using a sample schema.

---

## Assessment Structure

Each question is answered in its own SQL file:

- `Assessment_Q1.sql` – High-Value Customers with Multiple Products
- `Assessment_Q2.sql` – Transaction Frequency Analysis
- `Assessment_Q3.sql` – Account Inactivity Alert
- `Assessment_Q4.sql` – Customer Lifetime Value Estimation

---

##Question-by-Question Approach

### **Q1: High-Value Customers with Multiple Products**
- **Objective**: Identify customers with at least one funded savings plan and one investment plan.
- **Strategy**: Joined users, plans, and transactions. Filtered by plan type and grouped by owner. Used `HAVING` to filter only cross-product users.

---

### **Q2: Transaction Frequency Analysis**
- **Objective**: Categorize customers into High, Medium, and Low frequency based on monthly transaction rate.
- **Strategy**: Calculated total transactions and the number of active months. Divided to get average monthly frequency, then bucketed using `CASE`.

---

### **Q3: Account Inactivity Alert**
- **Objective**: Flag active accounts with no deposits for over 365 days.
- **Strategy**: Used `MAX(created_on)` to get last transaction date per plan. Computed inactivity days using `DATEDIFF`. Filtered for plans with inactivity over 365 days.

---

### **Q4: Customer Lifetime Value (CLV) Estimation**
- **Objective**: Estimate CLV based on tenure and transaction value.
- **Formula Used**: CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction

- - **Strategy**: Used `TIMESTAMPDIFF` to calculate tenure, derived average profit from 0.1% of transaction value.

---

## Challenges Faced

- Ensuring **accurate conversions** from kobo to naira (÷ 100).
- Handling **NULLs or zero divisions** (e.g., tenure = 0).
- Interpreting business rules like what counts as a "funded" plan or "active" account.

---

##  Tools Used

- SQL (MySQL-flavored syntax)
- Subqueries, `CASE`, `JOIN`, CTEs (`WITH`), aggregation functions

---

## Submission

All SQL queries are included in the respective `.sql` files in this repository as per the instructions.

---

Thank you for the opportunity!


