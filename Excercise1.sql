Exercise 1: Sales Analysis by Category
Objective: Obtain the total sales by product category for a specific period.

🔹 Query:
Retrieve the total sales and the number of products sold by category in the year 2013.

Key Tables:
    DimProduct (product category)
    FactSales (sales)
    DimDate (dates)

select 
    d.ClassName, 
    count(*) as producto_per_category, 
    SUM(ROUND(f.SalesAmount,2)) As total_sales,
    di.CalendarYear
from DimProduct d
join FactSales f on d.ProductKey = f.ProductKey
join DimDate di on f.DateKey = di.Datekey
where di.CalendarYear = 2009
group by d.ClassName, di.CalendarYear
order by di.CalendarYear;