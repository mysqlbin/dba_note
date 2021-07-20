[coding001@db-a ~]$ pt-table-sync --help
pt-table-sync synchronizes data efficiently between MySQL tables.  For more
details, please use the --help option, or try 'perldoc /usr/bin/pt-table-sync'
for complete documentation.

Usage: pt-table-sync [OPTIONS] DSN [DSN]

Options:

  --algorithms=s            Algorithm to use when comparing the tables, in
                            order of preference (default Chunk,Nibble,GroupBy,
                            Stream)
  --ask-pass                Prompt for a password when connecting to MySQL
  --bidirectional           Enable bidirectional sync between first and
                            subsequent hosts
  --[no]bin-log             Log to the binary log (SET SQL_LOG_BIN=1) (default
                            yes)
  --buffer-in-mysql         Instruct MySQL to buffer queries in its memory
  --[no]buffer-to-client    Fetch rows one-by-one from MySQL while comparing (
                            default yes)
  --channel=s               Channel name used when connected to a server using
                            replication channels
  --charset=s           -A  Default character set
  --[no]check-child-tables  Check if --execute will adversely affect child
                            tables (default yes)
  --[no]check-master        With --sync-to-master, try to verify that the
                            detected master is the real master (default yes)
  --[no]check-slave         Check whether the destination server is a slave (
                            default yes)
  --[no]check-triggers      Check that no triggers are defined on the
                            destination table (default yes)
  --chunk-column=s          Chunk the table on this column
  --chunk-index=s           Chunk the table using this index
  --chunk-size=s            Number of rows or data size per chunk (default 1000)
  --columns=a           -c  Compare this comma-separated list of columns
  --config=A                Read this comma-separated list of config files; if
                            specified, this must be the first option on the
                            command line
  --conflict-column=s       Compare this column when rows conflict during a --
                            bidirectional sync
  --conflict-comparison=s   Choose the --conflict-column with this property as
                            the source
  --conflict-error=s        How to report unresolvable conflicts and conflict
                            errors (default warn)
  --conflict-threshold=s    Amount by which one --conflict-column must exceed
                            the other
  --conflict-value=s        Use this value for certain --conflict-comparison
  --databases=h         -d  Sync only this comma-separated list of databases
  --defaults-file=s     -F  Only read mysql options from the given file
  --dry-run                 Analyze, decide the sync algorithm to use, print
                            and exit
  --engines=h           -e  Sync only this comma-separated list of storage
                            engines
  --execute                 Execute queries to make the tables have identical
                            data
  --explain-hosts           Print connection information and exit
  --float-precision=i       Precision for FLOAT and DOUBLE number-to-string
                            conversion
  --[no]foreign-key-checks  Enable foreign key checks (SET FOREIGN_KEY_CHECKS=
                            1) (default yes)
  --function=s              Which hash function you'd like to use for checksums
  --help                    Show help and exit
  --[no]hex-blob            HEX() BLOB, TEXT and BINARY columns (default yes)
  --host=s              -h  Connect to host
  --ignore-columns=H        Ignore this comma-separated list of column names in
                            comparisons
  --ignore-databases=H      Ignore this comma-separated list of databases
  --ignore-engines=H        Ignore this comma-separated list of storage
                            engines (default FEDERATED,MRG_MyISAM)
  --ignore-tables=H         Ignore this comma-separated list of tables
  --[no]index-hint          Add FORCE/USE INDEX hints to the chunk and row
                            queries (default yes)
  --lock=i                  Lock tables: 0=none, 1=per sync cycle, 2=per table,
                            or 3=globally
  --lock-and-rename         Lock the source and destination table, sync, then
                            swap names
  --password=s          -p  Password to use when connecting
  --pid=s                   Create the given PID file
  --port=i              -P  Port number to use for connection
  --print                   Print queries that will resolve differences
  --recursion-method=a      Preferred recursion method used to find slaves (
                            default processlist,hosts)
  --replace                 Write all INSERT and UPDATE statements as REPLACE
  --replicate=s             Sync tables listed as different in this table
  --set-vars=A              Set the MySQL variables in this comma-separated
                            list of variable=value pairs
  --slave-password=s        Sets the password to be used to connect to the
                            slaves
  --slave-user=s            Sets the user to be used to connect to the slaves
  --socket=s            -S  Socket file to use for connection
  --sync-to-master          Treat the DSN as a slave and sync it to its master
  --tables=h            -t  Sync only this comma-separated list of tables
  --timeout-ok              Keep going if --wait fails
  --[no]transaction         Use transactions instead of LOCK TABLES
  --trim                    TRIM() VARCHAR columns in BIT_XOR and ACCUM modes
  --[no]unique-checks       Enable unique key checks (SET UNIQUE_CHECKS=1) (
                            default yes)
  --user=s              -u  User for login if not current user
  --verbose             -v  Print results of sync operations
  --version                 Show version and exit
  --[no]version-check       Check for the latest version of Percona Toolkit,
                            MySQL, and other programs (default yes)
  --wait=m              -w  How long to wait for slaves to catch up to their
                            master.  Optional suffix s=seconds, m=minutes, h=
                            hours, d=days; if no suffix, s is used.
  --where=s                 WHERE clause to restrict syncing to part of the
                            table
  --[no]zero-chunk          Add a chunk for rows with zero or zero-equivalent
                            values (default yes)

