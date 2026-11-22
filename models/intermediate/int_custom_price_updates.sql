{{
  config (
    materialized = 'incremental',
    incremental_strategy = 'append'
  )
}}

/* By snapshotting changes to the custom prices data, version tracking can be enabled.
   The simplest approach is appending new records. Depending on the nature of updates to the source data,
   more sophisticated strategies like merging using a unique key can be employed.
*/

select
    -- {{ dbt_utils.generate_surrogate_key(['customer_id','custom_pricing_id','starts_at', 'ends_at']) }} as update_key,
    customer_id,
    custom_pricing_id,
    payment_method_id,
    starts_at,
    ends_at,
    iff(ends_at='9999-12-31', true, false) as is_current,
    fixed_rate,
    variable_rate,
    current_timestamp as updated_at
from {{ ref('stg_custom_pricing') }}
