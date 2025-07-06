-- KULTRA MEGA STORES Sql Case Study
USE DSA_db

SELECT *
FROM KMS

--- Changing the data type of Sales and Shipping_cost from float to decimal
-- Sales column alteration
ALTER TABLE KMS
ALTER COLUMN Sales decimal(18,2)

-- Shipping_cost column alteration
ALTER TABLE KMS
ALTER COLUMN Sales decimal(18,2)

---- Business Questions 
---- CASE SCENARIO 1
--- Which product category had the highest sales?
SELECT Product_category,
			 SUM(Sales) AS Total_sales 
FROM KMS
GROUP BY Product_category
ORDER BY Total_sales DESC
-- The result shows that Technology had the highest sales in the store with a value of 89,061.05


-- What are the Top 3 and Bottom 3 regions in terms of sales?
-- To get the top 3 in terms of sales
SELECT TOP 3 Region, SUM(Sales) as Total_sales
FROM KMS
GROUP BY Region
ORDER BY Total_sales DESC
-- To get the bottom 3 in terms of sales
SELECT TOP 3 Region, SUM(Sales) as Total_sales
FROM KMS
GROUP BY Region
ORDER BY Total_sales ASC
-- The top 3 regions in terms of sales are West, Ontario, and Prarie while the bottom 3 regions are Nunavut, Northwest Territories, and Yukon
	   

-- What were the total sales of appliances in Ontario?
SELECT Product_sub_category, 
	   Province, Region,
	   SUM(Sales) AS Total_sales
FROM KMS
WHERE Product_sub_category LIKE '%Appliances%' AND Province = 'Ontario' AND Region = 'Ontario'
GROUP BY Product_sub_category, Province, Region
-- The total sales of appliances in Ontario came to a total of approximately 202,347


--- Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
-- The management can engage the customers by asking for feedbacks to understand why they aren't spending more. They can also introduce loyalty points to customers to regulate their patronage and 
-- strategic discounts can also be introduced in order to re-engage the dormant customers
-- Get the top 10 customers who generated the lowest sales
SELECT DISTINCT TOP 10 Order_ID,
					   Customer_name,
					   SUM(Sales) AS Total_revenue
FROM KMS
GROUP BY Order_ID, Customer_name
ORDER BY Total_revenue ASC


--  KMS incurred the most shipping cost using which shipping method?
SELECT TOP 1 Ship_mode, SUM(Shipping_cost) AS Total_shipping_cost
FROM KMS
GROUP BY Ship_mode
ORDER BY Total_shipping_cost DESC
-- Results show that shipping via delivery truck incurred the most cost from shipping


----- CASE SCENARIO 2
-- Who are the most valuable customers, and what products or services do they typically purchase?
SELECT TOP 15 Customer_name,
			  Product_category,
			  Product_sub_category,
			  COUNT(*) AS Purchase_count,
			  SUM(Sales) AS Total_product_sales,
			  SUM(Profit) AS Total_product_profit
FROM KMS
GROUP BY Customer_name,
		 Product_category,
		 Product_sub_category
ORDER BY Purchase_count DESC,
		 Product_category


-- Which small business customer had the highest sales?
SELECT TOP 1 Customer_name, 
			 Customer_segment, 
		     MAX(Sales) AS Highest_sales
FROM KMS
WHERE Customer_segment LIKE '%Small Business%'
GROUP BY Customer_name, Customer_segment
ORDER BY Highest_sales DESC


-- 8. Which Corporate Customer placed the most number of orders in 2009 – 2012?
SELECT TOP 1 Order_date,
		     Customer_segment,
		     Customer_name,
		     SUM(Order_quantity) AS Total_order_quantity
FROM KMS
WHERE Customer_segment = 'Corporate'
GROUP BY Order_date,
		 Customer_segment, 
		 Customer_name
HAVING Order_date BETWEEN '2009-01-01' AND '2012-01-01'
ORDER BY Total_order_quantity DESC
-- The corporate consumer who made the most number of orders from 2009 - 2012 is Laurel Elliston with a total order quantity of 148


-- 9. Which consumer customer was the most profitable one?
SELECT DISTINCT TOP 1 Customer_name,
					  Customer_segment,
					  SUM(Profit) AS Total_profit
FROM KMS
GROUP BY Customer_name, Customer_segment
ORDER BY Total_profit DESC
-- The most profitable customer who is from the consumer segment is Emily Phan


-- 10. Which customer returned items, and what segment do they belong to?
SELECT DISTINCT TOP 1  k.customer_name,
					   k.order_id,
					   k.customer_segment,
					   o.status
FROM KMS k
JOIN Order_Status o ON k.Order_ID = o.Order_ID
WHERE o.status = 'Returned'
ORDER BY k.order_id DESC

-- 11. If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, 
-- do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer
SELECT Order_priority,
	   Ship_mode,
	   SUM(Shipping_cost) AS Total_shipping_cost
FROM KMS
GROUP BY Ship_mode, Order_priority
ORDER BY Total_shipping_cost DESC
-- The company's approach to shippping cost was very economical as results show that for all levels of order_priority 
-- except the medium level of priority used delivery truck as their top mode of shipping which could be as a result of customers' preference
-- due to the high cost associated with faster delivery or the company's inability to cater for large amounts of orders with high priority 
-- so while the company spent appropriately, little to no consideration was made.

