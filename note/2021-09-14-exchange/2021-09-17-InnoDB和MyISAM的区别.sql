
1. 采用的底层数据结构

	都采用B+树实现索引

2. 存储相关
	
	主键索引和二级索引叶子节点的内容
		InnoDB主键索引的叶子节点存储的是整行记录
		InnoDB二级索引的叶子节点存储的是主键索引的键值
	
	MyISAM
		MyISAM 主键索引和二级索引的 索引文件(MYI) 都是和数据文件(MYD)分离的

3. 功能性
	InnoDB的事务支持、事务隔离级别、行锁、MVCC等
	MyISAM 是支持表锁，没有行锁，不支持事务	

4. 统计表的所有行数
	用 count(*) 统计表所有的行记录，MyISAM 表可以毫秒级返回数据，因为 MyISAM 表维护1个计数器。


从 底层的数据结构、存储、功能支持、统计表的所有行数 这个维度进行考量





DROP TABLE IF EXISTS `t`;
CREATE TABLE `t` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '',
  `ntableId` int(11) DEFAULT NULL COMMENT '',
  `nplayerId` int(11) DEFAULT NULL COMMENT '',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_nplayerId` (`nplayerId`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4;


-rw-r-----. 1 mysql mysql     8634 10月 15 00:48 t.frm
-rw-r-----. 1 mysql mysql        0 10月 15 00:48 t.MYD
-rw-r-----. 1 mysql mysql     1024 10月 15 00:48 t.MYI
