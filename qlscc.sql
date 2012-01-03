--+------------------------------------------------------------------------------------------------
    -- Name         : LSG
    -- Description  : Constraints columns list
    -- Parameters   : 1 - fully qualified name like (/SCHEMA/TABLE/INDEX/COLUMN)
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
(/* Q LSI */
select /*+ DRIVING_SITE(p) */ c.owner, c.table_name, c.constraint_name, c.column_name, c.position
from dba_cons_columns&&2 c
/* Q END */)
select
  '/'||owner||'/'||table_name||'/'||constraint_name||'/'||column_name fqname
from q
where
  '/'||owner||'/'||table_name||'/'||constraint_name
  like upper('%/&&1%')
order by owner, table_name, constraint_name, position
;
