
--%EV Sales Analysis in India%



--Drop Unwanted Columns

Alter Table EVSalesIndia
Drop Column F9, F10, F11, F12, F13;


--Number of States Present

SELECT COUNT(DISTINCT State) AS UniqueStates
FROM [EV_Sales Analysis India]..EVSalesIndia;


--Select required data from the table  

Select *
From [EV_Sales Analysis India]..EVSalesIndia
Order by 1,4


Select * 
From [EV_Sales Analysis India]..EVSalesIndia
Order by Year, 
         CASE Month_Name 
            WHEN 'Jan' THEN 1
            WHEN 'Feb' THEN 2
            WHEN 'Mar' THEN 3
            WHEN 'Apr' THEN 4
            WHEN 'May' THEN 5
            WHEN 'Jun' THEN 6
            WHEN 'Jul' THEN 7
            WHEN 'Aug' THEN 8
            WHEN 'Sep' THEN 9
            WHEN 'Oct' THEN 10
            WHEN 'Nov' THEN 11
            WHEN 'Dec' THEN 12
            ELSE 13  -- This can handle any invalid or NULL month
         END, 
         State;


--Sales By Year

Select Year, SUM([Sales Quantity]) AS TotalSales
From [EV_Sales Analysis India]..EVSalesIndia
Group by Year
Order by 1;


--Sales Per State

Select State, SUM([Sales Quantity]) AS TotalSales
From [EV_Sales Analysis India]..EVSalesIndia
Group by State
Order by 2


--Sales By Vehicle Class

Select Vehicle_class, SUM([Sales Quantity]) AS TotalSales
From [EV_Sales Analysis India]..EVSalesIndia
Group by Vehicle_class
Order by 2 DESC


--Sales By Vehicle Type

Select Vehicle_type, SUM([Sales Quantity]) AS TotalSales
From [EV_Sales Analysis India]..EVSalesIndia
Group by Vehicle_type
Order by 2 DESC


--Monthly Analysis

Select Month_name,  SUM([Sales Quantity]) AS TotalSales
From [EV_Sales Analysis India]..EVSalesIndia
Group by Month_name
Order by  
         CASE Month_Name 
            WHEN 'Jan' THEN 1
            WHEN 'Feb' THEN 2
            WHEN 'Mar' THEN 3
            WHEN 'Apr' THEN 4
            WHEN 'May' THEN 5
            WHEN 'Jun' THEN 6
            WHEN 'Jul' THEN 7
            WHEN 'Aug' THEN 8
            WHEN 'Sep' THEN 9
            WHEN 'Oct' THEN 10
            WHEN 'Nov' THEN 11
            WHEN 'Dec' THEN 12
            ELSE 13  -- This can handle any invalid or NULL month
         END;


--Vehicle Sales Per State

--SELECT State, Vehicle_class, SUM([Sales Quantity]) AS TotalSales
--FROM [EV_Sales Analysis India]..EVSalesIndia
--GROUP BY State, Vehicle_class

--Ranking Vehicle_class per State by there Sales:
--SELECT State, Vehicle_class, SUM([Sales Quantity]) AS TotalSales,
--           RANK() OVER (PARTITION BY State ORDER BY SUM([Sales Quantity]) DESC) AS SalesRank     --ranking is done separately for each State.
--FROM [EV_Sales Analysis India]..EVSalesIndia
--GROUP BY State, Vehicle_class

--Top Vehicle Sales 
Select State, Vehicle_class, TotalSales
From (
    Select State, Vehicle_class, SUM([Sales Quantity]) AS TotalSales,
           RANK() OVER (Partition By State Order by SUM([Sales Quantity]) DESC) AS SalesRank     --ranking is done separately for each State.
    From [EV_Sales Analysis India]..EVSalesIndia
    Group by State, Vehicle_class
) AS RankedSales
Where SalesRank = 1           --Selecting only top 1
Order by State


--Total Sales and Average Sales for Each Vehicle Class

Select Vehicle_class, SUM([Sales Quantity]) AS TotalSales, AVG([Sales Quantity]) AS AvgSales
From [EV_Sales Analysis India]..EVSalesIndia
Group by Vehicle_class
Order by TotalSales DESC


--Monthly Sales For Year 2023

Select Year, Month_name, SUM([Sales Quantity]) AS TotalSales
From [EV_Sales Analysis India]..EVSalesIndia
Where Year = 2023  -- Can Change this to the desired year
Group by Year, Month_name
Order by Month_name


--Top 5 States with the Highest Sales

Select Top 5 State, SUM([Sales Quantity]) AS TotalSales
From [EV_Sales Analysis India]..EVSalesIndia
Group by State
Order by 2 DESC

