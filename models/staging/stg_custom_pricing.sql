select
    customer_id,
    custom_pricing_id,
    payment_method_id,
    starts_at,
    coalesce(ends_at, '9999-12-31') as ends_at,
    fixed_rate,
    variable_rate
from {{ source('raw', 'custom_pricing') }}
