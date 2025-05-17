-- Mock Data Generator for Professional Services Database
-- This script populates the tables with realistic sample data

-- Clear any existing data
DELETE FROM TimeEntries;
DELETE FROM Invoices;
DELETE FROM Rates;
DELETE FROM ProjectAssignments;
DELETE FROM Projects;
DELETE FROM Employees;
DELETE FROM Clients;

-- Insert sample Clients
INSERT INTO Clients (ClientID, ClientName, Industry, ContactPerson, ContactEmail, ContactPhone, DateAdded, IsActive)
VALUES 
(1, 'Acme Corporation', 'Technology', 'John Smith', 'john.smith@acme.com', '555-123-4567', '2023-01-15', 1),
(2, 'Global Financial', 'Finance', 'Sarah Johnson', 'sarah.j@globalfin.com', '555-234-5678', '2023-02-20', 1),
(3, 'HealthPlus', 'Healthcare', 'Michael Brown', 'mbrown@healthplus.org', '555-345-6789', '2023-03-10', 1),
(4, 'RetailGiant', 'Retail', 'Emily Davis', 'e.davis@retailgiant.com', '555-456-7890', '2023-04-05', 1),
(5, 'InnoTech Solutions', 'Technology', 'Robert Wilson', 'rwilson@innotech.com', '555-567-8901', '2023-05-12', 1),
(6, 'Media Matters', 'Media', 'Amanda Lee', 'alee@mediamatters.com', '555-678-9012', '2023-06-08', 0);

-- Insert sample Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, Title, Department, HireDate, BillableTarget, CostRate, Email, IsActive)
VALUES 
(1, 'David', 'Parker', 'Senior Consultant', 'Consulting', '2022-01-10', 160.00, 75.00, 'dparker@company.com', 1),
(2, 'Jennifer', 'Adams', 'Project Manager', 'Management', '2022-02-15', 140.00, 85.00, 'jadams@company.com', 1),
(3, 'Thomas', 'Garcia', 'Business Analyst', 'Analytics', '2022-03-22', 150.00, 65.00, 'tgarcia@company.com', 1),
(4, 'Michelle', 'Taylor', 'Developer', 'Technology', '2022-04-18', 170.00, 80.00, 'mtaylor@company.com', 1),
(5, 'Kevin', 'Martinez', 'UX Designer', 'Design', '2022-05-09', 160.00, 70.00, 'kmartinez@company.com', 1),
(6, 'Jessica', 'Robinson', 'Data Scientist', 'Analytics', '2022-06-14', 150.00, 90.00, 'jrobinson@company.com', 1),
(7, 'Andrew', 'Nelson', 'Consultant', 'Consulting', '2022-07-25', 160.00, 60.00, 'anelson@company.com', 1),
(8, 'Laura', 'Phillips', 'Marketing Specialist', 'Marketing', '2022-08-08', 130.00, 55.00, 'lphillips@company.com', 0);

-- Insert sample Projects
INSERT INTO Projects (ProjectID, ClientID, ProjectName, Description, StartDate, EndDate, EstimatedHours, Budget, ProjectManager, Status)
VALUES 
(1, 1, 'Software Implementation', 'ERP system implementation', '2023-03-01', '2023-09-30', 1200, 180000.00, 2, 'Active'),
(2, 2, 'Financial Analysis', 'Q3 financial performance analysis', '2023-06-15', '2023-08-15', 400, 60000.00, 3, 'Completed'),
(3, 3, 'Patient Portal Redesign', 'Redesign of patient portal interface', '2023-05-01', '2023-11-30', 900, 120000.00, 2, 'Active'),
(4, 4, 'Supply Chain Optimization', 'Optimizing retail supply chain', '2023-07-01', '2024-01-31', 800, 100000.00, 2, 'Active'),
(5, 5, 'Data Migration', 'Migration to new data platform', '2023-04-15', '2023-07-15', 600, 90000.00, 3, 'Completed'),
(6, 1, 'Mobile App Development', 'New mobile application development', '2023-08-01', '2024-02-28', 1000, 150000.00, 2, 'Active'),
(7, 2, 'Risk Assessment', 'Financial risk assessment', '2023-09-01', '2023-12-15', 300, 45000.00, 3, 'On Hold');

