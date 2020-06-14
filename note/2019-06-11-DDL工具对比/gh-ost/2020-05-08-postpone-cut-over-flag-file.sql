2020-05-08 16:42:53 INFO starting gh-ost 1.0.49
2020-05-08 16:42:53 INFO Migrating `sbtest`.`t1_10w`
2020-05-08 16:42:53 INFO connection validated on 192.168.0.91:3306
2020-05-08 16:42:53 INFO User has SUPER, REPLICATION SLAVE privileges, and has ALL privileges on `sbtest`.*
2020-05-08 16:42:53 INFO binary logs validated on 192.168.0.91:3306
2020-05-08 16:42:53 INFO Inspector initiated on kp04:3306, version 8.0.18
2020-05-08 16:42:53 INFO Table found. Engine=InnoDB
2020-05-08 16:42:53 INFO Estimated number of rows via EXPLAIN: 100275
2020-05-08 16:42:53 INFO Recursively searching for replication master
2020-05-08 16:42:53 INFO Master found to be kp04:3306
2020-05-08 16:42:53 INFO log_slave_updates validated on 192.168.0.91:3306
2020-05-08 16:42:53 INFO connection validated on 192.168.0.91:3306
2020-05-08 16:42:53 INFO Connecting binlog streamer at mysql-bin.000007:484526089
[2020/05/08 16:42:53] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 root    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/08 16:42:53] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000007, 484526089)
[2020/05/08 16:42:53] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
2020-05-08 16:42:53 INFO connection validated on 192.168.0.91:3306
2020-05-08 16:42:53 INFO connection validated on 192.168.0.91:3306
2020-05-08 16:42:53 INFO will use time_zone='SYSTEM' on applier
2020-05-08 16:42:53 INFO Examining table structure on applier
2020-05-08 16:42:53 INFO Applier initiated on kp04:3306, version 8.0.18
2020-05-08 16:42:53 INFO Dropping table `sbtest`.`_t1_10w_ghc`
2020-05-08 16:42:53 INFO Table dropped
2020-05-08 16:42:53 INFO Creating changelog table `sbtest`.`_t1_10w_ghc`
2020-05-08 16:42:53 INFO rotate to next log from mysql-bin.000007:0 to mysql-bin.000007
[2020/05/08 16:42:53] [info] binlogsyncer.go:723 rotate to (mysql-bin.000007, 484526089)
2020-05-08 16:42:53 INFO Changelog table created
2020-05-08 16:42:53 INFO Creating ghost table `sbtest`.`_t1_10w_gho`
2020-05-08 16:42:53 INFO Ghost table created
2020-05-08 16:42:53 INFO Altering ghost table `sbtest`.`_t1_10w_gho`
2020-05-08 16:42:53 INFO Ghost table altered
2020-05-08 16:42:53 INFO Intercepted changelog state GhostTableMigrated
2020-05-08 16:42:53 INFO Created postpone-cut-over-flag-file: /tmp/ghost.postpone.flag
2020-05-08 16:42:53 INFO Waiting for ghost table to be migrated. Current lag is 0s
2020-05-08 16:42:53 INFO Handled changelog state GhostTableMigrated
2020-05-08 16:42:53 INFO Chosen shared unique key is PRIMARY
2020-05-08 16:42:53 INFO Shared columns are id,c1
2020-05-08 16:42:53 INFO Listening on unix socket file: /tmp/gh-ost.sbtest.t1_10w.sock
2020-05-08 16:42:53 INFO Migration min values: [1]
2020-05-08 16:42:53 INFO Migration max values: [100005]
2020-05-08 16:42:53 INFO Waiting for first throttle metrics to be collected
2020-05-08 16:42:53 INFO First throttle metrics collected
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 16:42:53 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: Threads_running=20; critical-load: Threads_running=50; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# postpone-cut-over-flag-file: /tmp/ghost.postpone.flag [set]
# panic-flag-file: /tmp/ghost.panic.flag
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 0s(total), 0s(copy); streamer: mysql-bin.000007:484528242; Lag: 0.02s, State: migrating; ETA: N/A
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000007:484528721; Lag: 1.03s, State: migrating; ETA: N/A
Copy: 16000/100275 16.0%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 2s(copy); streamer: mysql-bin.000007:484678289; Lag: 1.00s, State: migrating; ETA: 10s
Copy: 50000/100275 49.9%; Applied: 0; Backlog: 0/1000; Time: 3s(total), 3s(copy); streamer: mysql-bin.000007:484995137; Lag: 1.01s, State: migrating; ETA: 3s
Copy: 92000/100275 91.7%; Applied: 0; Backlog: 0/1000; Time: 4s(total), 4s(copy); streamer: mysql-bin.000007:485386729; Lag: 1.00s, State: migrating; ETA: 0s
2020-05-08 16:42:58 INFO Row copy complete
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 5s(total), 4s(copy); streamer: mysql-bin.000007:485461864; Lag: 1.00s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 5s(total), 4s(copy); streamer: mysql-bin.000007:485462352; Lag: 1.00s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 6s(total), 4s(copy); streamer: mysql-bin.000007:485463861; Lag: 1.00s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 7s(total), 4s(copy); streamer: mysql-bin.000007:485464359; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 8s(total), 4s(copy); streamer: mysql-bin.000007:485465258; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 9s(total), 4s(copy); streamer: mysql-bin.000007:485466155; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 10s(total), 4s(copy); streamer: mysql-bin.000007:485467052; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 11s(total), 4s(copy); streamer: mysql-bin.000007:485467952; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 12s(total), 4s(copy); streamer: mysql-bin.000007:485468852; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 13s(total), 4s(copy); streamer: mysql-bin.000007:485469752; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 14s(total), 4s(copy); streamer: mysql-bin.000007:485470652; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 15s(total), 4s(copy); streamer: mysql-bin.000007:485471552; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 16s(total), 4s(copy); streamer: mysql-bin.000007:485472452; Lag: 1.00s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 17s(total), 4s(copy); streamer: mysql-bin.000007:485473753; Lag: 1.00s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 18s(total), 4s(copy); streamer: mysql-bin.000007:485474653; Lag: 1.00s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 19s(total), 4s(copy); streamer: mysql-bin.000007:485475152; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 20s(total), 4s(copy); streamer: mysql-bin.000007:485476453; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 21s(total), 4s(copy); streamer: mysql-bin.000007:485476952; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 22s(total), 4s(copy); streamer: mysql-bin.000007:485478253; Lag: 1.00s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 23s(total), 4s(copy); streamer: mysql-bin.000007:485478752; Lag: 1.01s, State: postponing cut-over; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 24s(total), 4s(copy); streamer: mysql-bin.000007:485479652; Lag: 1.01s, State: postponing cut-over; ETA: due

