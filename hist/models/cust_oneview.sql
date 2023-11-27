select 
customer_key,
start_date,
lead(start_date) over (partition by customer_key order by start_date asc) as end_date,
customer_address,
customer_phone
from (
select distinct a.customer_key, p.as_of_date as start_date,
a.customer_address, b.customer_phone
from {{ref('pit_customer')}} p
INNER JOIN as_of_date d
    ON p.SAT_CUSTOMERADD_PK = d.CUSTOMER_HK and p.as_of_date = d.as_of_date
INNER JOIN sat_customeradd a
    ON p.SAT_CUSTOMERADD_PK = a.CUSTOMER_HK and p.SAT_CUSTOMERADD_LDTS = a.EFFECTIVE_FROM
LEFT OUTER JOIN sat_customerphone b
    ON p.SAT_CUSTOMERPHONE_LDTS = b.EFFECTIVE_FROM and a.CUSTOMER_HK = b.CUSTOMER_HK
order by 1 asc
)
