
SELECT *
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT * 
FROM EmployeeDemographics
RIGHT OUTER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

USE [SQL Tutorial]

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
INNER jOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary) 

-- Updating and Deleting
UPDATE [SQL Tutorial].dbo.EmployeeDemographics
SET FirstName = 'Andrew', LastName = 'Agbeja'
WHERE EmployeeID = 1009

USE [SQL Tutorial]
SELECT * FROM EmployeeDemographics
SELECT * FROM EmployeeSalary

-- Partition By
SELECT FirstName, LastName, Gender, Salary, 
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM [SQL Tutorial].dbo.EmployeeDemographics dem
JOIN [SQL Tutorial].dbo.EmployeeSalary Sal
ON dem.EmployeeID = sal.EmployeeID

--Temp Table
CREATE TABLE #temp_Employee
(
EmployeeID int,
JobTitle varchar(100),
Salary int
)

SELECT * 
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES
('1001', 'HR', '45000')

-- Copying data from another table
INSERT INTO #temp_Employee
SELECT *
FROM [SQL Tutorial].dbo.EmployeeSalary

CREATE TABLE #Temp_Employee2
(
JobTitle varchar(50),
EmployeesPerJon int,
AverageAge int,
AvgSalary int
)

INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM [SQL Tutorial].dbo.EmployeeDemographics emp
JOIN [SQL Tutorial].dbo.EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #Temp_Employee2

-- Creating Tables with Errors
CREATE TABLE EmployeeErrors
(
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES
('1001 ', 'Jimbo', 'Halbert'),
(' 1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors

-- Using TRIM, LTRIM, RTRIM
SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

-- Using Replace

SELECT EmployeeID, LastName, REPLACE(LastName, '- Fired','') as LastnameFixed
FROM EmployeeErrors

-- Using SubString

SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

-- Upper and Lower

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors

SELECT Company_ID, Company, City_Id
FROM [dbo].[Unicorn_Companies]
UNION
SELECT City_Id, City, Country_ID
FROM [dbo].[City_Lookup]

--Case Statement
SELECT Company_ID, Company, Valuation,
CASE
	WHEN Valuation < 10000000000 THEN 'Regular'
	WHEN Valuation < 50000000000 THEN 'VIP'
	ELSE 'VVIP'
END AS Party_Invite
FROM [dbo].[Unicorn_Companies]
WHERE Valuation is NOT NULL
ORDER BY Valuation

--SELECT MAX(Valuation)
--FROM [dbo].[Unicorn_Companies]

-- Creating the Stored Procedure 1

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

-- Calling the Stored procedure

EXEC TEST

-- Creating Stored Procedure 2

CREATE PROCEDURE Temp_Employee
AS
CREATE TABLE #Temp_Employee2
(
JobTitle varchar(50),
EmployeesPerJon int,
AverageAge int,
AvgSalary int
)

INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM [SQL Tutorial].dbo.EmployeeDemographics emp
JOIN [SQL Tutorial].dbo.EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #Temp_Employee2

-- Calling the Stored Procedure
EXEC Temp_Employee @JobTitle = 'Salesman