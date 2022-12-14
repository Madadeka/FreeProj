create or replace view view_store_product as 
  select s.name as store, s.address, p.name as product, p.price  
  FROM public.store s 
  left join public.table_linc tl on tl.id_store = s.id 
  left join public.product p on tl.id_product = p.id 
  order by s.name