# SQL Assignment 1: Professional Services Analytics

## Overview
This assignment will help you refresh your SQL JOIN knowledge and build expertise with complex queries relevant to professional services firms. You'll work with a database containing tables for clients, employees, projects, time entries, rates, and invoices.

## Setup
1. Ensure you've successfully set up the Professional Services database using the schema and mock data scripts provided
2. Review the database structure in the setup guide to understand the relationships between tables
3. Open a new SQL file in your Cursor (VSCode) environment to complete the exercises

## Exercises

### Exercise 1: Basic JOINs - Employee Utilization
Calculate the utilization rate for each employee (billable hours divided by target hours) for April 2023.

**Expected output:** Employee name, billable hours, target hours, utilization rate

### Exercise 2: Multi-table JOINs - Project Profitability
Calculate the profitability of each active project by comparing billed revenue against employee costs.

**Expected output:** Project name, total revenue, total cost, profit, profit margin percentage

### Exercise 3: Subqueries - Top Performing Employees
Find the top 3 employees with the highest billable hours in their respective departments.

**Expected output:** Department, employee name, billable hours, rank within department

### Exercise 4: Window Functions - Running Invoice Totals
Calculate a running total of invoices paid by each client, ordered by invoice date.

**Expected output:** Client name, invoice date, invoice amount, running total

### Exercise 5: Complex Aggregation - Realization Rate Analysis
Calculate the realization rate (invoiced amount / billable value) for each project, including analysis of which projects have the best and worst realization rates.

**Expected output:** Project name, billable value, invoiced amount, realization rate, rating (High/Medium/Low)

## Submission Instructions
Create a single SQL file containing all your queries. Each query should:
- Be preceded by a comment indicating which exercise it solves
- Include any explanations or observations about the results
- Be tested to ensure it runs without errors

## Resources
- SQL Server documentation for any functions you need
- The database schema diagram in the setup guide
- The example query in the setup guide as a starting point

## Extra Challenge
For those who finish early or want an additional challenge:
- Create a comprehensive dashboard query that shows key performance indicators for the entire professional services business
- Include metrics like overall utilization, realization, average project profitability, and projected vs. actual revenue

## Due Date
Complete this assignment before our next session to ensure you're ready to move on to JavaScript fundamentals.

## Hints
- For Exercise 1, remember that employee target hours are monthly values in the Employees table.
- For Exercise 2, you'll need to join TimeEntries to both Rates (for revenue) and Employees (for costs).
- For Exercise 3, look into using the ROW_NUMBER() or RANK() window functions.
- For Exercise 5, consider using CASE statements to categorize realization rates.
