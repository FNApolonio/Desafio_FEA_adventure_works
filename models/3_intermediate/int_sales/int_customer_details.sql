-- int_sales/int_costumer_details.sql

with
    customer as (
        select
            customerid
            , personid
            , storeid
            , territoryid
            , modifieddate
        from {{ ref('stg_customer') }}
    )

    , person as (
        select 
            businessentityid
            , persontype
            , firstname
            , middlename
            , lastname
            , TRIM(CONCAT(firstname, ' ', COALESCE(middlename, ''), ' ', lastname)) AS fullname
        from {{ ref('stg_person') }}

    )

    , joined_customer as (
        select
            c.customerid
            , js.businessentityid
            , c.storeid
            , js.persontype
            , js.firstname
            , js.middlename
            , js.lastname
            , js.fullname
        from 
            customer c
        left join
            person js
        on 
            c.customerid = js.businessentityid
    )

select *
from joined_customer 