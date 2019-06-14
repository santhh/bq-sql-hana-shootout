/* BQ query (Standard) to find total sales by store */
with transactions as
(select distinct store_id, sum(round(order_total)) as total_orders 
 from `sap-gtm-demo-project.Merchant.sales_transactions` 
 group by store_id order by total_orders desc),
store_locations as(
  select distinct store_id, any_value(full_address) as full_address
  from Merchant.locations group by store_id
  order by store_id desc
) 
select distinct transactions.store_id, 
  concat("$",Cast(transactions.total_orders as string)) as total_orders, 
  store_locations.full_address
  from transactions
  JOIN store_locations using(store_id)
  order by total_orders desc