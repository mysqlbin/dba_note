


pt-osc之chunk设置
在pt-osc的帮助文档中，关于chunk的参数有如下：
--chunk-index=s Prefer this index for chunking tables

--chunk-index-columns=i Use only this many left-most columns of a --chunk-index

--chunk-size=z Number of rows to select for each chunk copied (default 1000)

--chunk-size-limit=f Do not copy chunks this much larger than the desired chunk size (default 4.0)

--chunk-time=f Adjust the chunk size dynamically so each data-copy query takes this long to execute (default 0.5)

当chunk-size和chunk-time两者都未指定时，chunk-size默认值为1000，chunk-time默认值为0.5S，第一次按照chunk-size来进行数据复制，然后根据第一次复制的时间动态调整chumk-size的大小，以适应服务器的性能变化，如上一次复制1000行消耗0.1S，则下次动态调整chumk-size为5000。
如果明确指定chumk-size的值或将chunk-time指定为0，则每次都按照chunk-size复制数据。


https://www.cnblogs.com/TeyGao/p/7160421.html  MySQL--pt-osc工具学习



[root@mgr9 ~]# pt-online-schema-change --help
pt-online-schema-change alters a table's structure without blocking reads or
writes.  Specify the database and table in the DSN.  Do not use this tool before
reading its documentation and checking your backups carefully.  For more
details, please use the --help option, or try 'perldoc
/usr/bin/pt-online-schema-change' for complete documentation.

Usage: pt-online-schema-change [OPTIONS] DSN

Options:

  --alter=s                        The schema modification, without the ALTER
                                   TABLE keywords
  --alter-foreign-keys-method=s    How to modify foreign keys so they reference
                                   the new table
  --[no]analyze-before-swap        Execute ANALYZE TABLE on the new table
                                   before swapping with the old one (default
                                   yes)
  --ask-pass                       Prompt for a password when connecting to
                                   MySQL
  --charset=s                  -A  Default character set
  --[no]check-alter                Parses the --alter specified and tries to
                                   warn of possible unintended behavior (
                                   default yes)
  --check-interval=m               Sleep time between checks for --max-lag (
                                   default 1).  Optional suffix s=seconds, m=
                                   minutes, h=hours, d=days; if no suffix, s is
                                   used.
  --[no]check-plan                 Check query execution plans for safety (
                                   default yes)
  --[no]check-replication-filters  Abort if any replication filter is set on
                                   any server (default yes)
  --check-slave-lag=s              Pause the data copy until this replica's lag
                                   is less than --max-lag
  --[no]check-unique-key-change    Avoid pt-online-schema-change to run if the
                                   specified statement for --alter is trying to
                                   add an unique index (default yes)
  --chunk-index=s                  Prefer this index for chunking tables
  --chunk-index-columns=i          Use only this many left-most columns of a --
                                   chunk-index
  --chunk-size=z                   Number of rows to select for each chunk
                                   copied (default 1000)
  --chunk-size-limit=f             Do not copy chunks this much larger than the
                                   desired chunk size (default 4.0)
  --chunk-time=f                   Adjust the chunk size dynamically so each
                                   data-copy query takes this long to execute (
                                   default 0.5)
  --config=A                       Read this comma-separated list of config
                                   files; if specified, this must be the first
                                   option on the command line
  --critical-load=A                Examine SHOW GLOBAL STATUS after every
                                   chunk, and abort if the load is too high (
                                   default Threads_running=50)
  --data-dir=s                     Create the new table on a different
                                   partition using the DATA DIRECTORY feature
  --database=s                 -D  Connect to this database
  --default-engine                 Remove ENGINE from the new table
  --defaults-file=s            -F  Only read mysql options from the given file
  --[no]drop-new-table             Drop the new table if copying the original
                                   table fails (default yes)
  --[no]drop-old-table             Drop the original table after renaming it (
                                   default yes)
  --[no]drop-triggers              Drop triggers on the old table. --no-drop-
                                   triggers forces --no-drop-old-table (default
                                   yes)
  --dry-run                        Create and alter the new table, but do not
                                   create triggers, copy data, or replace the
                                   original table
  --execute                        Indicate that you have read the
                                   documentation and want to alter the table
  --force                          This options bypasses confirmation in case
                                   of using alter-foreign-keys-method = none ,
                                   which might break foreign key constraints
  --help                           Show help and exit
  --host=s                     -h  Connect to host
  --max-flow-ctl=f                 Somewhat similar to --max-lag but for PXC
                                   clusters
  --max-lag=m                      Pause the data copy until all replicas' lag
                                   is less than this value (default 1s).
                                   Optional suffix s=seconds, m=minutes, h=
                                   hours, d=days; if no suffix, s is used.
  --max-load=A                     Examine SHOW GLOBAL STATUS after every
                                   chunk, and pause if any status variables are
                                   higher than their thresholds (default
                                   Threads_running=25)
  --new-table-name=s               New table name before it is swapped. %T is
                                   replaced with the original table name (
                                   default %T_new)
  --null-to-not-null               Allows MODIFYing a column that allows NULL
                                   values to one that doesn't allow them
  --only-same-schema-fks           Check foreigns keys only on tables on the
                                   same schema than the original table
  --password=s                 -p  Password to use when connecting
  --pause-file=s                   Execution will be paused while the file
                                   specified by this param exists
  --pid=s                          Create the given PID file
  --plugin=s                       Perl module file that defines a
                                   pt_online_schema_change_plugin class
  --port=i                     -P  Port number to use for connection
  --preserve-triggers              Preserves old triggers when specified
  --print                          Print SQL statements to STDOUT
  --progress=a                     Print progress reports to STDERR while
                                   copying rows (default time,30)
  --quiet                      -q  Do not print messages to STDOUT (disables --
                                   progress)
  --recurse=i                      Number of levels to recurse in the hierarchy
                                   when discovering replicas
  --recursion-method=a             Preferred recursion method for discovering
                                   replicas (default processlist,hosts)
  --remove-data-dir                If the original table was created using the
                                   DATA DIRECTORY feature, remove it and create
                                   the new table in MySQL default directory
                                   without creating a new isl file (default no)
  --set-vars=A                     Set the MySQL variables in this comma-
                                   separated list of variable=value pairs
  --skip-check-slave-lag=d         DSN to skip when checking slave lag
  --slave-password=s               Sets the password to be used to connect to
                                   the slaves
  --slave-user=s                   Sets the user to be used to connect to the
                                   slaves
  --sleep=f                        How long to sleep (in seconds) after copying
                                   each chunk (default 0)
  --socket=s                   -S  Socket file to use for connection
  --statistics                     Print statistics about internal counters
  --[no]swap-tables                Swap the original table and the new, altered
                                   table (default yes)
  --tries=a                        How many times to try critical operations
  --user=s                     -u  User for login if not current user
  --version                        Show version and exit
  --[no]version-check              Check for the latest version of Percona
                                   Toolkit, MySQL, and other programs (default
                                   yes)

