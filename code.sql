CREATE DATABASE Bank_Analytics;
USE Bank_Analytics;


CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    occupation VARCHAR(50),
    education_level VARCHAR(50),
    marital_status VARCHAR(20),
    income DECIMAL(12,2),
    credit_score INT,
    loan_status VARCHAR(20)
);

select * from credit_card_transactions;

CREATE TABLE credit_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trans_date_trans_time DATETIME,
    cc_num BIGINT,
    merchant VARCHAR(100),
    category VARCHAR(50),
    amt DECIMAL(12,2),
    first VARCHAR(50),
    last VARCHAR(50),
    gender VARCHAR(10),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(20),
    zip VARCHAR(10),
    lat DECIMAL(10,6),
    longs DECIMAL(10,6),
    city_pop INT,
    job VARCHAR(50),
    dob DATE,
    trans_num BIGINT,
    unix_time BIGINT,
    merch_lat DECIMAL(10,6),
    merch_long DECIMAL(10,6),
    is_fraud TINYINT,
    merch_zipcode VARCHAR(10)
);


-- How many loan applications are present in the dataset?
SELECT COUNT(*) AS total_loans FROM loans;

-- How many loans were approved vs rejected?
SELECT loan_status, COUNT(*) AS count FROM loans GROUP BY loan_status;

-- What is the average applicant income?
SELECT AVG(income) AS avg_income FROM loans;

-- Average credit score
SELECT AVG(credit_score) AS avg_credit_score FROM loans;

-- Loans by gender
SELECT gender, COUNT(*) AS count FROM loans GROUP BY gender;


-- Loans by occupation
SELECT occupation, COUNT(*) AS count FROM loans GROUP BY occupation;

-- Loans by education level
SELECT education_level, COUNT(*) AS count FROM loans GROUP BY education_level;

-- Loan approval rate by gender
SELECT gender, loan_status, COUNT(*) AS count FROM loans GROUP BY gender, loan_status;

-- Loan approval rate by occupation
SELECT occupation, loan_status, COUNT(*) AS count FROM loans GROUP BY occupation, loan_status;

-- Loan approval rate by education level
SELECT education_level, loan_status, COUNT(*) AS count FROM loans GROUP BY education_level, loan_status;

-- Loan approval rate by marital status
SELECT marital_status, loan_status, COUNT(*) AS count FROM loans GROUP BY marital_status, loan_status;

-- Highest income applicants who got loan approved
SELECT age, gender, income, loan_status 
FROM loans 
WHERE loan_status='Approved' 
ORDER BY income DESC LIMIT 5;


-- Who are the top 5 applicants with the highest income whose loans were approved?
SELECT age, gender, occupation, education_level, income, loan_status 
FROM loans 
WHERE loan_status='Approved' 
ORDER BY income DESC 
LIMIT 5;

-- Total transactions
SELECT COUNT(*) AS total_transactions 
FROM credit_card_transactions;

-- Fraudulent vs non-fraudulent transactions
SELECT is_fraud, COUNT(*) AS count 
FROM credit_card_transactions 
GROUP BY is_fraud;

-- Total transaction amount for fraud vs non-fraud
SELECT is_fraud, SUM(amt) AS total_amount 
FROM credit_card_transactions 
GROUP BY is_fraud;


-- Top 5 merchants with most transactions (general)
SELECT merchant, COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY merchant
ORDER BY total_transactions DESC
LIMIT 5;


-- Average transaction amount for fraud vs non-fraud
SELECT is_fraud, AVG(amt) AS avg_amount 
FROM credit_card_transactions 
GROUP BY is_fraud;

-- Transaction type distribution (if category indicates type)
SELECT category, COUNT(*) AS count 
FROM credit_card_transactions 
GROUP BY category;


-- Customers with highest number of transactions (all transactions)
SELECT cc_num, COUNT(*) AS transaction_count
FROM credit_card_transactions
GROUP BY cc_num
ORDER BY transaction_count DESC
LIMIT 5;

-- Monthly transaction trend (all transactions)
SELECT MONTH(trans_date_trans_time) AS month, COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY month
ORDER BY month;

-- What is the average transaction amount for each month?
SELECT MONTH(trans_date_trans_time) AS month, AVG(amt) AS avg_amount
FROM credit_card_transactions
GROUP BY month;


-- Total transaction amount per customer
SELECT cc_num, SUM(amt) AS total_amount 
FROM credit_card_transactions 
GROUP BY cc_num;


-- Top 10 merchants by transaction volume
SELECT merchant, COUNT(*) AS total_transactions 
FROM credit_card_transactions 
GROUP BY merchant 
ORDER BY total_transactions DESC 
LIMIT 10;


-- Who are the top 10 merchants with the highest total transaction amount?”
SELECT merchant, SUM(amt) AS total_amount
FROM credit_card_transactions
GROUP BY merchant
ORDER BY total_amount DESC
LIMIT 10;


-- Top 5 customers by total transaction amount
SELECT cc_num, SUM(amt) AS total_amount, COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY cc_num
ORDER BY total_amount DESC
LIMIT 5;

