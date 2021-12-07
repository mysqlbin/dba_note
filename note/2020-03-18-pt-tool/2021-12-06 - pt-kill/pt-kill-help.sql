
shell> pt-kill
Usage: pt-kill [OPTIONS] [DSN]

Errors in command-line arguments:
  * Specify at least one of --kill, --kill-query, --print, --execute-command or --stop

pt-kill kills MySQL connections. pt-kill connects to MySQL and gets queries from
SHOW PROCESSLIST if no FILE is given.  Else, it reads queries from one or more
FILE which contains the output of SHOW PROCESSLIST.  If FILE is -, pt-kill reads
from STDIN.  For more details, please use the --help option, or try 'perldoc
/usr/bin/pt-kill' for complete documentation.
[root@mgr9 bin]# pt-kill --help
pt-kill kills MySQL connections. pt-kill connects to MySQL and gets queries from
SHOW PROCESSLIST if no FILE is given.  Else, it reads queries from one or more
FILE which contains the output of SHOW PROCESSLIST.  If FILE is -, pt-kill reads
from STDIN.  For more details, please use the --help option, or try 'perldoc
/usr/bin/pt-kill' for complete documentation.

Usage: pt-kill [OPTIONS] [DSN]

Options:

  --ask-pass              Prompt for a password when connecting to MySQL
  --charset=s         -A  Default character set
  --config=A              Read this comma-separated list of config files; if
                          specified, this must be the first option on the
                          command line
  --create-log-table      Create the --log-dsn table if it does not exist
  --daemonize             Fork to the background and detach from the shell
  --database=s        -D  The database to use for the connection
  --defaults-file=s   -F  Only read mysql options from the given file
  --filter=s              Discard events for which this Perl code doesn't
                          return true
  --group-by=s            Apply matches to each class of queries grouped by
                          this SHOW PROCESSLIST column
  --help                  Show help and exit
  --host=s            -h  Connect to host (default localhost)
  --interval=m            How often to check for queries to kill.  Optional
                          suffix s=seconds, m=minutes, h=hours, d=days; if no
                          suffix, s is used.
  --kill-busy-commands=s  group: Actions (default Query)
  --log=s                 Print all output to this file when daemonized
  --log-dsn=d             Store each query killed in this DSN
  --password=s        -p  Password to use when connecting
  --pid=s                 Create the given PID file
  --port=i            -P  Port number to use for connection
  --query-id              Prints an ID of the query that was just killed
  --rds                   Denotes the instance in question is on Amazon RDS
  --run-time=m            How long to run before exiting.  Optional suffix s=
                          seconds, m=minutes, h=hours, d=days; if no suffix, s
                          is used.
  --sentinel=s            Exit if this file exists (default /tmp/pt-kill-
                          sentinel)
  --set-vars=A            Set the MySQL variables in this comma-separated list
                          of variable=value pairs
  --slave-password=s      Sets the password to be used to connect to the slaves
  --slave-user=s          Sets the user to be used to connect to the slaves
  --socket=s          -S  Socket file to use for connection
  --stop                  Stop running instances by creating the --sentinel file
  --[no]strip-comments    Remove SQL comments from queries in the Info column
                          of the PROCESSLIST (default yes)
  --user=s            -u  User for login if not current user
  --verbose           -v  Print information to STDOUT about what is being done
  --version               Show version and exit
  --[no]version-check     Check for the latest version of Percona Toolkit,
                          MySQL, and other programs (default yes)
  --victims=s             Which of the matching queries in each class will be
                          killed (default oldest)
  --wait-after-kill=m     Wait after killing a query, before looking for more
                          to kill.  Optional suffix s=seconds, m=minutes, h=
                          hours, d=days; if no suffix, s is used.
  --wait-before-kill=m    Wait before killing a query.  Optional suffix s=
                          seconds, m=minutes, h=hours, d=days; if no suffix, s
                          is used.

Actions:

  --execute-command=s     Execute this command when a query matches
  --kill                  Kill the connection for matching queries
  --kill-query            Kill matching queries
  --print                 Print a KILL statement for matching queries; does not
                          actually kill queries

Class Matches:

  --any-busy-time=m       Match query class if any query has been running for
                          longer than this time. "Longer than" means that if
                          you specify 10, for example, the class will only
                          match if there's at least one query that has been
                          running for greater than 10 seconds.  Optional suffix
                          s=seconds, m=minutes, h=hours, d=days; if no suffix,
                          s is used.
  --each-busy-time=m      Match query class if each query has been running for
                          longer than this time. "Longer than" means that if
                          you specify 10, for example, the class will only
                          match if each and every query has been running for
                          greater than 10 seconds.  Optional suffix s=seconds,
                          m=minutes, h=hours, d=days; if no suffix, s is used.
  --query-count=i         Match query class if it has at least this many queries

