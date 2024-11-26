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
    
    , product_subcategory as (
        select
            productsubcategoryid
            , productcategoryid
            , product_subcategory
            , modifieddate
        from {{ ref('stg_productsubcategory') }}
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
            , pc.productcategoryid
            , p.product_name
            , ps.product_subcategory
            , pc.product_category
            , p.listprice
        from
            product p
        left join
            product_subcategory ps
        on
            p.productsubcategoryid = ps.productsubcategoryid
        left join
            product_category pc
        on ps.productcategoryid = pc.productcategoryid

    ) 

select *
from joined_product