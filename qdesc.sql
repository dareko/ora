--+------------------------------------------------------------------------------------------------
-- Name         : DESC
-----------------
-- Description  : DB objects description
-----------------
-- Parameters   :
-----------------
--              : 1 - fully qualified name like (/SCHEMA/TYPE/NAME)
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

set long 9999
column dsc format a999 wrapped

begin
   dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR',TRUE);
   dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SEGMENT_ATTRIBUTES',FALSE);
   dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'TABLESPACE',FALSE);
   dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'STORAGE',FALSE);
   dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'FORCE',FALSE);
end;
/

with q as
(/* QLSX */
select o.owner, o.object_type, o.object_name
  , null num_rows
from all_objects o
order by o.owner, o.object_type, o.object_name
/* QEND */)
select upper('/'||owner||'/'||object_type||'/'||object_name) fqname
  , num_rows info
  , dbms_metadata.get_ddl(object_type, object_name, owner) dsc
from q
where
  upper('/'||owner||'/'||object_type||'/'||object_name)
  like upper('%/&&1%')
  and rownum <= decode(&&3,0,rownum,&&3);

set long 80
