{{ config(materialized= 'table') }}

with

    dim_region as (
        select
            *
        from {{ ref('dim_region') }}
    )

    , dim_credit_card as (
        select
            *
        from {{ ref('dim_credit_card') }}
    )

    , dim_customers as (
        select
            *
        from {{ ref('dim_customers') }}
    )

    , dim_reason as (
        select
            *
        from {{ ref('dim_reason') }} 
    )
    
    , dim_calendar as (
        select
            *
        from {{ ref('dim_calendar') }}
    )

    , fact_sales_header as (
        select 
            salesheader.salesorderid
            , dim_region.sk_region as fk_region
            , dim_credit_card.sk_credit_card as fk_credit_card
            , dim_customers.sk_customer as fk_customer
            , dim_calendar.sk_calendar as fk_calendar
            , ifnull(dim_reason.promotion_names_agg, 'não informado') as reason_agg
            , salesheader.orderdate
            , salesheader.duedate
            , salesheader.shipdate
            , case
                when salesheader.status = 1 then 'Em process'
                when salesheader.status = 2 then 'Aprovado'
                when salesheader.status = 3 then 'Em falta'
                when salesheader.status = 4 then 'Rejeitado'
                when salesheader.status = 5 then 'Enviado'
                when salesheader.status = 6 then 'Cancelado'
            end as order_status
            , case
                when salesheader.onlineorderflag = true then 'Online'
                when salesheader.onlineorderflag = false then 'Physical'
            end as sales_channel
            , salesheader.subtotal
            , salesheader.taxamt
            , salesheader.freight
            , salesheader.totaldue
        from {{ ref('stg_orderheader') }} as salesheader
        left join dim_region
            on salesheader.billtoaddressid = dim_region.addressid
        left join dim_credit_card 
            on salesheader.creditcardid = dim_credit_card.creditcardid
        left join dim_customers
            on salesheader.customerid = dim_customers.customerid
        left join dim_calendar
            on salesheader.orderdate = dim_calendar.date_day
        left join dim_reason
            on salesheader.salesorderid = dim_reason.salesorderid
    )

select *
from fact_sales_header