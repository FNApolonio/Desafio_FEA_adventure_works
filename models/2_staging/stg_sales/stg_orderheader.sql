with
    order_header as (
        select
            salesorderid
            , billtoaddressid
            , customerid
            , territoryid
            , status 
            , onlineorderflag
            , creditcardid
            , subtotal
            , taxamt
            , freight
            , totaldue
            , date (orderdate) as orderdate
            , date (duedate) as duedate
            , date (shipdate) as shipdate
            , modifieddate
        from {{ source('stg_sales', 'salesorderheader') }}
    )

select *
from order_header