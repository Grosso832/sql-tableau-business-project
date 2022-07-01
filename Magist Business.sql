# What categories of tech products does Magist have?
#   electronics, computers_accessories, computers, tablets_printing_image, telephony
# These products are just the important ones - you could count in a different way and 

#How many products of these tech categories have been sold 
#(within the time window of the database snapshot)? 
#What percentage does that represent from the overall number of products sold?

SELECT product_category_name_english, COUNT(customer_id) as ord_count
FROM orders
JOIN order_items oi
	ON orders.order_id = oi.order_id
JOIN products p
	ON oi.product_id = p.product_id
JOIN product_category_name_translation pcnt
	ON p.product_category_name = pcnt.product_category_name
WHERE product_category_name_english IN ("electronics", "computer_accessories", "computers", "tablets_printing_image", "telephony")
GROUP BY product_category_name_english
ORDER BY ord_count;

# Same without Filtering just tech-categories
SELECT product_category_name_english, COUNT(customer_id) as ord_count
FROM orders
JOIN order_items oi
	ON orders.order_id = oi.order_id
JOIN products p
	ON oi.product_id = p.product_id
JOIN product_category_name_translation pcnt
	ON p.product_category_name = pcnt.product_category_name
GROUP BY product_category_name_english
ORDER BY ord_count;

# AVG Price in General
SELECT AVG(price) AS avg_price
FROM order_items;

# AVG Price by category
SELECT product_category_name_english, AVG(price) AS avg_price
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
JOIN product_category_name_translation pcnt
	ON p.product_category_name = pcnt.product_category_name
GROUP BY product_category_name_english
ORDER BY avg_price DESC;

# AVG Price by categories: TECH / NON-TECH   "electronics", "computer_accessories", "computers", "tablets_printing_image", "telephony
# Are Tech-products popular at this platform? Answer: No, less than 7% of all sales are Tech-related products - with a lower average price (94 : 122)
SELECT
	CASE
		WHEN product_category_name_english = "electronics" THEN "Tech"
        WHEN product_category_name_english = "computer_accessories" THEN "Tech"
        WHEN product_category_name_english = "computers" THEN "Tech"
        WHEN product_category_name_english = "tablets_printing_image" THEN "Tech"
        WHEN product_category_name_english = "telephony" THEN "Tech"
        ELSE "NON-TECH"
        END AS "new_category",
        AVG(price) AS avg_price,
        COUNT(order_id) AS count_order_id
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
JOIN product_category_name_translation pcnt
	ON p.product_category_name = pcnt.product_category_name
GROUP BY new_category
ORDER BY avg_price DESC;


# How many Months are in the data base - 25 Monate und die sind wahrscheinlich nicht voll...
SELECT CONCAT(
    YEAR(order_purchase_timestamp),"_",
    MONTH(order_purchase_timestamp)) AS ye_mo,
    COUNT(*) AS count_
FROM
    orders
GROUP BY ye_mo
ORDER BY ye_mo;

#How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?


#What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?


#Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?


#DELIVERY TIME
#What’s the average time between the order being placed and the product being delivered?
#How many orders are delivered on time vs orders delivered with a delay?
#Is there any pattern for delayed orders, e.g. big products being delayed more often?



SELECT*
FROM orders;

SELECT *
FROM order_items;

SELECT *
FROM products;