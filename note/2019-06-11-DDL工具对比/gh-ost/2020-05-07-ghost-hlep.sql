

[root@kp04 ~]# /root/ghost/gh-ost --help
Usage of gh-ost:
  -aliyun-rds
    	set to 'true' when you execute on Aliyun RDS.
  -allow-master-master
    	explicitly allow running in a master-master setup
  -allow-nullable-unique-key
    	allow gh-ost to migrate based on a unique key with nullable columns. As long as no NULL values exist, this should be OK. If NULL values exist in chosen key, data may be corrupted. Use at your own risk!
  -allow-on-master
    	allow this migration to run directly on master. Preferably it would run on a replica
  -alter string
    	alter statement (mandatory)
  -approve-renamed-columns ALTER
    	in case your ALTER statement renames columns, gh-ost will note that and offer its interpretation of the rename. By default gh-ost does not proceed to execute. This flag approves that gh-ost's interpretation is correct
  -ask-pass
    	prompt for MySQL password
  -assume-master-host string
    	(optional) explicitly tell gh-ost the identity of the master. Format: some.host.com[:port] This is useful in master-master setups where you wish to pick an explicit master, or in a tungsten-replicator where gh-ost is unable to determine the master
  -assume-rbr
    	set to 'true' when you know for certain your server uses 'ROW' binlog_format. gh-ost is unable to tell, event after reading binlog_format, whether the replication process does indeed use 'ROW', and restarts replication to be certain RBR setting is applied. Such operation requires SUPER privileges which you might not have. Setting this flag avoids restarting replication and you can proceed to use gh-ost without SUPER privileges
  -check-flag
    	Check if another flag exists/supported. This allows for cross-version scripting. Exits with 0 when all additional provided flags exist, nonzero otherwise. You must provide (dummy) values for flags that require a value. Example: gh-ost --check-flag --cut-over-lock-timeout-seconds --nice-ratio 0
  -chunk-size int
    	amount of rows to handle in each iteration (allowed range: 100-100,000) (default 1000)
  -concurrent-rowcount
    	(with --exact-rowcount), when true (default): count rows after row-copy begins, concurrently, and adjust row estimate later on; when false: first count rows, then start row copy (default true)
  -conf string
    	Config file
  -critical-load string
    	Comma delimited status-name=threshold, same format as --max-load. When status exceeds threshold, app panics and quits
  -critical-load-hibernate-seconds int
    	When nonzero, critical-load does not panic and bail out; instead, gh-ost goes into hibernate for the specified duration. It will not read/write anything to from/to any server
  -critical-load-interval-millis int
    	When 0, migration immediately bails out upon meeting critical-load. When non-zero, a second check is done after given interval, and migration only bails out if 2nd check still meets critical load
		设置为0时，一旦达到临界负载，迁移将立即失效。 如果为非零值，则在给定间隔后进行第二次检查，并且仅在第二次检查仍满足关键负载时迁移才能解决
  -cut-over string
    	choose cut-over type (default|atomic, two-step) (default "atomic")
  -cut-over-exponential-backoff
    	Wait exponentially longer intervals between failed cut-over attempts. Wait intervals obey a maximum configurable with 'exponential-backoff-max-interval').
  -cut-over-lock-timeout-seconds int
    	Max number of seconds to hold locks on tables while attempting to cut-over (retry attempted when lock exceeds timeout) (default 3)
  -database string
    	database name (mandatory)
  -debug
    	debug mode (very verbose)
  -default-retries int
    	Default number of retries for various operations before panicking (default 60)
  -discard-foreign-keys
    	DANGER! This flag will migrate a table that has foreign keys and will NOT create foreign keys on the ghost table, thus your altered table will have NO foreign keys. This is useful for intentional dropping of foreign keys
  -dml-batch-size int
    	batch size for DML events to apply in a single transaction (range 1-100) (default 10)
  -exact-rowcount
    	actually count table rows as opposed to estimate them (results in more accurate progress estimation)
  -execute
    	actually execute the alter & migrate the table. Default is noop: do some tests and exit
  -exponential-backoff-max-interval int
    	Maximum number of seconds to wait between attempts when performing various operations with exponential backoff. (default 64)
  -force-named-cut-over
    	When true, the 'unpostpone|cut-over' interactive command must name the migrated table
  -force-named-panic
    	When true, the 'panic' interactive command must name the migrated table
  -force-table-names string
    	table name prefix to be used on the temporary tables
  -gcp
    	set to 'true' when you execute on a 1st generation Google Cloud Platform (GCP).
  -heartbeat-interval-millis int
    	how frequently would gh-ost inject a heartbeat value (default 100)
  -help
    	Display usage
  -hooks-hint string
    	arbitrary message to be injected to hooks via GH_OST_HOOKS_HINT, for your convenience
  -hooks-hint-owner string
    	arbitrary name of owner to be injected to hooks via GH_OST_HOOKS_HINT_OWNER, for your convenience
  -hooks-hint-token string
    	arbitrary token to be injected to hooks via GH_OST_HOOKS_HINT_TOKEN, for your convenience
  -hooks-path string
    	directory where hook files are found (default: empty, ie. hooks disabled). Hook files found on this path, and conforming to hook naming conventions will be executed
  -host string
    	MySQL hostname (preferably a replica, not the master) (default "127.0.0.1")
  -initially-drop-ghost-table
    	Drop a possibly existing Ghost table (remains from a previous run?) before beginning operation. Default is to panic and abort if such table exists
  -initially-drop-old-table
    	Drop a possibly existing OLD table (remains from a previous run?) before beginning operation. Default is to panic and abort if such table exists
  -initially-drop-socket-file
    	Should gh-ost forcibly delete an existing socket file. Be careful: this might drop the socket file of a running migration!
  -master-password string
    	MySQL password on master, if different from that on replica. Requires --assume-master-host
  -master-user string
    	MySQL user on master, if different from that on replica. Requires --assume-master-host
  -max-lag-millis int
    	replication lag at which to throttle operation (default 1500)
  -max-load string
    	Comma delimited status-name=threshold. e.g: 'Threads_running=100,Threads_connected=500'. When status exceeds threshold, app throttles writes
  -migrate-on-replica
    	Have the migration run on a replica, not on the master. This will do the full migration on the replica including cut-over (as opposed to --test-on-replica)
  -nice-ratio float
    	force being 'nice', imply sleep time per chunk time; range: [0.0..100.0]. Example values: 0 is aggressive. 1: for every 1ms spent copying rows, sleep additional 1ms (effectively doubling runtime); 0.7: for every 10ms spend in a rowcopy chunk, spend 7ms sleeping immediately after
  -ok-to-drop-table
    	Shall the tool drop the old table at end of operation. DROPping tables can be a long locking operation, which is why I'm not doing it by default. I'm an online tool, yes?
  -panic-flag-file string
    	when this file is created, gh-ost will immediately terminate, without cleanup
  -password string
    	MySQL password
  -port int
    	MySQL port (preferably a replica, not the master) (default 3306)
  -postpone-cut-over-flag-file string
    	while this file exists, migration will postpone the final stage of swapping tables, and will keep on syncing the ghost table. Cut-over/swapping would be ready to perform the moment the file is deleted.
  -quiet
    	quiet
  -replica-server-id uint
    	server id used by gh-ost process. Default: 99999 (default 99999)
  -replication-lag-query string
    	Deprecated. gh-ost uses an internal, subsecond resolution query
  -serve-socket-file string
    	Unix socket file to serve on. Default: auto-determined and advertised upon startup
  -serve-tcp-port int
    	TCP port to serve on. Default: disabled
  -skip-foreign-key-checks
    	set to 'true' when you know for certain there are no foreign keys on your table, and wish to skip the time it takes for gh-ost to verify that
  -skip-renamed-columns ALTER
    	in case your ALTER statement renames columns, gh-ost will note that and offer its interpretation of the rename. By default gh-ost does not proceed to execute. This flag tells gh-ost to skip the renamed columns, i.e. to treat what gh-ost thinks are renamed columns as unrelated columns. NOTE: you may lose column data
  -skip-strict-mode
    	explicitly tell gh-ost binlog applier not to enforce strict sql mode
  -ssl
    	Enable SSL encrypted connections to MySQL hosts
  -ssl-allow-insecure
    	Skips verification of MySQL hosts' certificate chain and host name. Requires --ssl
  -ssl-ca string
    	CA certificate in PEM format for TLS connections to MySQL hosts. Requires --ssl
  -ssl-cert string
    	Certificate in PEM format for TLS connections to MySQL hosts. Requires --ssl
  -ssl-key string
    	Key in PEM format for TLS connections to MySQL hosts. Requires --ssl
  -stack
    	add stack trace upon error
  -switch-to-rbr
    	let this tool automatically switch binary log format to 'ROW' on the replica, if needed. The format will NOT be switched back. I'm too scared to do that, and wish to protect you if you happen to execute another migration while this one is running
  -table string
    	table name (mandatory)
  -test-on-replica
    	Have the migration run on a replica, not on the master. At the end of migration replication is stopped, and tables are swapped and immediately swap-revert. Replication remains stopped and you can compare the two tables for building trust
  -test-on-replica-skip-replica-stop
    	When --test-on-replica is enabled, do not issue commands stop replication (requires --test-on-replica)
  -throttle-additional-flag-file string
    	operation pauses when this file exists; hint: keep default, use for throttling multiple gh-ost operations (default "/tmp/gh-ost.throttle")
  -throttle-control-replicas string
    	List of replicas on which to check for lag; comma delimited. Example: myhost1.com:3306,myhost2.com,myhost3.com:3307
  -throttle-flag-file string
    	operation pauses when this file exists; hint: use a file that is specific to the table being altered
  -throttle-http string
    	when given, gh-ost checks given URL via HEAD request; any response code other than 200 (OK) causes throttling; make sure it has low latency response
  -throttle-query string
    	when given, issued (every second) to check if operation should throttle. Expecting to return zero for no-throttle, >0 for throttle. Query is issued on the migrated server. Make sure this query is lightweight
  -timestamp-old-table
    	Use a timestamp in old table name. This makes old table names unique and non conflicting cross migrations
  -tungsten
    	explicitly let gh-ost know that you are running on a tungsten-replication based topology (you are likely to also provide --assume-master-host)
  -user string
    	MySQL user
  -verbose
    	verbose
  -version
    	Print version & exit
		
		