-- Insert sample ProjectAssignments
INSERT INTO ProjectAssignments (AssignmentID, ProjectID, EmployeeID, RoleOnProject, AssignedDate)
VALUES 
(1, 1, 1, 'Lead Consultant', '2023-03-01'),
(2, 1, 4, 'Developer', '2023-03-01'),
(3, 1, 5, 'UX Design', '2023-03-01'),
(4, 2, 3, 'Lead Analyst', '2023-06-15'),
(5, 2, 6, 'Data Support', '2023-06-15'),
(6, 3, 2, 'Project Manager', '2023-05-01'),
(7, 3, 5, 'Lead Designer', '2023-05-01'),
(8, 3, 7, 'Support Consultant', '2023-05-01'),
(9, 4, 1, 'Lead Consultant', '2023-07-01'),
(10, 4, 7, 'Support Consultant', '2023-07-01'),
(11, 5, 6, 'Lead Data Scientist', '2023-04-15'),
(12, 5, 4, 'Developer', '2023-04-15'),
(13, 6, 4, 'Lead Developer', '2023-08-01'),
(14, 6, 5, 'UX Designer', '2023-08-01'),
(15, 7, 3, 'Lead Analyst', '2023-09-01'),
(16, 7, 1, 'Senior Advisor', '2023-09-01');

-- Insert sample Rates
INSERT INTO Rates (RateID, ProjectID, EmployeeID, RoleType, HourlyRate, EffectiveDate, EndDate)
VALUES 
(1, 1, 1, 'Lead Consultant', 200.00, '2023-03-01', NULL),
(2, 1, 4, 'Developer', 175.00, '2023-03-01', NULL),
(3, 1, 5, 'UX Design', 165.00, '2023-03-01', NULL),
(4, 2, 3, 'Lead Analyst', 180.00, '2023-06-15', '2023-08-15'),
(5, 2, 6, 'Data Support', 190.00, '2023-06-15', '2023-08-15'),
(6, 3, 2, 'Project Manager', 185.00, '2023-05-01', NULL),
(7, 3, 5, 'Lead Designer', 165.00, '2023-05-01', NULL),
(8, 3, 7, 'Support Consultant', 150.00, '2023-05-01', NULL),
(9, 4, 1, 'Lead Consultant', 200.00, '2023-07-01', NULL),
(10, 4, 7, 'Support Consultant', 150.00, '2023-07-01', NULL),
(11, 5, 6, 'Lead Data Scientist', 190.00, '2023-04-15', '2023-07-15'),
(12, 5, 4, 'Developer', 175.00, '2023-04-15', '2023-07-15'),
(13, 6, 4, 'Lead Developer', 180.00, '2023-08-01', NULL),
(14, 6, 5, 'UX Designer', 165.00, '2023-08-01', NULL),
(15, 7, 3, 'Lead Analyst', 180.00, '2023-09-01', NULL),
(16, 7, 1, 'Senior Advisor', 210.00, '2023-09-01', NULL);

-- Insert sample TimeEntries (abbreviated - 2 weeks of entries for selected projects)
INSERT INTO TimeEntries (EntryID, EmployeeID, ProjectID, EntryDate, Hours, Description, BillableStatus, ApprovalStatus, DateSubmitted)
VALUES 
-- Project 1 entries for David Parker (Employee 1)
(1, 1, 1, '2023-04-03', 7.5, 'Initial requirements gathering', 'Billable', 'Approved', '2023-04-03'),
(2, 1, 1, '2023-04-04', 8.0, 'System architecture design', 'Billable', 'Approved', '2023-04-04'),
(3, 1, 1, '2023-04-05', 6.5, 'Client meeting and documentation', 'Billable', 'Approved', '2023-04-05'),
(4, 1, 1, '2023-04-06', 7.0, 'Technical specifications', 'Billable', 'Approved', '2023-04-06'),
(5, 1, 1, '2023-04-07', 8.0, 'Implementation planning', 'Billable', 'Approved', '2023-04-07'),
(6, 1, 1, '2023-04-10', 7.5, 'Team coordination and review', 'Billable', 'Approved', '2023-04-10'),
(7, 1, 1, '2023-04-11', 6.0, 'Issue resolution and client call', 'Billable', 'Approved', '2023-04-11'),
(8, 1, 1, '2023-04-12', 8.0, 'Phase 1 implementation', 'Billable', 'Approved', '2023-04-12'),
(9, 1, 1, '2023-04-13', 7.5, 'Testing and documentation', 'Billable', 'Approved', '2023-04-13'),
(10, 1, 1, '2023-04-14', 6.5, 'Progress review and planning', 'Billable', 'Approved', '2023-04-14'),

