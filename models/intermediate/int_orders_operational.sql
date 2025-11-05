SELECT
orders_id
,date_date
,ROUND ((margin + shipping_fee-logcost-ship_cost),2) as operational_margin
,revenue
,quantity
,purchase_cost
,margin
,shipping_fee
,logcost
,ship_cost
FROM {{ref("int_orders_margin")}}
LEFT JOIN {{ref("stg_raw__ship")}}
USING (orders_id)