--+------------------------------------------------------------------------------------------------
-- Name         : PS
-- Description  : DB sessions - inactive/active with longops info
-- Parameters   : 1 - fully qualified name like (/SERVICE/SERVER/INSTANCE/USER/OSUSER/MACHINE)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Author       : Dariusz Owczarek (mailto:dariusz.owczarek@edba.eu)
-- Copyright    : Copyright (c) 2007-2011 Dariusz Owczarek. All rights reserved. 
--                This file is part of Quality Oracle Scripts.
--                The Quality Oracle Scripts is a free software;
--                you can redistribute it and/or adapt it under the terms
--                of the Creative Commons Attribution 3.0 Unported license.
-- Notes        : This software is provided "AS IS" without warranty
--                of any kind, express or implied.
-- ------------------------------------------------------------------------------------------------

with q as
(/* Q PS */
select s.service_name, i.instance_name, decode(s.server, 'DEDICATED', s.server, 'SHARED') server
  , s.username, s.osuser, s.machine, s.program, s.status, s.state, s.event
  , s.sid, s.serial#
  , t.sql_id, t.sql_text, sl.opname, sl.time_remaining, sl.elapsed_seconds, sl.sofar, sl.totalwork
from gv$session&&2 s
  join gv$instance&&2 i
    on i.instance_number = s.inst_id
  left join gv$sqlarea&&2 t
    on t.sql_id = s.sql_id and t.address = s.sql_address and t.hash_value = s.sql_hash_value and t.inst_id = s.inst_id
  left join gv$session_longops&&2 sl
    on sl.sid = s.sid and sl.serial# = s.serial# and sl.inst_id = s.inst_id
       and sl.sofar != sl.totalwork
where s.username is not NULL and s.program not like 'oracle%' and s.program not like 'emagent%'
  and t.sql_text not like '%/* Q PS */%'
order by case when opname is not null then 2 when status = 'ACTIVE' then 1 else 0 end
  , s.service_name, i.instance_name, s.username, s.osuser, s.machine, s.program, s.status
/* Q END */)
select upper('/'||service_name||'/'||server||'/'||instance_name||'/'||username||'/'||osuser||'/'||machine
  ||'/'||substr(program, 1, instr(translate(program, '@ ', '@@'), '@')-1)||'/'||status) fqname
  , 'SID, SERIAL: '||sid||', '||serial# info
  , 'SQL ID: '||sql_id||', STATE: '||case state when 'WAITING' then 'WAITING' else 'CPU' end
    ||', EVENT: '||case state when 'WAITING' then event else 'cpu / run queue' end||chr(10)
    ||case
      when status = 'ACTIVE' and opname is null then
        sql_text
      when status = 'ACTIVE' and opname is not null then
        opname||': '
        ||round(time_remaining/60)||':'||mod(time_remaining,60)||' remaining'
        ||', '||round(elapsed_seconds/60)||':'||mod(elapsed_seconds,60)||' elapsed'
        ||decode(totalwork, 0, '', ', '||round(sofar/totalwork*100, 2)||' % done')
        ||chr(10)||sql_text
      else
        null
    end dsc
from q
where
  upper('/'||service_name||'/'||server||'/'||instance_name||'/'||username||'/'||osuser||'/'||machine
  ||'/'||substr(program, 1, instr(translate(program, '@ ', '@@'), '@')-1)||'/'||status)
  like upper('%/&&1%')
  and status = 'ACTIVE'
union all
select upper('/'||service_name||'/'||server||'/'||instance_name||'/'||username||'/'||osuser||'/'||machine
  ||'/'||substr(program, 1, instr(translate(program, '@ ', '@@'), '@')-1)||'/'||status) fqname
  , 'COUNT: '||count(*) info
  , null dsc
from q
where
  upper('/'||service_name||'/'||server||'/'||instance_name||'/'||username||'/'||osuser||'/'||machine
  ||'/'||substr(program, 1, instr(translate(program, '@ ', '@@'), '@')-1)||'/'||status)
  like upper('%/&&1%')
  and status != 'ACTIVE'
group by upper('/'||service_name||'/'||server||'/'||instance_name||'/'||username||'/'||osuser||'/'||machine
  ||'/'||substr(program, 1, instr(translate(program, '@ ', '@@'), '@')-1)||'/'||status)
order by 1
;
