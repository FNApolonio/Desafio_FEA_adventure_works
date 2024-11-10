with
    credit_card as (
        select 
            creditcardid
            , cardtype
            , modifieddate
        from {{ source('stg_sales', 'creditcard') }}
    )

select *
from credit_card 