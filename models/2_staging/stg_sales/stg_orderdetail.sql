with
    sales_order_detail as (
        select
            salesorderid
            , salesorderdetailid
            , orderqty
            , productid
            , unitprice
            , unitpricediscount
            ,  COALESCE(unitprice * (1.0 - COALESCE(unitpricediscount, 0.0)) * orderqty, 0.0) as linetotal
            , modifieddate
        from {{ source('stg_sales', 'salesorderdetail') }}
    )

select *
from sales_order_detail