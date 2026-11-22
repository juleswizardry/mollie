select
    customer_id,
    country_code,
    organization_name,
    coalesce(sales_manager_id, 'N/A') as sales_manager_id,
    first_payment_date
from {{ source('raw', 'organizations') }}
