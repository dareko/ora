-- ----------------------------------------------------------------------------
-- Description  : SQL*Plus login script
-- ----------------------------------------------------------------------------

-- set to terminal width - 1 or 999 for unlimited horizontal scrolling in terminal
set linesize 159
-- your editor of choice
define _editor = "/usr/local/bin/edit -w"
set editfile $HOME/tmp/afiedt.sqq
-- def _start = start   -- Windows
-- def _start = firefox -- Unix/Linux
def _start = open -- MacOS
-- keep this commented out, otherwise a DBMS_OUTPUT.GET_LINES call is made
-- after all PL/SQL executions which may distort execution statistics
--set serveroutput on size unlimited

-- this makes describe command better to read and more informative
set describe depth 1 linenum on indent on

set pagesize 9999
set long 10000000
set longchunksize 10000000
set arraysize 100

--disable displaying replacement of substitution variables
set verify off
-- disable paging results
set pause off
set tab off
set trimspool on
set trimout on

variable n number
variable v varchar2(4000)

column object_name format a30
column table_name format a30
column view_name format a30
column column_name format a30
column index_name format a30
column tablespace_name format a30

set termout off
set feedback off

def _instance_name = &&_connect_identifier
col instance_name new_value _instance_name
select upper(instance_name) instance_name from v$instance;
!echo -ne "\033]0;&_instance_name/&_user\007"

alter session set nls_date_format='yyyy-mm-dd:hh24:mi:ss';
alter session set nls_timestamp_format='yyyy-mm-dd:hh24:mi:ss';

set termout on
set feedback on
set timing on
