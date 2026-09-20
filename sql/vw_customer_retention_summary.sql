USE stratacloud_db;  

create or replace view vw_customer_retention_summary as 
select dc.customer_id, dc.company_name, dc.industry, dc.country,

dp.plan_name, dp.monthly_fee AS base_plan_price,

fs.start_date, fs.end_date, fs.status, fs.monthly_revenue, fs.discount_pct,

coalesce(st.total_tickets,0) as total_tickets, st.avg_resolution_time_hrs, st.avg_csat

from fact_subscriptions fs 
join dim_customers dc on fs.customer_id=dc.customer_id
join dim_plans dp on fs.plan_id=dp.plan_id
left join
(
SELECT 
    customer_id,
    COUNT(ticket_id) AS total_tickets,
    ROUND(AVG(resolution_time_hrs), 1) AS avg_resolution_time_hrs,
    ROUND(AVG(csat_score), 2) AS avg_csat
FROM fact_support_tickets
GROUP BY customer_id
)st
on fs.customer_id=st.customer_id;



select * from vw_customer_retention_summary
