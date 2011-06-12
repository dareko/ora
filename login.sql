-- ----------------------------------------------------------------------------
-- Description  : SQL*Plus login script
-- ----------------------------------------------------------------------------

-- set to terminal width - 1 or 999 for unlimited horizontal scrolling in terminal
set linesize 159
set truncate on
-- your editor of choice
define _editor="/usr/local/bin/edit -w"
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
