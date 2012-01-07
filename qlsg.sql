/*+------------------------------------------------------------------------------------------------

@q lsg /grantee/privilege/owner
: Database privileges listing

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
(/* QLSG */
select /*+ DRIVING_SITE(p) */ p.grantee, p.privilege, p.owner, p.table_name object_name
from dba_tab_privs&&2 p
union all
select /*+ DRIVING_SITE(p) */ p.grantee, p.granted_role privilege, 'ROLE' owner, '' object_name
from dba_role_privs&&2 p
union all
select /*+ DRIVING_SITE(p) */ p.grantee, p.privilege, 'SYS' owner, '' object_name
from dba_sys_privs&&2 p
/* QEND */)
select
  '/'||grantee||'/'||privilege||'/'||owner
  ||case when object_name is NULL then NULL else '/'||object_name end fqname
from q
where
  '/'||grantee||'/'||privilege||'/'||owner
  ||case when object_name is NULL then NULL else '/'||object_name end
  like upper('%/&&1%')
order by 1
;
