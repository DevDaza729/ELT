-- TODO: This query will return a table with the top 10 least revenue categories 
-- in English, the number of orders and their total revenue. The first column 
-- will be Category, that will contain the top 10 least revenue categories; the 
-- second one will be Num_order, with the total amount of orders of each 
-- category; and the last one will be Revenue, with the total revenue of each 
-- catgory.
-- HINT: All orders should have a delivered status and the Category and actual 
-- delivery date should be not null.

SELECT P.product_category_name_english AS Category,
		COUNT(DISTINCT P.order_id) AS Num_order,
		SUM(P.payment_value) AS Revenue
FROM (
SELECT *
FROM olist_products op
JOIN product_category_name_translation p ON p.product_category_name = op.product_category_name
JOIN olist_orders oo ON oo.order_id = ooi.order_id
JOIN olist_order_items ooi ON op.product_id = ooi.product_id
JOIN olist_order_payments oop ON oo.order_id = oop.order_id 
) AS P
WHERE P.order_status = 'delivered' AND Category IS NOT NULL AND P.order_delivered_customer_date IS NOT NULL
GROUP BY Category 
ORDER BY Revenue ASC 
LIMIT 10; 