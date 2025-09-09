select * from pizza_sales


--Total revenue
select SUM(total_price) AS Total_Revenue from pizza_sales


--Average Order Value
select SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_order_value from pizza_sales


--Total Pizzas Sold
select SUM(quantity) AS Total_pizzas_sold from pizza_sales


--Total Orders
select count(DISTINCT order_id) AS Total_orders from pizza_sales


--Average Pizzas Per Order
select SUM(quantity) / COUNT(DISTINCT order_id) AS Avg_pizza_per_order from pizza_sales


--Hourly Trend for Total Pizzas Sold
select DATEPART(HOUR, order_time) AS order_hour, SUM(quantity) AS Total_pizzas_sold
from pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time) 


--Weekly Trend for Orders
select 
       DATEPART(ISO_WEEK, order_date) AS WeekNumber,
       YEAR(order_date) AS Year,
       COUNT(DISTINCT order_id) AS Total_orders
from pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY Year, WeekNumber


--Percentage of Sales by Pizza Category
select pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue, 
CAST(SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales) 
AS DECIMAL(10,2)) AS PCT 
from pizza_sales
GROUP BY pizza_category 


--Percentage of Sales by Pizza Size
select pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(sum(total_price) * 100 /
(select SUM(total_price) from pizza_sales) AS DECIMAL (10, 2)) AS PCT
from pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size


--Total Pizzas Sold by Pizza Category
select pizza_category, SUM(quantity) AS Total_Quantity_Sold
from pizza_sales 
where MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


--Top 5 Pizzas by Revenue
select Top 5 pizza_name, SUM(total_price) AS Total_Revenue
from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC


--Bottom 5 Pizzas by Revenue
select Top 5 pizza_name, SUM(total_price) AS Total_Revenue
from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC


--Top 5 Pizzas by Quantity
select Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC


--Bottom 5 Pizzas by Quantity
select Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC


--Top 5 Pizzas by Total Orders
select Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC


--Bottom 5 Pizzas by Total Orders
select Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
