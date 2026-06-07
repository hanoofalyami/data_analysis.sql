-- explore all objects in the database
 select 
	*
from 
	INFORMATION_SCHEMA.TABLES

--explore all columns in the database
select 
	*
from
	INFORMATION_SCHEMA.COLUMNS 
where
	table_name='dim_customers'
