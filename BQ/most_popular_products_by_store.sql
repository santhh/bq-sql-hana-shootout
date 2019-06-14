/* BQ query (Standard) to find most popular products by store*/
with product_list as (
select products.product_id, count(products.product_id) as sku
from `sap-gtm-demo-project.Merchant.sales_transactions` as transactions
cross join unnest(line_item) as products 
where transactions.store_id = '1230'
group by product_id,store_id
order by sku desc ), 
product_details as (
  select distinct (products.id), any_value(products.item_group_id) as group_id
  from `sap-gtm-demo-project.Merchant.products` as products
  group by id
  
) select product_list.product_id, product_list.sku as number_of_times_sold, product_details.group_id
from product_list join product_details on (product_list.product_id=product_details.id)
order by number_of_times_sold desc