-- Shows whole table data 
Select * From portfolioproject..nashville

-- Converts Saledate column in date format
Select SaleDate, CONVERT(date, SaleDate) as SaleDate2 From portfolioproject..nashville

-- Alter table with SaleDateConverted column
Alter table nashville
add SaleDateConverted Date;

-- Update SaleDateConverted column with converted date format
Update nashville 
set SaleDateConverted = CONVERT(Date, SaleDate)

-- Shows SaleDateConverted table
Select SaleDateConverted From portfolioproject..nashville

-- Checking PropertyAddress if null or not
Select * From portfolioproject..nashville
where PropertyAddress is null

-- Trying to find out fill the null values in PropertyAddress column
select a.PropertyAddress, b.PropertyAddress, a.ParcelID, b.ParcelID, a.[UniqueID ], b.[UniqueID ], isnull(a.PropertyAddress, b.PropertyAddress) 
from portfolioproject..nashville a
join portfolioproject..nashville b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Once you got the way to fill the null values, can be updated through following commands
update a
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress) 
from portfolioproject..nashville a
join portfolioproject..nashville b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Split address in two parts with the help of substring query
select 
Substring (PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) As Address,
Substring (PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as Address
from portfolioproject..nashville

-- Putting Split data in table
Alter table nashville
add PropertyAddress1 nvarchar(255);

Update nashville 
set PropertyAddress1 = Substring (PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

-- Putting Split data in table
Alter table nashville
add PropertyAddress2 nvarchar(255);

Update nashville 
set PropertyAddress2 = Substring (PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

-- Shows table data 
select PropertyAddress1, PropertyAddress2 from portfolioproject..nashville

select * from portfolioproject..nashville

select 
PARSENAME(REPLACE(OwnerAddress, ',','.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
from portfolioproject..nashville

-- Putting Split data in table
Alter table nashville
add OwnerAddress1 nvarchar(255);

Update nashville 
set OwnerAddress1 = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)

-- Putting Split data in table
Alter table nashville
add OwnerAddress2 nvarchar(255);

Update nashville 
set OwnerAddress2 = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)

-- Putting Split data in table
Alter table nashville
add OwnerAddress3 nvarchar(255);

Update nashville 
set OwnerAddress3 = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)

-- Make Uniqueness of data
select Distinct(SoldAsVacant)--, COUNT(SoldAsVacant)
from portfolioproject..nashville

select SoldAsVacant, 
CASE 
WHEN soldasvacant = 'Y' then 'Yes'
WHEN soldasvacant = 'N' then 'No'
Else soldasvacant 
end
from portfolioproject..nashville

-- Update uniqueness data in table 
Update nashville
Set SoldAsVacant = 
CASE 
WHEN soldasvacant = 'Y' then 'Yes'
WHEN soldasvacant = 'N' then 'No'
Else soldasvacant 
END
FROM portfolioproject..nashville

-- Checking duplicacy in table
select *, ROW_NUMBER()
over (Partition by parcelID,
PropertyAddress, 
SalePrice,
SaleDate,
LegalReference
order by uniqueID) as row_num
from portfolioproject..nashville
order by ParcelID

-- Using CTE to count duplicacy of data
with rownumCTE as(
select *, ROW_NUMBER()
over (Partition by parcelID,
PropertyAddress, 
SalePrice,
SaleDate,
LegalReference
order by uniqueID) as row_num
from portfolioproject..nashville
--order by ParcelID
)

-- Will give duplicate data
Select * from rownumCTE where row_num > 1 order by PropertyAddress

-- Will delete duplicate data
Delete from rownumCTE where row_num > 1 --order by PropertyAddress

Select * from portfolioproject..nashville

-- Drop columns in table
Alter table portfolioproject..nashville
Drop column OwnerAddress, TaxDistrict, OwnerName

