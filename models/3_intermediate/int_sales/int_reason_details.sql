-- int_sales/int_reason_details.sql

with
    sales_reason as (
        select
            salesorderid
            , salesreasonid
            , modifieddate
        from {{ ref('stg_orderheadersalesreason') }}
    )

    , reason as (
        select
            salesreasonid
            , promotion_name
            , reasontype
            , modifieddate
        from {{ ref('stg_reason') }}
    )

    , joined_reason as (
        select
            sr.salesorderid
            ,  listagg (r.promotion_name, ', ') as promotion_names_agg
            ,  listagg (r.reasontype, ', ') as reason_types_agg
        from
            sales_reason sr
        left join
            reason r
        on 
            sr.salesreasonid = r.salesreasonid
        group by
            sr.salesorderid
    )

select *
from joined_reason