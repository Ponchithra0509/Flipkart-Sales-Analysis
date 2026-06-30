# ====================================
# Flipkart Sales Analysis Project
# SQL Portfolio Project
# Author : Ponchithra T
# Database : flipkart_project
# ====================================
CREATE DATABASE flipkart_project;
USE flipkart_project;
SELECT COUNT(*)
FROM flipkard;
DESC flipkard;
SELECT COUNT(*)
FROM flipkard
WHERE brand and price IS NULL;

# 1 How many unique product categories are available
SELECT COUNT(DISTINCT category)
FROM flipkard;

# 2 How many products are available in each category?
select count(product_name) as total_products, category 
from flipkard
group by category;

# 3 Which are the Top 5 categories with the highest number of products?
select category,count(*) as Total_products
from flipkard
group by category
order by total_products desc
limit 5;

# 4 Which are the Top 5 categories by total revenue?
select category, sum(final_price * units_sold) as total_revenue
from flipkard
group by category
order by total_revenue desc
limit 5 ;

# 5 Find the Top 5 brands by total revenue.
SELECT brand,
       SUM(final_price * units_sold) AS total_revenue
FROM flipkard
GROUP BY brand
ORDER BY total_revenue DESC
LIMIT 5; 

# 6 Find the top 5 brands by average product rating.
select brand , avg(rating) as average_product_rating
from flipkard
group by brand 
order by average_product_rating desc
limit 5;

# 7 Find the Top 5 brands that sold the highest number of units.
select brand, sum(units_sold) as total_units
    from flipkard
    group by brand 
    order by total_units desc
    limit 5;

# 8 Find the Top 5 categories with the highest average selling price.
select category , avg(final_price) as average_selling_price
from flipkard
group by category
order by average_selling_price desc
limit 5;

# 9 Find the Top 5 brands by total revenue, but only include products with a rating of 4.5 or higher.
SELECT brand,
       SUM(final_price * units_sold) AS total_revenue
FROM flipkard
WHERE rating >= 4.5
GROUP BY brand
ORDER BY total_revenue DESC
LIMIT 5;

# 10 Find all categories whose total revenue is greater than ₹10,00,00,000.
SELECT category,
       SUM(final_price * units_sold) AS total_revenue
FROM flipkard
GROUP BY category
HAVING SUM(final_price * units_sold) > 100000000
ORDER BY total_revenue DESC;

# 11 Find brands that have an average rating of at least 4.5, but only consider products whose price is greater than ₹10,000.
select brand , avg(rating) as avg_rating
from flipkard
where final_price > 10000
group by brand
having  avg(rating) >= 4.5
order by avg_rating desc;

# 12 Find the highest & lowest selling price among all products.
select category, max(final_price) as highest_selling_price from flipkard 
group by category;

select min(final_price)  AS lowest_selling_price
 from flipkard; 

# 13 Find the brand that has the highest average rating.
SELECT brand,
       AVG(rating) AS highest_rating 
FROM flipkard
GROUP BY brand
ORDER BY highest_rating DESC
LIMIT 1;

# 14 he sales manager wants a list of premium products: Rating 4.5 or above ,Final price greater than ₹20,000
select product_name, brand, final_price,rating
from flipkard
where rating >= 4.5 and final_price > 20000
order by final_price desc;

# 15 The marketing team wants products that belong to either: Electronics, Fashion
select product_name,
		brand, 
		category, 
		final_price
from flipkard
where category = "Electronics" or 
	category = "Fashion"
order by final_price desc;

# 16 Find products that satisfy: Category is Electronics OR Fashion AND Rating is 4.5 or higher
SELECT product_name,
       brand,
       category,
       rating,
       final_price
FROM flipkard
WHERE (category = 'Electronics'
       OR category = 'Fashion')
  AND rating >= 4.5
ORDER BY final_price DESC;

# 17 The finance team wants products whose selling price is between ₹10,000 and ₹50,000 (inclusive).
select product_name,
	brand,
	final_price
from flipkard
where final_price between 10000 and 50000
order by final_price;

# 18 The marketing team wants to analyze only these brands: Apple, Samsung, Sony
select product_name,
	brand,
	category,
	final_price
from flipkard 
where brand in ("Apple","Samsung","Sony")
order by brand asc;

# 19 The management team wants to analyze all products except these brands: Apple, Samsung, Sony
select product_name,
	brand,
	category,
	final_price
from flipkard 
where brand not in ("Apple","Samsung","Sony")
order by brand asc;

# 20 The marketing team wants all products whose product name starts with the letter S.
select product_name , category, brand 
from flipkard
where product_name like 's%'
order by product_name asc;

# 21 Find all products whose product name starts with S and has exactly one more char acter after S.
SELECT product_name,
       brand
FROM flipkard
WHERE product_name LIKE 'S___'
ORDER BY product_name;

# 22 Find all products where the rating is NULL.
select product_name ,brand ,rating
from flipkard
where rating is null; 

# 23 STRING FUNCTIONS 
				#UPPER
