
暂停和恢复：
	使用socket监听请求，操作者可以在命令运行后更改相应的参数。
		--serve-socket-file string：socket文件
		--serve-socket-file=/tmp/ghost.sock
		当执行操作的过程中发现负载、延迟上升了，不得不终止操作，重新配置参数，如 chunk-size，然后重新执行操作命令； 
		#暂停
		echo throttle | socat - /tmp/ghost.sock
		#恢复
		echo no-throttle | socat - /tmp/ghost.sock
	
动态调整性能参数：
	echo chunk-size=100 | socat - /tmp/ghost.sock
	echo max-lag-millis=200 | socat - /tmp/ghost.sock
	echo max-load=Thread_running=3 | socat - /tmp/ghost.sock	
	
	
root@mysqldb 11:41:  [sbtest]> select count(*) from sbtest.t1_10w;
+----------+
| count(*) |
+----------+
|   100005 |
+----------+
1 row in set (0.83 sec)

执行 gh-ost
	time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_10w" --alter="engine=innodb" --allow-on-master --execute  --ok-to-drop-table --serve-socket-file=/tmp/ghost.sock 

暂停 gh-ost
	echo throttle | socat - /tmp/ghost.sock

select * from sbtest.t1_10w order by id desc limit 1;

动态调整参数 chunk-size
	echo chunk-size=100 | socat - /tmp/ghost.sock

恢复 gh-ost
	echo no-throttle | socat - /tmp/ghost.sock


运行详情如下

shell>  echo throttle | socat - /tmp/ghost.sock
# Note: you may only throttle for as long as your binary logs are not purged
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 12:08:19 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 1s(copy); streamer: mysql-bin.000007:386514090; Lag: 0.51s, State: migrating; ETA: N/A


shell> echo chunk-size=100 | socat - /tmp/ghost.sock
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 12:08:19 +0800 2020
# chunk-size: 100; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 22s(total), 22s(copy); streamer: mysql-bin.000007:386630967; Lag: 20.21s, State: throttled, commanded by user; ETA: 3m0s


shell> echo no-throttle | socat - /tmp/ghost.sock
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 12:08:19 +0800 2020
# chunk-size: 100; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m31s(total), 2m30s(copy); streamer: mysql-bin.000007:386660295; Lag: 148.61s, State: throttled, commanded by user; ETA: 20m23s


[root@kp04 data]# time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_10w" --alter="engine=innodb" --allow-on-master --execute  --ok-to-drop-table --serve-socket-file=/tmp/ghost.sock
[2020/05/08 12:08:19] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/08 12:08:19] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000007, 386507448)
[2020/05/08 12:08:19] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
[2020/05/08 12:08:19] [info] binlogsyncer.go:723 rotate to (mysql-bin.000007, 386507448)
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 12:08:19 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 0s(total), 0s(copy); streamer: mysql-bin.000007:386509601; Lag: 0.07s, State: migrating; ETA: N/A
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 12:08:19 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000007:386514090; Lag: 0.01s, State: migrating; ETA: N/A
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 1s(copy); streamer: mysql-bin.000007:386514090; Lag: 0.51s, State: migrating; ETA: N/A
Copy: 6000/100275 6.0%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 2s(copy); streamer: mysql-bin.000007:386572410; Lag: 0.11s, State: migrating; ETA: 31s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 3s(total), 3s(copy); streamer: mysql-bin.000007:386620824; Lag: 0.91s, State: throttled, commanded by user; ETA: 24s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 4s(total), 4s(copy); streamer: mysql-bin.000007:386621328; Lag: 1.91s, State: throttled, commanded by user; ETA: 32s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 5s(total), 5s(copy); streamer: mysql-bin.000007:386621832; Lag: 2.91s, State: throttled, commanded by user; ETA: 40s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 6s(total), 6s(copy); streamer: mysql-bin.000007:386622336; Lag: 3.91s, State: throttled, commanded by user; ETA: 48s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 7s(total), 7s(copy); streamer: mysql-bin.000007:386622840; Lag: 4.91s, State: throttled, commanded by user; ETA: 56s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 8s(total), 8s(copy); streamer: mysql-bin.000007:386623344; Lag: 5.91s, State: throttled, commanded by user; ETA: 1m5s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 9s(total), 9s(copy); streamer: mysql-bin.000007:386623849; Lag: 6.91s, State: throttled, commanded by user; ETA: 1m13s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 10s(total), 10s(copy); streamer: mysql-bin.000007:386624355; Lag: 7.91s, State: throttled, commanded by user; ETA: 1m21s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 11s(total), 11s(copy); streamer: mysql-bin.000007:386624863; Lag: 8.91s, State: throttled, commanded by user; ETA: 1m29s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 12s(total), 12s(copy); streamer: mysql-bin.000007:386625371; Lag: 9.91s, State: throttled, commanded by user; ETA: 1m37s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 13s(total), 13s(copy); streamer: mysql-bin.000007:386625879; Lag: 10.91s, State: throttled, commanded by user; ETA: 1m45s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 14s(total), 14s(copy); streamer: mysql-bin.000007:386626388; Lag: 11.91s, State: throttled, commanded by user; ETA: 1m53s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 15s(total), 15s(copy); streamer: mysql-bin.000007:386626897; Lag: 12.91s, State: throttled, commanded by user; ETA: 2m1s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 16s(total), 16s(copy); streamer: mysql-bin.000007:386627405; Lag: 13.91s, State: throttled, commanded by user; ETA: 2m9s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 17s(total), 17s(copy); streamer: mysql-bin.000007:386627913; Lag: 14.91s, State: throttled, commanded by user; ETA: 2m18s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 18s(total), 18s(copy); streamer: mysql-bin.000007:386628422; Lag: 15.91s, State: throttled, commanded by user; ETA: 2m26s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 19s(total), 19s(copy); streamer: mysql-bin.000007:386628931; Lag: 16.91s, State: throttled, commanded by user; ETA: 2m34s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 20s(total), 20s(copy); streamer: mysql-bin.000007:386629440; Lag: 17.91s, State: throttled, commanded by user; ETA: 2m42s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 21s(total), 21s(copy); streamer: mysql-bin.000007:386629949; Lag: 18.91s, State: throttled, commanded by user; ETA: 2m50s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 22s(total), 22s(copy); streamer: mysql-bin.000007:386630458; Lag: 19.91s, State: throttled, commanded by user; ETA: 2m58s
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 12:08:19 +0800 2020

