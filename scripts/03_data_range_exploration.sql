-- find the date of the first and last order
-- how many years of sales are avaiable 

select 
	min(order_date) first_order_date,
	max(order_date) last_order_date,
	datediff(year,min(order_date),max(order_date)) as order_range_years

from
	gold.fact_sales

-- find the youngest and oldest customer
--
select
	min(birthdate) as oldest_birthdate,
	DATEDIFF(year,min(birthdate),getdate()) as oldest_age,
	max(birthdate) as youngest_birthdate,
	DATEDIFF(year,max(birthdate),getdate()) as youngest_age

from	
	gold.dim_customers
