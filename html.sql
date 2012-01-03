-- ----------------------------------------------------------------------------
-- Description  : HTML output for last query executed
-- ----------------------------------------------------------------------------

set markup HTML on ENTMAP off SPOOL on TABLE "class=data cellspacing=1" HEAD "<style type='text/css'> -
body          {font:8pt Arial,Helvetica,sans-serif; -
               background: white; color: grey;} -
p             {font:8pt Arial,Helvetica,sans-serif; -
               background: white; color: grey;} -
table.data    {width: 100%;} -
table.data td {padding-left: 3px; padding-right: 3px; -
               font:8pt Arial,Helvetica,sans-serif; -
               background: #E0E0E0; color: black; -
               white-space: nowrap;} -
table.data th {padding-left: 3px; padding-right: 3px; -
               font:8pt Arial,Helvetica,sans-serif; -
               background: grey; color: white;} -
</style>" -
BODY ""

set termout off

spool spool.html
list
/
spool off

set termout on

set markup HTML off SPOOL off ENTMAP on

host &_start spool.html
