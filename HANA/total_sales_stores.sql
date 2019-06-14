// query to find total sales / store id - total dataset size> 800GB
with transactions AS 
(select distinct transactions."store_id" as store_id, sum(round(transactions."order_total")) as "total_orders" 
 from sales_transactions as transactions
 group by transactions."store_id"
 order by "total_orders" desc),
store_locations as(
  select distinct store.store_id, first_value(store.full_address order by store.full_address) as "full_address"
  from location store
  group by store.store_id
  order by store.store_id desc) 
select distinct transactions.store_id, transactions."total_orders" as "total_orders",
store_locations."full_address"
from transactions
join store_locations on store_locations.store_id = transactions.store_id
order by transactions."total_orders" desc