

[root@env backup]# innobackupex --help
Open source backup tool for InnoDB and XtraDB

Copyright (C) 2009-2015 Percona LLC and/or its affiliates.
Portions Copyright (C) 2000, 2011, MySQL AB & Innobase Oy. All Rights Reserved.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation version 2
of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You can download full text of the license on http://www.gnu.org/licenses/gpl-2.0.txt


innobackupex - Non-blocking backup tool for InnoDB, XtraDB and HailDB databases

NOTICE: 'innobackupex' is deprecated, please switch to 'xtrabackup'

SYNOPOSIS

innobackupex [--compress] [--compress-threads=NUMBER-OF-THREADS] [--compress-chunk-size=CHUNK-SIZE]
             [--encrypt=ENCRYPTION-ALGORITHM] [--encrypt-threads=NUMBER-OF-THREADS] [--encrypt-chunk-size=CHUNK-SIZE]
             [--encrypt-key=LITERAL-ENCRYPTION-KEY] | [--encryption-key-file=MY.KEY]
             [--include=REGEXP] [--user=NAME]
             [--password=WORD] [--port=PORT] [--socket=SOCKET]
             [--no-timestamp] [--ibbackup=IBBACKUP-BINARY]
             [--slave-info] [--galera-info] [--stream=tar|xbstream]
             [--defaults-file=MY.CNF] [--defaults-group=GROUP-NAME]
             [--databases=LIST] [--no-lock] 
             [--tmpdir=DIRECTORY] [--tables-file=FILE]
             [--history=NAME]
             [--incremental] [--incremental-basedir]
             [--incremental-dir] [--incremental-force-scan] [--incremental-lsn]
             [--incremental-history-name=NAME] [--incremental-history-uuid=UUID]
             [--close-files] [--compact]     
             BACKUP-ROOT-DIR

innobackupex --apply-log [--use-memory=B]
             [--defaults-file=MY.CNF]
             [--export] [--redo-only] [--ibbackup=IBBACKUP-BINARY]
             BACKUP-DIR

innobackupex --copy-back [--defaults-file=MY.CNF] [--defaults-group=GROUP-NAME] BACKUP-DIR

innobackupex --move-back [--defaults-file=MY.CNF] [--defaults-group=GROUP-NAME] BACKUP-DIR

innobackupex [--decompress] [--decrypt=ENCRYPTION-ALGORITHM]
             [--encrypt-key=LITERAL-ENCRYPTION-KEY] | [--encryption-key-file=MY.KEY]
             [--parallel=NUMBER-OF-FORKS] BACKUP-DIR

DESCRIPTION

The first command line above makes a hot backup of a MySQL database.
By default it creates a backup directory (named by the current date
	and time) in the given backup root directory.  With the --no-timestamp
option it does not create a time-stamped backup directory, but it puts
the backup in the given directory (which must not exist).  This
command makes a complete backup of all MyISAM and InnoDB tables and
indexes in all databases or in all of the databases specified with the
--databases option.  The created backup contains .frm, .MRG, .MYD,
.MYI, .MAD, .MAI, .TRG, .TRN, .ARM, .ARZ, .CSM, CSV, .opt, .par, and
InnoDB data and log files.  The MY.CNF options file defines the
location of the database.  This command connects to the MySQL server
using the mysql client program, and runs xtrabackup as a child
process.

The --apply-log command prepares a backup for starting a MySQL
server on the backup. This command recovers InnoDB data files as specified
in BACKUP-DIR/backup-my.cnf using BACKUP-DIR/xtrabackup_logfile,
and creates new InnoDB log files as specified in BACKUP-DIR/backup-my.cnf.
The BACKUP-DIR should be the path to a backup directory created by
xtrabackup. This command runs xtrabackup as a child process, but it does not 
connect to the database server.

The --copy-back command copies data, index, and log files
from the backup directory back to their original locations.
The MY.CNF options file defines the original location of the database.
The BACKUP-DIR is the path to a backup directory created by xtrabackup.

The --move-back command is similar to --copy-back with the only difference that
it moves files to their original locations rather than copies them. As this
option removes backup files, it must be used with caution. It may be useful in
cases when there is not enough free disk space to copy files.

The --decompress --decrypt command will decrypt and/or decompress a backup made
with the --compress and/or --encrypt options. When decrypting, the encryption
algorithm and key used when the backup was taken MUST be provided via the
specified options. --decrypt and --decompress may be used together at the same
time to completely normalize a previously compressed and encrypted backup. The
--parallel option will allow multiple files to be decrypted and/or decompressed
simultaneously. In order to decompress, the qpress utility MUST be installed
and accessable within the path. This process will remove the original
compressed/encrypted files and leave the results in the same location.

On success the exit code innobackupex is 0. A non-zero exit code 
indicates an error.

