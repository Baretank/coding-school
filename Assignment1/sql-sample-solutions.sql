-- SQL Assignment 1: Sample Solutions
-- These are examples of solutions for the exercises in Assignment 1.
-- You should attempt to solve the problems on your own before reviewing these.

-- Exercise 1: Basic JOINs - Employee Utilization
-- Calculate the utilization rate for each employee (billable hours divided by target hours) for April 2023.
SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    SUM(CASE WHEN t.BillableStatus = 'Billable' THEN t.Hours ELSE 0 END) AS BillableHours,
    e.BillableTarget AS TargetHours,
    ROUND(SUM(CASE WHEN t.BillableStatus = 'Billable' THEN t.Hours ELSE 0 END) / e.BillableTarget * 100, 2) AS UtilizationRate
FROM 
    Employees e
LEFT JOIN 
    TimeEntries t ON e.EmployeeID = t.EmployeeID AND MONTH(t.EntryDate) = 4 AND YEAR(t.EntryDate) = 2023
WHERE 
    e.IsActive = 1
GROUP BY 
    e.EmployeeID, e.FirstName, e.LastName, e.BillableTarget
ORDER BY 
    UtilizationRate DESC;

-- Exercise 2: Multi-table JOINs - Project Profitability
-- Calculate the profitability of each active project by comparing billed revenue against employee costs.
SELECT 
    p.ProjectID,
    p.ProjectName,
    c.ClientName,
    -- Calculate total revenue (billable hours * billing rate)
    ROUND(SUM(t.Hours * r.HourlyRate), 2) AS TotalRevenue,
    -- Calculate total cost (hours * employee cost rate)
    ROUND(SUM(t.Hours * e.CostRate), 2) AS TotalCost,
    -- Calculate profit
    ROUND(SUM(t.Hours * r.HourlyRate) - SUM(t.Hours * e.CostRate), 2) AS Profit,
    -- Calculate profit margin percentage
    CASE 
        WHEN SUM(t.Hours * r.HourlyRate) = 0 THEN 0
        ELSE ROUND(((SUM(t.Hours * r.HourlyRate) - SUM(t.Hours * e.CostRate)) / SUM(t.Hours * r.HourlyRate)) * 100, 2)
    END AS ProfitMarginPercentage
FROM 
    Projects p
JOIN 
    Clients c ON p.ClientID = c.ClientID
JOIN 
    TimeEntries t ON p.ProjectID = t.ProjectID
JOIN 
    Employees e ON t.EmployeeID = e.EmployeeID
JOIN 
    Rates r ON t.ProjectID = r.ProjectID AND t.EmployeeID = r.EmployeeID
WHERE 
    p.Status = 'Active'
    AND t.BillableStatus = 'Billable'
GROUP BY 
    p.ProjectID, p.ProjectName, c.ClientName
ORDER BY 
    ProfitMarginPercentage DESC;

-- Exercise 3: Subqueries - Top Performing Employees
-- Find the top 3 employees with the highest billable hours in their respective departments.
WITH EmployeeBillableHours AS (
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        e.Department,
        SUM(CASE WHEN t.BillableStatus = 'Billable' THEN t.Hours ELSE 0 END) AS BillableHours,
        ROW_NUMBER() OVER (PARTITION BY e.Department ORDER BY SUM(CASE WHEN t.BillableStatus = 'Billable' THEN t.Hours ELSE 0 END) DESC) AS DepartmentRank
    FROM 
        Employees e
    LEFT JOIN 
        TimeEntries t ON e.EmployeeID = t.EmployeeID
    WHERE 
        e.IsActive = 1
    GROUP BY 
        e.EmployeeID, e.FirstName, e.LastName, e.Department
)
SELECT 
    Department,
    EmployeeName,
    BillableHours,
    DepartmentRank
FROM 
    EmployeeBillableHours
WHERE 
    DepartmentRank <= 3
ORDER BY 
    Department, DepartmentRank;

