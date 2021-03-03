
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
[2020/05/07 16:46:29] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/07 16:46:29] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000006, 625864)
[2020/05/07 16:46:29] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
[2020/05/07 16:46:29] [info] binlogsyncer.go:723 rotate to (mysql-bin.000006, 625864)
2020-05-07 16:46:29 ERROR parsing time "" as "2006-01-02T15:04:05.999999999Z07:00": cannot parse "" as "2006"
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Thu May 07 16:46:29 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 0/100470 0.0%; Applied: 0; Backlog: 0/1000; Time: 0s(total), 0s(copy); streamer: mysql-bin.000006:627677; Lag: 0.00s, State: migrating; ETA: N/A
Copy: 0/100470 0.0%; Applied: 0; Backlog: 0/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000006:632100; Lag: 0.10s, State: migrating; ETA: N/A
Copy: 24000/100470 23.9%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 2s(copy); streamer: mysql-bin.000006:762844; Lag: 0.10s, State: migrating; ETA: 6s
Copy: 63000/100470 62.7%; Applied: 1; Backlog: 0/1000; Time: 3s(total), 3s(copy); streamer: mysql-bin.000006:971971; Lag: 0.30s, State: migrating; ETA: 1s
Copy: 81000/100470 80.6%; Applied: 1; Backlog: 0/1000; Time: 4s(total), 4s(copy); streamer: mysql-bin.000006:1069957; Lag: 0.10s, State: migrating; ETA: 0s
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 4s(total), 4s(copy); streamer: mysql-bin.000006:1172288; Lag: 0.10s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 1/1000; Time: 5s(total), 4s(copy); streamer: mysql-bin.000006:1176638; Lag: 0.10s, State: migrating; ETA: due
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Thu May 07 16:46:29 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 5s(total), 4s(copy); streamer: mysql-bin.000006:1178327; Lag: 0.10s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 6s(total), 4s(copy); streamer: mysql-bin.000006:1181827; Lag: 0.10s, State: migrating; ETA: due
[2020/05/07 16:46:35] [info] binlogsyncer.go:164 syncer is closing...
[2020/05/07 16:46:35] [error] binlogstreamer.go:77 close sync with err: sync is been closing...
[2020/05/07 16:46:35] [info] binlogsyncer.go:179 syncer is closed
# Done

real	0m6.833s
user	0m0.141s
sys	0m0.047s



root@mysqldb 16:19:  [sbtest]> select * from `sbtest`.`t1_10w` order by id desc limit 1;
+--------+
| id     |
+--------+
| 100006 |
+--------+
1 row in set (0.00 sec)

root@mysqldb 16:44:  [sbtest]> delete from `sbtest`.`t1_10w` where id=100006;
Query OK, 1 row affected (0.01 sec)

root@mysqldb 16:46:  [sbtest]> select * from `sbtest`.`t1_10w` order by id desc limit 1;
+--------+
| id     |
+--------+
| 100005 |
+--------+
1 row in set (0.01 sec)

DML 在前, row copy 在后

general log
	2020-05-07T08:46:31.715296Z	   54 Query	START TRANSACTION
	2020-05-07T08:46:31.715446Z	   54 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	2020-05-07T08:46:31.715543Z	   54 Query	insert /* gh-ost `sbtest`.`t1_10w` */ ignore into `sbtest`.`_t1_10w_gho` (`id`)
		  (select `id` from `sbtest`.`t1_10w` force index (`PRIMARY`)
			where (((`id` > _binary'38000')) and ((`id` < _binary'39000') or ((`id` = _binary'39000')))) lock in share mode
		  )
	2020-05-07T08:46:31.721725Z	   54 Query	COMMIT
	
	删除数据
	2020-05-07T08:46:31.730329Z	   41 Query	delete from `sbtest`.`t1_10w` where id=100006
	2020-05-07T08:46:31.735237Z	   57 Query	select  /* gh-ost `sbtest`.`t1_10w` iteration:39 */
							`id`
						from
							`sbtest`.`t1_10w`
						where ((`id` > _binary'39000')) and ((`id` < _binary'100006') or ((`id` = _binary'100006')))
						order by
							`id` asc
						limit 1
						offset 999
	2020-05-07T08:46:31.737023Z	   54 Query	START TRANSACTION
	2020-05-07T08:46:31.737207Z	   54 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	2020-05-07T08:46:31.737384Z	   54 Query	insert /* gh-ost `sbtest`.`t1_10w` */ ignore into `sbtest`.`_t1_10w_gho` (`id`)
		  (select `id` from `sbtest`.`t1_10w` force index (`PRIMARY`)
			where (((`id` > _binary'39000')) and ((`id` < _binary'40000') or ((`id` = _binary'40000')))) lock in share mode
		  )
	2020-05-07T08:46:31.744497Z	   54 Query	COMMIT
	2020-05-07T08:46:31.759010Z	   57 Query	START TRANSACTION
	2020-05-07T08:46:31.760291Z	   57 Query	SET SESSION time_zone = '+00:00', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	
	应用到影子表(_t1_10w_gho)
	新表数据还不存在，应用binlog为空操作，会等copy迁移。
	2020-05-07T08:46:31.760473Z	   57 Query	delete /* gh-ost `sbtest`.`_t1_10w_gho` */
					from
						`sbtest`.`_t1_10w_gho`
					where
						((`id` = 100006))
	2020-05-07T08:46:31.760616Z	   57 Query	COMMIT
	2020-05-07T08:46:31.760744Z	   54 Query	select  /* gh-ost `sbtest`.`t1_10w` iteration:40 */
							`id`
						from
							`sbtest`.`t1_10w`
						where ((`id` > _binary'40000')) and ((`id` < _binary'100006') or ((`id` = _binary'100006')))
						order by
							`id` asc
						limit 1
						offset 999
	