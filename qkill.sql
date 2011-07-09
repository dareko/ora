--+------------------------------------------------------------------------------------------------
-- Name         : KILL
-- Description  : DB sessions with kill seesion statements
-- Parameters   : 1 - fully qualified name like (/SERVICE/INSTANCE/USER/OSUSER/MACHINE)
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
(/* Q KILL */
select s.service_name, i.instance_name, decode(s.server, 'DEDICATED', s.server, 'SHARED') server
  , s.username, s.osuser, s.machine, s.program, s.status
  , s.sid, s.serial#
from gv$session&&2 s
  join gv$instance&&2 i
    on i.instance_number = s.inst_id
where s.username is not NULL and s.program not like 'oracle%' and s.program not like 'emagent%'
  and rownum <= decode(&&3,0,rownum,&&3)
order by s.service_name, i.instance_name, s.username, s.osuser, s.machine, s.program, s.status
/* Q END */)
select '-- '||upper('/'||service_name||'/'||server||'/'||instance_name||'/'||username||'/'||osuser||'/'||machine
  ||'/'||substr(program, 1, instr(translate(program, '@ ', '@@'), '@')-1)||'/'||status) fqname
  , '' info
  , 'alter system kill session '''||sid||', '||serial#||''';' dsc
from q
where
  upper('/'||service_name||'/'||server||'/'||instance_name||'/'||username||'/'||osuser||'/'||machine
  ||'/'||substr(program, 1, instr(translate(program, '@ ', '@@'), '@')-1)||'/'||status)
  like upper('%/&&1%')
order by 1
;
