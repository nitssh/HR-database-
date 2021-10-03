## TASK 1

# This database contains Sales details of transaction of a superstore. 
# It  has 5 tables, namely cust_dimen (containing details about 
# customer and their respective locations), prod_dimen (containing 
# product category and their subcategories), orders_dimen (with order no,
# date, and priority), shipping_dimen (with ship date, order and shipping 
# mode), and market_fact (orderwise customerwise marketwise orderquantity, 
# sales value, discount profit and shipping cost details).

# The tables in this database can help in making decisions regarding sales ,
# segment etc   by running some queries according to our convenience 
# using market_fact we can derive various insights which will help us  to 
# understand data in better way  

# Base Tables
# 1. cust_dimen - Cust_id as Primary Key, no foreign key
# 2. prod_dimen - Prod_id as Primary Key, no foreign key 
# 3. orders_dimen - Ord_id as Primary Key, although Order_ID is also there but 
#	it is advisable to use Ord_id as primary Key to ensure relationship consistency. 
#	But Order_ID will as foreign key in shipping_dimen will help retrieve the details
# 4. shipping_dimen - Shipping id as primary key and Order_ID as foreign key.
# 5. market_fact - Ord_id, Prod_id, Ship_id and Cust_id as foreign key. No Primary Key.


#Task 2 - Basic & Advanced Analysis 

create database superstore 

# Query 1
select customer_name as "Customer Name" , Customer_Segment as "Customer Segment" from superstore.cust_dimen

#Query 2
select * from superstore.cust_dimen order by customer_name desc

#Query 3 
select order_id,order_date from superstore.orders_dimen where order_priority = "high" 

#Query 4
select round(sum(Sales),2) as "TOTAL SALES", Round(avg(Sales),2) as "AVERAGE SALES" from market_fact;

#Query 5
select max(sales), min(sales) from market_fact

#Query 6
select Region, count(Cust_id) as "No. of Customers" from cust_dimen group by Region order by count(Cust_id);

#Query 7
select region, count(cust_id) as "No. of customers" from cust_dimen group by Region order by count(Cust_id) desc limit 1;

#Query 8 
select c.Region as "Region", c.Customer_Name as "Customer Name", 
		p.Product_Sub_Category as "Product Sub Category", 
        sum(m.Order_Quantity) as "Order Quantity"
from market_fact m 
		join cust_dimen c on m.Cust_id = c.Cust_id
        join prod_dimen p on m.Prod_id = p.Prod_id
where c.Region = "ATLANTIC" and p.Product_Sub_Category = "TABLES"
group by c.Customer_Name
Order by sum(m.Order_Quantity) DESC;

#Query 9
select  customer_name as " Customer name " , Customer_Segment as "No of small businees" 
from cust_dimen where Province ="ontario" and Customer_Segment = "small business"

#Query 10 
select Prod_id , sum(Order_Quantity) as "no. of products sold"
from market_fact group by Prod_id order by sum(Order_Quantity) desc;

#Query 11
select prod_id, product_sub_category from superstore.prod_dimen 
where product_category = 'furniture' or product_category = 'technology';

#Query 12
select p.Product_Category as "Product Category", round(sum(m.Profit), 2) as "Profits"
from market_fact m 
        join prod_dimen p on m.Prod_id = p.Prod_id
group by p.Product_Category
Order by sum(m.Profit) DESC;

#Query 13
select p.Product_Category as "Product Category", p.Product_Sub_Category as "Product Sub Category",
		round(sum(m.Profit), 2) as "Total Profits"
from market_fact m 
        join prod_dimen p on m.Prod_id = p.Prod_id
group by p.Product_Sub_Category
Order by p.Product_Category;

#Query 14
select o.order_date, m.order_quantity, m.sales 
from superstore.market_fact as m join superstore.orders_dimen as o on m.ord_id = o.ord_id order by o.order_date;

# Query 15. 
select customer_name from superstore.cust_dimen 
where instr(customer_name, 'r') = 2 and instr(customer_name, 'd') = 4;


# Query 16. 
select m.cust_id as cust_id, m.sales as sales, c.customer_name as customer_name, c.region as region from superstore.market_fact as m
join superstore.cust_dimen as c on m.cust_id = c.cust_id
where m.sales between 1000 and 5000;


# Query 17. 
select * from(select sales, dense_rank() over(order by sales desc) 
as r from superstore.market_fact) sub where r = 3;


#Query 18 
select c.Region as "Region",count(m.Ship_id) as "No of Shipments", 
		round(sum(m.Profit),2) as "Profit in each region"
from market_fact m 
		join cust_dimen c on m.Cust_id = c.Cust_id
        join prod_dimen p on m.Prod_id = p.Prod_id
Where Product_Sub_Category = (
				Select p.Product_Sub_Category 
				from market_fact m 
					join prod_dimen p on m.Prod_id = p.Prod_id
					group by Product_Sub_Category
					order by sum(m.Profit)
					LIMIT 1) 
group by c.Region
order by sum(m.Profit);