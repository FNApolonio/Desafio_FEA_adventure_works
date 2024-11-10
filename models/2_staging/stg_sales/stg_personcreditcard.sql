with
    person_creditcard as (
        select
            businessentityid
            , creditcardid
            , modifieddate
        from {{ source('stg_sales', 'personcreditcard') }}
    )

select *
from person_creditcard