USE stratacloud_db;

create or replace view vw_support_ticket_details as 
select  fst.ticket_id,  fst.customer_id,  fst.category,  fst.resolution_time_hrs, fst.csat_score,
fs.status,
dp.plan_name,
dc.company_name, dc.industry,dc.country

from fact_support_tickets fst
join fact_subscriptions fs
on fst.customer_id=fs.customer_id
join dim_plans dp
on dp.plan_id=fs.plan_id
join dim_customers dc
on dc.customer_id=fst.customer_id;


select * from vw_support_ticket_details