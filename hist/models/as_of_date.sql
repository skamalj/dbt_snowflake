{{ config(materialized='table') }}

WITH as_of_date AS (
    select  customer_hk, effective_from from v_stg_custadd
    union
    select  customer_hk, effective_from  from v_stg_custphone
)

SELECT distinct customer_hk, effective_from  as AS_OF_DATE FROM as_of_date
