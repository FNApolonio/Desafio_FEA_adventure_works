with
    reason as (
        select
            salesreasonid
            , name as promotion_name
            , reasontype
            , modifieddate
        from {{ source('stg_sales', 'salesreason') }}
    )

select *
from reason