select * from "Pizza_sales";

-- Total Revenue: Sum of the Total Price of all Pizza Orders
select 
	sum(total_price) as "Total_Revenue" 
from 
	"Pizza_sales";

-- Orders where the Quantity is greater than 1 
select 
	* 
from 
	"Pizza_sales" 
where 
	quantity>1;

-- Average Order Value: Total Revenue divided by the total number of Orders
Select 
	sum(total_price) / count(distinct order_id) as "Average_Order_Value" 
from 
	"Pizza_sales";

-- Total Pizzas Sold: The Sum of the quantities of all the Pizzas sold
select 
	sum(quantity) as "Total_Pizzas_Sold" 
from 
	"Pizza_sales";

-- Total Orders: The total number of orders placed.
select 
	count(distinct order_id) as "Total_Orders" 
from 
	"Pizza_sales";

-- Average Pizzas per Order: Average number of Pizzas sold per order, total number of pizzas divided by total number of orders
select 
	cast(sum(quantity) / count(distinct order_id) as decimal(10,2)) as "Average_Pizzas_Order"
from 
	"Pizza_sales";

--Daily Trend of Orders: To get the trend of total orders from a particular day of the week
select 
     TO_CHAR(order_date, 'Day') as "Day", 
     count(distinct order_id) as "Total_Orders"
from 
     "Pizza_sales"
group by 
     TO_CHAR(order_date, 'Day');
	 
--Hourly Trend of Orders: To get the Hourly trend of total orders
Select 
	date_part('Hour', order_time) as "Hour",
	count(distinct order_id) as "Total_Orders"
from
	"Pizza_sales"
group by
	date_part('Hour', order_time)
order by
	date_part('Hour', order_time);
	
-- Percentage of Sales by Pizza Category: Number of Pizzas Sold in each category
Select 
	pizza_category as "Category",
	cast(sum(total_Price) as decimal(10,2)) as "Total_Sales",
	cast(sum(total_price) * 100 / 
	(select
		sum(total_price)
	 from 
	 	"Pizza_sales") as decimal(10,2)) as "Percentage_Sales_Category"
from 
	"Pizza_sales"
group by	
	pizza_category;

--Percentage of sales by Pizza Size: Get the Sales Percentage with the Pizza Size
select
	pizza_size as "Size",
	cast(sum(total_price) as decimal (10,2)) as "Sales_by_Size",
	cast(sum(total_price) * 100 /
	(Select
		sum(total_price)
	 from
	 "Pizza_sales") as decimal (10,2)) as "Percentage_by_Size"
from
	"Pizza_sales"
group by
	Pizza_size
order by 
	"Percentage_by_Size";

-- Total Pizzas sold by Pizza Category: Total Sales of Pizza by Category
Select
	pizza_category as "Category",
	sum(quantity) as "Total_Pizzas_Sold"
from 
	"Pizza_sales"
group by
	"Category"
order by 
	"Total_Pizzas_Sold";

-- Top 5 Best Sellers by Total Pizzas Sold: Identify the top 5 selling Pizzas
Select 
	Pizza_name as "Pizza", 
	sum(quantity) as "Count"
from 
	"Pizza_sales"
group by
	"Pizza"
order by 
	"Count" DESC
limit 5;


--Top 5 Worst Sellers of Total Pizzas sold: Identify Top 5 Worst Pizzas sold
Select 
	Pizza_name as "Pizza", 
	sum(quantity) as "Count"
from 
	"Pizza_sales"
group by
	"Pizza"
order by 
	"Count" ASC
limit 5;