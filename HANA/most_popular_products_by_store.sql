/* query to find most popular products by store id*/
with product_list as (
SELECT transactions."product_id", count(transactions."product_id") as "sku"
FROM sales_transactions as transactions
where transactions."store_id" = '1230'
group by transactions."product_id",transactions."store_id"
order by "sku" desc), 
product_details as (
  select distinct (products."id"), first_value(products."item_group_id" order by products."item_group_id")as "group_id"
  from products as products
  group by products."id"
) select product_list."product_id", product_list."sku" as number_of_times_sold, product_details."group_id"
from product_list join product_details on (product_list."product_id"=product_details."id")
order by number_of_times_sold desc
