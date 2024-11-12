with
    sales_person as (
        select
            businessentityid
            , territoryid
            , salesquota
            , bonus
            , commissionpct
            , salesytd
            , saleslastyear
            , modifieddate
        from {{ source('stg_sales', 'salesperson') }}
    )

select *
from sales_person