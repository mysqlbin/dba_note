


	drop table if exists t526;
	CREATE TABLE `t526` (
	`id` bigint(20) unsigned NOT NULL auto_increment,
	PRIMARY KEY  (`id`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 comment='存储table_clublogscore表自增ID的表';

	
SELECT @@identity		
	session A	                    session B
	INSERT INTO t526 () values ();   
									INSERT INTO t526 () values ();
									SELECT @@identity; 
									+------------+
									| @@identity |
									+------------+
									|          2 |
									+------------+
									1 row in set (0.00 sec)
	SELECT @@identity; 
	+------------+
	| @@identity |
	+------------+
	|          1 |
	+------------+
	1 row in set (0.00 sec)
		
		
SELECT LAST_INSERT_ID()
		
	session A	                    session B
	INSERT INTO t526 () values ();   
									INSERT INTO t526 () values ();
									SELECT LAST_INSERT_ID();
									+------------------+
									| LAST_INSERT_ID() |
									+------------------+
									|                2 |
									+------------------+
									1 row in set (0.00 sec)
	SELECT LAST_INSERT_ID();
	root@localhost [db1]>SELECT LAST_INSERT_ID();
	+------------------+
	| LAST_INSERT_ID() |
	+------------------+
	|                1 |
	+------------------+
	1 row in set (0.00 sec)
	
SELECT @@identity 和 SELECT LAST_INSERT_ID() 都是 session 级别的。
放心用。


