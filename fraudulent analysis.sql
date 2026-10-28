# USE UniTech DATABASE
USE UniTech;

# DATA ANALYSIS GROUP CAPSTONE PROJECT COHORT 8
# PROJECT TITLE: Fraud Transaction Analysis
# GROUP NAME: Sunshine Group (MYSQL)
# GROUP MEMBERS: 
# 1. Chidiebere Priest Iloakpuwa (Group Leader)
# 2. Adediran Michael. O
# 3. Adeosun Oluwapelumi Miracle
# 4. Anita Chiamaka Nwosu
# 5. Bukola Omowunmi
# 6. Asonja Funmilayo I.

# Display The Columns And Data Types in The Table.
DESCRIBE fraudulent;

# Display The First 10 Transaction Records.
SELECT *
FROM fraudulent
LIMIT 10;

# Check For Duplicate Records
SELECT
Transaction_ID,
User_ID,
Transaction_Amount,
Transaction_Type,
Transaction_Date,
Transaction_Time,
Device_Type,
Location,
Merchant_Category,
Card_Type,
Authentication_Method,
Is_Weekend,
COUNT(*) AS Duplicate_Count
FROM fraudulent
GROUP BY Transaction_ID,
User_ID,
Transaction_Amount,
Transaction_Type,
Transaction_Date,
Transaction_Time,
Device_Type,
Location,
Merchant_Category,
Card_Type,
Authentication_Method,
Is_Weekend
HAVING COUNT(*) > 1;

# Check For Missing Values
SELECT
SUM(Transaction_ID IS NULL) AS Missing_Transaction_ID,
SUM(User_ID IS NULL) AS Missing_User_ID,
SUM(Transaction_Amount IS NULL) AS Missing_Transaction_Amount,
SUM(Transaction_Type IS NULL) AS Missing_Transaction_Type,
SUM(Transaction_Date IS NULL) AS Missing_Missing_Transaction_Date,
SUM(Transaction_Time IS NULL) AS Missing_Transaction_Time,
SUM(Device_Type IS NULL) AS Missing_Device_Type,
SUM(Location IS NULL) AS Missing_Location,
SUM(Merchant_Category IS NULL) AS Missing_Merchant_Category,
SUM(Card_Type IS NULL) AS Missing_Card_Type,
SUM(Authentication_Method IS NULL) AS Missing_Authentication_Method,
SUM(Is_Weekend IS NULL) AS Missing_Is_Weekend
FROM fraudulent;

# ==================================
# BUSINESS CASE 1: Fraud Transaction 
# BUSINESS QUESTION: Analyse The Data To Uncover Authentication Method Used in Fraudulent Transactions

# Determine The Total Number of Transaction Records.
SELECT
COUNT(*) AS Total_Transactions
FROM fraudulent;

# Determine The Number of Transactions Recorded For Each Authentication Method.
SELECT
Authentication_Method,
COUNT(*) AS Total_Transactions,
ROUND(COUNT(*) * 100.0 /(SELECT COUNT(*) FROM fraudulent),2) AS Percentage
FROM fraudulent
GROUP BY Authentication_Method
ORDER BY Total_Transactions DESC;

# Identify Authentication Methods Used Across Different Transaction Types.
SELECT
Transaction_Type,
Authentication_Method,
COUNT(*) AS Total_Transactions,
ROUND(SUM(Transaction_Amount), 2) AS Total_Amount
FROM fraudulent
GROUP BY Transaction_Type, Authentication_Method
ORDER BY Transaction_Type, Total_Transactions DESC;

# Compare Transaction Volumes and Monetary Values Across Authentication Methods.
SELECT
Authentication_Method, 
COUNT(*) AS Total_Transactions,
ROUND(SUM(Transaction_Amount), 2) AS Total_Transaction_Amount,
ROUND(AVG(Transaction_Amount), 2) AS Average_Transaction_Amount,
ROUND(MAX(Transaction_Amount), 2) AS Highest_Transaction_Amount
FROM fraudulent
GROUP BY Authentication_Method
ORDER BY Total_Transaction_Amount DESC;

# Investigate Authentication Methods Across Devices.
SELECT
Device_Type,
Authentication_Method,
COUNT(*) AS Total_Transactions,
ROUND(SUM(Transaction_Amount), 2) AS Total_Transaction_Amount
FROM fraudulent
GROUP BY Device_Type, Authentication_Method
ORDER BY Device_Type, Total_Transactions DESC;

# Examine Authentication Methods Across Locations.
SELECT
Location, Authentication_Method,
COUNT(*) AS Total_Transactions,
ROUND(SUM(Transaction_Amount), 2) AS Total_Transaction_Amount
FROM fraudulent
GROUP BY Location, Authentication_Method
ORDER BY Location,
Total_Transactions DESC;

# Compare Authentication Methods Used on Weekdays and Weekends.
SELECT
CASE WHEN Is_Weekend = 1 THEN 'Weekend' WHEN Is_Weekend = 0 THEN 'Weekday'ELSE 'Unknown' END AS Day_Type, Authentication_Method,
COUNT(*) AS Total_Transactions,
ROUND(SUM(Transaction_Amount), 2) AS Total_Transaction_Amount
FROM fraudulent
GROUP BY Is_Weekend, Authentication_Method
ORDER BY Day_Type, Total_Transactions DESC;