Usage: [innobackupex [--defaults-file=#] --backup | innobackupex [--defaults-file=#] --prepare] [OPTIONS]
  -v, --version       print xtrabackup version information
  -?, --help          This option displays a help screen and exits.
  --apply-log         Prepare a backup in BACKUP-DIR by applying the
                      transaction log file named "xtrabackup_logfile" located
                      in the same directory. Also, create new transaction logs.
                      The InnoDB configuration is read from the file
                      "backup-my.cnf".
  --redo-only         This option should be used when preparing the base full
                      backup and when merging all incrementals except the last
                      one. This forces xtrabackup to skip the "rollback" phase
                      and do a "redo" only. This is necessary if the backup
                      will have incremental changes applied to it later. See
                      the xtrabackup documentation for details.
  --copy-back         Copy all the files in a previously made backup from the
                      backup directory to their original locations.
  --move-back         Move all the files in a previously made backup from the
                      backup directory to the actual datadir location. Use with
                      caution, as it removes backup files.
  --galera-info       This options creates the xtrabackup_galera_info file
                      which contains the local node state at the time of the
                      backup. Option should be used when performing the backup
                      of Percona-XtraDB-Cluster. Has no effect when backup
                      locks are used to create the backup.
  --slave-info        This option is useful when backing up a replication slave
                      server. It prints the binary log position and name of the
                      master server. It also writes this information to the
                      "xtrabackup_slave_info" file as a "CHANGE MASTER"
                      command. A new slave for this master can be set up by
                      starting a slave server on this backup and issuing a
                      "CHANGE MASTER" command with the binary log position
                      saved in the "xtrabackup_slave_info" file.
  --incremental       This option tells xtrabackup to create an incremental
                      backup, rather than a full one. It is passed to the
                      xtrabackup child process. When this option is specified,
                      either --incremental-lsn or --incremental-basedir can
                      also be given. If neither option is given, option
                      --incremental-basedir is passed to xtrabackup by default,
                      set to the first timestamped backup directory in the
                      backup base directory.
  --no-lock           Use this option to disable table lock with "FLUSH TABLES
                      WITH READ LOCK". Use it only if ALL your tables are
                      InnoDB and you DO NOT CARE about the binary log position
                      of the backup. This option shouldn't be used if there are
                      any DDL statements being executed or if any updates are
                      happening on non-InnoDB tables (this includes the system
                      MyISAM tables in the mysql database), otherwise it could
                      lead to an inconsistent backup. If you are considering to
                      use --no-lock because your backups are failing to acquire
                      the lock, this could be because of incoming replication
                      events preventing the lock from succeeding. Please try
                      using --safe-slave-backup to momentarily stop the
                      replication slave thread, this may help the backup to
                      succeed and you then don't need to resort to using this
                      option.
  --safe-slave-backup Stop slave SQL thread and wait to start backup until
                      Slave_open_temp_tables in "SHOW STATUS" is zero. If there
                      are no open temporary tables, the backup will take place,
                      otherwise the SQL thread will be started and stopped
                      until there are no open temporary tables. The backup will
                      fail if Slave_open_temp_tables does not become zero after
                      --safe-slave-backup-timeout seconds. The slave SQL thread
                      will be restarted when the backup finishes.
  --rsync             Uses the rsync utility to optimize local file transfers.
                      When this option is specified, innobackupex uses rsync to
                      copy all non-InnoDB files instead of spawning a separate
                      cp for each file, which can be much faster for servers
                      with a large number of databases or tables.  This option
                      cannot be used together with --stream.
  --force-non-empty-directories 
                      This option, when specified, makes --copy-back or
                      --move-back transfer files to non-empty directories. Note
                      that no existing files will be overwritten. If
                      --copy-back or --nove-back has to copy a file from the
                      backup directory which already exists in the destination
                      directory, it will still fail with an error.
  --no-timestamp      This option prevents creation of a time-stamped
                      subdirectory of the BACKUP-ROOT-DIR given on the command
                      line. When it is specified, the backup is done in
                      BACKUP-ROOT-DIR instead.
  --no-version-check  This option disables the version check which is enabled
                      by the --version-check option.
  --no-backup-locks   This option controls if backup locks should be used
                      instead of FLUSH TABLES WITH READ LOCK on the backup
                      stage. The option has no effect when backup locks are not
                      supported by the server. This option is enabled by
                      default, disable with --no-backup-locks.
  --decompress        Decompresses all files with the .qp extension in a backup
                      previously made with the --compress option.
  -u, --user=name     This option specifies the MySQL username used when
                      connecting to the server, if that's not the current user.
                      The option accepts a string argument. See mysql --help
                      for details.
  -H, --host=name     This option specifies the host to use when connecting to
                      the database server with TCP/IP.  The option accepts a
                      string argument. See mysql --help for details.
  -P, --port=#        This option specifies the port to use when connecting to
                      the database server with TCP/IP.  The option accepts a
                      string argument. See mysql --help for details.
  -p, --password=name This option specifies the password to use when connecting
                      to the database. It accepts a string argument.  See mysql
                      --help for details.
  -S, --socket=name   This option specifies the socket to use when connecting
                      to the local database server with a UNIX domain socket. 
                      The option accepts a string argument. See mysql --help
                      for details.
  --incremental-history-name=name 
                      This option specifies the name of the backup series
                      stored in the PERCONA_SCHEMA.xtrabackup_history history
                      record to base an incremental backup on. Xtrabackup will
                      search the history table looking for the most recent
                      (highest innodb_to_lsn), successful backup in the series
                      and take the to_lsn value to use as the starting lsn for
                      the incremental backup. This will be mutually exclusive
                      with --incremental-history-uuid, --incremental-basedir
                      and --incremental-lsn. If no valid lsn can be found (no
                      series by that name, no successful backups by that name)
                      xtrabackup will return with an error. It is used with the
                      --incremental option.
  --incremental-history-uuid=name 
                      This option specifies the UUID of the specific history
                      record stored in the PERCONA_SCHEMA.xtrabackup_history to
                      base an incremental backup on.
                      --incremental-history-name, --incremental-basedir and
                      --incremental-lsn. If no valid lsn can be found (no
                      success record with that uuid) xtrabackup will return
                      with an error. It is used with the --incremental option.
  --decrypt=name      Decrypts all files with the .xbcrypt extension in a
                      backup previously made with --encrypt option.
  --ftwrl-wait-query-type=name 
                      This option specifies which types of queries are allowed
                      to complete before innobackupex will issue the global
                      lock. Default is all.
  --kill-long-query-type=name 
                      This option specifies which types of queries should be
                      killed to unblock the global lock. Default is "all".
  --history[=name]    This option enables the tracking of backup history in the
                      PERCONA_SCHEMA.xtrabackup_history table. An optional
                      history series name may be specified that will be placed
                      with the history record for the current backup being
                      taken.
  --include=name      This option is a regular expression to be matched against
                      table names in databasename.tablename format. It is
                      passed directly to xtrabackup's --tables option. See the
                      xtrabackup documentation for details.
  --databases=name    This option specifies the list of databases that
                      innobackupex should back up. The option accepts a string
                      argument or path to file that contains the list of
                      databases to back up. The list is of the form
                      "databasename1[.table_name1] databasename2[.table_name2]
                      . . .". If this option is not specified, all databases
                      containing MyISAM and InnoDB tables will be backed up. 
                      Please make sure that --databases contains all of the
                      InnoDB databases and tables, so that all of the
                      innodb.frm files are also backed up. In case the list is
                      very long, this can be specified in a file, and the full
                      path of the file can be specified instead of the list.
                      (See option --tables-file.)
  --kill-long-queries-timeout=# 
                      This option specifies the number of seconds innobackupex
                      waits between starting FLUSH TABLES WITH READ LOCK and
                      killing those queries that block it. Default is 0
                      seconds, which means innobackupex will not attempt to
                      kill any queries.
  --ftwrl-wait-timeout=# 
                      This option specifies time in seconds that innobackupex
                      should wait for queries that would block FTWRL before
                      running it. If there are still such queries when the
                      timeout expires, innobackupex terminates with an error.
                      Default is 0, in which case innobackupex does not wait
                      for queries to complete and starts FTWRL immediately.
  --ftwrl-wait-threshold=# 
                      This option specifies the query run time threshold which
                      is used by innobackupex to detect long-running queries
                      with a non-zero value of --ftwrl-wait-timeout. FTWRL is
                      not started until such long-running queries exist. This
                      option has no effect if --ftwrl-wait-timeout is 0.
                      Default value is 60 seconds.
  --debug-sleep-before-unlock=# 
                      This is a debug-only option used by the XtraBackup test
                      suite.
  --safe-slave-backup-timeout=# 
                      How many seconds --safe-slave-backup should wait for
                      Slave_open_temp_tables to become zero. (default 300)
  --close-files       Do not keep files opened. This option is passed directly
                      to xtrabackup. Use at your own risk.
  --compact           Create a compact backup with all secondary index pages
                      omitted. This option is passed directly to xtrabackup.
                      See xtrabackup documentation for details.
  --compress[=name]   This option instructs xtrabackup to compress backup
                      copies of InnoDB data files. It is passed directly to the
                      xtrabackup child process. Try 'xtrabackup --help' for
                      more details.
  --compress-threads=# 
                      This option specifies the number of worker threads that
                      will be used for parallel compression. It is passed
                      directly to the xtrabackup child process. Try 'xtrabackup
                      --help' for more details.
  --compress-chunk-size=# 
                      Size of working buffer(s) for compression threads in
                      bytes. The default value is 64K.
  --encrypt=name      This option instructs xtrabackup to encrypt backup copies
                      of InnoDB data files using the algorithm specified in the
                      ENCRYPTION-ALGORITHM. It is passed directly to the
                      xtrabackup child process. Try 'xtrabackup --help' for
                      more details.
  --encrypt-key=name  This option instructs xtrabackup to use the given
                      ENCRYPTION-KEY when using the --encrypt or --decrypt
                      options. During backup it is passed directly to the
                      xtrabackup child process. Try 'xtrabackup --help' for
                      more details.
  --encrypt-key-file=name 
                      This option instructs xtrabackup to use the encryption
                      key stored in the given ENCRYPTION-KEY-FILE when using
                      the --encrypt or --decrypt options.
  --encrypt-threads=# This option specifies the number of worker threads that
                      will be used for parallel encryption. It is passed
                      directly to the xtrabackup child process. Try 'xtrabackup
                      --help' for more details.
  --encrypt-chunk-size=# 
                      This option specifies the size of the internal working
                      buffer for each encryption thread, measured in bytes. It
                      is passed directly to the xtrabackup child process. Try
                      'xtrabackup --help' for more details.
  --export            This option is passed directly to xtrabackup's --export
                      option. It enables exporting individual tables for import
                      into another server. See the xtrabackup documentation for
                      details.
  --extra-lsndir=name This option specifies the directory in which to save an
                      extra copy of the "xtrabackup_checkpoints" file. The
                      option accepts a string argument. It is passed directly
                      to xtrabackup's --extra-lsndir option. See the xtrabackup
                      documentation for details.
  --incremental-basedir=name 
                      This option specifies the directory containing the full
                      backup that is the base dataset for the incremental
                      backup.  The option accepts a string argument. It is used
                      with the --incremental option.
  --incremental-dir=name 
                      This option specifies the directory where the incremental
                      backup will be combined with the full backup to make a
                      new full backup.  The option accepts a string argument.
                      It is used with the --incremental option.
  --incremental-force-scan 
                      This options tells xtrabackup to perform full scan of
                      data files for taking an incremental backup even if full
                      changed page bitmap data is available to enable the
                      backup without the full scan.
  --log-copy-interval=# 
                      This option specifies time interval between checks done
                      by log copying thread in milliseconds.
  --incremental-lsn=name 
                      This option specifies the log sequence number (LSN) to
                      use for the incremental backup.  The option accepts a
                      string argument. It is used with the --incremental
                      option. It is used instead of specifying
                      --incremental-basedir. For databases created by MySQL and
                      Percona Server 5.0-series versions, specify the LSN as
                      two 32-bit integers in high:low format. For databases
                      created in 5.1 and later, specify the LSN as a single
                      64-bit integer.
  --parallel=#        On backup, this option specifies the number of threads
                      the xtrabackup child process should use to back up files
                      concurrently.  The option accepts an integer argument. It
                      is passed directly to xtrabackup's --parallel option. See
                      the xtrabackup documentation for details.
  --rebuild-indexes   This option only has effect when used together with the
                      --apply-log option and is passed directly to xtrabackup.
                      When used, makes xtrabackup rebuild all secondary indexes
                      after applying the log. This option is normally used to
                      prepare compact backups. See the XtraBackup manual for
                      more information.
  --rebuild-threads=# Use this number of threads to rebuild indexes in a
                      compact backup. Only has effect with --prepare and
                      --rebuild-indexes.
  --stream=name       This option specifies the format in which to do the
                      streamed backup.  The option accepts a string argument.
                      The backup will be done to STDOUT in the specified
                      format. Currently, the only supported formats are tar and
                      xbstream. This option is passed directly to xtrabackup's
                      --stream option.
  --tables-file=name  This option specifies the file in which there are a list
                      of names of the form database.  The option accepts a
                      string argument.table, one per line. The option is passed
                      directly to xtrabackup's --tables-file option.
  --throttle=#        This option specifies a number of I/O operations (pairs
                      of read+write) per second.  It accepts an integer
                      argument.  It is passed directly to xtrabackup's
                      --throttle option.
  -t, --tmpdir=name   This option specifies the location where a temporary
                      files will be stored. If the option is not specified, the
                      default is to use the value of tmpdir read from the
                      server configuration.
  --use-memory=#      This option accepts a string argument that specifies the
                      amount of memory in bytes for xtrabackup to use for crash
                      recovery while preparing a backup. Multiples are
                      supported providing the unit (e.g. 1MB, 1GB). It is used
                      only with the option --apply-log. It is passed directly
                      to xtrabackup's --use-memory option. See the xtrabackup
                      documentation for details.
[root@env backup]# 

