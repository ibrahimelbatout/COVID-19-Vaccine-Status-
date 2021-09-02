--Cleansed DIM_Products Table 
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode, 
  p.[EnglishProductName] AS [Product Name], 
  ps.EnglishProductsubcategoryName AS [Sub Category], 
  --JOINED IN FROM SUBCATEGORY TABLE
  pc.EnglishProductCategoryName AS [Product Category], 
  --JOINED IN FROM CATEGORY TABLE
  p.[Color] AS [Product Color], 
  p.[Size] AS [Product Size], 
  p.[ProductLine] AS [Product Line], 
  P.[ModelName] AS [Product Model], 
  p.[EnglishDescription] AS [Product Description],
  ISNULL (p.Status, 'Outdated') AS [Product Status] 
FROM 
  [AdventureWorksDW2019].[dbo].[DimProduct] AS p 
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey 
ORDER BY 
  p.ProductKey ASC
