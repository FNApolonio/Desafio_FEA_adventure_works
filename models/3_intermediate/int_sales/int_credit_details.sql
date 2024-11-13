-- int_sales/int_credit_details.sql

with
    credit_card as (
        select 
            creditcardid
            , cardtype
            , modifieddate
        from {{ ref('stg_creditcard') }}
    )

    , person_creditcard as (
        select
            creditcardid
            , businessentityid
            , modifieddate
        from {{ ref('stg_personcreditcard') }}
    )

    , joined_credit_card as (
        select
            cc.creditcardid
            , coalesce (cc.cardtype, 'Not informed') as cardtype
            , pc.businessentityid
        from 
            credit_card cc
        left join
           person_creditcard pc
        on 
            cc.creditcardid = pc.creditcardid
        )

select *
from joined_credit_card