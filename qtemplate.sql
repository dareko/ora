-- ------------------------------------------------------------------------------------------------
-- Name         : Q
-- Description  : Quality Oracle Scripts template
-- Parameters   : 1 - fully qualified name like
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

--column string format a9
--column number format 999G999
--column null null -=null=-

--break on c1 skip page
--compute sum count of c2 on c1

select ...
from ...
where
  regexp_like('&param', '^.a{1,2}.+$', 'i');
;

--clear computes
--clear breaks
