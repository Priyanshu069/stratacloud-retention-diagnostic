USE stratacloud_db;

-- Executive Lifetime Baseline(Task 1)

with account_status as (
select count(*) as total_accounts,
count(case when status='Active' then 1 end) as active_accounts,
count(case when status='Cancelled' then 1 end) as cancelled_accounts,
sum(case when status='active' then monthly_revenue else 0 end) as Active_Monthly_Recurring_Revenue,
sum(case when status='cancelled' then monthly_revenue else 0 end) as Total_Monthly_Recurring_Revenue_Lost
from fact_subscriptions
)


select total_accounts,active_accounts,cancelled_accounts,
round(
cancelled_accounts*100.0/total_accounts,2
) as logo_churn_percent,
round(
Total_Monthly_Recurring_Revenue_Lost*100.0/(Active_Monthly_Recurring_Revenue+Total_Monthly_Recurring_Revenue_Lost),2
) as revenue_churn_percent
from account_status;


-- ------------------------------------------------------
-- Root Cause Churn Analysis (Plan Tier & Discounting) (Task 2)
-- ------------------------------------------------------


select dp.plan_name,count(*) as total_accounts,
count(case when status = 'cancelled' then 1 end) as cancelled_accounts,
round(count(case when status = 'cancelled' then 1 end)*100.0/count(*),2) as churn_percentage
from fact_subscriptions fs
right join dim_plans dp
on fs.plan_id=dp.plan_id
group by dp.plan_id, dp.plan_name;



-- average discount by status

select status,round(avg(discount_pct)*100,2) as avg_discount_pct
from fact_subscriptions
group by status;


-- -----------------------------------------------
-- Task 3: Support Bottlenecks & Customer Health
-- -----------------------------------------------

-- average resolution time (hours) and average CSAT score for customers who eventually Cancelled versus those who remain Active

select fs.status,round(avg(fst.resolution_time_hrs),1) as resol_time_hrs,
round(avg(csat_score),2) as average_csat
from fact_support_tickets fst
left join fact_subscriptions fs
on fst.customer_id=fs.customer_id
group by fs.status;


-- top reported ticket categories for accounts that churned

select fst.category,count(*) as churn_ticket_count
from fact_support_tickets fst
left join fact_subscriptions fs
on fst.customer_id=fs.customer_id
where fs.status='cancelled'
group by fst.category
order by churn_ticket_count desc