Option types: s=string, i=integer, f=float, h/H/a/A=comma-separated list, d=DSN, z=size, m=time

Rules:

  --dry-run and --execute are mutually exclusive.
  This tool accepts additional command-line arguments. Refer to the SYNOPSIS and usage information for details.

DSN syntax is key=value[,key=value...]  Allowable DSN keys:

  KEY  COPY  MEANING
  ===  ====  =============================================
  A    yes   Default character set
  D    no    Database for the old and new table
  F    yes   Only read default options from the given file
  P    yes   Port number to use for connection
  S    yes   Socket file to use for connection
  h    yes   Connect to host
  p    yes   Password to use when connecting
  t    no    Table to alter
  u    yes   User for login if not current user

  If the DSN is a bareword, the word is treated as the 'h' key.

Options and values after processing arguments:

  --alter                          (No value)
  --alter-foreign-keys-method      (No value)
  --analyze-before-swap            TRUE
  --ask-pass                       FALSE
  --charset                        (No value)
  --check-alter                    TRUE
  --check-interval                 1
  --check-plan                     TRUE
  --check-replication-filters      TRUE
  --check-slave-lag                (No value)
  --check-unique-key-change        TRUE
  --chunk-index                    (No value)
  --chunk-index-columns            (No value)
  --chunk-size                     1000
  --chunk-size-limit               4.0
  --chunk-time                     0.5
  --config                         /etc/percona-toolkit/percona-toolkit.conf,/etc/percona-toolkit/pt-online-schema-change.conf,/root/.percona-toolkit.conf,/root/.pt-online-schema-change.conf
  --critical-load                  Threads_running=50
  --data-dir                       (No value)
  --database                       (No value)
  --default-engine                 FALSE
  --defaults-file                  (No value)
  --drop-new-table                 TRUE
  --drop-old-table                 TRUE
  --drop-triggers                  TRUE
  --dry-run                        FALSE
  --execute                        FALSE
  --force                          FALSE
  --help                           TRUE
  --host                           (No value)
  --max-flow-ctl                   (No value)
  --max-lag                        1
  --max-load                       Threads_running=25
  --new-table-name                 %T_new
  --null-to-not-null               FALSE
  --only-same-schema-fks           FALSE
  --password                       (No value)
  --pause-file                     (No value)
  --pid                            (No value)
  --plugin                         (No value)
  --port                           (No value)
  --preserve-triggers              FALSE
  --print                          FALSE
  --progress                       time,30
  --quiet                          FALSE
  --recurse                        (No value)
  --recursion-method               processlist,hosts
  --remove-data-dir                TRUE
  --set-vars                       
  --skip-check-slave-lag           (No value)
  --slave-password                 (No value)
  --slave-user                     (No value)
  --sleep                          0
  --socket                         (No value)
  --statistics                     FALSE
  --swap-tables                    TRUE
  --tries                          (No value)
  --user                           (No value)
  --version                        FALSE
  --version-check                  TRUE

  
  