select product_name, upper(brand) as upper_brandName from flipkard
order by brand;  
				#LOWER
SELECT product_name,
       LOWER(brand) AS lower_brandName
FROM flipkard
ORDER BY brand;
				#LENGTH
SELECT product_name,
       LENGTH(product_name) AS name_length
FROM flipkard
ORDER BY name_length DESC;
				#CONCAT
select  concat(product_name ," ",brand) as product_details
from flipkard
order by  brand desc;
				#LEFT()
SELECT brand,
       LEFT(brand, 3) AS short_brand
FROM flipkard
ORDER BY brand;
				#RIGHT
select brand ,right(brand, 2) as last_two_letters from flipkard
order by brand;
				#SUBSTRING
select product_name ,substring(product_name, 1,5) as short_name from flipkard
order by product_name;

# 24 CASE WHEN
	 	# i)The CEO wants products to be categorized based on price. Rules: Final Price ≥ 50000 → Premium, 
#Final Price ≥ 20000 and < 50000 → Mid Range ,Final Price < 20000 → Budget
SELECT product_name,
       final_price,
       CASE
           WHEN final_price >= 50000 THEN 'Premium'
           WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
           ELSE 'Budget'
       END AS price_category
FROM flipkard
ORDER BY final_price DESC;

		# ii) Classify products based on rating. Rules: Rating ≥ 4.5 → Excellent,Rating ≥ 4.0 and < 4.5 → Good ,Rating < 4.0 → Average
 select product_name, rating,
case
	when rating >= 4.5 then "exellent"
    when rating >= 4.0 and rating < 4.5 then "good"
    else "average"
end as rating_category
from flipkard
order by product_name;

		# iii) The CEO wants to know how many products are in each price category.  Rules: Final Price ≥ 50000 → Premium, 
#Final Price ≥ 20000 and < 50000 → Mid Range ,Final Price < 20000 → Budget
SELECT
    CASE
        WHEN final_price >= 50000 THEN 'Premium'
        WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
        ELSE 'Budget'
    END AS price_category,
    COUNT(*) AS total_products
FROM flipkard
GROUP BY
    CASE
        WHEN final_price >= 50000 THEN 'Premium'
        WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
        ELSE 'Budget'
    END
ORDER BY total_products DESC;

		# iv) The CEO wants to know the average rating for each price category.
SELECT
    CASE
        WHEN final_price >= 50000 THEN 'Premium'
        WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
        ELSE 'Budget'
    END AS price_category,
    AVG(rating) AS avg_rating
FROM flipkard
GROUP BY
    CASE
        WHEN final_price >= 50000 THEN 'Premium'
        WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
        ELSE 'Budget'
    END
ORDER BY avg_rating DESC;

		# v) The sales manager wants to know the total revenue generated by each price category.
Select 
CASE
        WHEN final_price >= 50000 THEN 'Premium'
        WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
        ELSE 'Budget'
    END as price_category,
SUM(final_price * units_sold) as Revenue 
From Flipkard
group by 
CASE
        WHEN final_price >= 50000 THEN 'Premium'
        WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
        ELSE 'Budget'
    END
Order by revenue desc;

		# vi) The CEO wants to know only those price categories that have more than 1,000 products.
Select 
CASE
        WHEN final_price >= 50000 THEN 'Premium'
        WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
        ELSE 'Budget'
    END as price_category,
 count(*) as total_products 
From Flipkard 
Group by 
CASE
        WHEN final_price >= 50000 THEN 'Premium'
        WHEN final_price >= 20000 AND final_price < 50000 THEN 'Mid Range'
        ELSE 'Budget'
    END
Having total_products > 1000
Order by total_products desc;
 
 # 25 DATE FUNCTIONS 
		# i) Business Requirement Show: product_name ,listing_date ,listing_year
select product_name,listing_date,
		YEAR(listing_date)as listing_year
from flipkard
order by listing_year desc ;

		# ii) The marketing team wants to know which month each product was listed.
select product_name,listing_date,
		month(listing_date)as listing_month
from flipkard
order by listing_date ;

		# iii) Instead of showing the month as a number (1, 2, 3...), the manager wants the month name.
select product_name,listing_date,
		monthname(listing_date)as listing_month
from flipkard
order by listing_date desc;

		# iv) The operations team wants to know on which day of the month each product was listed.
select product_name,listing_date,
		day(listing_date)as listing_day
from flipkard
order by listing_date ;

		# v) The business team wants to know which weekday each product was listed. "On which weekday are most products listed?"
select 
		dayname(listing_date)as listing_dayname,
       COUNT(*) AS total_products
from flipkard
GROUP BY DAYNAME(listing_date)
ORDER BY total_products DESC;

		# vi) The CEO wants to know how many products were listed in each year.
select 
		year(listing_date)as listing_year,
       COUNT(*) AS total_products
from flipkard
GROUP BY year(listing_date)
ORDER BY listing_year;

		# vii) Which month had the highest number of product listings?
