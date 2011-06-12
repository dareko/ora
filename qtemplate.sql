-- ----------------------------------------------------------------------------
-- Description  : Selects <D>
-- Parameters   : 1 - fully qualified name like
--                2 - database link
--                3 - rows limit
-- Requirements : Access to dbms_metadata and the all views
-- ----------------------------------------------------------------------------
-- Author       : Dariusz Owczarek (mailto:darek@edba.eu)
-- Copyright    : Copyright (c) 2007-2011 Dariusz Owczarek. All rights reserved. 
--                This file is part of Quality Oracle Scripts.
--                Quality Oracle Scripts is free software;
--                you can redistribute it and/or modify it under the terms
--                of the GNU General Public License as published
--                by the Free Software Foundation; either version 2
--                of the License, or (at your option) any later version.
-- Notes        : This software is provided "AS IS" without warranty
-- 		            of any kind, express or implied.
-- ----------------------------------------------------------------------------

column string format a9
column number format 999G999

column fqname heading 'Name' format a60;
column n3 heading 'Fl' format 99;
column n9 heading 'Rows' format 999G999G999;

break on c1 skip page
compute sum count of c2 on c1

select ...
from ...
where
  regexp_like('&param', '^.a{1,2}.+$', 'i');
;

clear computes
clear breaks
clear columns
