-- int_person/int_person_details.sql

with
    address as (
        select
            addressid
            , addressline
            , city
            , stateprovinceid
            , modifieddate 
        from {{ ref('stg_address') }}
    ),

    country_region as (
        select
            countryregioncode
            , country_name
            , modifieddate
        from {{ ref('stg_countryregion') }}         
    ),
    
    state_province as (
        select
            stateprovinceid
            , name_province
            , territoryid
            , stateprovincecode
            , countryregioncode
            , modifieddate
        from {{ ref('stg_stateprovince') }}
    ),

    sales_territory as (
        select
            territoryid
            , region_name
            , countryregioncode
            , continent
            , salesytd
            , saleslastyear
            , modifieddate
        from {{ ref('stg_territory') }}
    ),

    joined_region as (
        select
            a.addressid
            , a.addressline
            , a.city
            , a.stateprovinceid
            , cr.countryregioncode
            , cr.country_name
            , sp.name_province
            , sp.stateprovincecode
            , st.territoryid
            , st.region_name
            , st.continent
            , st.salesytd
            , st.saleslastyear
        from 
            address a
        left join
            state_province sp on a.stateprovinceid = sp.stateprovinceid
        left join
            country_region cr on cr.countryregioncode = sp.countryregioncode
        left join
            sales_territory st on st.territoryid = sp.territoryid
    )

select *
from joined_region