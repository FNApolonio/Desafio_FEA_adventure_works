with 
    person as (
        select 
        businessentityid
        , persontype
        , firstname
        , middlename
        , lastname
        , TRIM(CONCAT(firstname, ' ', COALESCE(middlename, ''), ' ', lastname)) AS fullname
        , 
    from {{ source('stg_person', 'person') }}
    )

select *
from person