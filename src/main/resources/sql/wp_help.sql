select wp.ID, 
	wp.post_title as name, 
	wp.post_content as title, 
	wp.post_excerpt as second_title, 
 (SELECT meta_value FROM wp_postmeta WHERE post_id = wp.ID and meta_key = '_price' limit 1) as price,
 (SELECT name FROM wp_term_relationships wtr 
    left join  wp_term_taxonomy wtt on  wtt.term_id = wtr.term_taxonomy_id 
    left join wp_terms wt on wt.term_id =  wtt.term_taxonomy_id 
  where object_id =wp.ID  and taxonomy like 'product_cat' limit 1) as category
from wp_posts wp 
where wp.post_type like 'product'  	and post_content like '%FTP%'
	or  wp.post_type like 'product_variation' 
	and post_content like '%FTP%'
	limit 100


select 
	p.id,
	p.post_author,
	p.post_date,
	p.post_status,
	(select meta_value from  wp_postmeta pm where pm.post_id = p.ID and pm.meta_key  = '_billing_address_index') as details
	(select meta_value from  wp_postmeta pm where pm.post_id = p.ID and pm.meta_key  = '_billing_first_name' 
	   ||' '||select meta_value from  wp_postmeta pm where pm.post_id = p.ID and pm.meta_key  = '_billing_last_name' ) as full_name

	/*'_billing_first_name' 
	'_billing_last_name'
	'_billing_phone'*/
from wp_posts p where post_type ="shop_order"


select * from 	wp_posts where post_date > '2020-09-03 22:09:39.0'

select * from  wp_postmeta  where post_id = 2877

select * from wp_woocommerce_order_items where order_id = 2877

select * from wp_woocommerce_order_itemmeta where order_item_id = 10


	2020-09-03 23:09:39.0
	
	
	
SELECT * FROM wp_term_relationships wtr where object_id =2157

SELECT * FROM wp_term_taxonomy wtt  where  term_id =153 and taxonomy like 'product_cat'


SELECT * FROM wp_terms wtt where term_id =3

SELECT * FROM wp_postmeta WHERE post_id =2157 and meta_key = '_price' limit 1

 SELECT * FROM wp_posts WHERE post_type = 'product' 
 

 SELECT name FROM wp_term_relationships wtr 
 left join  wp_term_taxonomy wtt on  wtt.term_id = wtr.term_taxonomy_id 
 left join wp_terms wt on wt.term_id =  wtt.term_taxonomy_id 
 where object_id =2157  and taxonomy like 'product_cat'
 

  SELECT wp_get_post_meta(2873, '_price') 
  
  select * from wp_woocommerce_order_itemmeta
  
    select * from wp_woocommerce_order_itemmeta