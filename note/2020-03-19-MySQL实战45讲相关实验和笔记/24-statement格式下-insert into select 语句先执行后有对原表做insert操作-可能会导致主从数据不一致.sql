


CREATE TABLE `t` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `c` (`c`)
) ENGINE=InnoDB;

insert into t values(null, 1,1);
insert into t values(null, 2,2);
insert into t values(null, 3,3);
insert into t values(null, 4,4);

create table t2 like t
	
	
时间点		session A 	session B
T1	
						begin;
						insert into t2(c,d) select c,d from t;
T2			insert into t values(-1, -1, -1); 		



事务隔离级别：读已提交
binlog_format：statement 格式
session B 执行期间，session A语句执行成功；会不会导致主从数据不一致？
	会的。
	因为  insert into select 语句对原表不加锁，可以会出现一种导致主从数据不一致：
		session B先执行，比 session A 后完成，因此会比 session A 后写入 binlog的情况，binlog 里面就记录了这样的语句序列：
            insert into t values(-1, -1, -1);
            insert into t2(c,d) select c,d from t;
		这个语句到了备库执行，就会把 id=-1 这一行也写到表 t2 中，出现主备不一致：t2表在从库比主库多一行记录。
		
		