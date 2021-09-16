
max_execution_time参数

	控制select查询语句执行的最大时间
	可以作为过载保护的一种方法。

	Command-Line Format		--max-execution-time=#
	System Variable			max_execution_time
	Scope					Global, Session
	Dynamic					Yes
	Type					Integer
	Default Value			0



表结构和数据

	drop table if exists t1_10w;

	CREATE TABLE `t1_10w` (
	  `id` int(10) unsigned NOT NULL,
	  `age` int(10)  NOT NULL,
	  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;


	DROP PROCEDURE IF EXISTS insertbatch_t1_10w;
	DELIMITER ;;
	CREATE PROCEDURE insertbatch_t1_10w()
	BEGIN
	DECLARE i INT;
	  SET i=1;
		start transaction;
	  WHILE(i<=5000000) DO
		INSERT INTO t1_10w(id, age) VALUES(i, i);
		SET i=i+1; 
	  END WHILE;
		commit;
	END
	;;
	DELIMITER ;

	call insertbatch_t1_10w();


	mysql> select count(*) from t1_10w;
	+----------+
	| count(*) |
	+----------+
	|  5000000 |
	+----------+
	1 row in set (3.03 sec)



实践

1. 会话级别的设置

	-- 设置为1秒

	set max_execution_time=1000;

	mysql> select * from t1_10w where CreateTime='2021-09-16 04:20:07' order by age desc;
	ERROR 3024 (HY000): Query execution was interrupted, maximum statement execution time exceeded


	-- 设置为5秒
	set max_execution_time=5000;

	mysql> select * from t1_10w where age=1;
	+----+-----+---------------------+
	| id | age | CreateTime          |
	+----+-----+---------------------+
	|  1 |   1 | 2021-09-16 04:25:15 |
	+----+-----+---------------------+
	1 row in set (1.99 sec)

2. 全局级别的设置
	
	set global max_execution_time=1000;
	
	mysql> show global variables like '%max_execution_time%';
	+--------------------+-------+
	| Variable_name      | Value |
	+--------------------+-------+
	| max_execution_time | 1000  |
	+--------------------+-------+
	1 row in set (0.23 sec)
	
	重新开启1个session
	mysql> select * from t1_10w where age=1;
	ERROR 3024 (HY000): Query execution was interrupted, maximum statement execution time exceeded

	---------------------------------------------------------------------------------------------------
	
	set global max_execution_time=5000;
	
	重新开启1个session
	mysql> select * from t1_10w where age=1;
	+----+-----+---------------------+
	| id | age | CreateTime          |
	+----+-----+---------------------+
	|  1 |   1 | 2021-09-16 04:25:15 |
	+----+-----+---------------------+
	1 row in set (1.99 sec)


set global 对当前会话不生效。


https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_execution_time