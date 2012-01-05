--+------------------------------------------------------------------------------------------------
    -- Name         : LSSYS
    -- Description  : DB data dictionary listing
    -- Parameters   : /NAME
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
(/* Q LSSYS */
select /*+ DRIVING_SITE(p) */ d.table_name, d.comments
from dict&&2 d
order by d.table_name
/* Q END */)
select
  '/'||table_name fqname, comments fdesc
from q
where
  '/'||table_name like upper('%/&&1%')
  and (&&3 = 0 or rownum <= &&3)
;
