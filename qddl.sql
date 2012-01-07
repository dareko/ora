/*+------------------------------------------------------------------------------------------------

@q ddl /object_type/owner/name
: Database objects DDL statements

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

set long 9999
column dsc format a999 wrapped

begin
  dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', TRUE);
  dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SEGMENT_ATTRIBUTES', FALSE);
  dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'TABLESPACE', FALSE);
  dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'STORAGE', FALSE);
  dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'FORCE', FALSE);
end;
/

with q as
(/* QDDL */
select o.owner, o.object_type, o.object_name, null num_rows
from all_objects o
order by o.owner, o.object_type, o.object_name
/* QEND */)
select upper('/'||object_type||'/'||owner||'/'||object_name) fqname, num_rows info
  , dbms_metadata.get_ddl(object_type, object_name, owner) dsc
from q
where
  upper('/'||object_type||'/'||owner||'/'||object_name)
  like upper('%/&&1%')
  and (&&3 = 0 or rownum <= &&3);

set long 80
