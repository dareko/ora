/*-------------------------------------------------------------------------------------------------

@q script like_condition
: Quality Oracle Scripts template

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

--column string format a9
--column number format 999G999
--column null null -=null=-

--break on c1 skip page
--compute sum count of c2 on c1

with q as
(/* Q<> */
select /*+ DRIVING_SITE(o) */ 
from <>&&2 o
/* QEND */)
select
  upper('/'||) fqname
  , info
  , dsc
from q
where
  upper('/'||)
  like upper('%/&&1%')
  and (&&3 = 0 or rownum <= &&3)
;

--clear computes
--clear breaks
