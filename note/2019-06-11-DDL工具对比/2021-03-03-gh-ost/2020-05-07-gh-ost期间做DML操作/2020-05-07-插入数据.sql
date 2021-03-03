
drop table if exists t1_10w;

CREATE TABLE `t1_10w` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP PROCEDURE IF EXISTS insertbatch_t1_10w;
CREATE PROCEDURE insertbatch_t1_10w()
BEGIN
DECLARE i INT;
  SET i=1;
	start transaction;
  WHILE(i<=100000) DO
    INSERT INTO sbtest.t1_10w(id)VALUES(i);
    SET i=i+1; 
  END WHILE;
	commit;
END;

call insertbatch_t1_10w();


[root@kp04 ~]# time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_10w" --alter="engine=innodb" --allow-on-master --execute
[2020/05/07 16:23:57] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/07 16:23:57] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000006, 70118)
[2020/05/07 16:23:57] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
[2020/05/07 16:23:57] [info] binlogsyncer.go:723 rotate to (mysql-bin.000006, 70118)
2020-05-07 16:23:57 ERROR parsing time "" as "2006-01-02T15:04:05.999999999Z07:00": cannot parse "" as "2006"
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Thu May 07 16:23:57 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 0/100463 0.0%; Applied: 0; Backlog: 0/1000; Time: 0s(total), 0s(copy); streamer: mysql-bin.000006:71931; Lag: 0.00s, State: migrating; ETA: N/A
Copy: 0/100463 0.0%; Applied: 0; Backlog: 0/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000006:76353; Lag: 0.09s, State: migrating; ETA: N/A
Copy: 21000/100463 20.9%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 2s(copy); streamer: mysql-bin.000006:191315; Lag: 0.09s, State: migrating; ETA: 7s
Copy: 61000/100463 60.7%; Applied: 1; Backlog: 0/1000; Time: 3s(total), 3s(copy); streamer: mysql-bin.000006:406769; Lag: 0.08s, State: migrating; ETA: 1s
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 4s(total), 3s(copy); streamer: mysql-bin.000006:616725; Lag: 0.09s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 4s(total), 3s(copy); streamer: mysql-bin.000006:617210; Lag: 0.09s, State: migrating; ETA: due
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Thu May 07 16:23:57 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 5s(total), 3s(copy); streamer: mysql-bin.000006:622164; Lag: 0.09s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 5s(total), 3s(copy); streamer: mysql-bin.000006:623050; Lag: 0.09s, State: migrating; ETA: due
[2020/05/07 16:24:02] [info] binlogsyncer.go:164 syncer is closing...
[2020/05/07 16:24:03] [error] binlogstreamer.go:77 close sync with err: sync is been closing...
[2020/05/07 16:24:03] [info] binlogsyncer.go:179 syncer is closed
# Done

real	0m5.577s
user	0m0.133s
sys	0m0.040s
root@mysqldb 16:19:  [sbtest]> select * from `sbtest`.`t1_10w` order by id desc limit 1;
+--------+
| id     |
+--------+
| 100005 |
+--------+
1 row in set (0.00 sec)



INSERT INTO `sbtest`.`t1_10w` (`id`) VALUES ('100006');

DML 在前, row copy 在后

general log
	2020-05-07T08:23:59.970338Z	   35 Query	START TRANSACTION
	2020-05-07T08:23:59.970413Z	   35 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	2020-05-07T08:23:59.970508Z	   35 Query	insert /* gh-ost `sbtest`.`t1_10w` */ ignore into `sbtest`.`_t1_10w_gho` (`id`)
		  (select `id` from `sbtest`.`t1_10w` force index (`PRIMARY`)
			where (((`id` > _binary'27000')) and ((`id` < _binary'28000') or ((`id` = _binary'28000')))) lock in share mode
		  )
	2020-05-07T08:23:59.977374Z	   35 Query	COMMIT
	2020-05-07T08:24:00.002656Z	   36 Query	select  /* gh-ost `sbtest`.`t1_10w` iteration:28 */
							`id`
						from
							`sbtest`.`t1_10w`
						where ((`id` > _binary'28000')) and ((`id` < _binary'100005') or ((`id` = _binary'100005')))
						order by
							`id` asc
						limit 1
						offset 999
	2020-05-07T08:24:00.003936Z	   35 Query	START TRANSACTION
	2020-05-07T08:24:00.004205Z	   35 Query	insert /* gh-ost `sbtest`.`t1_10w` */ ignore into `sbtest`.`_t1_10w_gho` (`id`)
		  (select `id` from `sbtest`.`t1_10w` force index (`PRIMARY`)
			where (((`id` > _binary'28000')) and ((`id` < _binary'29000') or ((`id` = _binary'29000')))) lock in share mode
		  )
	2020-05-07T08:24:00.010880Z	   36 Query	select hint, value from `sbtest`.`_t1_10w_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-07T08:24:00.011251Z	   35 Query	COMMIT

	插入 id=100006 的数据
	2020-05-07T08:24:00.033918Z	   27 Query	INSERT INTO `sbtest`.`t1_10w` (`id`) VALUES ('100006')

	2020-05-07T08:24:00.040705Z	   35 Query	select  /* gh-ost `sbtest`.`t1_10w` iteration:29 */
							`id`
						from
							`sbtest`.`t1_10w`
						where ((`id` > _binary'29000')) and ((`id` < _binary'100005') or ((`id` = _binary'100005')))
						order by
							`id` asc
						limit 1
						offset 999
	2020-05-07T08:24:00.041282Z	   35 Query	START TRANSACTION
	2020-05-07T08:24:00.041455Z	   35 Query	insert /* gh-ost `sbtest`.`t1_10w` */ ignore into `sbtest`.`_t1_10w_gho` (`id`)
		  (select `id` from `sbtest`.`t1_10w` force index (`PRIMARY`)
			where (((`id` > _binary'29000')) and ((`id` < _binary'30000') or ((`id` = _binary'30000')))) lock in share mode
		  )
	2020-05-07T08:24:00.048754Z	   35 Query	COMMIT

	应用到影子表(_t1_10w_gho)
	如果应用binlog在后，会replace into。
	2020-05-07T08:24:00.081968Z	   36 Query	START TRANSACTION
									   replace into .....
	2020-05-07T08:24:00.082503Z	   36 Query	replace /* gh-ost `sbtest`.`_t1_10w_gho` */ into
					`sbtest`.`_t1_10w_gho`
						(`id`)
					values
						(100006)
	2020-05-07T08:24:00.082725Z	   36 Query	COMMIT

	
	2020-05-07T08:24:00.095808Z	   35 Query	select  /* gh-ost `sbtest`.`t1_10w` iteration:30 */
							`id`
						from
							`sbtest`.`t1_10w`
						where ((`id` > _binary'30000')) and ((`id` < _binary'100005') or ((`id` = _binary'100005')))
						order by
							`id` asc
						limit 1
						offset 999

	