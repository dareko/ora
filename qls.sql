/*+------------------------------------------------------------------------------------------------

@q ls /object_type/owner/name
: Database objects listing

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
(/* QLS */
select /*+ DRIVING_SITE(o) */ o.owner, o.object_type, o.object_name, o.status
  , NULL subobject_name, NULL subobject_name2
from dba_objects&&2 o
where o.object_type in
  ('TABLE'
  ,'CLUSTER'
  ,'VIEW'
  ,'SYNONYM'
  ,'SEQUENCE'
  ,'PROCEDURE'
  ,'FUNCTION'
  ,'PACKAGE'
  ,'PACKAGE BODY'
  ,'TRIGGER'
  ,'TYPE'
  ,'TYPE BODY'
  ,'LOB'
  ,'LIBRARY'
  ,'DIRECTORY'
  ,'LOB PARTITION'
  ,'LOB SUBPARTITION'
  ,'MATERIALIZED VIEW'
  ,'CONTEXT'
  ,'DATABASE LINK')
union all
select /*+ DRIVING_SITE(i) */ i.owner, 'INDEX' object_type, i.table_name object_name
  , i.status, i.index_name subobject_name, NULL subobject_name2
from dba_indexes&&2 i
union all
select /*+ DRIVING_SITE(p) */ p.table_owner, 'TABLE PARTITION' object_type
  , p.table_name object_name
  , '' status, p.partition_name subobject_name, NULL subobject_name2
from dba_tab_partitions&&2 p
union all
select /*+ DRIVING_SITE(i) */ i.table_owner, 'INDEX PARTITION' object_type
  , i.table_name object_name
  , p.status, i.index_name subobject_name, p.partition_name subobject_name2
from dba_indexes&&2 i
  join dba_ind_partitions&&2 p on p.index_name = i.index_name and p.index_owner = i.owner
union all
select /*+ DRIVING_SITE(s) */ s.table_owner, 'TABLE SUBPARTITION' object_type
  , s.table_name object_name
  , 'N/A' status, s.subpartition_name subobject_name, NULL subobject_name2
from dba_tab_subpartitions&&2 s
union all
select /*+ DRIVING_SITE(i) */ i.table_owner, 'INDEX SUBPARTITION' object_type
  , i.table_name object_name
  , s.status, i.index_name subobject_name, s.subpartition_name subobject_name2
from dba_indexes&&2 i
  join dba_ind_subpartitions&&2 s on s.index_name = i.index_name and s.index_owner = i.owner
/* QEND */)
select upper('/'||case when subobject_name is NULL then object_type else 'TABLE' end
            ||'/'||owner||'/'||object_name
            ||case when subobject_name is NULL then NULL else '/'||subobject_name end
            ||case when subobject_name2 is NULL then NULL else '/'||subobject_name2 end) fqname
  , status info
from q
where
  upper('/'||case when subobject_name is NULL then object_type else 'TABLE' end
        ||'/'||owner||'/'||object_name
        ||case when subobject_name is NULL then NULL else '/'||subobject_name end
        ||case when subobject_name2 is NULL then NULL else '/'||subobject_name2 end)
  like upper('%/&&1%')
order by 1
;
