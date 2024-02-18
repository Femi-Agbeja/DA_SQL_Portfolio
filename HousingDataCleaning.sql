-- Cleaning the data using SQL
USE Housing_Data

SELECT *
FROM [Nashville Housing Data for Data]

-- Standardizing the Sales date

UPDATE [Nashville Housing Data for Data]
SET SaleDate = CONVERT(DATE,SaleDate)

-- Cleaning up the Property Address Column

-- Exploring
SELECT *
FROM [Nashville Housing Data for Data]
WHERE PropertyAddress IS NULL
ORDER BY ParcelID

-- Filling in the blanks
-- This will be done by joining a table to its self against the percelID and the UniqueID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Nashville Housing Data for Data] a
JOIN [Nashville Housing Data for Data] b
-- if the percelID is the same, the property/address should be the same
ON a.ParcelID = b.ParcelID
-- Ignore if the uniqueID is the same.
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Nashville Housing Data for Data] a
JOIN [Nashville Housing Data for Data] b
-- if the percelID is the same, the property/address should be the same
ON a.ParcelID = b.ParcelID
-- Ignore if the uniqueID is the same.
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL