--+------------------------------------------------------------------------------------------------
    -- Name         : LSS
    -- Description  : DB objects statistics
    -- Parameters   : /SCHEMA/NAME
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
(/* Q LSS */
select /*+ DRIVING_SITE(o) */ o.owner, o.object_type, o.object_name
, ts.partition_name, ts.num_rows, ts.blocks, ts.avg_row_len, ts.sample_size
, ts.last_analyzed, ts.stattype_locked, ts.stale_stats
from dba_objects&&2 o
  left outer join dba_tab_statistics&&2 ts on (ts.owner = o.owner and ts.table_name = o.object_name)
where o.object_type = 'TABLE'
order by o.owner, o.object_name, ts.partition_name
/* QEND */)
select upper('/'||owner||'/'||object_name
            ||case when partition_name is NULL then NULL else '/'||partition_name end) fqname
  , to_char(last_analyzed, 'yyyy-mm-dd hh24:mi')
    ||decode(stale_stats, 'NO', '', '/STALE')
    ||case when stattype_locked is null then '' else '/LOCKED='||stattype_locked end info
  , 'ROWS: '||num_rows||', BLOCKS: '||blocks||', AVG_ROW_LENGTH: '||avg_row_len||', SAMPLE: '||sample_size dsc
from q
where
  upper('/'||owner||'/'||object_name)
  like upper('%/&&1%')
  and (&&3 = 0 or rownum <= &&3)
;
