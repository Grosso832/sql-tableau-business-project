-- 1. How many orders? 99441
SELECT COUNT(*)
FROM orders;

-- 2. Are Orders actually delivered?
SELECT order_status, COUNT(*) 
FROM orders;

# Count by Year/Month
SELECT 
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
    COUNT(*) AS count_
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_;

#How many Products are there?
SELECT DISTINCT COUNT(product_id), pcnt.product_category_name_english
FROM products p
JOIN product_category_name_translation pcnt
	ON p.product_category_name = pcnt.product_category_name
GROUP BY pcnt.product_category_name_english
ORDER BY COUNT(product_id) DESC
;
# Sellers per Category
SELECT DISTINCT pcnt.product_category_name_english, COUNT(s.seller_id)
FROM sellers s
JOIN order_items oi
	ON s.seller_id = oi.seller_id
JOIN products p
	ON oi.product_id = p.product_id
JOIN product_category_name_translation pcnt
	ON p.product_category_name = pcnt.product_category_name
GROUP BY pcnt.product_category_name_english
ORDER BY s.seller_id
;

# Sellers TOTAL
SELECT DISTINCT COUNT(seller_id)
FROM sellers;

SELECT DISTINCT COUNT(product_id)
FROM products;

# What’s the price for the most expensive and cheapest products?
SELECT MAX(price), MIN(price)
FROM order_items;

# What are the highest and lowest payment values?
SELECT MIN(payment_value), MAX(payment_value)
FROM order_payments;