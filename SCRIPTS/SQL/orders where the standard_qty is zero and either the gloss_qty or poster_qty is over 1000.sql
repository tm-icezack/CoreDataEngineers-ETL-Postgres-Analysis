select  a.id,name,b.account_id,standard_qty,gloss_qty,poster_qty,primary_poc primary_contact
from accounts a inner join orders b on a.id = b.account_id 
	where standard_qty is null 
	and( poster_qty > 1000
	or gloss_qty > 1000)