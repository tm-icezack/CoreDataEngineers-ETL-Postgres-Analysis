/* Provide a table that shows the region for each sales rep along with
their associated accounts. 
Your final table should include three columns: the region name,
the sales rep name, and
the account name. Sort the accounts alphabetically (A-Z) by account name. */

select  distinct d.name REGION_NAME, C.NAME SALES_REP_NAME, A.NAME ACCOUNT_name
from accounts a inner join orders b on a.id = b.account_id 
inner join sales_reps c on a.sales_rep_id = c.id 
inner join region d on c.region_id = d.id
order by A.NAME asc