select count(*) as total_product,
		monthname(listing_date) as listing_month
from flipkard
group by  monthname(listing_date)
order by total_product desc
limit 1;

select product_name, date_format(listing_date, '%d %M %Y') as formatted_date
from flipkard;

			#SUBQUERY
	# 26 SCALER SUBQUERY
#i) The CEO wants to see all products whose final_price is greater than the average final_price of all products.
select product_name, brand , final_price
from flipkard 
where final_price > (select avg(final_price) from flipkard) ;

# ii) Find products whose rating is greater than the average rating.
select product_name, brand , rating
from flipkard 
where rating > (select avg(rating) from flipkard);

# iii) Find the products whose final_price is equal to the highest final_price.
select product_name, brand , final_price
from flipkard 
where final_price = (select max(final_price) from flipkard);

	# 27 MULTI-ROW SUBQUERY
# i) Find all products that belong to the categories which have at least one product with a rating of 5.
	select product_name, category , rating
	from flipkard
	where category in (select category  from flipkard
	where rating = 5);
    
# ii) Find all products whose brand is one of the brands that has at least one product priced above ₹50,000.
select product_name, brand , final_price
from flipkard
where brand in (select brand from flipkard
where final_price > 50000) ;

# iii) Find all products whose category has at least one product with more than 10,000 units sold.
select category, product_name, units_sold
from flipkard
where category in ( select category from flipkard 
where units_sold > 4000);

	# 28 CORRELATED SUBQUERY
# i) Find the most expensive product in each category.
select category , product_name, final_price
from flipkard f1
where final_price = ( select max(final_price) from flipkard f2
where f1.category = f2.category);

# ii) Find the highest-rated product in each brand.
select brand , product_name, rating
from flipkard f1
where rating = ( select max(rating) from flipkard f2
where f1.brand = f2.brand);

# iii) Find the lowest-priced product in each category.
select category , product_name, final_price
from flipkard f1
where final_price = ( select min(final_price) from flipkard f2
where f1.category = f2.category);

# iv) Find the products whose price is greater than the average price of their own category.
select category , product_name, final_price
from flipkard f1
where final_price > ( select avg(final_price) from flipkard f2
where f1.category = f2.category);

	# COMMON TABLE EXPRESSION (CTE)
# 29  SIMPLE CTE 
# The manager wants to calculate the total revenue for each category and then display only the categories where revenue is greater than ₹100,000,000.
WITH category_revenue AS (
    SELECT category,
           SUM(final_price * units_sold) AS total_revenue
    FROM flipkard
    GROUP BY category
)
SELECT *
FROM category_revenue
WHERE total_revenue > 100000000
ORDER BY total_revenue DESC;
 
# Create a CTE named brand_rating.Inside the CTE calculate: brand ,AVG(rating) as avg_rating. Then, from the CTE:Show only brands where avg_rating >= 3
with brand_rating as (
select brand, avg(rating) as avg_rating 
from flipkard
group by brand)
select brand, avg_rating
from brand_rating 
where avg_rating >=3
order by avg_rating desc ;

# Create a CTE named category_sales. Inside the CTE calculate: category, SUM(units_sold) as total_units. 
	#Then display only the Top 3 categories based on total_units.
with category_sales as (
  select category , sum(units_sold) as total_units
  from flipkard 
  group by category)
  select category,total_units
  from category_sales
  order by total_units desc
  limit 3;

		# 30 MULTIPLE CTE
# The manager wants a report showing:Each category,Total revenue,Average rating
with category_revenue as(
select category, sum(final_price* units_sold) as total_revenue 
from flipkard
group by category),
category_rating as(
select category, avg(rating) as avg_rating
from flipkard 
group by category)
select cr.category ,  cr.total_revenue , cra.avg_rating 
from category_revenue cr
join  category_rating cra 
on cr.category=cra.category
order by cr.total_revenue desc;

		# WINDOW FUNCTION
	# 31 ROW NUMBER()
# The manager wants to assign a unique rank to every product based on final_price from highest to lowest.
select row_number() over(order by final_price desc) as unique_rank,
 product_name, brand, final_price
from flipkard;

	# 32 RANK()
# The manager wants to rank products by final_price.
select rank() over(order by final_price desc) as rank_by_finalProducts,
product_name,final_price
from flipkard;

	# 33 DENSE_RANK()
#Rank the products based on final_price.If two products have the same price, they should receive the same rank.
select DENSE_RANK()over(order by final_price desc) as price_rank,
 product_name, brand, final_price
from flipkard;

	# 34 PARTITION BY
#The manager wants to rank products within each category based on final_price.
select row_number() over (partition by category 
order by final_price desc
) as category_rank ,
product_name, category,final_price
from flipkard;

		#JOIN
 #35 SELF JOIN
# Find pairs of products belonging to the same category.
SELECT f1.product_name AS product1,
       f2.product_name AS product2,
       f1.category
FROM flipkard f1
JOIN flipkard f2
ON f1.category = f2.category
AND f1.product_id <> f2.product_id;

