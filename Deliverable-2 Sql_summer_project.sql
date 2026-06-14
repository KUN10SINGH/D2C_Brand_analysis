-- database creation--  
create database sql_summer_project;
use sql_summer_projectcustomer_data_finalcustomer_data_final;



-- import table - customer_data_final 

-- views/ sql level query--  
create view location_analysis as 
     select Location,count(*) as total_customer,round(avg(`Loyalty Score`),3) as avg_loyalty_score,round(avg(`Customer Value Score`),3) as avg_value_score,round(avg(`Purchase Amount (USD)`),3) as avg_purchase,round(avg(`Promotion Used`)*100,3) as promotion_used_rate from customer_data_final 
     group by Location;
     
create view category_analysis as 
     select Category,count(*) as total_customer,round(avg(`Loyalty Score`),3) as avg_loyalty_score,round(avg(`Customer Value Score`),3) as avg_value_score,round(avg(`Purchase Amount (USD)`),3) as avg_purchase,round(avg(`Previous Purchases`),3) as avg_prev_purchase from customer_data_final 
     group by Category;
     
create view promotion_analysis as 
     select `Promotion Used`,count(*) as total_customer,round(avg(`Loyalty Score`),3) as avg_loyalty_score,round(avg(`Customer Value Score`),3) as avg_value_score,round(avg(`Purchase Amount (USD)`),3) as avg_purchase_score from customer_data_final 
     group by `Promotion Used`;
     
create view loyalty_value as 
     select `Customer Loyalty Type`,`Customer Value Tier`,count(*) as total_customer from customer_data_final 
     group by `Customer Loyalty Type`,`Customer Value Tier`;
     
create view seasonal_analysis as 
     select Season,count(*) as total_customer,round(avg(`Loyalty Score`),3) as avg_loyalty_score,round(avg(`Customer Value Score`),3) as avg_value_score,round(avg(`Purchase Amount (USD)`),3) as avg_purchase,round(avg(`Previous Purchases`),3) as avg_prev_purchase from customer_data_final 
     group by Season;
     
     

-- sql_questions_query

-- customer which has high value to brand
select `Customer ID`,`Customer Value Score`,`Customer Value Tier` from customer_data_final
where `Customer Value Tier` = 'High Value';

select `Customer ID`,`Customer Value Score`,`Customer Value Tier` from customer_data_final
where `Customer Value Tier` = 'Medium Value';

select `Customer ID`,`Customer Value Score`,`Customer Value Tier` from customer_data_final
where `Customer Value Tier` = 'Low Value';


-- customer with strongest repeat purchase behaviour
select `Customer ID`,`Loyalty Score`,`Customer Loyalty Type` from customer_data_final
where `Customer Loyalty Type` = 'Champion';

select `Customer ID`,`Loyalty Score`,`Customer Loyalty Type` from customer_data_final
where `Customer Loyalty Type` = 'Loyal';


-- season and category with higher tenure customers 
select * from seasonal_analysis
order by avg_prev_purchase desc;

select * from category_analysis
order by avg_prev_purchase desc;


-- season and category with lower tenure customers
select * from seasonal_analysis
order by avg_prev_purchase asc;

select * from category_analysis
order by avg_prev_purchase asc;


-- georaphies with organic demand vs discount driven volume
-- promotion dependent location 
select * from location_analysis
order by promotion_used_rate desc;
-- promotion independent location 
select * from location_analysis
order by promotion_used_rate asc;


-- ideal customer 
select Gender,ROUND(AVG(Age),2) AS Avg_Age,COUNT(*) AS Customers FROM customer_data_final
where `Ideal Customer`='Ideal Customer'
group by Gender
 