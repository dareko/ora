--+------------------------------------------------------------------------------------------------
    -- Name         : SQLP
    -- Description  : Execution plans for SQL_ID
    -- Parameters   : 1 - SQL_ID
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
set lines 200
/* Q SQLP */
with q as
(
select s.sql_id, s.child_number, s.inst_id
from gv$sql&&2 s
order by s.sql_id, s.child_number
)
select p.plan_table_output
from q, table(dbms_xplan.display('gv$sql_plan_statistics_all', NULL, 'TYPICAL' --'ALLSTATS LAST +PEEKED_BINDS +PARTITION'
                                ,'inst_id='||q.inst_id||' and sql_id='''||q.sql_id||''''
                                 ||' and child_number='||q.child_number)) p
--table(dbms_xplan.display_cursor(sql_id, child_number, 'ALLSTATS LAST +PEEKED_BINDS +PARTITION')
where sql_id = '&&1'
order by sql_id, child_number
/* Q END */
;
