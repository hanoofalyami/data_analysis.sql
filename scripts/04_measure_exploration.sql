-- find the total sales
select 
	sum(sales_amount) as total_sales
from
	gold.fact_sales

-- find how many items are sold
select
	sum(quantity) as total_quantity
from
	gold.fact_sales

-- find the average selling price
select 
	avg(price) avg_price
from
	gold.fact_sales
	
-- find the total number of orders
select 
	count(order_number) as total_orders
from
	gold.fact_sales
--
select 
	count(distinct order_number) as total_orders
from
	gold.fact_sales

-- find the total number of products
select
	count(distinct product_name) as total_product
from
	gold.dim_products

--
select
	count(distinct product_key) as total_product
from
	gold.dim_products

-- find the total number of customers
select 
	count(customer_id)
from
	gold.dim_customers
-- find the total number of customers that has placed an order
select
	count(distinct customer_key) as total_customers
from
	gold.fact_sales

-- generate a report that show all key metrics of the business
select 
	'total_sales' as mesure_name,
	sum(sales_amount) as measure_value
from
	gold.fact_sales
--
union all
select
	'total_quantity',
	sum(quantity) as measure_value
from
	gold.fact_sales
--
union all
select 
	'average price',
	avg(price) measure_value
from
	gold.fact_sales
--
union all
select 
	'total Nr. orders',
	count(order_number) 
from
	gold.fact_sales
--
union all
select
	'total Nr. products',
	count(distinct product_name) 
from
	gold.dim_products
--
union all
select
	'total Nr. customers',
	count(distinct customer_key) 
from
	gold.fact_sales
