/*-------------------------------------------------------------------------------------------------

@q jobs /owner/name/subname
: Database scheduler jobs listing

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
(/* QJOBS */
select /*+ DRIVING_SITE(j) */ owner, job_name, j.job_subname, j.job_type, j.job_action
  , j.state, j.next_run_date
  , n.recipient, n.event, n.event_flag
from dba_scheduler_jobs&&2 j
  left outer join dba_scheduler_notifications&&2 n using (owner, job_name)
order by owner, job_name, j.job_subname
/* QEND */)
select upper('/'||owner||'/'||job_name||'/'||job_subname) fqname
  , state||', NEXT: '||to_char(next_run_date, 'YYYY-MM-DD HH24:MI') info
  , job_type||': '||job_action||chr(10)||'NOTIFICATION: '||recipient||': '
    ||listagg(event, ', ') within group (order by event_flag) dsc
from q
where
  upper('/'||owner||'/'||job_name||'/'||job_subname)
  like upper('%/&&1%')
group by owner, job_name, job_subname, job_type, job_action, state, next_run_date, recipient
;
