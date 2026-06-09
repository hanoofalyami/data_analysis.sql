/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* analyze the yearly performance of products by comparing their sales
to both avergae sales perfromance of the product and the previous years sales */

with yearly_product_sales as(
select
	year(f.order_date) order_year,
	p.product_name,
	sum(f.sales_amount) current_sales
from 
	gold.fact_sales f
left join gold.dim_products p
on
	f.product_key=p.product_key
where order_date is not null
group by year(f.order_date),p.product_name
)
select 
	order_year,
	product_name,
	current_sales,
	avg(current_sales)over(partition by product_name) avg_sales,
	current_sales-avg(current_sales)over(partition by product_name) as diff_avg,
	case when current_sales-avg(current_sales)over(partition by product_name)>0 then 'Above Avg'
		   when current_sales-avg(current_sales)over(partition by product_name)<0 then 'Below_avg'
		   else 'avg'
	end avg_change,
	-- year-over-year Analysis 
	lag(current_sales)over(partition by product_name order by order_year asc) as py_sales,
	current_sales-lag(current_sales)over(partition by product_name order by order_year asc) diff_diff,
	case when current_sales-lag(current_sales)over(partition by product_name order by order_year asc)>0 then 'Increasing'
		   when current_sales-lag(current_sales)over(partition by product_name order by order_year asc)<0 then 'Decrease'
		   else 'No Change'
	end avg_change
from
	yearly_product_sales
order by product_name,order_year
