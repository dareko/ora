/* BEGIN OVERVIEW

Quality Oracle Scripts
======================

    Version 0.1
    github.com/dareko/ora

Quality Oracle Scripts is a bundle of SQL*Plus scripts for monitoring and troubleshooting
Oracle databases. For further information, see [http://www.edba.eu] [1].

This software is provided "AS IS" without warranty of any kind, express or implied.

[1]: http://www.edba.eu     "www.edba.eu"

Author
------

Dariusz Owczarek [dariusz.owczarek@edba.eu] [2]

[2]: mailto:dariusz.owczarek@edba.eu

Usage
-----

* Text Output

    @q script like_condition[@db_link][#rows_limit]

* HTML Output

    @h script like_condition[@db_link][#rows_limit]

Installation
------------

* Simply obtain a copy of ``ora`` directory, which may be located anywhere
  on your system, for example in the home directory

* Add ``ora`` directory to you SQLPATH variable:

    ``export SQLPATH="$HOME/ora"``

* Open ``$HOME/ora/login.sql`` login script and modify if needed

* (OPTIONAL) Create database links in order to query several DBs without reconnecting

* Using ``SQL*Plus``, log on as user who has ``DBA`` or ``SELECT_CATALOG_ROLE`` privileges

END OVERVIEW */

/* BEGIN LICENSE

License and Copyright
---------------------

Copyright (c) 2007-2012 by Dariusz Owczarek. All rights reserved. 
This file is part of Quality Oracle Scripts. The Quality Oracle Scripts is
a free software; you can redistribute it and/or adapt it under the terms
of the [Creative Commons Attribution 3.0 Unported license] [3].

[3]: http://creativecommons.org/licenses/by/3.0/ "CC BY 3.0"

Scripts
-------

END LICENSE */

define q_dba_version_scripts='jobs11,sql11,kill11'

set linesize 159

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
  , decode(instr(',&&q_dba_version_scripts,'
                ,',&&1'||substr(c.value, 1, instr(c.value, '.')-1)||','), 0, '&&1'
          ,'&&1'||substr(c.value, 1, instr(c.value, '.')-1)) dba_script
  , nvl('&&q_db_link', '@'||d.property_value) db_link
from database_compatible_level&&q_db_link c, database_properties&&q_db_link d
where d.property_name = 'GLOBAL_DB_NAME';

clear columns

set termout on

spool q&&q_dba_script..sqq

prompt --------------------------------------------------------------------------------------------

prompt -- @q &&q_dba_script &&q_name_like (http://www.edba.eu)
prompt -- &&q_db_link/&&_user - &&q_dba_date
prompt --------------------------------------------------------------------------------------------

column fqname format a99 truncate
column info format a59 truncate
column dsc newline

@@q&&q_dba_script..sql "&q_name_like" "&q_db_link" "&q_limit_rows"

spool off

clear columns

undefine q_dba_version_scripts
undefine q_name_like
undefine q_db_link
undefine q_limit_rows
undefine q_dba_date
undefine q_dba_script

set feedback on
set timing on
set heading on
