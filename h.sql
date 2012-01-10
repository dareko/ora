/*-------------------------------------------------------------------------------------------------

Usage
-----

* HTML Output

    @h script like_condition[@db_link][#rows_limit]

*/-------------------------------------------------------------------------------------------------
/* Author       : Dariusz Owczarek (mailto:dariusz.owczarek@edba.eu)
   Copyright    : Copyright (c) 2007-2012 Dariusz Owczarek. All rights reserved. 
                  This file is part of Quality Oracle Scripts.
                  The Quality Oracle Scripts is a free software;
                  you can redistribute it and/or adapt it under the terms
                  of the Creative Commons Attribution 3.0 Unported license.
   Notes        : This software is provided "AS IS" without warranty
                  of any kind, express or implied.
*/-------------------------------------------------------------------------------------------------

define q_dba_version_scripts='jobs11,sql11,kill11'

set linesize 9999

set feedback off
set timing off
set heading off

set termout off

column name_like new_value q_name_like
column db_link new_value q_db_link
column limit_rows new_value q_limit_rows

column dba_date new_value q_dba_date
column dba_script new_value q_dba_script

select /* Q */ substr('&&2', 1, instr(translate('&&2@','@#','@@'), '@') -1) name_like
  , substr('&&2', instr('&&2@', '@'), instr('&&2@#', '#') - instr('&&2@', '@')) db_link
  , nvl(substr('&&2', instr('&&2#', '#') + 1), 0) limit_rows
from dual;

select /* Q */ to_char(sysdate,'dd.mm.yyyy hh24:mi:ss') dba_date
  , decode(instr(',&&q_dba_version_scripts,', ',&&1,'), 0, '&&1'
          ,'&&1'||substr(c.value, 1, instr(c.value, '.')-1)) dba_script
  , nvl('&&q_db_link', '@'||d.property_value) db_link
from database_compatible_level&&q_db_link c, database_properties&&q_db_link d
where d.property_name = 'GLOBAL_DB_NAME';

clear columns

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

spool q&&q_dba_script..html

prompt @h &&q_dba_script &&q_name_like (<a href=http://www.edba.eu>http://www.edba.eu</a>)
prompt &&q_db_link/&&_user - &&q_dba_date
prompt <hr>

@@q&&q_dba_script..sql "&q_name_like" "&q_db_link" "&q_limit_rows"

spool off

clear columns

undefine q_dba_version_scripts
undefine q_name_like
undefine q_db_link
undefine q_limit_rows
undefine q_dba_date

set termout on
set feedback on
set timing on
set heading on

set markup HTML off SPOOL off ENTMAP on

host &_start q&&q_dba_script..html
undefine q_dba_script
