 {{ config(materialized='table') }}


WITH orders_per_day AS ( 
SELECT
date_date
,COUNT (DISTINCT orders_id) as transactions
,ROUND (SUM(revenue),2) as revenue
,ROUND (SUM(margin),2) as margin
,ROUND (SUM (operational_margin),2) as operational_margin
,ROUND (SUM (purchase_cost),2) as purchase_cost
,ROUND (SUM (ship_cost),2) as ship_cost
,ROUND (SUM (shipping_fee),2) as shipping_fee
,ROUND (SUM (logcost),2) as logcost
,SUM (quantity) as quantity
FROM {{ref("int_orders_operational")}}
GROUP BY date_date
)
SELECT
     date_date
     , revenue
     , margin
     , operational_margin
     , purchase_cost
     , shipping_fee
     , logcost
     , ship_cost
     , quantity
     , ROUND(revenue/NULLIF(nb_transactions, 0), 2) AS average_basket
 FROM orders_per_day
 ORDER BY  date_date DESC