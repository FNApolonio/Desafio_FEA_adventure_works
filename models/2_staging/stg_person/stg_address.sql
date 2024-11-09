with
    address as (
        select
            addressid
            , addressline1 as addressline
            , city
            , stateprovinceid
            , modifieddate
        from {{ source('stg_person', 'address') }}
    )

select *
from address