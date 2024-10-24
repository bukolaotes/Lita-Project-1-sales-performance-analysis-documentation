Create table salesdata(Order_ID integer not null,
					   Customer_Id varchar(50),
					   Product varchar(50),
					   Region	varchar(50),
					   Order_Date	date,
					   Quantity integer,
					   Unit_Price integer
					   ):
					   


select *  from salesdata

---- retrieve the total sales for each product category------
select product,sum(Quantity) as totalsales
from salesdata
group by product

 


--------find the number of sales transactions in each region----
Select region,count(*) AS
number_of_sales
from salesdata
group by region;

------ find the highest-selling product by total sales value----- 
select product,sum(Quantity) as totalsales
from salesdata 
group by product
order by totalsales DESC
LIMIT 1;

 
-----calculate total revenue per product------

SELECT product,
sum(Quantity * unit_price)  as total_revenue
from salesdata
group by product

------calculate monthly sales totals for the current year------
select DATE_TRUNC('month',order_date)
AS month,
     sum(Quantity) AS
totalsales
from salesdata
where
    EXTRACT(YEAR FROM order_date) =
EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
    month
order by 
	month;
	
---------find the top 5 customers by total purchase amount------
	select 
Customer_Id,
sum(Quantity) AS
Total_purchase
from
   salesdata
 group by
    Customer_id
	order by
	  Total_purchase DESC
	  LIMIT 5;

---------	calculate the percentage of total sales contributed by each region------
SELECT
     region,
	 SUM(Quantity) AS 
	 TOTALSALES,
	  (SUM(Quantity) * 100.0 /
	  (SELECT SUM(Quantity) FROM
	  salesdata)) AS sales_percentage
	  FROM
	     salesdata
	  GROUP BY
	       region;
		
	  
   
   
   -------identify products with no sales in the last quarter-----
  WITH all_products AS(
   SELECT DISTINCT product
   FROM salesdata
),
recent_sales AS(
 SELECT DISTINCT product
FROM salesdata
WHERE Order_Date>=NOW() - INTERVAL '3 months'
)
SELECT
ap.product
FROM
all_products ap
WHERE
ap.product NOT IN (SELECT
product from recent_sales);