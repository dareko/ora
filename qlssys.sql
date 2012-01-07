/*+------------------------------------------------------------------------------------------------

@q lssys /name
: Database dictionary listing

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
(/* QLSSYS */
select /*+ DRIVING_SITE(d) */ d.table_name, d.comments
from dict&&2 d
order by d.table_name
/* QEND */)
select
  '/'||table_name fqname, comments fdesc
from q
where
  '/'||table_name like upper('%/&&1%')
  and (&&3 = 0 or rownum <= &&3)
;
