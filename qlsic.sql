/*+------------------------------------------------------------------------------------------------

@q lsic /owner/table/index/column
: Object indexed columns listing

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
(/* QLSIC */
select /*+ DRIVING_SITE(c) */ c.table_owner, c.table_name, c.index_name, c.column_name, c.column_position
from dba_ind_columns&&2 c
order by c.table_owner, c.table_name, c.index_name, c.column_position
/* QEND */)
select
  '/'||table_owner||'/'||table_name||'/'||index_name||'/'||column_name fqname
from q
where
  '/'||table_owner||'/'||table_name||'/'||index_name||'/'||column_name
  like upper('%/&&1%')
  and (&&3 = 0 or rownum <= &&3)
;