动态调整参数 chunk-size 为 100
# chunk-size: 100; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 22s(total), 22s(copy); streamer: mysql-bin.000007:386630967; Lag: 20.21s, State: throttled, commanded by user; ETA: 3m0s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 23s(total), 23s(copy); streamer: mysql-bin.000007:386631705; Lag: 20.91s, State: throttled, commanded by user; ETA: 3m6s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 24s(total), 24s(copy); streamer: mysql-bin.000007:386632213; Lag: 21.91s, State: throttled, commanded by user; ETA: 3m14s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 25s(total), 25s(copy); streamer: mysql-bin.000007:386632722; Lag: 22.91s, State: throttled, commanded by user; ETA: 3m23s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 26s(total), 26s(copy); streamer: mysql-bin.000007:386633231; Lag: 23.91s, State: throttled, commanded by user; ETA: 3m31s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 27s(total), 27s(copy); streamer: mysql-bin.000007:386633740; Lag: 24.91s, State: throttled, commanded by user; ETA: 3m39s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 28s(total), 28s(copy); streamer: mysql-bin.000007:386634249; Lag: 25.91s, State: throttled, commanded by user; ETA: 3m47s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 29s(total), 29s(copy); streamer: mysql-bin.000007:386634758; Lag: 26.91s, State: throttled, commanded by user; ETA: 3m55s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 30s(total), 30s(copy); streamer: mysql-bin.000007:386635267; Lag: 27.91s, State: throttled, commanded by user; ETA: 4m3s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 31s(total), 31s(copy); streamer: mysql-bin.000007:386635775; Lag: 28.91s, State: throttled, commanded by user; ETA: 4m11s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 32s(total), 32s(copy); streamer: mysql-bin.000007:386636284; Lag: 29.91s, State: throttled, commanded by user; ETA: 4m19s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 33s(total), 33s(copy); streamer: mysql-bin.000007:386636793; Lag: 30.91s, State: throttled, commanded by user; ETA: 4m27s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 34s(total), 34s(copy); streamer: mysql-bin.000007:386637302; Lag: 31.91s, State: throttled, commanded by user; ETA: 4m36s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 35s(total), 35s(copy); streamer: mysql-bin.000007:386637811; Lag: 32.91s, State: throttled, commanded by user; ETA: 4m44s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 36s(total), 36s(copy); streamer: mysql-bin.000007:386638320; Lag: 33.91s, State: throttled, commanded by user; ETA: 4m52s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 37s(total), 37s(copy); streamer: mysql-bin.000007:386638829; Lag: 34.91s, State: throttled, commanded by user; ETA: 5m0s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 38s(total), 38s(copy); streamer: mysql-bin.000007:386639337; Lag: 35.91s, State: throttled, commanded by user; ETA: 5m8s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 39s(total), 39s(copy); streamer: mysql-bin.000007:386639845; Lag: 36.91s, State: throttled, commanded by user; ETA: 5m16s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 40s(total), 40s(copy); streamer: mysql-bin.000007:386640354; Lag: 37.91s, State: throttled, commanded by user; ETA: 5m24s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 41s(total), 41s(copy); streamer: mysql-bin.000007:386640863; Lag: 38.91s, State: throttled, commanded by user; ETA: 5m32s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 42s(total), 42s(copy); streamer: mysql-bin.000007:386641372; Lag: 39.91s, State: throttled, commanded by user; ETA: 5m40s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 43s(total), 43s(copy); streamer: mysql-bin.000007:386641881; Lag: 40.91s, State: throttled, commanded by user; ETA: 5m49s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 44s(total), 44s(copy); streamer: mysql-bin.000007:386642390; Lag: 41.91s, State: throttled, commanded by user; ETA: 5m57s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 45s(total), 45s(copy); streamer: mysql-bin.000007:386642899; Lag: 42.91s, State: throttled, commanded by user; ETA: 6m5s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 46s(total), 46s(copy); streamer: mysql-bin.000007:386643407; Lag: 43.91s, State: throttled, commanded by user; ETA: 6m13s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 47s(total), 47s(copy); streamer: mysql-bin.000007:386643916; Lag: 44.91s, State: throttled, commanded by user; ETA: 6m21s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 48s(total), 48s(copy); streamer: mysql-bin.000007:386644425; Lag: 45.91s, State: throttled, commanded by user; ETA: 6m29s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 49s(total), 49s(copy); streamer: mysql-bin.000007:386644934; Lag: 46.91s, State: throttled, commanded by user; ETA: 6m37s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 50s(total), 50s(copy); streamer: mysql-bin.000007:386645443; Lag: 47.91s, State: throttled, commanded by user; ETA: 6m45s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 51s(total), 51s(copy); streamer: mysql-bin.000007:386645952; Lag: 48.91s, State: throttled, commanded by user; ETA: 6m54s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 52s(total), 52s(copy); streamer: mysql-bin.000007:386646461; Lag: 49.91s, State: throttled, commanded by user; ETA: 7m2s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 53s(total), 53s(copy); streamer: mysql-bin.000007:386646969; Lag: 50.91s, State: throttled, commanded by user; ETA: 7m10s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 54s(total), 54s(copy); streamer: mysql-bin.000007:386647478; Lag: 51.91s, State: throttled, commanded by user; ETA: 7m18s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 55s(total), 55s(copy); streamer: mysql-bin.000007:386647987; Lag: 52.91s, State: throttled, commanded by user; ETA: 7m26s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 56s(total), 56s(copy); streamer: mysql-bin.000007:386648496; Lag: 53.91s, State: throttled, commanded by user; ETA: 7m34s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 57s(total), 57s(copy); streamer: mysql-bin.000007:386649005; Lag: 54.91s, State: throttled, commanded by user; ETA: 7m42s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 58s(total), 58s(copy); streamer: mysql-bin.000007:386649514; Lag: 55.91s, State: throttled, commanded by user; ETA: 7m50s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 59s(total), 59s(copy); streamer: mysql-bin.000007:386650023; Lag: 56.91s, State: throttled, commanded by user; ETA: 7m58s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m0s(total), 1m0s(copy); streamer: mysql-bin.000007:386650532; Lag: 57.91s, State: throttled, commanded by user; ETA: 8m7s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m5s(total), 1m5s(copy); streamer: mysql-bin.000007:386651042; Lag: 62.91s, State: throttled, commanded by user; ETA: 8m47s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m10s(total), 1m10s(copy); streamer: mysql-bin.000007:386651553; Lag: 67.91s, State: throttled, commanded by user; ETA: 9m28s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m15s(total), 1m15s(copy); streamer: mysql-bin.000007:386652066; Lag: 72.91s, State: throttled, commanded by user; ETA: 10m8s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m20s(total), 1m20s(copy); streamer: mysql-bin.000007:386652579; Lag: 77.91s, State: throttled, commanded by user; ETA: 10m49s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m25s(total), 1m25s(copy); streamer: mysql-bin.000007:386653093; Lag: 82.91s, State: throttled, commanded by user; ETA: 11m29s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m30s(total), 1m30s(copy); streamer: mysql-bin.000007:386653607; Lag: 87.91s, State: throttled, commanded by user; ETA: 12m10s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m35s(total), 1m35s(copy); streamer: mysql-bin.000007:386654121; Lag: 92.91s, State: throttled, commanded by user; ETA: 12m51s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m40s(total), 1m40s(copy); streamer: mysql-bin.000007:386654635; Lag: 97.91s, State: throttled, commanded by user; ETA: 13m31s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m45s(total), 1m45s(copy); streamer: mysql-bin.000007:386655149; Lag: 102.91s, State: throttled, commanded by user; ETA: 14m12s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m50s(total), 1m50s(copy); streamer: mysql-bin.000007:386655664; Lag: 107.91s, State: throttled, commanded by user; ETA: 14m52s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 1m55s(total), 1m55s(copy); streamer: mysql-bin.000007:386656179; Lag: 112.91s, State: throttled, commanded by user; ETA: 15m33s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m0s(total), 2m0s(copy); streamer: mysql-bin.000007:386656694; Lag: 117.91s, State: throttled, commanded by user; ETA: 16m14s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m5s(total), 2m5s(copy); streamer: mysql-bin.000007:386657207; Lag: 122.91s, State: throttled, commanded by user; ETA: 16m54s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m10s(total), 2m10s(copy); streamer: mysql-bin.000007:386657720; Lag: 127.91s, State: throttled, commanded by user; ETA: 17m35s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m15s(total), 2m15s(copy); streamer: mysql-bin.000007:386658235; Lag: 132.91s, State: throttled, commanded by user; ETA: 18m15s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m20s(total), 2m20s(copy); streamer: mysql-bin.000007:386658750; Lag: 137.91s, State: throttled, commanded by user; ETA: 18m56s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m25s(total), 2m25s(copy); streamer: mysql-bin.000007:386659265; Lag: 142.91s, State: throttled, commanded by user; ETA: 19m36s
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m30s(total), 2m30s(copy); streamer: mysql-bin.000007:386659780; Lag: 147.91s, State: throttled, commanded by user; ETA: 20m17s
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 12:08:19 +0800 2020
# chunk-size: 100; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 11000/100275 11.0%; Applied: 0; Backlog: 0/1000; Time: 2m31s(total), 2m30s(copy); streamer: mysql-bin.000007:386660295; Lag: 148.61s, State: throttled, commanded by user; ETA: 20m23s
Copy: 32300/100275 32.2%; Applied: 0; Backlog: 0/1000; Time: 2m35s(total), 2m35s(copy); streamer: mysql-bin.000007:386925244; Lag: 0.11s, State: migrating; ETA: 5m26s
Copy: 74500/100275 74.3%; Applied: 0; Backlog: 0/1000; Time: 2m40s(total), 2m40s(copy); streamer: mysql-bin.000007:387436142; Lag: 0.11s, State: migrating; ETA: 55s
Copy: 80600/100275 80.4%; Applied: 0; Backlog: 0/1000; Time: 2m41s(total), 2m41s(copy); streamer: mysql-bin.000007:387511125; Lag: 0.11s, State: migrating; ETA: 39s
Copy: 83900/100275 83.7%; Applied: 0; Backlog: 0/1000; Time: 2m42s(total), 2m42s(copy); streamer: mysql-bin.000007:387552770; Lag: 0.01s, State: migrating; ETA: 31s
Copy: 89400/100275 89.2%; Applied: 0; Backlog: 0/1000; Time: 2m43s(total), 2m43s(copy); streamer: mysql-bin.000007:387619617; Lag: 0.01s, State: migrating; ETA: 19s
Copy: 96700/100275 96.4%; Applied: 0; Backlog: 0/1000; Time: 2m44s(total), 2m44s(copy); streamer: mysql-bin.000007:387710105; Lag: 0.11s, State: migrating; ETA: 6s
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 2m45s(total), 2m44s(copy); streamer: mysql-bin.000007:387751252; Lag: 0.11s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 2m45s(total), 2m44s(copy); streamer: mysql-bin.000007:387752949; Lag: 0.04s, State: migrating; ETA: due
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Fri May 08 12:08:19 +0800 2020
# chunk-size: 100; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/ghost.sock
Copy: 100005/100005 100.0%; Applied: 0; Backlog: 0/1000; Time: 2m46s(total), 2m44s(copy); streamer: mysql-bin.000007:387756906; Lag: 0.01s, State: migrating; ETA: due
[2020/05/08 12:11:06] [info] binlogsyncer.go:164 syncer is closing...
[2020/05/08 12:11:06] [error] binlogstreamer.go:77 close sync with err: sync is been closing...
[2020/05/08 12:11:06] [info] binlogsyncer.go:179 syncer is closed
# Done

real	2m46.703s
user	0m0.854s
sys	0m0.539s





