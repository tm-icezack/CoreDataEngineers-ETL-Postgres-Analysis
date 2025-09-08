select  a.id,name,b.account_id,standard_qty,gloss_qty,poster_qty,primary_poc primary_contact
from accounts a inner join orders b on a.id = b.account_id 
	wHERE (name LIKE 'C%' OR name LIKE 'W%')
  AND (
       (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
       AND primary_poc NOT LIKE '%eana%'
      )