-- Project 1 entries for Michelle Taylor (Employee 4)
(11, 4, 1, '2023-04-03', 8.0, 'Development setup and configuration', 'Billable', 'Approved', '2023-04-03'),
(12, 4, 1, '2023-04-04', 7.5, 'Core module development', 'Billable', 'Approved', '2023-04-04'),
(13, 4, 1, '2023-04-05', 8.0, 'API integration development', 'Billable', 'Approved', '2023-04-05'),
(14, 4, 1, '2023-04-06', 8.0, 'Data model implementation', 'Billable', 'Approved', '2023-04-06'),
(15, 4, 1, '2023-04-07', 7.0, 'Unit testing', 'Billable', 'Approved', '2023-04-07'),
(16, 4, 1, '2023-04-10', 8.0, 'Feature development - reporting', 'Billable', 'Approved', '2023-04-10'),
(17, 4, 1, '2023-04-11', 8.0, 'Feature development - user management', 'Billable', 'Approved', '2023-04-11'),
(18, 4, 1, '2023-04-12', 7.5, 'Bug fixes and code review', 'Billable', 'Approved', '2023-04-12'),
(19, 4, 1, '2023-04-13', 8.0, 'Integration testing', 'Billable', 'Approved', '2023-04-13'),
(20, 4, 1, '2023-04-14', 7.0, 'Documentation and deployment prep', 'Billable', 'Approved', '2023-04-14'),

-- Project 2 entries for Thomas Garcia (Employee 3)
(21, 3, 2, '2023-07-03', 7.0, 'Financial data collection', 'Billable', 'Approved', '2023-07-03'),
(22, 3, 2, '2023-07-04', 7.5, 'Initial data analysis', 'Billable', 'Approved', '2023-07-04'),
(23, 3, 2, '2023-07-05', 8.0, 'Performance metric development', 'Billable', 'Approved', '2023-07-05'),
(24, 3, 2, '2023-07-06', 6.5, 'Client meeting and requirement clarification', 'Billable', 'Approved', '2023-07-06'),
(25, 3, 2, '2023-07-07', 7.0, 'Analysis of Q3 performance trends', 'Billable', 'Approved', '2023-07-07'),
(26, 3, 2, '2023-07-10', 8.0, 'Detailed report development', 'Billable', 'Approved', '2023-07-10'),
(27, 3, 2, '2023-07-11', 7.5, 'Financial modeling', 'Billable', 'Approved', '2023-07-11'),
(28, 3, 2, '2023-07-12', 7.0, 'Benchmark comparison analysis', 'Billable', 'Approved', '2023-07-12'),
(29, 3, 2, '2023-07-13', 8.0, 'Report preparation and review', 'Billable', 'Approved', '2023-07-13'),
(30, 3, 2, '2023-07-14', 6.0, 'Presentation development', 'Billable', 'Approved', '2023-07-14');

