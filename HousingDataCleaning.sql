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


-- Breaking out the Address column into individual columns
-- The adddress column contains the real address and the city

SELECT PropertyAddress
FROM [Nashville Housing Data for Data]

--  Using the Substrig to extract the address into another column called 'Address'

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address 
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS City
FROM [Nashville Housing Data for Data]

-- Creating the two new columns
-- First Table - 'PropertySplitAddress'
ALTER TABLE [dbo].[Nashville Housing Data for Data]
ADD PropertySplitAddress NVARCHAR(255)

UPDATE [Nashville Housing Data for Data]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

-- Second Table - 'PropertySplitCity'
ALTER TABLE [dbo].[Nashville Housing Data for Data]
ADD PropertySplitCity NVARCHAR(255)

UPDATE [Nashville Housing Data for Data]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

-- Checking what was done

SELECT *
FROM [Nashville Housing Data for Data]

-- Another way to have done it using PARSENAME
SELECT
PARSENAME(REPLACE(PropertyAddress,',','.'), 2),
PARSENAME(REPLACE(PropertyAddress,',','.'), 1)
FROM [Nashville Housing Data for Data]

-- Breaking out the OwnerAddress column into individual columns (3 columns)
SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'), 3),
PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM [Nashville Housing Data for Data]

-- Creating the three new columns
-- First Table - 'OwnerSplitAddress'
ALTER TABLE [dbo].[Nashville Housing Data for Data]
ADD OwnerSplitAddress NVARCHAR(255)

UPDATE [Nashville Housing Data for Data]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

-- Second Table - 'OwnerSplitCity'
ALTER TABLE [dbo].[Nashville Housing Data for Data]
ADD OwnerSplitCity NVARCHAR(255)

UPDATE [Nashville Housing Data for Data]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)

-- Third Table - 'OwnerSplitCity'
ALTER TABLE [dbo].[Nashville Housing Data for Data]
ADD OwnerSplitState NVARCHAR(255)

UPDATE [Nashville Housing Data for Data]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

-- Checking what was done

SELECT *
FROM [Nashville Housing Data for Data]

-- Change Y and N to Yes and No Respectfully in the "Sold as Vacant" Field
-- Exploring the field
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) AS COUNTS
FROM [Nashville Housing Data for Data]
GROUP BY SoldAsVacant
ORDER BY 2

-- Executing the correction
SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
FROM [Nashville Housing Data for Data]

-- Updating the Table
UPDATE [Nashville Housing Data for Data]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END