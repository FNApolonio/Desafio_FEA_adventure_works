with
    product_category as (
        select 
            productcategoryid
            , name as product_category
            , modifieddate
        from {{ source('stg_production','productcategory') }}
    )

select *
from product_category