2020-05-08 16:43:18 INFO Grabbing voluntary lock: gh-ost.1654.lock
2020-05-08 16:43:18 INFO Setting LOCK timeout as 2 seconds
2020-05-08 16:43:18 INFO Looking for magic cut-over table
2020-05-08 16:43:18 INFO Creating magic cut-over table `sbtest`.`_t1_10w_20200508164253_del`
2020-05-08 16:43:18 INFO Magic cut-over table created
2020-05-08 16:43:18 INFO Locking `sbtest`.`t1_10w`, `sbtest`.`_t1_10w_20200508164253_del`
2020-05-08 16:43:18 INFO Tables locked
2020-05-08 16:43:18 INFO Session locking original & magic tables is 1654
2020-05-08 16:43:18 INFO Writing changelog state: AllEventsUpToLockProcessed:1588927398310474578
2020-05-08 16:43:18 INFO Intercepted changelog state AllEventsUpToLockProcessed
2020-05-08 16:43:18 INFO Handled changelog state AllEventsUpToLockProcessed
2020-05-08 16:43:18 INFO Waiting for events up to lock
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 1/1000; Time: 25s(total), 4s(copy); streamer: mysql-bin.000007:485481623; Lag: 1.01s, State: migrating; ETA: due
2020-05-08 16:43:19 INFO Waiting for events up to lock: got AllEventsUpToLockProcessed:1588927398310474578
2020-05-08 16:43:19 INFO Done waiting for events up to lock; duration=832.764462ms
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 16:42:53 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: Threads_running=20; critical-load: Threads_running=50; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# postpone-cut-over-flag-file: /tmp/ghost.postpone.flag 
# panic-flag-file: /tmp/ghost.panic.flag
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 26s(total), 4s(copy); streamer: mysql-bin.000007:485482512; Lag: 1.01s, State: migrating; ETA: due
2020-05-08 16:43:19 INFO Setting RENAME timeout as 1 seconds
2020-05-08 16:43:19 INFO Session renaming tables is 1658
2020-05-08 16:43:19 INFO Issuing and expecting this to block: rename /* gh-ost */ table `sbtest`.`t1_10w` to `sbtest`.`_t1_10w_20200508164253_del`, `sbtest`.`_t1_10w_gho` to `sbtest`.`t1_10w`
2020-05-08 16:43:19 INFO Found atomic RENAME to be blocking, as expected. Double checking the lock is still in place (though I don't strictly have to)
2020-05-08 16:43:19 INFO Checking session lock: gh-ost.1654.lock
2020-05-08 16:43:19 INFO Connection holding lock on original table still exists
2020-05-08 16:43:19 INFO Will now proceed to drop magic table and unlock tables
2020-05-08 16:43:19 INFO Dropping magic cut-over table
2020-05-08 16:43:19 INFO Releasing lock from `sbtest`.`t1_10w`, `sbtest`.`_t1_10w_20200508164253_del`
2020-05-08 16:43:19 INFO Tables unlocked
2020-05-08 16:43:19 INFO Tables renamed
2020-05-08 16:43:19 INFO Lock & rename duration: 1.187715034s. During this time, queries on `t1_10w` were blocked
2020-05-08 16:43:19 INFO Looking for magic cut-over table
[2020/05/08 16:43:19] [info] binlogsyncer.go:164 syncer is closing...
2020-05-08 16:43:19 INFO Closed streamer connection. err=<nil>
2020-05-08 16:43:19 INFO Dropping table `sbtest`.`_t1_10w_ghc`
[2020/05/08 16:43:19] [error] binlogsyncer.go:631 connection was bad
[2020/05/08 16:43:19] [error] binlogstreamer.go:77 close sync with err: Sync was closed
[2020/05/08 16:43:19] [info] binlogsyncer.go:179 syncer is closed
2020-05-08 16:43:19 INFO Table dropped
2020-05-08 16:43:19 INFO Am not dropping old table because I want this operation to be as live as possible. If you insist I should do it, please add `--ok-to-drop-table` next time. But I prefer you do not. To drop the old table, issue:
2020-05-08 16:43:19 INFO -- drop table `sbtest`.`_t1_10w_20200508164253_del`
2020-05-08 16:43:19 INFO Done migrating `sbtest`.`t1_10w`
2020-05-08 16:43:19 INFO Removing socket file: /tmp/gh-ost.sbtest.t1_10w.sock
2020-05-08 16:43:19 INFO Tearing down inspector
2020-05-08 16:43:19 INFO Tearing down applier
2020-05-08 16:43:19 INFO Tearing down streamer
2020-05-08 16:43:19 INFO Tearing down throttler
# Done
