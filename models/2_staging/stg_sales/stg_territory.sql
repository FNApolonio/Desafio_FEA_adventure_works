with
    sales_territory as (
        select
            territoryid
            , name as region_name
            , countryregioncode
            , "group" as continent
            , salesytd
            , saleslastyear
            , modifieddate
        from {{ source('stg_sales', 'salesterritory') }}
    )

select *
from sales_territory