-- Exercise 4: Window Functions - Running Invoice Totals
-- Calculate a running total of invoices paid by each client, ordered by invoice date.
SELECT 
    c.ClientName,
    i.InvoiceDate,
    i.Amount AS InvoiceAmount,
    SUM(i.PaymentAmount) OVER (PARTITION BY c.ClientID ORDER BY i.InvoiceDate) AS RunningTotal
FROM 
    Invoices i
JOIN 
    Clients c ON i.ClientID = c.ClientID
WHERE 
    i.Status IN ('Paid', 'Partial') 
    AND i.PaymentAmount > 0
ORDER BY 
    c.ClientName, i.InvoiceDate;

-- Exercise 5: Complex Aggregation - Realization Rate Analysis
-- Calculate the realization rate (invoiced amount / billable value) for each project
WITH ProjectBillableValue AS (
    SELECT 
        p.ProjectID,
        p.ProjectName,
        ROUND(SUM(t.Hours * r.HourlyRate), 2) AS BillableValue
    FROM 
        Projects p
    JOIN 
        TimeEntries t ON p.ProjectID = t.ProjectID
    JOIN 
        Rates r ON t.ProjectID = r.ProjectID AND t.EmployeeID = r.EmployeeID
    WHERE 
        t.BillableStatus = 'Billable'
    GROUP BY 
        p.ProjectID, p.ProjectName
),
ProjectInvoicedAmount AS (
    SELECT 
        ProjectID,
        SUM(Amount) AS InvoicedAmount
    FROM 
        Invoices
    GROUP BY 
        ProjectID
)
SELECT 
    pbv.ProjectID,
    pbv.ProjectName,
    pbv.BillableValue,
    COALESCE(pia.InvoicedAmount, 0) AS InvoicedAmount,
    CASE 
        WHEN pbv.BillableValue = 0 THEN 0
        ELSE ROUND((COALESCE(pia.InvoicedAmount, 0) / pbv.BillableValue) * 100, 2)
    END AS RealizationRate,
    CASE 
        WHEN COALESCE(pia.InvoicedAmount, 0) / pbv.BillableValue >= 0.95 THEN 'High'
        WHEN COALESCE(pia.InvoicedAmount, 0) / pbv.BillableValue >= 0.85 THEN 'Medium'
        ELSE 'Low'
    END AS Rating
FROM 
    ProjectBillableValue pbv
LEFT JOIN 
    ProjectInvoicedAmount pia ON pbv.ProjectID = pia.ProjectID
ORDER BY 
    RealizationRate DESC;

-- Extra Challenge: Comprehensive Dashboard Query
SELECT 
    -- Overall Utilization Rate
    ROUND((SUM(CASE WHEN t.BillableStatus = 'Billable' THEN t.Hours ELSE 0 END) / 
           SUM(e.BillableTarget)) * 100, 2) AS OverallUtilizationRate,
    
    -- Overall Realization Rate
    ROUND((SUM(i.Amount) / 
           SUM(CASE WHEN t.BillableStatus = 'Billable' THEN t.Hours * r.HourlyRate ELSE 0 END)) * 100, 2) AS OverallRealizationRate,
    
    -- Average Project Profitability
    ROUND(AVG((SUM(t.Hours * r.HourlyRate) - SUM(t.Hours * e.CostRate)) / 
             CASE WHEN SUM(t.Hours * r.HourlyRate) = 0 THEN 1 ELSE SUM(t.Hours * r.HourlyRate) END) * 100, 2) AS AvgProjectProfitability,
    
    -- Projected vs Actual Revenue
    SUM(p.Budget) AS ProjectedRevenue,
    SUM(i.Amount) AS ActualRevenue,
    ROUND((SUM(i.Amount) / SUM(p.Budget)) * 100, 2) AS RevenueAchievementRate
FROM 
    Projects p
JOIN 
    TimeEntries t ON p.ProjectID = t.ProjectID
JOIN 
    Employees e ON t.EmployeeID = e.EmployeeID
JOIN 
    Rates r ON t.ProjectID = r.ProjectID AND t.EmployeeID = r.EmployeeID
LEFT JOIN 
    Invoices i ON p.ProjectID = i.ProjectID
WHERE 
    p.Status IN ('Active', 'Completed')
GROUP BY 
    ();
