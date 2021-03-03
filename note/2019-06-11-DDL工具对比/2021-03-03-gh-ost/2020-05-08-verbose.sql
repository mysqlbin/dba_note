
[root@kp04 data]# time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_10w" --alter="engine=innodb" --allow-on-master --execute  --ok-to-drop-table --serve-socket-file=/tmp/ghost.sock --verbose
2020-05-08 14:22:47 INFO starting gh-ost 1.0.49
2020-05-08 14:22:47 INFO Migrating `sbtest`.`t1_10w`
2020-05-08 14:22:47 INFO connection validated on 192.168.0.91:3306
2020-05-08 14:22:47 INFO User has SUPER, REPLICATION SLAVE privileges, and has ALL privileges on `sbtest`.*
2020-05-08 14:22:47 INFO binary logs validated on 192.168.0.91:3306
2020-05-08 14:22:47 INFO Restarting replication on 192.168.0.91:3306 to make sure binlog settings apply to replication thread
2020-05-08 14:22:47 INFO Inspector initiated on kp04:3306, version 8.0.18
2020-05-08 14:22:47 INFO Table found. Engine=InnoDB
2020-05-08 14:22:47 INFO Estimated number of rows via EXPLAIN: 100275
2020-05-08 14:22:47 INFO Recursively searching for replication master
2020-05-08 14:22:47 INFO Master found to be kp04:3306
2020-05-08 14:22:47 INFO log_slave_updates validated on 192.168.0.91:3306
2020-05-08 14:22:47 INFO connection validated on 192.168.0.91:3306
2020-05-08 14:22:47 INFO Connecting binlog streamer at mysql-bin.000007:478834466
[2020/05/08 14:22:47] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/08 14:22:47] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000007, 478834466)
[2020/05/08 14:22:47] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
2020-05-08 14:22:47 INFO rotate to next log from mysql-bin.000007:0 to mysql-bin.000007
[2020/05/08 14:22:47] [info] binlogsyncer.go:723 rotate to (mysql-bin.000007, 478834466)
2020-05-08 14:22:47 INFO connection validated on 192.168.0.91:3306
2020-05-08 14:22:47 INFO connection validated on 192.168.0.91:3306
2020-05-08 14:22:47 INFO will use time_zone='SYSTEM' on applier
2020-05-08 14:22:47 INFO Examining table structure on applier
2020-05-08 14:22:47 INFO Applier initiated on kp04:3306, version 8.0.18
2020-05-08 14:22:47 INFO Dropping table `sbtest`.`_t1_10w_ghc`
2020-05-08 14:22:47 INFO Table dropped
2020-05-08 14:22:47 INFO Creating changelog table `sbtest`.`_t1_10w_ghc`
2020-05-08 14:22:47 INFO Changelog table created
2020-05-08 14:22:47 INFO Creating ghost table `sbtest`.`_t1_10w_gho`
2020-05-08 14:22:47 INFO Ghost table created
2020-05-08 14:22:47 INFO Altering ghost table `sbtest`.`_t1_10w_gho`
2020-05-08 14:22:48 INFO Ghost table altered
2020-05-08 14:22:48 INFO Intercepted changelog state GhostTableMigrated
2020-05-08 14:22:48 INFO Waiting for ghost table to be migrated. Current lag is 0s
2020-05-08 14:22:48 INFO Handled changelog state GhostTableMigrated
2020-05-08 14:22:48 INFO Chosen shared unique key is PRIMARY
2020-05-08 14:22:48 INFO Shared columns are id,c1
2020-05-08 14:22:48 INFO Listening on unix socket file: /tmp/ghost.sock
2020-05-08 14:22:48 INFO Migration min values: [1]
2020-05-08 14:22:48 INFO Migration max values: [100005]
2020-05-08 14:22:48 INFO Waiting for first throttle metrics to be collected
2020-05-08 14:22:48 INFO First throttle metrics collected
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 14:22:47 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 1s(total), 0s(copy); streamer: mysql-bin.000007:478836619; Lag: 0.20s, State: migrating; ETA: N/A
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 1s(copy); streamer: mysql-bin.000007:478841104; Lag: 0.09s, State: migrating; ETA: N/A
Copy: 20000/100275 19.9%; Applied: 0; Backlog: 0/1000; Time: 3s(total), 2s(copy); streamer: mysql-bin.000007:479031451; Lag: 0.08s, State: migrating; ETA: 8s
Copy: 34000/100275 33.9%; Applied: 0; Backlog: 0/1000; Time: 4s(total), 3s(copy); streamer: mysql-bin.000007:479164441; Lag: 0.58s, State: migrating; ETA: 5s
Copy: 54000/100275 53.9%; Applied: 0; Backlog: 0/1000; Time: 5s(total), 4s(copy); streamer: mysql-bin.000007:479354793; Lag: 0.18s, State: migrating; ETA: 3s
Copy: 83000/100275 82.8%; Applied: 0; Backlog: 0/1000; Time: 6s(total), 5s(copy); streamer: mysql-bin.000007:479629584; Lag: 0.08s, State: migrating; ETA: 1s
2020-05-08 14:22:54 INFO Row copy complete
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 7s(total), 5s(copy); streamer: mysql-bin.000007:479789960; Lag: 0.08s, State: migrating; ETA: due
2020-05-08 14:22:54 INFO Grabbing voluntary lock: gh-ost.1503.lock
2020-05-08 14:22:54 INFO Setting LOCK timeout as 6 seconds
2020-05-08 14:22:54 INFO Looking for magic cut-over table
2020-05-08 14:22:54 INFO Creating magic cut-over table `sbtest`.`_t1_10w_del`
2020-05-08 14:22:54 INFO Magic cut-over table created
2020-05-08 14:22:54 INFO Locking `sbtest`.`t1_10w`, `sbtest`.`_t1_10w_del`
2020-05-08 14:22:54 INFO Tables locked
2020-05-08 14:22:54 INFO Session locking original & magic tables is 1503
2020-05-08 14:22:54 INFO Writing changelog state: AllEventsUpToLockProcessed:1588918974434683093
2020-05-08 14:22:54 INFO Intercepted changelog state AllEventsUpToLockProcessed
2020-05-08 14:22:54 INFO Handled changelog state AllEventsUpToLockProcessed
2020-05-08 14:22:54 INFO Waiting for events up to lock
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 1/1000; Time: 7s(total), 5s(copy); streamer: mysql-bin.000007:479793911; Lag: 0.08s, State: migrating; ETA: due
2020-05-08 14:22:55 INFO Waiting for events up to lock: got AllEventsUpToLockProcessed:1588918974434683093
2020-05-08 14:22:55 INFO Done waiting for events up to lock; duration=902.038506ms
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 14:22:47 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 8s(total), 5s(copy); streamer: mysql-bin.000007:479796212; Lag: 0.08s, State: migrating; ETA: due
2020-05-08 14:22:55 INFO Setting RENAME timeout as 3 seconds
2020-05-08 14:22:55 INFO Session renaming tables is 1502
2020-05-08 14:22:55 INFO Issuing and expecting this to block: rename /* gh-ost */ table `sbtest`.`t1_10w` to `sbtest`.`_t1_10w_del`, `sbtest`.`_t1_10w_gho` to `sbtest`.`t1_10w`
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 8s(total), 5s(copy); streamer: mysql-bin.000007:479799106; Lag: 0.08s, State: migrating; ETA: due
2020-05-08 14:22:56 INFO Found atomic RENAME to be blocking, as expected. Double checking the lock is still in place (though I don't strictly have to)
2020-05-08 14:22:56 INFO Checking session lock: gh-ost.1503.lock
2020-05-08 14:22:56 INFO Connection holding lock on original table still exists
2020-05-08 14:22:56 INFO Will now proceed to drop magic table and unlock tables
2020-05-08 14:22:56 INFO Dropping magic cut-over table
2020-05-08 14:22:56 INFO Releasing lock from `sbtest`.`t1_10w`, `sbtest`.`_t1_10w_del`
2020-05-08 14:22:56 INFO Tables unlocked
2020-05-08 14:22:56 INFO Tables renamed
2020-05-08 14:22:56 INFO Lock & rename duration: 2.007872268s. During this time, queries on `t1_10w` were blocked
2020-05-08 14:22:56 INFO Looking for magic cut-over table
[2020/05/08 14:22:56] [info] binlogsyncer.go:164 syncer is closing...
2020-05-08 14:22:56 INFO Closed streamer connection. err=<nil>
2020-05-08 14:22:56 INFO Dropping table `sbtest`.`_t1_10w_ghc`
[2020/05/08 14:22:56] [error] binlogstreamer.go:77 close sync with err: sync is been closing...
[2020/05/08 14:22:56] [info] binlogsyncer.go:179 syncer is closed
2020-05-08 14:22:56 INFO Table dropped
2020-05-08 14:22:56 INFO Dropping table `sbtest`.`_t1_10w_del`
2020-05-08 14:22:56 ERROR Error 1146: Table 'sbtest._t1_10w_ghc' doesn't exist
2020-05-08 14:22:56 INFO Table dropped
2020-05-08 14:22:56 INFO Done migrating `sbtest`.`t1_10w`
2020-05-08 14:22:56 INFO Removing socket file: /tmp/ghost.sock
2020-05-08 14:22:56 INFO Tearing down inspector
2020-05-08 14:22:56 INFO Tearing down applier
2020-05-08 14:22:56 INFO Tearing down streamer
2020-05-08 14:22:56 INFO Tearing down throttler
# Done

real	0m9.466s
user	0m0.166s
sys	0m0.061s
