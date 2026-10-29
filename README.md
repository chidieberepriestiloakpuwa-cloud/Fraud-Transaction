# Fraud-Transaction
Business Case: Analyse The Data To Uncover Authentication Method Used in Fraudulent Transactions

#SUMMARY: This project uses MySQL to analyze 50,000 transaction records and investigate how different authentication methods are used across transaction types, devices, locations, and days of the week. The goal is to identify transaction patterns that may require further investigation and help improve fraud monitoring and transaction security.

OBJECTIVES: The objective of this project is to identify the most frequently used authentication methods, compare their transaction volumes and monetary values, and examine their usage across devices, locations, and weekdays and weekends. The analysis aims to provide insights that support better transaction monitoring and security decisions, while recognizing that confirmed fraudulent transactions cannot be identified without a fraud-status field.

KEY FINDINGS:
1. The analysis identifies the most frequently used authentication methods and their percentage of total recorded transactions. This helps establish which methods account for the largest share of transaction activity.

2. Comparing authentication methods across transaction types reveals which methods are commonly used for different categories of transactions.

3. Comparing total transaction amounts, average transaction amounts, and highest transaction amounts across authentication methods helps identify methods associated with larger financial transactions.

4. The analysis shows how authentication methods are distributed across recorded device types. This may help identify device and authentication combinations that warrant further investigation.

5. Comparing authentication methods across locations helps identify geographical differences in transaction activity and areas that may require additional monitoring.

5. The analysis compares authentication methods used on weekdays and weekends, helping reveal differences in transaction volumes and monetary values between the two periods.

6. Combining authentication methods with transaction types, devices, locations, and day types can help identify transaction patterns that deserve further investigation. However, these patterns alone do not establish that fraud has occurred.


RECOMMENDATIONS: 
1. Incorporate a verified fraud indicator, such as Is_Fraud, to distinguish confirmed fraudulent transactions from legitimate transactions. This will allow the analysis to identify authentication methods associated with actual fraud cases.

2. Review the security controls associated with each authentication method. Consider multi-factor authentication and additional verification for high-risk transactions where appropriate.

3. Review unusually large transactions and authentication methods associated with high transaction values. Establish appropriate transaction thresholds based on historical behaviour and business risk.

4. Investigate unusual combinations of devices, locations, and authentication methods, particularly when they differ from a customer's established transaction history.

5. Check for missing values, duplicate transaction IDs, inconsistent authentication method labels, invalid transaction amounts, and incorrect date or time entries before conducting further analysis.

6. Examine transaction activity by hour, day, week, and month to identify unusual patterns and potential periods of increased fraud risk.

7. Once confirmed fraud labels are available, calculate the percentage of fraudulent transactions associated with each authentication method. This will provide more meaningful security insights than transaction volume alone.

8. Combine authentication information with customer history, transaction frequency, failed authentication attempts, and confirmed fraud outcomes to improve fraud detection and risk assessment.

9. Regularly review transaction patterns and update fraud detection rules as new data becomes available

10. We recommended adding a verified fraud indicator, investigating unusual transactions, improving data quality, and strengthening security controls for high-risk transactions.

APPROACH: The project began by exploring the transaction dataset in MySQL, examining its structure, sample records, missing values, and duplicate records. SQL queries were then used to analyze authentication methods by transaction count, transaction amount, transaction type, device, location, and day of the week. Finally, the results were interpreted to identify transaction patterns, highlight data limitations, and recommend strategies for improving transaction monitoring and security.

LIMITATIONS:
1. A Dedicated Fraud-Status Column was not assigned, although The File Records Authentication Methods, Transaction Amounts, Transaction Types, Devices, Locations, And Transaction Dates, It Does Not Identify Which Transactions Are Confirmed Fraudulent. Therefore, The Analysis Cannot Conclusively Determine Which Authentication Method Is Associated With The Highest Number Of Actual Fraud Cases.

2. The Dataset Does Not Provide Authentication Success Or Failure Information, Failed Login Attempts, Or Details Of Additional Security Verification. This Limits The Ability To Determine Whether A Particular Authentication Method Successfully Prevented Suspicious Transactions.

3. The dataset records the authentication method used but does not provide details about authentication success or failure, failed login attempts, IP Address, or whether additional security verification was required.

4. The dataset does not appear to include customer profiles, account history, or previous transaction behaviour. This limits the ability to identify unusual transactions or suspicious customer activities.

5. The location analysis compares authentication methods across recorded locations but does not establish whether a transaction occurred in an unusual location for a particular customer.

The queries compare transaction counts and monetary values across authentication methods but do not calculate fraud rates or authentication success rates. Consequently, a method with the highest transaction volume cannot automatically be considered the least secure.

The analysis uses counts, sums, averages, and maximum values. It does not include statistical tests or predictive models to establish whether observed differences are significant or to predict fraudulent transactions.

