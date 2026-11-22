select
    payment_id,
    customer_id,
    payment_date,
    payment_method_id,
    total_volume
from {{ source('raw', 'payments') }}
