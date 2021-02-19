



root@mysqldb 12:47:  [db1]> select * from t;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  1 |    1 |    1 |
|  3 |    3 |    3 |
+----+------+------+
2 rows in set (0.00 sec)



sudo /usr/bin/mysqldump -uroot -p123456abc  --single-transaction --master-data=2 -B db1 --tables t > t.sql

cat t.sql


DROP TABLE IF EXISTS `t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t`
--

LOCK TABLES `t` WRITE;   -- 保证数据导入的一致性
/*!40000 ALTER TABLE `t` DISABLE KEYS */;
INSERT INTO `t` VALUES (1,1,1),(3,3,3);
/*!40000 ALTER TABLE `t` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



Waiting for table metadata lock
	事务A                                       事务B                               事务C

	LOCK TABLES `t` WRITE;
												select * from t;
												(Blocked)
																					show processlist;

																					

	root@mysqldb 12:57:  [(none)]> show processlist;
	+-----+------+--------------------+------+---------+------+---------------------------------+------------------+
	| Id  | User | Host               | db   | Command | Time | State                           | Info             |
	+-----+------+--------------------+------+---------+------+---------------------------------+------------------+
	| 212 | root | 192.168.0.55:56796 | db2  | Sleep   |   15 |                                 | NULL             |
	| 213 | root | 192.168.0.55:56800 | db2  | Sleep   |   88 |                                 | NULL             |
	| 214 | root | 192.168.0.55:56804 | db2  | Sleep   |   36 |                                 | NULL             |
	| 215 | root | 192.168.0.55:56806 | db1  | Sleep   |  383 |                                 | NULL             |
	| 216 | root | 192.168.0.55:56828 | db2  | Sleep   |   25 |                                 | NULL             |
	| 218 | root | 192.168.0.55:56852 | db2  | Sleep   |   78 |                                 | NULL             |
	| 219 | root | 192.168.0.55:56874 | db2  | Sleep   |   67 |                                 | NULL             |
	| 220 | root | 192.168.0.55:56896 | db2  | Sleep   |   46 |                                 | NULL             |
	| 221 | root | 192.168.0.55:56958 | db2  | Sleep   |   57 |                                 | NULL             |
	| 222 | root | 192.168.0.55:58920 | db2  | Sleep   |    4 |                                 | NULL             |
	| 265 | root | localhost          | db1  | Sleep   |   23 |                                 | NULL             |
	| 267 | root | localhost          | db1  | Query   |   11 | Waiting for table metadata lock | select * from t  |
	| 268 | root | localhost          | NULL | Query   |    0 | starting                        | show processlist |
	+-----+------+--------------------+------+---------+------+---------------------------------+------------------+
	13 rows in set (0.00 sec)


		
执行 lock tables t write; 这个语句，则其他线程读写 t表 的语句都会被阻塞.