Filter:

  --ignore-tables-regex=s   Ignore tables whose names match the Perl regex

Option types: s=string, i=integer, f=float, h/H/a/A=comma-separated list, d=DSN, z=size, m=time

Rules:

  Specify at least one of --print, --execute, or --dry-run.
  --where and --replicate are mutually exclusive.
  This tool accepts additional command-line arguments. Refer to the SYNOPSIS and usage information for details.

DSN syntax is key=value[,key=value...]  Allowable DSN keys:

  KEY  COPY  MEANING
  ===  ====  =============================================
  A    yes   Default character set
  D    yes   Database containing the table to be synced
  F    yes   Only read default options from the given file
  P    yes   Port number to use for connection
  S    yes   Socket file to use for connection
  h    yes   Connect to host
  p    yes   Password to use when connecting
  t    yes   Table to be synced
  u    yes   User for login if not current user

  If the DSN is a bareword, the word is treated as the 'h' key.

Options and values after processing arguments:

  --algorithms              Chunk,Nibble,GroupBy,Stream
  --ask-pass                FALSE
  --bidirectional           FALSE
  --bin-log                 TRUE
  --buffer-in-mysql         FALSE
  --buffer-to-client        TRUE
  --channel                 (No value)
  --charset                 (No value)
  --check-child-tables      TRUE
  --check-master            TRUE
  --check-slave             TRUE
  --check-triggers          TRUE
  --chunk-column            (No value)
  --chunk-index             (No value)
  --chunk-size              1000
  --columns                 (No value)
  --config                  /etc/percona-toolkit/percona-toolkit.conf,/etc/percona-toolkit/pt-table-sync.conf,/home/coding001/.percona-toolkit.conf,/home/coding001/.pt-table-sync.conf
  --conflict-column         (No value)
  --conflict-comparison     (No value)
  --conflict-error          warn
  --conflict-threshold      (No value)
  --conflict-value          (No value)
  --databases               (No value)
  --defaults-file           (No value)
  --dry-run                 FALSE
  --engines                 (No value)
  --execute                 FALSE
  --explain-hosts           FALSE
  --float-precision         (No value)
  --foreign-key-checks      TRUE
  --function                (No value)
  --help                    TRUE
  --hex-blob                TRUE
  --host                    (No value)
  --ignore-columns          
  --ignore-databases        
  --ignore-engines          FEDERATED,MRG_MyISAM
  --ignore-tables           
  --ignore-tables-regex     (No value)
  --index-hint              TRUE
  --lock                    (No value)
  --lock-and-rename         FALSE
  --password                (No value)
  --pid                     (No value)
  --port                    (No value)
  --print                   FALSE
  --recursion-method        processlist,hosts
  --replace                 FALSE
  --replicate               (No value)
  --set-vars                
  --slave-password          (No value)
  --slave-user              (No value)
  --socket                  (No value)
  --sync-to-master          FALSE
  --tables                  (No value)
  --timeout-ok              FALSE
  --transaction             FALSE
  --trim                    FALSE
  --unique-checks           TRUE
  --user                    (No value)
  --verbose                 0
  --version                 FALSE
  --version-check           TRUE
  --wait                    (No value)
  --where                   (No value)
  --zero-chunk              TRUE
