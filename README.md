# Sales Performance Analysis

---
### Project Objective


This project aims to analyze monthly sales performance across different regions and product lines to identify trends and areas for improvement.

### Data Description:

The dataset "salesdata.xls" file  contains sales transaction records for the last two years, including columns like date, region, product type,  amount per unit, number of units sold.


### Tools

- Excel - Data cleaniing and creating of pivot tables
- postgresql - Data Analytics
- Power BI - Creating of reports


### Data Cleaning/Prepearation


1.	Removed duplicate rows .
2.	standardized product names for consistent analysis across the dataset.


### Exploratory Data Analysis (EDA)

EDA involved exploring the sales data to answer key questions,such as :


- What is  total sales for each product category?
- What is the number of sales transactions in each region?
- Which product is the highest-selling  by total sales value?
- What is total revenue per product?
- What is the monthly sales totals for the current year?
- Who are the top 5 customers by total purchase amount?
- What is the percentage of total sales contributed by each region?
- which  products are with no sales in the last quarter?



### Data Analytics



```
Create table salesdata(Order_ID integer not null,
					   Customer_Id varchar(50),
					   Product varchar(50),
					   Region	varchar(50),
					   Order_Date	date,
					   Quantity integer,
					   Unit_Price integer
					   );
```


select *  from salesdata

```
----IMPORT DATASET---



```
Select SUM(Quantity * Unit_Price) AS totalsalesvalue
FROM salesdata
```


```
Select product,Sum(Quantity * Unit_Price) AS totalsalesvalue
FROM salesdata
group by product
order by totalsalesvalue desc

 ```



Select region,count(*) AS
number_of_sales
from salesdata
group by region;
```

```
select product,sum(Quantity * Unit_Price) as totalsalesvalue
from salesdata 
group by product
order by totalsalesvalue DESC
LIMIT 1;
```
 


SELECT product,
sum(Quantity * Unit_Price)  as totalrevenue
from salesdata
group by product
order by totalrevenue desc

```


select DATE_TRUNC('month',order_date)
AS month,
     sum(Quantity * Unit_Price) AS totalsalesvalue

from salesdata
where
    EXTRACT(YEAR FROM order_date) =
EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
    month
order by 
	month;

```	



	select 
Customer_Id,
sum(Quantity * Unit_Price) AS
Total_purchaseamount
from
   salesdata
 group by
    Customer_id
	order by
	  Total_purchaseamount DESC
	  LIMIT 5;
```

SELECT 
Region,
SUM(Quantity * Unit_Price) AS
region_total,
     (SUM(Quantity * Unit_Price) /
	 total.total_sales * 100) AS
	 percentage_of_total_sales
	 FROM
	     salesdata,
		  (SELECT SUM(Quantity * Unit_Price) AS
	total_sales FROM salesdata) AS total
	GROUP BY
	      Region,total.total_sales;
       
```   
   
  ``` 
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

```



### RESULTS/FINDINGS


The South region sold 24,298 products which is 35% of the total products of the retail store. The west region sold the lowest products of 11,400 which is 17% of the total products.
In the month of February has the highest sales of product which is 9930 (15%), which may be due to marking of valentine’s day.
Hat product has the highest value of15929 products sold which is 23%, while Jacket product sold the lowest products (5452)8%.
East Region has the highest count of number of transactions (2483), while west has lowest count of number of transactions (2477) which is due to cultural dressing differences.
Shoes has highest revenue of #613,380, while socks have lowest revenue of #180,785, from the region of south #927,820 was the highest Revenue made from the four regions, west region made the lowest revenue.







### Recommendation


 Focus marketing efforts on top-performing regions and product lines.
 Address underperforming regions or product categories with targeted strategies
 Explore opportunities for cross-selling or upselling


