# Professional Services Database Setup Guide

This guide will help you set up the professional services database in your local environment using SQL Server and execute queries against the data.

## Prerequisites
- SQL Server installed on your computer or accessible remotely
- SQL Server Management Studio (SSMS) or Azure Data Studio for easier interaction
- Cursor or VSCode with SQL extensions for editing SQL files

## Setup Instructions

### 1. Create a New Database
First, create a new database in SQL Server:

```sql
CREATE DATABASE ProfessionalServices;
GO
USE ProfessionalServices;
GO
```

### 2. Run the Schema Creation Script
Execute the `professional-services-schema.sql` script to create all the tables and relationships.

### 3. Run the Mock Data Script
Execute the `professional-services-mock-data.sql` script to populate the tables with sample data.

### 4. Verify Setup
Run the following query to verify that all tables have been created and populated:

```sql
SELECT 'Clients' AS TableName, COUNT(*) AS RowCount FROM Clients
UNION ALL
SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL
SELECT 'Projects', COUNT(*) FROM Projects
UNION ALL
SELECT 'ProjectAssignments', COUNT(*) FROM ProjectAssignments
UNION ALL
SELECT 'Rates', COUNT(*) FROM Rates
UNION ALL
SELECT 'TimeEntries', COUNT(*) FROM TimeEntries
UNION ALL
SELECT 'Invoices', COUNT(*) FROM Invoices;
```

## Database Schema Overview

### Clients
Contains information about the clients that hire the professional services firm.

### Employees
Contains information about the employees who work on client projects.

### Projects
Contains information about the projects undertaken for clients.

### ProjectAssignments
Maps which employees are assigned to which projects and in what roles.

### Rates
Contains the billable rates for employees on different projects.

### TimeEntries
Records the time spent by employees on projects.

### Invoices
Records invoices sent to clients for billing.

## Key Relationships

- Each Client can have multiple Projects
- Each Project belongs to one Client
- Each Project can have multiple Employees assigned to it
- Each Employee can be assigned to multiple Projects
- TimeEntries connect Employees to Projects with hours worked
- Rates determine the billing rate for Employees on Projects
- Invoices are created for Clients based on Projects

## Example Query

This query calculates total billable hours and revenue by project:

```sql
SELECT 
    p.ProjectID,
    p.ProjectName,
    c.ClientName,
    SUM(t.Hours) AS TotalHours,
    ROUND(SUM(t.Hours * r.HourlyRate), 2) AS TotalRevenue,
    p.Budget,
    ROUND((SUM(t.Hours * r.HourlyRate) / p.Budget) * 100, 2) AS PercentOfBudget
FROM 
    Projects p
JOIN 
    Clients c ON p.ClientID = c.ClientID
JOIN 
    TimeEntries t ON p.ProjectID = t.ProjectID
JOIN 
    ProjectAssignments pa ON t.ProjectID = pa.ProjectID AND t.EmployeeID = pa.EmployeeID
JOIN 
    Rates r ON pa.ProjectID = r.ProjectID AND pa.EmployeeID = r.EmployeeID
WHERE 
    t.BillableStatus = 'Billable'
GROUP BY 
    p.ProjectID, p.ProjectName, c.ClientName, p.Budget
ORDER BY 
    TotalRevenue DESC;
```

This is just the beginning - the database is set up for complex queries around utilization, realization, work in progress (WIP), and other key professional services metrics.
