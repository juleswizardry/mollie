/* Question 2A: create a query for a dashboard/report to track price changes.*/

select
    customer_id,
    payment_method_id,
    updated_at as pricing_updated_at,
    fixed_rate as new_fixed_rate,
    variable_rate as new_variable_rate,
    -- is null when there is no previous rate
    lag(fixed_rate) over(partition by customer_id, payment_method_id order by ends_at) as old_fixed_rate,
    lag(variable_rate) over(partition by customer_id, payment_method_id order by ends_at) as old_variable_rate
from {{ ref('int_custom_price_updates') }}
