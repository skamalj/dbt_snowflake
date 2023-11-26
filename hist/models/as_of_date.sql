{{ config(materialized='table') }}

WITH as_of_date AS (
    select effective_from from v_stg_custadd
    union
    select  effective_from  from v_stg_custphone
)

SELECT distinct effective_from  as AS_OF_DATE FROM as_of_date
