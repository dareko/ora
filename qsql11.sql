/*-------------------------------------------------------------------------------------------------

@q sql /service/instance/user/module/profile/sql_text
: Database queries listing

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

with q as
(/* QSQL */
select /*+ DRIVING_SITE(s) */ s.service, i.instance_name, ss.parsing_schema_name, ss.module
  , ss.sql_profile, s.child_number
  , s.sql_id
  , s.last_load_time, s.last_active_time, s.fetches, s.executions
  , s.rows_processed, s.cpu_time, s.elapsed_time, s.buffer_gets, s.disk_reads, s.sorts 
  , s.loads, s.invalidations
  , s.is_bind_sensitive, s.is_bind_aware
  , s.sql_text
from gv$sql&&2 s
  join gv$instance&&2 i on i.instance_number = s.inst_id
  join gv$sqlarea&&2 ss on ss.inst_id = s.inst_id and ss.sql_id = s.sql_id
order by s.service, i.instance_name, ss.parsing_schema_name, ss.module, ss.action
  , ss.sql_profile, s.child_number
/* QEND */)
select upper('/'||service||'/'||instance_name||'/'||parsing_schema_name
             ||'/'||module||'/'||sql_profile||'/'||child_number) fqname
  , 'SQL_ID: '||sql_id info
  , 'FETCHES: '||fetches||', EXECS: '||executions
    ||', ROWS_PER_FETCH: '||rows_processed/nullif(fetches,0)
	  ||', CPU_MS: '||round(cpu_time/1000)||', ELAPSED_MS: '||round(elapsed_time/1000)
	  ||', BUFFER_GETS: ' ||buffer_gets||' DISK_READS: '||disk_reads
	  ||', SORTS: '||sorts||chr(10)
    ||'LAST_LOAD: '||last_load_time
    ||', LAST ACTIVE: '||to_char(last_active_time, 'yyyy-mm-dd/hh24:mi:ss')
    ||', LOADS: '||loads||', INVALIDATIONS; '||invalidations
    ||chr(10)||'BIND SENS./AWARE: '||is_bind_sensitive||'/'||is_bind_aware
    ||chr(10)||sql_text dsc
from q
where sql_id = '&&1'
  or (sql_text like '%&&1%' and sql_text not like '%/* Q % */%' and sql_text not like '%/* Q */%')
  and (&&3 = 0 or rownum <= &&3)
;