Query Matches:

  --busy-time=m           Match queries that have been running for longer than
                          this time.  Optional suffix s=seconds, m=minutes, h=
                          hours, d=days; if no suffix, s is used.
  --idle-time=m           Match queries that have been idle/sleeping for longer
                          than this time.  Optional suffix s=seconds, m=
                          minutes, h=hours, d=days; if no suffix, s is used.
  --ignore-command=s      Ignore queries whose Command matches this Perl regex
  --ignore-db=s           Ignore queries whose db (database) matches this Perl
                          regex
  --ignore-host=s         Ignore queries whose Host matches this Perl regex
  --ignore-info=s         Ignore queries whose Info (query) matches this Perl
                          regex
  --[no]ignore-self       Don't kill pt-kill's own connection (default yes)
  --ignore-state=s        Ignore queries whose State matches this Perl regex (
                          default Locked)
  --ignore-user=s         Ignore queries whose user matches this Perl regex
  --match-all             Match all queries that are not ignored
  --match-command=s       Match only queries whose Command matches this Perl
                          regex
  --match-db=s            Match only queries whose db (database) matches this
                          Perl regex
  --match-host=s          Match only queries whose Host matches this Perl regex
  --match-info=s          Match only queries whose Info (query) matches this
                          Perl regex
  --match-state=s         Match only queries whose State matches this Perl regex
  --match-user=s          Match only queries whose User matches this Perl regex
  --replication-threads   Allow matching and killing replication threads
  --test-matching=a       Files with processlist snapshots to test matching
                          options against

Option types: s=string, i=integer, f=float, h/H/a/A=comma-separated list, d=DSN, z=size, m=time

Rules:

  Specify at least one of --kill, --kill-query, --print, --execute-command or --stop.
  --any-busy-time and --each-busy-time are mutually exclusive.
  --kill and --kill-query are mutually exclusive.
  --daemonize and --test-matching are mutually exclusive.
  This tool accepts additional command-line arguments. Refer to the SYNOPSIS and usage information for details.

DSN syntax is key=value[,key=value...]  Allowable DSN keys:

  KEY  COPY  MEANING
  ===  ====  =============================================
  A    yes   Default character set
  D    yes   Default database
  F    yes   Only read default options from the given file
  P    yes   Port number to use for connection
  S    yes   Socket file to use for connection
  h    yes   Connect to host
  p    yes   Password to use when connecting
  t    no    Table to log actions in, if passed through --log-dsn
  u    yes   User for login if not current user

  If the DSN is a bareword, the word is treated as the 'h' key.

Options and values after processing arguments:

  --any-busy-time         (No value)
  --ask-pass              FALSE
  --busy-time             (No value)
  --charset               (No value)
  --config                /etc/percona-toolkit/percona-toolkit.conf,/etc/percona-toolkit/pt-kill.conf,/root/.percona-toolkit.conf,/root/.pt-kill.conf
  --create-log-table      FALSE
  --daemonize             FALSE
  --database              (No value)
  --defaults-file         (No value)
  --each-busy-time        (No value)
  --execute-command       (No value)
  --filter                (No value)
  --group-by              (No value)
  --help                  TRUE
  --host                  localhost
  --idle-time             (No value)
  --ignore-command        (No value)
  --ignore-db             (No value)
  --ignore-host           (No value)
  --ignore-info           (No value)
  --ignore-self           TRUE
  --ignore-state          Locked
  --ignore-user           (No value)
  --interval              30             --  pt-kill 默认检查间隔为30秒
  --kill                  FALSE
  --kill-busy-commands    Query
  --kill-query            FALSE
  --log                   (No value)
  --log-dsn               (No value)
  --match-all             FALSE
  --match-command         (No value)
  --match-db              (No value)
  --match-host            (No value)
  --match-info            (No value)
  --match-state           (No value)
  --match-user            (No value)
  --password              (No value)
  --pid                   (No value)
  --port                  (No value)
  --print                 FALSE
  --query-count           (No value)
  --query-id              FALSE
  --rds                   FALSE
  --replication-threads   FALSE
  --run-time              (No value)
  --sentinel              /tmp/pt-kill-sentinel
  --set-vars              
  --slave-password        (No value)
  --slave-user            (No value)
  --socket                (No value)
  --stop                  FALSE
  --strip-comments        TRUE
  --test-matching         (No value)
  --user                  (No value)
  --verbose               FALSE
  --version               FALSE
  --version-check         TRUE
  --victims               oldest
  --wait-after-kill       (No value)
  --wait-before-kill      (No value)

