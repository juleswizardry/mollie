/* Question 2B: show the total fee for each payment.
   As the grain of payments is one row per payment, aggregating is not necessary.
*/

select
    pay.payment_id,
    pay.total_volume,
    coalesce(custom.fixed_rate, default.fixed_rate) as total_fixed_fee, -- payment_id is a single transaction
    pay.total_volume * coalesce(custom.variable_rate, default.variable_rate) as total_variable_fee,
    total_fixed_fee + total_variable_fee as total_fee -- bigquery now also supports referencing aliases
from {{ ref('fct_payments') }} as pay
left join {{ ref('stg_custom_pricing') }} as custom
    on pay.customer_id = custom.customer_id
    and pay.payment_method_id = custom.payment_method_id
    and pay.payment_date >= custom.starts_at
    and pay.payment_date < custom.ends_at -- enddate is equal to next startdate
left join {{ ref('stg_default_pricing') }} as default
    on pay.payment_method_id = default.payment_method_id
    and pay.payment_date >= default.starts_at
    and pay.payment_date < default.ends_at
