{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "v_stg_custphone"
src_pk: "CUSTOMER_HK"
src_hashdiff: 
  source_column: "CUSTOMER_HASHDIFF"
  alias: "HASHDIFF"
src_payload:
  - "CUSTOMER_KEY"
  - "CUSTOMER_PHONE"
src_eff: "EFFECTIVE_FROM"
src_ldts: "LOAD_DATETIME"
src_source: "SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                   src_hashdiff=metadata_dict["src_hashdiff"],
                   src_payload=metadata_dict["src_payload"],
                   src_eff=metadata_dict["src_eff"],
                   src_ldts=metadata_dict["src_ldts"],
                   src_source=metadata_dict["src_source"],
                   source_model=metadata_dict["source_model"])   }}
