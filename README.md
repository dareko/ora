
Quality Oracle Scripts
======================

    Version 0.1
    github.com/dareko/ora

Quality Oracle Scripts is a bundle of SQL*Plus scripts for monitoring and troubleshooting
Oracle databases. For further information, see [http://www.edba.eu] [1].

This software is provided "AS IS" without warranty of any kind, express or implied.

[1]: http://www.edba.eu     "www.edba.eu"

Author
------

Dariusz Owczarek [dariusz.owczarek@edba.eu] [2]

[2]: mailto:dariusz.owczarek@edba.eu

Usage
-----

* Text Output

    @q script like_condition[@db_link][#rows_limit]

* HTML Output

    @h script like_condition[@db_link][#rows_limit]

Installation
------------

* Simply obtain a copy of ``ora`` directory, which may be located anywhere
  on your system, for example in the home directory

* Add ``ora`` directory to you SQLPATH variable:

    ``export SQLPATH="$HOME/ora"``

* Open ``$HOME/ora/login.sql`` login script and modify if needed

* (OPTIONAL) Create database links in order to query several DBs without reconnecting

* Using ``SQL*Plus``, log on as user who has ``DBA`` or ``SELECT_CATALOG_ROLE`` privileges

License and Copyright
---------------------

Copyright (c) 2007-2012 by Dariusz Owczarek. All rights reserved. 
This file is part of Quality Oracle Scripts. The Quality Oracle Scripts is
a free software; you can redistribute it and/or adapt it under the terms
of the [Creative Commons Attribution 3.0 Unported license] [3].

[3]: http://creativecommons.org/licenses/by/3.0/ "CC BY 3.0"

Scripts
-------

@q ddl /object_type/owner/name
: Database objects DDL statements


@q jobs /owner/name/subname
: Database scheduler jobs listing


@q kill /service/server/instance/user/osuser/machine
: Kill session statements


@q ls /object_type/owner/name
: Database objects listing


@q lsg /grantee/privilege/owner
: Database privileges listing


@q lsi /owner/table/index/column
: Object indexed columns listing


@q lss /owner/name
: Object statistics information


@q lssys /name
: Database dictionary listing


@q oemlsm /target_type/metric_label/column_label/metric_type
: OEM Metrics Listing


@q oemmd /metric_name/key_name
: OEM Daily Metrics


@q ps /service/server/instance/user/osuser/machine/program/status
: Database sessions listing with longops info


@q sql /service/instance/user/module/profile/sql_text
: Database queries listing
