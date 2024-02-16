-- USE [Unicorn Companies]
SELECT * FROM Unicorn_Companies
-- This shows the percentage of funding that makes up Unicorn's Valuation.

SELECT
Company,
Valuation,
Funding,
((Funding/Valuation)*100) AS 'Funding%'
FROM Unicorn_Companies
ORDER BY [Funding%] DESC;

-- Countries with the Highest Count of Unicorn, Sum Amount of Valuation and Sum Amount of Funding
-- 

SELECT 
Country,
COUNT(Company_ID) AS CountofCountries,
SUM(Valuation) AS SumofValuationPerCountry,
SUM(Funding) AS SumofFundingPerCountry
-- (SUM(Valuation)/ (Valuation)) AS PercentageofShare
FROM Unicorn_Companies
JOIN
Country_Lookup
ON Unicorn_Companies.Country_Id = Country_Lookup.Country_Id
GROUP BY Country
ORDER BY SumofValuationPerCountry DESC;


-- Continent with the Highest Count and Amount of Valuation

SELECT 
Continent,
COUNT(Company_ID) AS CountofContinent,
SUM(Valuation) AS ContinentValuation
FROM Unicorn_Companies
JOIN
Continent_Lookup
ON Unicorn_Companies.Continent_Id = Continent_Lookup.Continent_Id
GROUP BY Continent
ORDER BY ContinentValuation DESC;

-- Top 10 Unicorn Companies by Valuation

SELECT
TOP 10 Company,
Valuation
FROM Unicorn_Companies
ORDER BY Valuation

-- Industries with the Highest Funding

SELECT
TOP 5 Industry,
SUM(Funding) AS SumofFunding
FROM Unicorn_Companies
JOIN Industry_Lookup
ON Unicorn_Companies.Industry_Id = Industry_Lookup.Industry_ID
GROUP BY Industry
ORDER BY SumofFunding DESC

-- Top 10 Unicorn Companies by Funding

SELECT
TOP 10 Company,
Funding
FROM Unicorn_Companies
ORDER BY Funding DESC