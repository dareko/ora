-- ----------------------------------------------------------------------------
-- Description  : SQL*Plus login script
-- ----------------------------------------------------------------------------

-- set to terminal width - 1 or 999 for unlimited horizontal scrolling in terminal
set linesize 159
set truncate on
-- your editor fo choice
define _editor="/usr/local/bin/edit -w"
-- command editing file
set editfile $HOME/tmp/afiedt.sqq
-- keep this commented out, otherwise a DBMS_OUTPUT.GET_LINES call is made
-- after all PL/SQL executions which may distort execution statistics
--set serveroutput on size unlimited

-- this makes describe command better to read and more informative
set describe depth 1 linenum on indent on

set pagesize 9999
set long 10000000
set longchunksize 10000000
set arraysize 100

set verify off
set tab off
set trimspool on
set trimout on
set numformat 999,999,999

column null NULL "-=null=-"

variable n number
variable v varchar2(4000)

alter session set nls_date_format='yyyy-mm-dd:hh24:mi:ss';
alter session set nls_timestamp_format='yyyy-mm-dd:hh24:mi:ss';

set termout off

def trc=unknown
column tracefile noprint new_value trc
select value ||'/'||(select instance_name from v$instance) ||'_ora_'||
       (select spid||case when traceid is not null then '_'||traceid else null end
              from v$process where addr = (select paddr from v$session
                                         where sid = (select sid from v$mystat
                                                    where rownum = 1
                                               )
                                    )
       ) || '.trc' tracefile
from v$parameter where name = 'user_dump_dest';

-- Tanel Poder's scripts

-- format some more columns for common DBA queries
def _start=open
def _delete="rm -f"
def _tpt_tempdir=$HOME/tmp

def _ti_sequence=0
def _tptmode=normal
def _xt_seq=0

define all='"select /*+ no_merge */ sid from v$session"'

col first_change# for 99999999999999999
col next_change# for 99999999999999999
col checkpoint_change# for 99999999999999999
col resetlogs_change# for 99999999999999999
col plan_plus_exp for a100
col value_col_plus_show_param ON HEADING  'VALUE'  FORMAT a100

-- set html format
@@tpt_public_unixmac/htmlset nowrap "&_user@&_connect_identifier report"

-- set seminar logging file

def _tpt_tempfile=sqlplus_tmpfile

col seminar_logfile new_value seminar_logfile
col tpt_tempfile new_value _tpt_tempfile

select
    to_char(sysdate, 'YYYYMMDD-HH24MISS') seminar_logfile
  , instance_name||'-'||to_char(sysdate, 'YYYYMMDD-HH24MISS') tpt_tempfile
from v$instance;

def seminar_logfile=$HOME/tmp/&_tpt_tempfile..log

-- spool sqlplus output
spool &seminar_logfile append

-- set sqlprompt "&_USER'@'&_CONNECT_IDENTIFIER> "
-- i.sql is the "who am i" script which shows your session/instance info and
-- also sets command prompt window/xterm title
@@tpt_public_unixmac/i.sql

set termout on
