show tables;
select * from data;


//-- Total_Manufactured_quantaty
SELECT SUM(`manufactured qty`) AS Total_Manufactured_quantaty
FROM data;


//-- Total_Rejected_Quantity
SELECT SUM(`Rejected Qty`) AS Total_Rejected_Quantity
FROM data;


//-- Total_Processed_Quantity
SELECT SUM(`Processed Qty`) AS Total_Processed_Quantity
FROM data;


//-- Total_Wastage_Qty
SELECT SUM(`Produced Qty` - `Processed Qty` - `Rejected Qty`) AS Total_Wastage_Qty
FROM data;


//-- Total Employees 
SELECT COUNT(DISTINCT (`emp name`)) AS Total_EMP
FROM data;


//-- Overall Rejection Percentage
SELECT 
SUM(`Manufactured Qty`) AS Total_Manufactured,
SUM(`Rejected Qty`) AS Total_Rejected,
ROUND((SUM(`Rejected Qty`)
/ NULLIF(SUM(`Manufactured Qty`), 0)) * 100,2) AS Rejection_Percentage
FROM data;


//-- Employee Wise Rejected Qty
SELECT `Emp Name`,SUM(`Rejected Qty`) AS Emp_wise_Rejected_Qty
FROM data
GROUP BY `Emp Name`
ORDER BY Emp_wise_Rejected_Qty DESC;


//-- Machine wise Rejected Qty
SELECT `Machine Name`, SUM(`Rejected Qty`) AS Machine_wise_Rejected_Qty
FROM data
GROUP BY `Machine Name`
ORDER BY Machine_wise_Rejected_Qty DESC;


//-- Machine-Wise Production Comparison
SELECT `Machine Name`,
SUM(`Produced Qty`) AS Produced,
SUM(`Processed Qty`) AS Processed,
SUM(`Rejected Qty`) AS Rejected
FROM data
GROUP BY `Machine Name`
ORDER BY Produced DESC;


//-- Production Comparison trend (Daily)
SELECT `Doc Date`,
SUM(`Produced Qty`) AS Total_Produced,
SUM(`Processed Qty`) AS Total_Processed,
SUM(`Rejected Qty`) AS Total_Rejected
FROM data
GROUP BY `Doc Date`
ORDER BY `Doc Date` ASC;


//-- Manufacture Vs Rejected
SELECT
SUM(`Manufactured Qty`) AS Total_Manufactured,
SUM(`Rejected Qty`) AS Total_Rejected
FROM data;


//-- Employee-Wise Manufactured vs Rejected
SELECT `Emp Name`,
SUM(`Manufactured Qty`) AS Manufactured,
SUM(`Rejected Qty`) AS Rejected
FROM data
GROUP BY `Emp Name`
ORDER BY Manufactured DESC;


//-- Department-Wise Manufactured vs Rejected
SELECT `Department Name`,
SUM(`Manufactured Qty`) AS Total_Manufactured,
SUM(`Rejected Qty`) AS Total_Rejected
FROM data
GROUP BY `Department Name`
ORDER BY Total_Manufactured DESC;


//-- Machine Utilization Performance Score
SELECT `Machine Name`,
SUM(`Produced Qty`) AS Total_Produced,
SUM(`Rejected Qty`) AS Total_Rejected,

ROUND((SUM(`Produced Qty`) - SUM(`Rejected Qty`)) 
/ NULLIF(SUM(`Produced Qty`), 0) * 100,2) AS Machine_Performance_Score ,

ROUND(SUM(`Per day Machine Cost Made`),2) As Total_Machine_Cost_PerdayMade
FROM data
GROUP BY `Machine Name`
ORDER BY Machine_Performance_Score DESC;


//-- Comparison 
SELECT
CASE 
WHEN (SELECT AVG(`Rejected Qty`) FROM `data`) > (SELECT AVG(`Manufactured Qty`) FROM `data`) THEN 'More Rejected'
WHEN (SELECT AVG(`Rejected Qty`) FROM `data`) < (SELECT AVG(`Manufactured Qty`) FROM `data`) THEN 'Less Rejected'
ELSE 'Equal'
END AS `Comparison`;

