# DATA LIMITATION:
# 📈 A Dedicated Fraud-Status Column was not assigned, although The File Records Authentication Methods, Transaction Amounts, Transaction Types, Devices, Locations, And Transaction Dates, It Does Not Identify Which Transactions Are Confirmed Fraudulent. Therefore, The Analysis Cannot Conclusively Determine Which Authentication Method Is Associated With The Highest Number Of Actual Fraud Cases.
# 📈 THe Dataset Does Not Provide Authentication Success Or Failure Information, Failed Login Attempts, Or Details Of Additional Security Verification. This Limits The Ability To Determine Whether A Particular Authentication Method Successfully Prevented Suspicious Transactions.
# 📈 The dataset records the authentication method used but does not provide details about authentication success or failure, failed login attempts, IP Address, or whether additional security verification was required.
# 📈 The dataset does not appear to include customer profiles, account history, or previous transaction behaviour. This limits the ability to identify unusual transactions or suspicious customer activities.
# 📈 The location analysis compares authentication methods across recorded locations but does not establish whether a transaction occurred in an unusual location for a particular customer.
# 📈 The queries compare transaction counts and monetary values across authentication methods but do not calculate fraud rates or authentication success rates. Consequently, a method with the highest transaction volume cannot automatically be considered the least secure.
# 📈 The analysis uses counts, sums, averages, and maximum values. It does not include statistical tests or predictive models to establish whether observed differences are significant or to predict fraudulent transactions.

# KEY FINDINGS:
# 🔑 The analysis identifies the most frequently used authentication methods and their percentage of total recorded transactions. This helps establish which methods account for the largest share of transaction activity.
# 🔑 Comparing authentication methods across transaction types reveals which methods are commonly used for different categories of transactions.
# 🔑 Comparing total transaction amounts, average transaction amounts, and highest transaction amounts across authentication methods helps identify methods associated with larger financial transactions.
# 🔑 The analysis shows how authentication methods are distributed across recorded device types. This may help identify device and authentication combinations that warrant further investigation.
# 🔑 Comparing authentication methods across locations helps identify geographical differences in transaction activity and areas that may require additional monitoring.
# 🔑 The analysis compares authentication methods used on weekdays and weekends, helping reveal differences in transaction volumes and monetary values between the two periods.
# 🔑 Combining authentication methods with transaction types, devices, locations, and day types can help identify transaction patterns that deserve further investigation. However, these patterns alone do not establish that fraud has occurred.

# 💡 RECOMMENDATIONS:
# Incorporate a verified fraud indicator, such as Is_Fraud, to distinguish confirmed fraudulent transactions from legitimate transactions. This will allow the analysis to identify authentication methods associated with actual fraud cases.
# Review the security controls associated with each authentication method. Consider multi-factor authentication and additional verification for high-risk transactions where appropriate.
# Review unusually large transactions and authentication methods associated with high transaction values. Establish appropriate transaction thresholds based on historical behaviour and business risk.
# Investigate unusual combinations of devices, locations, and authentication methods, particularly when they differ from a customer's established transaction history.
# Check for missing values, duplicate transaction IDs, inconsistent authentication method labels, invalid transaction amounts, and incorrect date or time entries before conducting further analysis.
# Examine transaction activity by hour, day, week, and month to identify unusual patterns and potential periods of increased fraud risk.
# Once confirmed fraud labels are available, calculate the percentage of fraudulent transactions associated with each authentication method. This will provide more meaningful security insights than transaction volume alone.
# Combine authentication information with customer history, transaction frequency, failed authentication attempts, and confirmed fraud outcomes to improve fraud detection and risk assessment.
# Regularly review transaction patterns and update fraud detection rules as new data becomes available
# We recommended adding a verified fraud indicator, investigating unusual transactions, improving data quality, and strengthening security controls for high-risk transactions.

# CONCLUSION: DATA STORYTELLING:
# The investigation began with an important business question: which authentication methods are used in potentially fraudulent transactions, and how can this information help the business improve transaction security?
# The analysis of 50,000 transaction records revealed that Biometric authentication recorded the highest transaction count, while PIN authentication recorded the highest combined transaction value. It also showed that transaction activity varied across transaction types, devices, locations, weekdays, weekends, and months.
# These findings provide a useful picture of how authentication methods are used across the recorded transactions. They also identify areas where additional monitoring and investigation may be beneficial.
# However, the analysis revealed a critical limitation: the dataset does not identify confirmed fraudulent transactions. Therefore, the results cannot establish which authentication method is most vulnerable to fraud or which method provides the strongest protection.
# The business should address this limitation by introducing verified fraud-status data, reviewing unusual transactions, strengthening appropriate security controls, and improving the quality of its transaction records.
# Ultimately, the goal is to move beyond counting transactions and identifying patterns toward measuring confirmed fraud, understanding its causes, and preventing financial losses. By combining reliable data with continuous monitoring and evidence-based security decisions, the business can improve its fraud-risk management and protect its customers more effectively.

