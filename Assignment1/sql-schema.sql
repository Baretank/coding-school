-- Professional Services Database Schema
-- This script creates the basic schema for our professional services database

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS TimeEntries;
DROP TABLE IF EXISTS Invoices;
DROP TABLE IF EXISTS Rates;
DROP TABLE IF EXISTS ProjectAssignments;
DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Clients;

-- Create Clients table
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    ClientName VARCHAR(100) NOT NULL,
    Industry VARCHAR(50),
    ContactPerson VARCHAR(100),
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    DateAdded DATE,
    IsActive BIT DEFAULT 1
);

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Title VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    BillableTarget DECIMAL(5,2),  -- Target billable hours per month
    CostRate DECIMAL(10,2),       -- Cost per hour
    Email VARCHAR(100),
    IsActive BIT DEFAULT 1
);

-- Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ClientID INT,
    ProjectName VARCHAR(100) NOT NULL,
    Description VARCHAR(500),
    StartDate DATE,
    EndDate DATE,
    EstimatedHours INT,
    Budget DECIMAL(12,2),
    ProjectManager INT,   -- References an EmployeeID
    Status VARCHAR(20) DEFAULT 'Active',  -- Active, Completed, On Hold, Cancelled
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ProjectManager) REFERENCES Employees(EmployeeID)
);

-- Create project assignments table (which employees are on which projects)
CREATE TABLE ProjectAssignments (
    AssignmentID INT PRIMARY KEY,
    ProjectID INT,
    EmployeeID INT,
    RoleOnProject VARCHAR(50),
    AssignedDate DATE,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create Rates table (different rates for different roles or specific assignments)
CREATE TABLE Rates (
    RateID INT PRIMARY KEY,
    ProjectID INT,
    EmployeeID INT NULL,     -- If NULL, applies to role rather than specific employee
    RoleType VARCHAR(50),    -- Role type for this rate
    HourlyRate DECIMAL(10,2),
    EffectiveDate DATE,
    EndDate DATE NULL,       -- If NULL, currently active
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create TimeEntries table
CREATE TABLE TimeEntries (
    EntryID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectID INT,
    EntryDate DATE,
    Hours DECIMAL(5,2),
    Description VARCHAR(200),
    BillableStatus VARCHAR(20),  -- Billable, Non-Billable, Internal
    ApprovalStatus VARCHAR(20) DEFAULT 'Pending',  -- Pending, Approved, Rejected
    DateSubmitted DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Create Invoices table
CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY,
    ClientID INT,
    ProjectID INT,
    InvoiceDate DATE,
    DueDate DATE,
    Amount DECIMAL(12,2),
    Status VARCHAR(20) DEFAULT 'Unpaid',  -- Unpaid, Paid, Partial, Void
    PaymentDate DATE NULL,
    PaymentAmount DECIMAL(12,2) NULL,
    Notes VARCHAR(200),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
