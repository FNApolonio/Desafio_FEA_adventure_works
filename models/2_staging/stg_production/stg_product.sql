with
    product as (
        select
            productid
            , productsubcategoryid
            , name as product_name
            , listprice
            , modifieddate
        from {{ source('stg_production','product') }}
    )

select *
from  product