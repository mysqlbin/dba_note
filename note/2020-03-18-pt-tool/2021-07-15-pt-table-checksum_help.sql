[coding001@db-a ~]$ pt-table-checksum --help
pt-table-checksum performs an online replication consistency check by executing
checksum queries on the master, which produces different results on replicas
that are inconsistent with the master.  The optional DSN specifies the master
host.  The tool's L<"EXIT STATUS"> is non-zero if any differences are found, or
if any warnings or errors occur.  For more details, please use the --help
option, or try 'perldoc /usr/bin/pt-table-checksum' for complete documentation.

Usage: pt-table-checksum [OPTIONS] [DSN]

Options:

  --binary-index                   This option modifies the behavior of --
                                   create-replicate-table such that the
                                   replicate table's upper and lower boundary
                                   columns are created with the BLOB data type
  --channel=s                      Channel name used when connected to a server
                                   using replication channels
  --[no]check-binlog-format        Check that the binlog_format is the same on
                                   all servers (default yes)
  --[no]check-plan                 Check query execution plans for safety (
                                   default yes)
  --chunk-index=s                  Prefer this index for chunking tables
  --chunk-index-columns=i          Use only this many left-most columns of a --
                                   chunk-index
  --chunk-size=z                   Number of rows to select for each checksum
                                   query (default 1000)
  --chunk-time=f                   Adjust the chunk size dynamically so each
                                   checksum query takes this long to execute (
                                   default 0.5)
  --[no]create-replicate-table     Create the --replicate database and table if
                                   they do not exist (default yes)
  --disable-qrt-plugin             Disable the QRT (Query Response Time) plugin
                                   if it is enabled
  --[no]empty-replicate-table      Delete previous checksums for each table
                                   before checksumming the table (default yes)
  --float-precision=i              Precision for FLOAT and DOUBLE number-to-
                                   string conversion
  --function=s                     Hash function for checksums (FNV1A_64,
                                   MURMUR_HASH, SHA1, MD5, CRC32, etc)
  --pause-file=s                   Execution will be paused while the file
                                   specified by this param exists
  --pid=s                          Create the given PID file
  --plugin=s                       Perl module file that defines a
                                   pt_table_checksum_plugin class
  --progress=a                     Print progress reports to STDERR (default
                                   time,30)
  --quiet                      -q  Print only the most important information (
                                   disables --progress) (default 0)
  --recurse=i                      Number of levels to recurse in the hierarchy
                                   when discovering replicas
  --recursion-method=a             Preferred recursion method for discovering
                                   replicas. pt-table-checksum performs several
                                   REPLICA CHECKS before and while running (
                                   default processlist,hosts)
  --replicate=s                    Write checksum results to this table (
                                   default percona.checksums)
  --[no]replicate-check            Check replicas for data differences after
                                   finishing each table (default yes)
  --replicate-check-only           Check replicas for consistency without
                                   executing checksum queries
  --replicate-check-retries=i      Retry checksum comparison this many times
                                   when a difference is encountered (default 1)
  --replicate-database=s           USE only this database
  --resume                         Resume checksumming from the last completed
                                   chunk (disables --[no]empty-replicate-table)
  --retries=i                      Retry a chunk this many times when there is
                                   a nonfatal error (default 2)
  --run-time=m                     How long to run.  Optional suffix s=seconds,
                                   m=minutes, h=hours, d=days; if no suffix, s
                                   is used.
  --separator=s                    The separator character used for
                                   CONCAT_WS() (default #)
  --skip-check-slave-lag=d         DSN to skip when checking slave lag
  --slave-password=s               Sets the password to be used to connect to
                                   the slaves
  --slave-skip-tolerance=f         When a master table is marked to be
                                   checksumed in only one chunk but a slave
                                   table exceeds the maximum accepted size for
                                   this, the table is skipped (default 1.0)
  --slave-user=s                   Sets the user to be used to connect to the
                                   slaves
  --trim                           Add TRIM() to VARCHAR columns (helps when
                                   comparing 4.1 to >= 5.0)
  --truncate-replicate-table       Truncate the replicate table before starting
                                   the checksum
  --[no]version-check              Check for the latest version of Percona
                                   Toolkit, MySQL, and other programs (default
                                   yes)
  --where=s                        Do only rows matching this WHERE clause

Config:

  --config=A                       Read this comma-separated list of config
                                   files; if specified, this must be the first
                                   option on the command line

Connection:

  --ask-pass                       Prompt for a password when connecting to
                                   MySQL
  --defaults-file=s            -F  Only read mysql options from the given file
  --host=s                     -h  Host to connect to (default localhost)
  --password=s                 -p  Password to use when connecting
  --port=i                     -P  Port number to use for connection
  --set-vars=A                     Set the MySQL variables in this comma-
                                   separated list of variable=value pairs
  --socket=s                   -S  Socket file to use for connection
  --user=s                     -u  User for login if not current user

Filter:

  --columns=a                  -c  Checksum only this comma-separated list of
                                   columns
  --databases=h                -d  Only checksum this comma-separated list of
                                   databases
  --databases-regex=s              Only checksum databases whose names match
                                   this Perl regex
  --engines=h                  -e  Only checksum tables which use these storage
                                   engines
  --ignore-columns=H               Ignore this comma-separated list of columns
                                   when calculating the checksum
  --ignore-databases=H             Ignore this comma-separated list of databases
  --ignore-databases-regex=s       Ignore databases whose names match this Perl
                                   regex
  --ignore-engines=H               Ignore this comma-separated list of storage
                                   engines (default FEDERATED,MRG_MyISAM)
  --ignore-tables=H                Ignore this comma-separated list of tables
  --ignore-tables-regex=s          Ignore tables whose names match the Perl
                                   regex
  --tables=h                   -t  Checksum only this comma-separated list of
                                   tables
  --tables-regex=s                 Checksum only tables whose names match this
                                   Perl regex

Help:

  --help                           Show help and exit
  --version                        Show version and exit

Output:

  --explain                        Show, but do not execute, checksum queries (
                                   disables --[no]empty-replicate-table) (
                                   default 0)

Safety:

  --[no]check-replication-filters  Do not checksum if any replication filters
                                   are set on any replicas (default yes)
  --[no]check-slave-tables         Checks that tables on slaves exist and have
                                   all the checksum --columns (default yes)
  --chunk-size-limit=f             Do not checksum chunks this much larger than
                                   the desired chunk size (default 2.0)

Throttle:

  --check-interval=m               Sleep time between checks for --max-lag (
                                   default 1).  Optional suffix s=seconds, m=
                                   minutes, h=hours, d=days; if no suffix, s is
                                   used.
  --check-slave-lag=s              Pause checksumming until this replica's lag
                                   is less than --max-lag
  --max-lag=m                      Pause checksumming until all replicas' lag
                                   is less than this value (default 1s).
                                   Optional suffix s=seconds, m=minutes, h=
                                   hours, d=days; if no suffix, s is used.
  --max-load=A                     Examine SHOW GLOBAL STATUS after every
                                   chunk, and pause if any status variables are
                                   higher than the threshold (default
                                   Threads_running=25)

Option types: s=string, i=integer, f=float, h/H/a/A=comma-separated list, d=DSN, z=size, m=time

Rules:

  This tool accepts additional command-line arguments. Refer to the SYNOPSIS and usage information for details.

DSN syntax is key=value[,key=value...]  Allowable DSN keys:

  KEY  COPY  MEANING
  ===  ====  =============================================
  A    yes   Default character set
  D    no    DSN table database
  F    yes   Defaults file for connection values
  P    yes   Port number to use for connection
  S    no    Socket file to use for connection
  h    yes   Connect to host
  p    yes   Password to use when connecting
  t    no    DSN table table
  u    yes   User for login if not current user

  If the DSN is a bareword, the word is treated as the 'h' key.

Options and values after processing arguments:

  --ask-pass                       FALSE
  --binary-index                   FALSE
  --channel                        (No value)
  --check-binlog-format            TRUE
  --check-interval                 1
  --check-plan                     TRUE
  --check-replication-filters      TRUE
  --check-slave-lag                (No value)
  --check-slave-tables             TRUE
  --chunk-index                    (No value)
  --chunk-index-columns            (No value)
  --chunk-size                     1000
  --chunk-size-limit               2.0
  --chunk-time                     0.5
  --columns                        (No value)
  --config                         /etc/percona-toolkit/percona-toolkit.conf,/etc/percona-toolkit/pt-table-checksum.conf,/home/coding001/.percona-toolkit.conf,/home/coding001/.pt-table-checksum.conf
  --create-replicate-table         TRUE
  --databases                      (No value)
  --databases-regex                (No value)
  --defaults-file                  (No value)
  --disable-qrt-plugin             FALSE
  --empty-replicate-table          TRUE
  --engines                        (No value)
  --explain                        0
  --float-precision                (No value)
  --function                       (No value)
  --help                           TRUE
  --host                           localhost
  --ignore-columns                 
  --ignore-databases               
  --ignore-databases-regex         (No value)
  --ignore-engines                 FEDERATED,MRG_MyISAM
  --ignore-tables                  percona.checksums
  --ignore-tables-regex            (No value)
  --max-lag                        1
  --max-load                       Threads_running=25
  --password                       (No value)
  --pause-file                     (No value)
  --pid                            (No value)
  --plugin                         (No value)
  --port                           (No value)
  --progress                       time,30
  --quiet                          0
  --recurse                        (No value)
  --recursion-method               processlist,hosts
  --replicate                      percona.checksums
  --replicate-check                TRUE
  --replicate-check-only           FALSE
  --replicate-check-retries        1
  --replicate-database             (No value)
  --resume                         FALSE
  --retries                        2
  --run-time                       (No value)
  --separator                      #
  --set-vars                       
  --skip-check-slave-lag           (No value)
  --slave-password                 (No value)
  --slave-skip-tolerance           1.0
  --slave-user                     (No value)
  --socket                         (No value)
  --tables                         (No value)
  --tables-regex                   (No value)
  --trim                           FALSE
  --truncate-replicate-table       FALSE
  --user                           (No value)
  --version                        FALSE
  --version-check                  TRUE
  --where                          (No value)
[coding001@db-a ~]$ 
