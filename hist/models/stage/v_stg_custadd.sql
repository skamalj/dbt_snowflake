{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
    source: 'CUSTOMERADD'
derived_columns:
  SOURCE: "!1"
  LOAD_DATETIME: "LOAD_DATE"
  EFFECTIVE_FROM: "WM_DATE"
  CUSTOMER_NAME: "CUSTOMER_NAME"
  CUSTOMER_ADDRESS: "CUSTOMER_ADDRESS"
  CUSTOMER_KEY: "CUSTOMERKEY"
hashed_columns:
  CUSTOMER_HK: "CUSTOMERKEY"
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - "CUSTOMERKEY"
      - "CUSTOMER_NAME"
      - "CUSTOMER_ADDRESS"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=false,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
