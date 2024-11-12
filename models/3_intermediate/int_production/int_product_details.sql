-- int_production/int_product_details.sql

with
    product as (
        select
            productid
            , productsubcategoryid
            , product_name
            , listprice
            , modifieddate
        from {{ ref('stg_product') }}
    )
    
    , product_category as (
        select 
            productcategoryid
            , product_category
            , modifieddate
        from {{ ref('stg_productcategory') }}
    )

    , joined_product as (
        select
            p.productid
            , p.productsubcategoryid
            , p.product_name
            , p.listprice
            , pc.product_category
        from
            product p
        left join
            product_category pc
        on
            p.productsubcategoryid = pc.productcategoryid
    ) 

select *
from joined_product




