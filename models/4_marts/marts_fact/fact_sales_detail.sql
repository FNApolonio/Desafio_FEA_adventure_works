{{ config(materialized= 'table') }}

with
    
    dim_product as (
        select 
            *
        from {{ ref('dim_product')}}   
    )

    , fact_sales_detail as (
        select
            s.salesorderid
            , dp.sk_product as fk_product
            , dp.productid
            , dp.product_name
            , s.orderqty
            , s.unitprice
            , s.unitpricediscount
            , s.linetotal
        from {{ ref('stg_orderdetail')}} as s
        left join dim_product dp
        on s.productid = dp.productid
    ) 

select *
from fact_sales_detail