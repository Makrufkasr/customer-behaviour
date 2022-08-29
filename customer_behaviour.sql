SELECT * , 
CASE WHEN customer_seq > 1 THEN 'Repeat Customer'
ELSE 'New Customer'
END AS RepeatPurchase
FROM 
(SELECT 
  EXTRACT(YEAR FROM Order_date) year,
  EXTRACT(MONTH FROM Order_date) month,
  FORMAT_DATE('%b, %Y', Order_date)month_year,
  Row_ID,
  Order_ID,
  Order_Date,
  Ship_Date,
  Ship_Mode,
  a.Customer_ID,
  Country,
  City,
  State,
  Region,
  product_name,
  category,
  sub_category,
  Sales,
  Quantity,
  Discount,
  Profit,
  RANK() OVER (PARTITION BY a.Customer_ID ORDER BY Ship_Date) AS customer_seq
FROM `makrufbinar.superstore.order` a
LEFT JOIN `makrufbinar.superstore.categories` b
ON a.Product_ID = b.product_id
LEFT JOIN `makrufbinar.superstore.customer` c
ON a.Customer_ID = c.customer_id
ORDER BY 1,2)
