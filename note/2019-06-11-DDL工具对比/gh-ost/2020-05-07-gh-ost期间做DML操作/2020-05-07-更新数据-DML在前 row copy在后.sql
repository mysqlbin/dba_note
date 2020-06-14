
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



DML在前, row copy在后

alter table t1_10w add column c1 int(10) not null default 0;

[root@kp04 ~]# time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_10w" --alter="engine=innodb" --allow-on-master --execute
[2020/05/07 18:22:13] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/07 18:22:13] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000006, 2141799)
[2020/05/07 18:22:13] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
[2020/05/07 18:22:13] [info] binlogsyncer.go:723 rotate to (mysql-bin.000006, 2141799)
2020-05-07 18:22:13 ERROR parsing time "" as "2006-01-02T15:04:05.999999999Z07:00": cannot parse "" as "2006"
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Thu May 07 18:22:12 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 0/100275 0.0%; Applied: 0; Backlog: 0/1000; Time: 0s(total), 0s(copy); streamer: mysql-bin.000006:2143612; Lag: 0.00s, State: migrating; ETA: N/A
Copy: 0/100275 0.0%; Applied: 0; Backlog: 1/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000006:2148319; Lag: 0.08s, State: migrating; ETA: N/A
Copy: 24000/100275 23.9%; Applied: 1; Backlog: 0/1000; Time: 2s(total), 2s(copy); streamer: mysql-bin.000006:2375838; Lag: 0.09s, State: migrating; ETA: 6s
Copy: 57000/100275 56.8%; Applied: 1; Backlog: 0/1000; Time: 3s(total), 3s(copy); streamer: mysql-bin.000006:2686191; Lag: 0.09s, State: migrating; ETA: 2s
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 4s(total), 3s(copy); streamer: mysql-bin.000006:3090188; Lag: 0.09s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 1/1000; Time: 4s(total), 3s(copy); streamer: mysql-bin.000006:3092531; Lag: 0.09s, State: migrating; ETA: due
# Migrating `sbtest`.`t1_10w`; Ghost table is `sbtest`.`_t1_10w_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Thu May 07 18:22:12 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_10w.sock
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 5s(total), 3s(copy); streamer: mysql-bin.000006:3096432; Lag: 0.09s, State: migrating; ETA: due
Copy: 100005/100005 100.0%; Applied: 1; Backlog: 0/1000; Time: 5s(total), 3s(copy); streamer: mysql-bin.000006:3097719; Lag: 0.09s, State: migrating; ETA: due
[2020/05/07 18:22:19] [info] binlogsyncer.go:164 syncer is closing...
[2020/05/07 18:22:19] [error] binlogstreamer.go:77 close sync with err: sync is been closing...
[2020/05/07 18:22:19] [info] binlogsyncer.go:179 syncer is closed
# Done

real	0m6.291s
user	0m0.142s
sys	0m0.044s


root@mysqldb 18:20:  [sbtest]> select * from `sbtest`.`t1_10w` order by id desc limit 1;
+--------+----+
| id     | c1 |
+--------+----+
| 100005 |  0 |
+--------+----+
1 row in set (0.00 sec)

update `sbtest`.`t1_10w` set c1=1 where id=100005;

root@mysqldb 18:22:  [sbtest]> select * from `sbtest`.`t1_10w` order by id desc limit 1;
+--------+----+
| id     | c1 |
+--------+----+
| 100005 |  1 |
+--------+----+
1 row in set (0.01 sec)


DML在前, row copy在后

general log
	
	DML 操作
	2020-05-07T10:22:14.211946Z	   67 Query	update `sbtest`.`t1_10w` set c1=1 where id=100005
	2020-05-07T10:22:14.224315Z	   85 Query	select  /* gh-ost `sbtest`.`t1_10w` iteration:0 */
							`id`
						from
							`sbtest`.`t1_10w`
						where ((`id` > _binary'1') or ((`id` = _binary'1'))) and ((`id` < _binary'100005') or ((`id` = _binary'100005')))
						order by
							`id` asc
						limit 1
						offset 999
	2020-05-07T10:22:14.225661Z	   91 Query	select hint, value from `sbtest`.`_t1_10w_ghc` where hint = 'heartbeat' and id <= 255

	开启事务, 迁移数据
	2020-05-07T10:22:14.226093Z	   85 Query	START TRANSACTION
	2020-05-07T10:22:14.226331Z	   85 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	2020-05-07T10:22:14.226614Z	   85 Query	insert /* gh-ost `sbtest`.`t1_10w` */ ignore into `sbtest`.`_t1_10w_gho` (`id`, `c1`)
		  (select `id`, `c1` from `sbtest`.`t1_10w` force index (`PRIMARY`)
			where (((`id` > _binary'1') or ((`id` = _binary'1'))) and ((`id` < _binary'1000') or ((`id` = _binary'1000')))) lock in share mode
		  )
	2020-05-07T10:22:14.239369Z	   91 Query	insert /* gh-ost */ into `sbtest`.`_t1_10w_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-07T18:22:14.238702346+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-07T10:22:14.248020Z	   92 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-07T10:22:14.249271Z	   92 Query	SET autocommit=true
	2020-05-07T10:22:14.249502Z	   92 Query	SET NAMES utf8mb4
	2020-05-07T10:22:14.249686Z	   92 Query	insert /* gh-ost */ into `sbtest`.`_t1_10w_ghc`
					(id, hint, value)
				values
					(NULLIF(0, 0), 'copy iteration 0 at 1588846934', 'Copy: 0/100275 0.0%; Applied: 0; Backlog: 1/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000006:2148319; Lag: 0.08s, State: migrating; ETA: N/A')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	提交
	2020-05-07T10:22:14.280505Z	   85 Query	COMMIT

	
	此时id=100005的记录还未拷贝到影子表， 所以 update 空记录
	新表数据还不存在，应用binlog为空操作，会等copy迁移。
	
	对未copy过的数据，出现对原表的update/delete操作。新表数据还不存在，应用binlog为空操作，会等copy迁移。
	
	2020-05-07T10:22:14.309086Z	   91 Query	START TRANSACTION
	2020-05-07T10:22:14.309401Z	   91 Query	SET SESSION time_zone = '+00:00', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	2020-05-07T10:22:14.309530Z	   91 Query	update /* gh-ost `sbtest`.`_t1_10w_gho` */
						`sbtest`.`_t1_10w_gho`
					set
						`id`=100005, `c1`=1
					where
						((`id` = 100005))
	2020-05-07T10:22:14.309892Z	   91 Query	COMMIT


	通过binlog把增量操作应用到影子表(_t1_10w_gho)