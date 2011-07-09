-- ----------------------------------------------------------------------------
-- Description  : Last query executed
-- ----------------------------------------------------------------------------

select prev_sql_id sql_id, prev_child_number child_number, prev_hash_value hash_value
from v$session 
where sid = (select sid from v$mystat where rownum = 1)
;