-- Add more time entries for various employees and projects
INSERT INTO TimeEntries (EntryID, EmployeeID, ProjectID, EntryDate, Hours, Description, BillableStatus, ApprovalStatus, DateSubmitted)
VALUES 
-- Project 3 entries for Kevin Martinez (Employee 5)
(31, 5, 3, '2023-06-05', 7.5, 'UX research and planning', 'Billable', 'Approved', '2023-06-05'),
(32, 5, 3, '2023-06-06', 8.0, 'User journey mapping', 'Billable', 'Approved', '2023-06-06'),
(33, 5, 3, '2023-06-07', 7.0, 'Wireframe development', 'Billable', 'Approved', '2023-06-07'),
(34, 5, 3, '2023-06-08', 6.5, 'Stakeholder review meeting', 'Billable', 'Approved', '2023-06-08'),
(35, 5, 3, '2023-06-09', 8.0, 'UI design - Homepage', 'Billable', 'Approved', '2023-06-09'),
(36, 5, 3, '2023-06-12', 7.5, 'UI design - Patient dashboard', 'Billable', 'Approved', '2023-06-12'),
(37, 5, 3, '2023-06-13', 8.0, 'UI design - Medical records', 'Billable', 'Approved', '2023-06-13'),
(38, 5, 3, '2023-06-14', 7.0, 'Usability testing preparation', 'Billable', 'Approved', '2023-06-14'),
(39, 5, 3, '2023-06-15', 6.0, 'Client feedback incorporation', 'Billable', 'Approved', '2023-06-15'),
(40, 5, 3, '2023-06-16', 7.0, 'Design system documentation', 'Billable', 'Approved', '2023-06-16');

-- Insert non-billable and internal time entries
INSERT INTO TimeEntries (EntryID, EmployeeID, ProjectID, EntryDate, Hours, Description, BillableStatus, ApprovalStatus, DateSubmitted)
VALUES 
(41, 1, 1, '2023-04-05', 1.5, 'Team training', 'Non-Billable', 'Approved', '2023-04-05'),
(42, 3, 2, '2023-07-06', 1.0, 'Team meeting', 'Non-Billable', 'Approved', '2023-07-06'),
(43, 4, 1, '2023-04-10', 1.0, 'Internal code review', 'Non-Billable', 'Approved', '2023-04-10'),
(44, 2, 3, '2023-06-09', 2.0, 'Team coordination', 'Non-Billable', 'Approved', '2023-06-09'),
(45, 5, 3, '2023-06-12', 1.5, 'Internal design review', 'Non-Billable', 'Approved', '2023-06-12');

-- Insert pending approval time entries
INSERT INTO TimeEntries (EntryID, EmployeeID, ProjectID, EntryDate, Hours, Description, BillableStatus, ApprovalStatus, DateSubmitted)
VALUES 
(46, 1, 1, '2023-04-17', 8.0, 'System integration', 'Billable', 'Pending', '2023-04-17'),
(47, 4, 1, '2023-04-17', 7.5, 'Backend development', 'Billable', 'Pending', '2023-04-17'),
(48, 3, 2, '2023-07-17', 8.0, 'Financial forecasting', 'Billable', 'Pending', '2023-07-17'),
(49, 5, 3, '2023-06-19', 7.0, 'Responsive design implementation', 'Billable', 'Pending', '2023-06-19');

-- Insert sample Invoices
INSERT INTO Invoices (InvoiceID, ClientID, ProjectID, InvoiceDate, DueDate, Amount, Status, PaymentDate, PaymentAmount, Notes)
VALUES 
(1, 1, 1, '2023-04-30', '2023-05-30', 28525.00, 'Paid', '2023-05-25', 28525.00, 'April billable hours'),
(2, 2, 2, '2023-07-31', '2023-08-30', 22275.00, 'Paid', '2023-08-28', 22275.00, 'July billable hours'),
(3, 3, 3, '2023-06-30', '2023-07-30', 19857.50, 'Paid', '2023-07-29', 19857.50, 'June billable hours'),
(4, 1, 1, '2023-05-31', '2023-06-30', 30275.00, 'Paid', '2023-06-28', 30275.00, 'May billable hours'),
(5, 1, 1, '2023-06-30', '2023-07-30', 29187.50, 'Partial', '2023-07-25', 15000.00, 'June billable hours'),
(6, 4, 4, '2023-07-31', '2023-08-30', 24500.00, 'Unpaid', NULL, NULL, 'July billable hours'),
(7, 5, 5, '2023-06-30', '2023-07-30', 27912.50, 'Paid', '2023-07-20', 27912.50, 'Final invoice for project');
