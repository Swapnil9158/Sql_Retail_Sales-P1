--SQL Retail Sales Analysis -P1
Create Database Sql_Project_p2;
--Create Table
Create Table retail_sales_tb
(
			transactions_id	INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(15),
			age	INT,
			category Varchar(25),
			quantiy INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
);


select * from retail_sales_tb
limit 10


select count(*) from retail_sales_tb

select * from retail_sales_tb
where sale_time is null

select * from retail_sales_tb
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantiy is null
or
cogs is null
or
total_sale is null;
--data Cleaning

delete from retail_sales_tb
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantiy is null
or
cogs is null
or
total_sale is null;

-- Data Explorations
-- How Many Sales we Have?
select count(*) as total_sale from retail_sales_tb;

-- How many Uniq Customer we have:
select count(distinct customer_id)as total_sale from retail_sales_tb;

-- How many Category We Have:
select distinct category as total_sale from retail_sales_tb;

--Data Analysys And Business Key Problem  & Answer

--1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select *
from retail_sales_tb
where sale_date = '2022-11-05';


--2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
select *
from retail_sales_tb
where category = 'Clothing'
and 
to_char(sale_date,'yyyy-mm')='2022-11'
and 
quantiy >=4

--3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders from retail_sales_tb
group by 1;

--4. **Write a SQL query to find the average age of customers who purchased items from the '' category.**:
select
Round(avg(age),2) as avg_age
from retail_sales_tb
where category ='Beauty'

--5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
select * From retail_sales_tb
where total_sale >1000


--6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
select
category,
gender,
count(*)as total_trans
from retail_sales_tb
group by category,
gender
order by 1;

--7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales_tb
GROUP BY 1, 2
) as t1
WHERE rank = 1


--8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
select 
customer_id,
sum(total_sale) as total_sales
from retail_sales_tb
group by 1
order by 1
limit 5

--9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
select
category,
count(distinct customer_id) as count_uniq_cust
from retail_sales_tb
group by category

--10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
with hourly_sale
as(

select *,
case
when Extract(Hour from sale_time)<12 then'Morning'
when Extract(Hour from sale_time)Between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales_tb
)
select
shift,
count(*) as total_orders
from hourly_sale
group by shift

--End Of Project