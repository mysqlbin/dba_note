	
	

mysql> select count(*) from table_clubaaaabbbbbdetail_history;
+----------+
| count(*) |
+----------+
| 10000853 |
+----------+
1 row in set (1.39 sec)

数据表只有主键索引没有其它二级索引的索引长度、数据长度
CREATE TABLE `table_clubaaaabbbbbdetail_history` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
  ..........................................
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=94342625 DEFAULT CHARSET=utf8mb4 COMMENT='';


索引长度： 0 bytes (0)
数据长度： 1.86 GB (1,993,342,976)



索引组织表：InnoDB存储引擎表根据主键顺序以索引的形式进行存储，称为索引组织表。
