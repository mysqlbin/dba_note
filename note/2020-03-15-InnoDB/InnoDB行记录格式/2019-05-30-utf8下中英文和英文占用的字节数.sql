
root@mysqldb 06:25:  [admin_db]> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)


root@mysqldb 05:21:  [admin_db]> show create table words_test;
+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table      | Create Table                                                                                                                                                                                                 |
+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| words_test | CREATE TABLE `words_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_word` (`word`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 |
+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

root@mysqldb 05:21:  [admin_db]> select * from words_test;
+----+------+
| id | word |
+----+------+
|  2 | a    |
|  1 | 中   |
+----+------+
2 rows in set (0.00 sec)

root@mysqldb 05:22:  [admin_db]> select LENGTH(word),word from words_test where id=1;
+--------------+------+
| LENGTH(word) | word |
+--------------+------+
|            3 | 中   |
+--------------+------+
1 row in set (0.00 sec)

root@mysqldb 05:22:  [admin_db]> select LENGTH(word),word from words_test where id=2;
+--------------+------+
| LENGTH(word) | word |
+--------------+------+
|            1 | a    |
+--------------+------+
1 row in set (0.00 sec)
