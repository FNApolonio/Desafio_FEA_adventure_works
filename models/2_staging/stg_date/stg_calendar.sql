with
    dimension_date  as (
        {{ dbt_date.get_date_dimension("2008-04-30", "2014-12-31")}}
    )

select *
from dimension_date