--+------------------------------------------------------------------------------------------------
    -- Name         : LSSYS
    -- Description  : DB data dictionary listing
    -- Parameters   : 1 - fully qualified name like (/NAME)
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
(/* Q LSSYS */
select /*+ DRIVING_SITE(p) */ d.table_name, d.comments
from dict&&2 d
/* Q END */)
select
  '/'||table_name fqname, comments fdesc
from q
where
  '/'||table_name like upper('%/&&1%')
order by 1
;
