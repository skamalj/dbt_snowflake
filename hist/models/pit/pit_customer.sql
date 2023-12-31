{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: hub_customer
src_pk: CUSTOMER_HK
as_of_dates_table: as_of_date
satellites: 
  sat_customeradd:
    pk:
      PK: CUSTOMER_HK
    ldts:
      LDTS: EFFECTIVE_FROM
  sat_customerphone:
    pk:
      PK: CUSTOMER_HK
    ldts:
      LDTS: EFFECTIVE_FROM
stage_tables: 
  v_stg_custadd: EFFECTIVE_FROM
  v_stg_custphone: EFFECTIVE_FROM    
src_ldts: LOAD_DATETIME
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set src_pk = metadata_dict['src_pk'] %}
{% set as_of_dates_table = metadata_dict['as_of_dates_table'] %}
{% set satellites = metadata_dict['satellites'] %}
{% set stage_tables_ldts = metadata_dict['stage_tables_ldts'] %}
{% set src_ldts = metadata_dict['src_ldts'] %}

{{ automate_dv.pit(source_model=source_model, src_pk=src_pk,
                   as_of_dates_table=as_of_dates_table,
                   satellites=satellites,
                   stage_tables_ldts=stage_tables_ldts,
                   src_ldts=src_ldts) }}
