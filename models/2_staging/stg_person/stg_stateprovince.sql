with
    state_province as (
        select
            stateprovinceid
            , name as name_province
            , territoryid
            , stateprovincecode
            , countryregioncode
            , modifieddate
        from {{ source('stg_person', 'stateprovince') }}
    )

select *
from state_province