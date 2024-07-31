
----- REVENUE BY CUSTOMER

SELECT CUS.customer_id, CUS.customer_name, CUS.customer_email, CUS.customer_phone, 
SUM(CAST(ORI.order_quantity AS INT) * CAST(ORD.order_total_price AS DECIMAL(10,2))) AS total_revenue
FROM LOADTEMP.CUSTOMER CUS
LEFT JOIN LOADTEMP.[ORDER] ORD ON CUS.customer_id = ORD.order_customer_id
LEFT JOIN LOADTEMP.ORDER_ITEM ORI ON ORD.order_id = ORI.order_id
GROUP BY CUS.customer_id, CUS.customer_name, CUS.customer_email, CUS.customer_phone
ORDER BY CUS.customer_id


----- GOODS VALUE BY INVENTORY LOCATION

SELECT INV.inventory_location, 
SUM(CAST(INV.inventory_quantity AS INT) * CAST(PRD.product_purchasing_price AS DECIMAL(10,2))) AS total_goods_value
FROM LOADTEMP.INVENTORY INV
LEFT JOIN LOADTEMP.PRODUCT PRD ON INV.inventory_product_id = PRD.product_id
GROUP BY INV.inventory_location
ORDER BY INV.inventory_location


----- AVERAGE ORDER VALUE BY CUSTOMER

SELECT CAST(AVG(CASE WHEN total_revenue IS NULL THEN 0 ELSE total_revenue END) AS DECIMAL(10,2)) AS avg_revenue_per_customer
FROM (
	SELECT CUS.customer_id, CUS.customer_name, CUS.customer_email, CUS.customer_phone, 
	SUM(CAST(ORI.order_quantity AS INT) * CAST(ORD.order_total_price AS DECIMAL(10,2))) AS total_revenue
	FROM LOADTEMP.CUSTOMER CUS
	LEFT JOIN LOADTEMP.[ORDER] ORD ON CUS.customer_id = ORD.order_customer_id
	LEFT JOIN LOADTEMP.ORDER_ITEM ORI ON ORD.order_id = ORI.order_id
	GROUP BY CUS.customer_id, CUS.customer_name, CUS.customer_email, CUS.customer_phone
     ) RD