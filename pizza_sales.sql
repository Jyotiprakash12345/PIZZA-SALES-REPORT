use pizza_sales;
select * from pizza_sales.`data model - pizza sales`; 
rename table pizza_sales.`data model - pizza sales` to pizza_sales.`pizza_sales_`;
select * from pizza_sales.`pizza_sales_`;
-- ------------------------------------------------------------------------------------
## pizza sales analysis
-- Q1. Total revenue
select cast(sum(total_price) as decimal(10,0)) as revenue 
from pizza_sales.`pizza_sales_`; 

-- Q2. Average order values
select cast(sum(total_price) / count(distinct order_id) as decimal(10,2)) as avg_order_value
from pizza_sales.`pizza_sales_`;

-- Q3. Total Pizza sold
select sum(quantity) as total_pizza_sold 
from pizza_sales.`pizza_sales_`;

-- Q4. Total Orders
select count(distinct order_id) as total_orders 
from pizza_sales.`pizza_sales_`;

-- Q5. Average pizza per order 
select cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))
as Avg_pizza_per_orders
from pizza_sales.`pizza_sales_`;

-- Q6.a. Hourly trend for total orders
select hour(order_time) as hourly_trend, count(distinct order_id) as total_orders 
from pizza_sales.pizza_sales_
group by hour(order_time);

-- Q6.b. Daily trend for total orders
select dayname(str_to_date(order_date,"%d-%m-%Y")) as order_day,
count(distinct order_id) as no_of_orders
from pizza_sales.pizza_sales_
group by dayname(str_to_date(order_date,"%d-%m-%Y"))
order by field(order_day,"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday");

-- Q6.c. Weekly trend for total orders
select week(str_to_date(order_date,"%d-%m-%Y"),3) as iso_weekly_sales,
count(distinct(order_id)) as total_orders 
from pizza_sales.pizza_sales_
group by week(str_to_date(order_date,"%d-%m-%Y"),3)
order by iso_weekly_sales;

-- Q7. Monthly trend for orders
select monthname(str_to_date(order_date,"%Y-%m-%d")) as monthly_trend,
count(distinct order_id) as no_of_orders
from pizza_sales.pizza_sales_
group by monthname(str_to_date(order_date,"%Y-%m-%d"))
order by field(monthly_trend,"January","February","March","April","May","June","July","August","September","October","November","December");

-- Q8. % of sales by pizza category
select pizza_category,cast(sum(total_price) as decimal (10,2)) as Total_revenue,
cast(sum(total_price)*100/ (select sum(total_price) from pizza_sales.pizza_sales_) as decimal(10,2)) as PCT_of_sales_by_category
from pizza_sales.pizza_sales_
group by pizza_category;

-- Q9. % of sales by pizza size
Select pizza_size,cast(sum(total_price) as decimal(10,2)) as total_sales,
cast(sum(total_price) / (select sum(total_price) from pizza_sales.pizza_sales_) * 100 as decimal(10,2)) as PCT_of_sales_by_pizza_size
from pizza_sales.pizza_sales_
group by pizza_size;

-- Q10. Total Pizzas sold by pizza category 
select pizza_category,sum(quantity) as no_of_pizza_sold
from pizza_sales.pizza_sales_
where month(str_to_date(order_date, '%Y-%m-%d')) = 2
group by pizza_category
order by no_of_pizza_sold desc;

-- Q11. Top 5 pizzas by revenue
select pizza_name, cast(sum(total_price) as decimal (10,2)) as revenue
from pizza_sales.pizza_sales_
group by pizza_name
order by revenue desc
limit 5;

-- Q12. Bottom 5 pizzas by revenue 
select pizza_name, cast(sum(total_price) as decimal (10,2)) as revenue
from pizza_sales.pizza_sales_
group by pizza_name
order by revenue asc
limit 5;

-- Q13. Top 5 pizzas by total orders
select pizza_name, count(distinct order_id) as total_orders
from pizza_sales.pizza_sales_
group by pizza_name
order by total_orders desc
limit 5;

-- Q14. Bottom 5 pizzas by total orders
select pizza_name, count(distinct order_id) as total_orders
from pizza_sales.pizza_sales_
group by pizza_name
order by total_orders asc
limit 5;

-- Q15. Top 5 pizzas by quantity
select pizza_name , sum(quantity) as qty
from pizza_sales.pizza_sales_
group by pizza_name
order by qty desc
limit 5; 

-- Q16. Bottom 5 pizzas by quantity
select pizza_name , sum(quantity) as qty
from pizza_sales.pizza_sales_
group by pizza_name
order by qty asc
limit 5;















