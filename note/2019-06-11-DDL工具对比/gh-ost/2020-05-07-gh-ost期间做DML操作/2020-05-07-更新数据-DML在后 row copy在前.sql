
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



DML在后, row copy 在前

alter table t1_10w add column c1 int(10) not null default 0;


[root@kp04 ~]# time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_10w" --alter="engine=innodb" --allow-on-master --execute
[2020/05/07 18:14:02] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/07 18:14:02] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000006, 1185460)
[2020/05/07 18:14:02] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
[2020/05/07 18:14:02] [info] binlogsyncer.go:723 rotate to (mysql-bin.000006, 1185460)
2020-05-07 18:14:02 ERROR parsing time "" as "2006-01-02T15:04:05.999999999Z07:00": cannot parse "" as "2006"
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Thu May 07 18:14:02 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 0/100575 0.0%; Applied: 0; Backlog: 0/1000; Time: 0s(total), 0s(copy); streamer: mysql-bin.000006:1187273; Lag: 0.00s, State: migrating; ETA: N/A
Copy: 0/100575 0.0%; Applied: 0; Backlog: 0/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000006:1191699; Lag: 0.11s, State: migrating; ETA: N/A
Copy: 31000/100575 30.8%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 2s(copy); streamer: mysql-bin.000006:1474976; Lag: 0.09s, State: migrating; ETA: 4s
Copy: 78000/100575 77.6%; Applied: 1; Backlog: 0/1000; Time: 3s(total), 3s(copy); streamer: mysql-bin.000006:1916814; Lag: 0.10s, State: migrating; ETA: 0s
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 3s(total), 3s(copy); streamer: mysql-bin.000006:2133347; Lag: 0.09s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 1/1000; Time: 4s(total), 3s(copy); streamer: mysql-bin.000006:2136895; Lag: 0.09s, State: migrating; ETA: due
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Thu May 07 18:14:02 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 4s(total), 3s(copy); streamer: mysql-bin.000006:2139383; Lag: 0.09s, State: migrating; ETA: due
[2020/05/07 18:14:07] [info] binlogsyncer.go:164 syncer is closing...
[2020/05/07 18:14:07] [error] binlogstreamer.go:77 close sync with err: sync is been closing...
[2020/05/07 18:14:07] [info] binlogsyncer.go:179 syncer is closed
# Done

real	0m4.918s
user	0m0.152s
sys	0m0.028s


root@mysqldb 18:13:  [sbtest]> select * from `sbtest`.`t1_10w` order by id asc limit 1;
+----+----+
| id | c1 |
+----+----+
|  1 |  0 |
+----+----+
1 row in set (0.00 sec)



update `sbtest`.`t1_10w` set c1=1 where id=1;

root@mysqldb 18:14:  [sbtest]>  select * from `sbtest`.`t1_10w` order by id asc limit 1;
+----+----+
| id | c1 |
+----+----+
|  1 |  1 |
+----+----+
1 row in set (0.01 sec)



DML 在后, row copy 在前

general log
2020-05-07T10:14:04.929770Z	   76 Query	START TRANSACTION
2020-05-07T10:14:04.929882Z	   76 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
2020-05-07T10:14:04.929994Z	   76 Query	insert /* gh-ost `sbtest`.`t1_10w` */ ignore into `sbtest`.`_t1_10w_gho` (`id`, `c1`)
      (select `id`, `c1` from `sbtest`.`t1_10w` force index (`PRIMARY`)
        where (((`id` > _binary'52000')) and ((`id` < _binary'53000') or ((`id` = _binary'53000')))) lock in share mode
      )
2020-05-07T10:14:04.936903Z	   76 Query	COMMIT

DML语句
2020-05-07T10:14:04.944332Z	   67 Query	update `sbtest`.`t1_10w` set c1=1 where id=1
2020-05-07T10:14:04.954492Z	   75 Query	select hint, value from `sbtest`.`_t1_10w_ghc` where hint = 'heartbeat' and id <= 255
2020-05-07T10:14:04.961683Z	   75 Query	select  /* gh-ost `sbtest`.`t1_10w` iteration:53 */
						`id`
					from
						`sbtest`.`t1_10w`
					where ((`id` > _binary'53000')) and ((`id` < _binary'100005') or ((`id` = _binary'100005')))
					order by
						`id` asc
					limit 1
					offset 999
2020-05-07T10:14:04.962382Z	   75 Query	START TRANSACTION
2020-05-07T10:14:04.962468Z	   75 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
2020-05-07T10:14:04.962567Z	   75 Query	insert /* gh-ost `sbtest`.`t1_10w` */ ignore into `sbtest`.`_t1_10w_gho` (`id`, `c1`)
      (select `id`, `c1` from `sbtest`.`t1_10w` force index (`PRIMARY`)
        where (((`id` > _binary'53000')) and ((`id` < _binary'54000') or ((`id` = _binary'54000')))) lock in share mode
      )
2020-05-07T10:14:04.970003Z	   76 Query	insert /* gh-ost */ into `sbtest`.`_t1_10w_ghc`
				(id, hint, value)
			values
				(NULLIF(1, 0), 'heartbeat', '2020-05-07T18:14:04.961458821+08:00')
			on duplicate key update
				last_update=NOW(),
				value=VALUES(value)
2020-05-07T10:14:04.970162Z	   75 Query	COMMIT
2020-05-07T10:14:04.990012Z	   76 Query	START TRANSACTION
2020-05-07T10:14:04.990128Z	   76 Query	SET SESSION time_zone = '+00:00', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')

应用binlog到影子表(_t1_10w_gho)
对已copy过的数据，出现对原表的update/delete操作。会通过应用binlog的update，对这条记录列全部覆盖更新，所以不会有累加的问题。
2020-05-07T10:14:04.990280Z	   76 Query	update /* gh-ost `sbtest`.`_t1_10w_gho` */
 					`sbtest`.`_t1_10w_gho`
				set
					`id`=1, `c1`=1
				where
 					((`id` = 1))
2020-05-07T10:14:04.990494Z	   76 Query	COMMIT



