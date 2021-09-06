

1. 表结构和数据的初始化
2. RC隔离级别
	2.1 等值范围查询--先根据主键索引更新数据再等值范围查询加锁
	2.2 范围查询--先根据主键索引更新数据再范围查询加锁
	2.3 等值范围更新--先根据主键索引更新数据再等值范围更新加锁
	2.4 范围更新--先根据主键索引更新数据再范围更新加锁

3. 小结
4. 未完成

1. 环境、表结构和数据的初始化
	
	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)


	DROP table IF EXISTS `t`;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	DROP PROCEDURE IF EXISTS `idata`;
	DELIMITER ;;
	CREATE DEFINER=`root`@`localhost` PROCEDURE `idata`()
	begin
	  declare i int;
	  set i=1;
		start transaction;
	  while(i<=5) do
		INSERT INTO t (c,d) values (i,i);
		set i=i+1;
	  end while;
		commit;
	end
	;;
	DELIMITER ;
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (0.00 sec)
	
	

2.1 等值范围查询--先根据主键索引更新数据再等值范围查询加锁

	session A       session B
	begin;
	update t set d=100 where id=2;
				
					begin;
					select * from t where id>=3 and  id<=4 lock in share mode;
					(Query OK)
	
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------

2.2 范围查询--先根据主键索引更新数据再范围查询加锁
	
	session A       session B
	begin;
	update t set d=100 where id=2;
	
					begin;
					select * from t where id>3 and  id<=4 lock in share mode;
					(Query OK)
	
	------------------------------------------------
	
	session A       session B
	begin;
	update t set d=100 where id=3;
	
					begin;
					select * from t where id>3 and  id<=4 lock in share mode;
					(Query OK)
					
					-- id>3，那就从id=4开始查找。
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------				

2.3 等值范围更新--先根据主键索引更新数据再等值范围更新加锁

	session A       session B
	begin;
	update t set d=100 where id=2;
	
					begin;
					update t set d=100 where id>=3 and  id<=4;
					(Query OK)
	
	
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------

2.4 范围更新--先根据主键索引更新数据再范围更新加锁
	
	session A       session B
	
	begin;
	update t set d=100 where id=2;
	
	
					begin;
					update t set d=100 where id>3 and  id<=4;
					(Query OK)
	
	--------------------------------------------------------
	
	session A       session B
	begin;
	update t set d=100 where id=3;
	
	
					begin;
					update t set d=100 where id>3 and  id<=4;
					(Query OK)				
					

								
3. 小结
	
	起点没有锁延伸。
	
4. 未完成

	看看有没有尾点的间隙锁
	-- 也就是考虑间隙锁
	
	