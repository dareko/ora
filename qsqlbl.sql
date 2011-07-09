--+------------------------------------------------------------------------------------------------
-- Name         : SQLBL
-- Description  : SQL baselines
-- Parameters   : 1 - fully qualified name like (/USER/MODULE)
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
(/* Q SQLBL */
select b.parsing_schema_name, b.module
  , b.sql_handle, b.plan_name, b.optimizer_cost
  , b.origin, b.enabled, b.accepted, b.fixed, b.autopurge
  , b.last_modified, b.last_executed, b.last_verified
  , b.sql_text
from dba_sql_plan_baselines&&2 b
order by b.parsing_schema_name, b.module
/* Q END */)
select upper('/'||parsing_schema_name||'/'||module) fqname
  , 'SQL HANDLE: '||sql_handle info
  , 'LAST ACTIVE: '||to_char(last_executed, 'yyyy-mm-dd/hh24:mi:ss')
    ||', LAST MODIFIED: '||to_char(last_modified, 'yyyy-mm-dd/hh24:mi:ss')
    ||', LAST VERIFIED: '||to_char(last_verified, 'yyyy-mm-dd/hh24:mi:ss')
    ||chr(10)||'ORIGIN: '||origin
    ||', ENA/ACC/FIX: '||enabled||'/'||accepted||'/'||fixed
    ||', AUTO PURGE: '||autopurge||', COST: '||optimizer_cost
    ||chr(10)||plan_name dsc
    --||chr(10)||sql_text dsc
from q
where (sql_handle = '&&1' or plan_name = '&&1')
  and rownum <= decode(&&3,0,rownum,&&3)
order by 1
;
