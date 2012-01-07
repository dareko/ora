Rem
Rem
Rem     ______     __         ______     ______     __  __     ______     ______     __  __    
Rem    /\  == \   /\ \       /\  __ \   /\  ___\   /\ \/ /    /\  == \   /\  __ \   /\_\_\_\   
Rem    \ \  __<   \ \ \____  \ \  __ \  \ \ \____  \ \  _"-.  \ \  __<   \ \ \/\ \  \/_/\_\/_  
Rem     \ \_____\  \ \_____\  \ \_\ \_\  \ \_____\  \ \_\ \_\  \ \_____\  \ \_____\   /\_\/\_\ 
Rem      \/_____/   \/_____/   \/_/\/_/   \/_____/   \/_/\/_/   \/_____/   \/_____/   \/_/\/_/ 
Rem                                                                                            
Rem
Rem
Rem    NAME
Rem      b.sql - BlackBox customizations
Rem
Rem    AUTHOR
Rem      Dariusz Owczarek
Rem
Rem    BLACKBOX AUTHOR
Rem      Przemyslaw Piotrowski
Rem      github.com/wski/blackbox
Rem
Rem
Rem    USAGE
Rem      @b <query>[;param1=value1[;param2=value2[...]]] <filter>
Rem      
Rem      query     - name of the embedded query or any SQL enclosed with "" 
Rem                  or just any table/view
Rem      paramN    - parameter name within one of the following:
Rem                      s (sort)       - custom sort (e.g. "sid,seq#", "1,3,5", "-id")
Rem                      c (columns)    - show given columns only (with auto GROUP BY when 
Rem                                       aggregates detected)
Rem                      n (top-n)      - show only n rows of default or supplied order
Rem                                       (3/sid/-time_waited will do top-3 partitioned by sid)
Rem                      w (where)      - additional WHERE condition on aliased columns
Rem                      g (graph)      - graph given columns or expressions
Rem                      i (instance)   - show given instances only (RAC, eg. 1,2,3)
Rem                      h (humanize)   - enable readable numbers (default 'y')
Rem      valueN    - value of the parameter (optionally enclosed with double quotes)
Rem      filter    - grep expression for result grid (invisible cell separator is ;)
Rem                  ... can also be a list of IDs from ID_ alias or regular
Rem                  query "select sid from v$mystat"
Rem
Rem
Rem    DISCLAIMER
Rem      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
Rem      EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
Rem      OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
Rem      NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
Rem      HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
Rem      WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
Rem      FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
Rem      OR OTHER DEALINGS IN THE SOFTWARE. 
Rem

Rem TODO
Rem * handling wrong query name
Rem * @b mystat . as non-privileged user
Rem * ddl ???

Rem col created ???
Rem col last_ddl_time hea LAST|DDL_TIME -> ???

set buf lastsql
cl buff
i
select
  s.prev_sql_id sql_id
, s.prev_child_number child_number
, s.prev_hash_value hash_value
from
  v$session s
where
  sid = (select max(m.sid) from v$mystat m)
.

set buf tbs2
cl buff
i
select 
  tablespace_name
, tablespace_size*8192 maxbytes
, used_space*8192 bytes
, round(used_percent)||'%' pct_max
from 
  dba_tablespace_usage_metrics
order by
  tablespace_name
.

set feedback off
set timing off

@../blackbox/bx &1 &2

set feedback on
set timing on
