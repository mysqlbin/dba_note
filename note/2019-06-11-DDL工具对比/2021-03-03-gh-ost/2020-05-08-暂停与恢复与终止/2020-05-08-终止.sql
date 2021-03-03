
终止运行
	我们通过来过创建 panic-flag-file 指定的文件，立即终止正在运行的gh-ost, 临时文件清理需要手动进行。

执行gh-ost 	
	time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_10w" --alter="engine=innodb" --allow-on-master --execute  --ok-to-drop-table --serve-socket-file=/tmp/ghost.sock  --panic-flag-file=/tmp/gh-ost.panic.t1.flag

创建文件/tmp/gh-ost.panic.t1.flag
	[root@kp04 tmp]# touch gh-ost.panic.t1.flag
	[root@kp04 tmp]# ll
	total 8
	-rw-r--r--. 1 root  root  0 May  8 14:32 gh-ost.panic.t1.flag

gh-ost终止运行了
	[root@kp04 data]# time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_10w" --alter="engine=innodb" --allow-on-master --execute  --ok-to-drop-table --serve-socket-file=/tmp/ghost.sock  --panic-flag-file=/tmp/gh-ost.panic.t1.flag
	[2020/05/08 14:32:03] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
	[2020/05/08 14:32:03] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000007, 481730081)
	[2020/05/08 14:32:03] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
	[2020/05/08 14:32:03] [info] binlogsyncer.go:723 rotate to (mysql-bin.000007, 481730081)
	2020-05-08 14:32:03 ERROR parsing time "" as "2006-01-02T15:04:05.999999999Z07:00": cannot parse "" as "2006"
	# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
	# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
	# Migration started at Fri May 08 14:32:03 +0800 2020
	# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
	# throttle-additional-flag-file: /tmp/gh-ost.throttle 
	# panic-flag-file: /tmp/gh-ost.panic.t1.flag
	# Serving on unix socket: /tmp/ghost.sock
	Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 0s(total), 0s(copy); streamer: mysql-bin.000007:481731894; Lag: 0.00s, State: migrating; ETA: N/A
	Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000007:481736320; Lag: 0.10s, State: migrating; ETA: N/A
	2020-05-08 14:32:05 FATAL Found panic-file /tmp/gh-ost.panic.t1.flag. Aborting without cleanup

	real	0m2.379s
	user	0m0.040s
	sys	0m0.017s


gh-ost log提示
	FATAL Found panic-file /tmp/gh-ost.panic.t1.flag. Aborting without cleanup

注意事项
	停止gh-ost操作会有遗留表 xxx_ghc, xxx_gho 还有socket文件，管理cut-over的文件,如果你需要执行两次请务必检查指定目录是否存在这些文件，并且清理掉文件和表
	root@mysqldb 14:35:  [sbtest]> show tables;
	+------------------+
	| Tables_in_sbtest |
	+------------------+
	| _t1_10w_ghc      |
	| _t1_10w_gho      |
	| sbtest1          |
	| t1_10w           |
	| t1_1w            |
	| t1_2500          |
	+------------------+
	6 rows in set (0.01 sec)

	[root@kp04 tmp]# ll
	total 8
	-rw-r--r--. 1 root  root  0 May  8 14:32 gh-ost.panic.t1.flag
	srwxr-xr-x. 1 root  root  0 May  8 14:32 ghost.sock
