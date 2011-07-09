-- ----------------------------------------------------------------------------
-- Description  : Excel output script
-- ----------------------------------------------------------------------------

set markup HTML on ENTMAP off SPOOL on TABLE "class=data" HEAD "<HTML xmlns:x='urn:schemas-microsoft-com:office:excel'>  -
<style type='text/css'> -
body          {font:8pt Arial,Helvetica,sans-serif; color: grey;} -
table.data td {mso-number-format:\@} -
table.data th {mso-number-format:General} -
</style>" -
BODY ""

spool spool.xls
set termout off
list
/
set termout on
spool off

set markup HTML off SPOOL off ENTMAP on

host &_start spool.xls
