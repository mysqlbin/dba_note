SELECT id,time,state,info FROM INFORMATION_SCHEMA.PROCESSLIST where state="Waiting for table metadata lock";
SELECT count(*) FROM INFORMATION_SCHEMA.PROCESSLIST where state="Waiting for table metadata lock";

	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

	INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('5', '5', '5');
	
	
	begin;
	select * from t limit 1;
	
			alter table  t add column test_filed int(11);
			


mysql> SELECT id,time,state,info FROM INFORMATION_SCHEMA.PROCESSLIST where state="Waiting for table metadata lock" order by id asc limit 1;
+------+------+---------------------------------+----------------------------------------------+
| id   | time | state                           | info                                         |
+------+------+---------------------------------+----------------------------------------------+
| 8868 |   58 | Waiting for table metadata lock | alter table  t add column test_filed int(11) |
+------+------+---------------------------------+----------------------------------------------+
1 row in set (0.01 sec)

id: 线程ID
time: 已经等待了多长时间的MDL元数据锁
info：被阻塞的DDL语句



 


