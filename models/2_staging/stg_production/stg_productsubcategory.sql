with
    product_subcategory as (
        select
            productsubcategoryid
            , productcategoryid
            , name as product_subcategory
            , modifieddate
        from {{ source('stg_production', 'productsubcategory') }}
    )

select *
from product_subcategory