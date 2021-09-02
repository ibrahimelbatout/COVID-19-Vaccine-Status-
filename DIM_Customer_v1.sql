--cleansing DIM_Customer table
SELECT 
  c.customerkey AS CustomerKey, 
  --,[GeographyKey]
  --,[CustomerAlternateKey]
  --,[Title]
 
  c.firstname AS [First Name], --,[MiddleName] 
  c.lastname AS [Last Name], 
  c.firstname + ' ' + lastname AS [Full Name] --,[NameStyle]
  --,[BirthDate]
  --,[MaritalStatus]
  --,[Suffix]
  , 
  CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Femal' END AS Gender ,--,[EmailAddress]
  --,[YearlyIncome]
  --,[TotalChildren]
  --,[NumberChildrenAtHome]
  --,[EnglishEducation]
  --,[SpanishEducation]
  --,[FrenchEducation]
  --,[EnglishOccupation]
  --,[SpanishOccupation]
  --,[FrenchOccupation]
  --,[HouseOwnerFlag]
  --,[NumberCarsOwned]
  --,[AddressLine1]
  --,[AddressLine2]
  --,[Phone]
  c.datefirstpurchase AS DateFirstPurchase --,[CommuteDistance]
  , 
  g.city AS [Customer City] --Joined in Customer City from Geography table
FROM 
  [AdventureWorksDW2019].[dbo].[DimCustomer] AS c 
  LEFT JOIN [dbo].[Dimgeography] AS g ON g.geographykey = c.geographykey 
ORDER BY 
  Customerkey ASC --ORDERD LIDT BY Customerkey


