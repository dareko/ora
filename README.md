
Quality Oracle Scripts
======================

    Version 0.1

Quality Oracle Scripts is a bundle of SQL*Plus scripts for managing
Oracle databases. For further information, see [http://www.edba.eu] [1].

Installation
------------

  - Simply obtain a copy of ``ora`` directory, which may be located anywhere
  on your system, for example in the home directory.

  - Add ``ora`` directory to you SQLPATH variable:

        export SQLPATH="$HOME/ora"

  - Open ``$HOME/ora/login.sql`` login script and modify if needed.

  - Using ``SQL*Plus``, log on as user who has ``DBA`` or ``SELECT_CATALOG_ROLE``
  privileges.

Usage
-----

        @q <command> <condition> <db_link> <num_rows_limit>

[1]: http://www.edba.eu     "www.edba.eu"

License and Copyright
---------------------

Copyright (c) 2007-2011 Dariusz Owczarek. All rights reserved. 
This file is part of Quality Oracle Scripts. The Quality Oracle Scripts is
a free software; you can redistribute it and/or adapt it under the terms
of the [Creative Commons Attribution 3.0 Unported license] [1].

[1]: http://creativecommons.org/licenses/by/3.0/     "CC BY 3.0"
-- ------------------------------------------------------------------------------------------------
-- Scripts
----------
-- ------------------------------------------------------------------------------------------------
-- Name         : Q
-- Description  : Master script
-- Parameters   : 1 - script name
--              : 2 - fully qualified name like
--              : 3 - optional: database link
--              : 4 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : DESC
-- Description  : DB objects description
-- Parameters   : 1 - fully qualified name like (/SCHEMA/TYPE/NAME)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : DF
-- Description  : DB schema size
-- Parameters   : 1 - fully qualified name like (/SCHEMA/TYPE/NAME)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : JOBS
-- Description  : DB scheduler jobs listing
-- Parameters   : 1 - fully qualified name like (/OWNER/NAME/SUBNAME)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : KILL
-- Description  : DB sessions with kill seesion statements
-- Parameters   : 1 - fully qualified name like (/SERVICE/INSTANCE/USER/OSUSER/MACHINE)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : LS
-- Description  : DB objects list
-- Parameters   : 1 - fully qualified name like (/TYPE/SCHEMA/NAME)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : LSG
-- Description  : DB privileges list
-- Parameters   : 1 - fully qualified name like (/GRANTEE/PRIVILEGE/OWNER)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : PS
-- Description  : DB sessions - inactive/active with longops info
-- Parameters   : 1 - fully qualified name like (/SERVICE/SERVER/INSTANCE/USER/OSUSER/MACHINE)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : SQL
-- Description  : DB queries with search on sql_text (not sql_fulltext)
-- Parameters   : 1 - fully qualified name like (/SERVICE/INSTANCE/USER/MODULE/PROFILE)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : SQLBL
-- Description  : SQL baselines
-- Parameters   : 1 - fully qualified name like (/USER/MODULE)
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
-- Name         : SQLP
-- Description  : Execution plans for SQL_ID
-- Parameters   : 1 - SQL_ID
--              : 2 - optional: database link
--              : 3 - optional: rows limit
-- ------------------------------------------------------------------------------------------------
