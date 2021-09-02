--Cleansed Fact_Internet_Sales Table --
SELECT 
       [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
      ,[SalesOrderNumber]
      ,[SalesAmount]

FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE 
     LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) -2  
	 -- THIS TO ENSURE THAT IT ONLY BRINGS TWO YEARS OF DATE FROM EXTRACTION 
ORDER BY 
     OrderDateKey ASC 