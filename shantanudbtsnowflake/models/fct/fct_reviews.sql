{{
    config(
        materialized='incremental',
        on_schema_change='fail'
    )
}}

WITH SRC_REVIEWS AS (
    SELECT * FROM  {{ ref('src_reviews')}}
)
SELECT * FROM SRC_REVIEWS
WHERE review_text IS NOT NULL

{% if is_incremental() %}
    AND review_date >= (select max(review_date) from {{ this }})
{% endif %}