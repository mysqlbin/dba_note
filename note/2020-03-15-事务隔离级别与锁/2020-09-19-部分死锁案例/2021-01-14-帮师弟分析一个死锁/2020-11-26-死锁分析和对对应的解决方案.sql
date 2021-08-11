
1. 表结构
2. 根据死锁分析日志
3. 形成死锁的加锁次序如下
4. 优化/避免本案例死锁的方案
5. 同时发生这个表可以优化的索引
6. 优化联合主键
7. 小结

1. 表结构

	mysql> show create table task_instance;
	+---------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Table         | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
	+---------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| task_instance | CREATE TABLE `task_instance` (
	  `task_id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
	  `dag_id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
	  `execution_date` timestamp(6) NOT NULL,
	  `start_date` timestamp(6) NULL DEFAULT NULL,
	  `end_date` timestamp(6) NULL DEFAULT NULL,
	  `duration` float DEFAULT NULL,
	  `state` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `try_number` int(11) DEFAULT NULL,
	  `hostname` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `unixname` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `job_id` int(11) DEFAULT NULL,
	  `pool` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `queue` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `priority_weight` int(11) DEFAULT NULL,
	  `operator` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `queued_dttm` timestamp(6) NULL DEFAULT NULL,
	  `pid` int(11) DEFAULT NULL,
	  `max_tries` int(11) DEFAULT '-1',
	  `executor_config` blob,
	  PRIMARY KEY (`task_id`,`dag_id`,`execution_date`),
	  KEY `ti_dag_state` (`dag_id`,`state`),
	  KEY `ti_pool` (`pool`,`state`,`priority_weight`),
	  KEY `ti_state_lkp` (`dag_id`,`task_id`,`execution_date`,`state`),
	  KEY `ti_state` (`state`),
	  KEY `ti_job_id` (`job_id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci |



2. 根据死锁分析日志
	事务一(TRANSACTION 2548893734)的信息：
	
		在等待的锁信息: -- WAITING FOR THIS LOCK TO BE GRANTED 部分
		
			RECORD LOCKS space id 795 page no 46866 n bits 128 index PRIMARY of table `airflow_v10`.`task_instance` trx id 2548893734 lock_mode X locks rec but not gap waiting

			index PRIMARY of table `airflow_v10`.`task_instance` --表示在等的是表task_instance的主键索引(`task_id`,`dag_id`,`execution_date`)上面的锁;
				
				0: len 12; hex 766964656f5f7461675f3666; asc video_tag_6f;;   -- task_id字段的值为 'video_tag_6f'
				1: len 30; hex 6d7973716c32686466735f6e6577636c75737465722e766964656f5f7461; asc mysql2hdfs_newcluster.video_ta; (total 31 bytes); -- dag_id字段的值为 'mysql2hdfs_newcluster.video_ta'

		持有的锁：
			--根据事务二(TRANSACTION 2548893737)在等待的锁信息分析出来
				
			持有二级索引 ti_state 对应 state = 'scheduled' 的锁。

		
	事务二(TRANSACTION 2548893737)的信息：
		持有的锁： -- HOLDS THE LOCK(S)部分
		
			
			
			持有的锁信息：
			
				index PRIMARY of table `airflow_v10`.`task_instance` trx id 2548893737 lock_mode X locks rec but not gap
				
				index PRIMARY of table `airflow_v10`.`task_instance` -- 持有task_instance表主键索引上面的锁
				
				lock_mode X locks rec but not gap -- 持有的锁为排他锁(写锁)
				
				行记录信息：
					0: len 12; hex 766964656f5f7461675f3666; asc video_tag_6f;;   -- task_id字段的值为 'video_tag_6f'
					1: len 30; hex 6d7973716c32686466735f6e6577636c75737465722e766964656f5f7461; asc mysql2hdfs_newcluster.video_ta; (total 31 bytes); -- dag_id字段的值为 'mysql2hdfs_newcluster.video_ta'
		
				
		在等待的锁信息:
			
			index ti_state of table `airflow_v10`.`task_instance` trx id 2548893737 lock_mode X locks rec but not gap waiting
			
			index ti_state of table `airflow_v10`.`task_instance` 表示在等的是表task_instance的二级索引 ti_state 上面的锁;
				-- 因此可以确定事务一(TRANSACTION 2548893734) 持有表task_instance的二级索引 ti_state 上面的锁。
			
			lock_mode X locks rec but not gap waiting  -- 想加一个排他锁(写锁)，但是处于等待中
			
			行记录信息：
				-- 二级索引 ti_state 的索引结构为：state字段 + PRIMARY KEY (`task_id`,`dag_id`,`execution_date`),
				0: len 9; hex 7363686564756c6564; asc scheduled;;    -- state字段的值为  scheduled 
				1: len 12; hex 766964656f5f7461675f3666; asc video_tag_6f;; -- task_id字段的值为 'video_tag_6f'
				2: len 30; hex 6d7973716c32686466735f6e6577636c75737465722e766964656f5f7461; asc mysql2hdfs_newcluster.video_ta; (total 31 bytes); -- dag_id字段的值为 'mysql2hdfs_newcluster.video_ta'
				3: len 7; hex 5fb4d4bc000000; asc _      ;;
					
			
			
3. 形成死锁的加锁次序如下

	时间点   事务一(TRANSACTION 2548893734)       							事务二(TRANSACTION 2548893737)
	T1		持有的锁： 持有二级索引ti_state 对应字段 state = 'scheduled' 的锁
	T2                                                                      持有的锁： 持有task_instance表主键索引记录上面的锁:  其中 task_id='video_tag_6f', dag_id='mysql2hdfs_newcluster.video_ta'

	T3 		在等待事务二的锁：task_instance表主键索引记录上面的锁:  其中 task_id='video_tag_6f', dag_id='mysql2hdfs_newcluster.video_ta'

	T4                                                                      在等待事务一的锁：表task_instance的二级索引 ti_state 记录字段 state = 'scheduled' 的锁		
	
	
	T3被T2阻塞，T4被T1阻塞，因此锁资源请求形成了环路，进而触发死锁检测, 因此导致了死锁。
	
	同时，可以看到，两个事务操作的是同一行记录。
	
	
4. 优化/避免本案例死锁的方案
	
	
	如果确定不需要二级索引ti_state， 可以删除二级索引 ti_state。
	
	因为事务一和事务二的更新语句最终都是要更新 state 字段，因此都需要对二级索引ti_state加锁。
	
		事务二的语句
			UPDATE task_instance SET state='queued'  -- 更新state字段 
				WHERE task_instance.task_id = 'video_tag_6f' AND task_instance.dag_id = 'mysql2hdfs_newcluster.video_tag' AND task_instance.execution_date = '2020-11-18 16:01:00'
		
		事务一的语句
			UPDATE task_instance,
			 (
				SELECT
					task_instance.try_number AS try_number,
					task_instance.task_id AS task_id,
					task_instance.dag_id AS dag_id,
					task_instance.execution_date AS execution_date,
					task_instance.start_date AS start_date,
					task_instance.end_date AS end_date,
					task_instance.duration AS duration,
					task_instance.state AS state,
					task_instance.max_tries AS max_tries,
					task_instance.hostname AS hostname,
					task_instance.unixname AS unixname,
					task_instance.job_id AS job_id,
					task_instance.pool AS pool,
					task_instance.queue AS queue,
					task_instance.priority_weight AS priority_weight,
					task_instance.operator AS operator,
					task_instance.queued_dttm AS queued_dttm,
					task_instance.pid AS pid,
					task_instance.executor_config AS executor_config
				FROM
					task_instance
				LEFT OUTER JOIN dag_run ON task_instance.dag_id = dag_run.dag_id
				AND task_instance.execution_date = dag_run.execution_date
				WHERE
					task_instance.dag_id IN ('hdfs_sync')
				AND task_instance.state IN ('up_for_retry')
				AND (
					dag_run.state != 'running'
					OR dag_run.state IS NULL
				)
			) AS anon_1
			SET task_instance.state = 'failed'    -- 更新state字段
			WHERE
				task_instance.dag_id = anon_1.dag_id
			AND task_instance.task_id = anon_1.task_id
			AND task_instance.execution_date = anon_1.execution_date
			
5. 同时发生这个表可以优化的索引
	这3个索引冗余了：
		PRIMARY KEY (`task_id`,`dag_id`,`execution_date`),
		KEY `ti_dag_state` (`dag_id`,`state`),
		KEY `ti_state_lkp` (`dag_id`,`task_id`,`execution_date`,`state`),
	
	
	如果有这样的查询条件： where task_id='' and dag_id='' and execution_date='', 有2个索引可以使用： PRIMARY KEY和KEY `ti_state_lkp`; 
	如果有根据 dag_id 来查询的，有 ti_dag_state 这个索引就行。
	因此ti_state_lkp 索引可以删除掉。
		

6. 优化联合主键
	mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 'task_instance';
	+---------------+---------------+--------------+---------------------+--------------+------------+-------------+----------------------------------------------------------+
	| database_name | table_name    | index_name   | last_update         | stat_name    | stat_value | sample_size | stat_description                                         |
	+---------------+---------------+--------------+---------------------+--------------+------------+-------------+----------------------------------------------------------+
	| test_db       | task_instance | PRIMARY      | 2020-11-25 06:30:22 | n_diff_pfx01 |          0 |           1 | task_id                                                  |
	| test_db       | task_instance | PRIMARY      | 2020-11-25 06:30:22 | n_diff_pfx02 |          0 |           1 | task_id,dag_id                                           |
	| test_db       | task_instance | PRIMARY      | 2020-11-25 06:30:22 | n_diff_pfx03 |          0 |           1 | task_id,dag_id,execution_date                            |
	| test_db       | task_instance | PRIMARY      | 2020-11-25 06:30:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index                        |
	| test_db       | task_instance | PRIMARY      | 2020-11-25 06:30:22 | size         |          1 |        NULL | Number of pages in the index                             |
	| test_db       | task_instance | ti_dag_state | 2020-11-25 06:30:22 | n_diff_pfx01 |          0 |           1 | dag_id                                                   |
	| test_db       | task_instance | ti_dag_state | 2020-11-25 06:30:22 | n_diff_pfx02 |          0 |           1 | dag_id,state                                             |
	| test_db       | task_instance | ti_dag_state | 2020-11-25 06:30:22 | n_diff_pfx03 |          0 |           1 | dag_id,state,task_id                                     |
	| test_db       | task_instance | ti_dag_state | 2020-11-25 06:30:22 | n_diff_pfx04 |          0 |           1 | dag_id,state,task_id,execution_date                      |
	| test_db       | task_instance | ti_dag_state | 2020-11-25 06:30:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index                        |
	| test_db       | task_instance | ti_dag_state | 2020-11-25 06:30:22 | size         |          1 |        NULL | Number of pages in the index                             |
	| test_db       | task_instance | ti_job_id    | 2020-11-25 06:30:22 | n_diff_pfx01 |          0 |           1 | job_id                                                   |
	| test_db       | task_instance | ti_job_id    | 2020-11-25 06:30:22 | n_diff_pfx02 |          0 |           1 | job_id,task_id                                           |
	| test_db       | task_instance | ti_job_id    | 2020-11-25 06:30:22 | n_diff_pfx03 |          0 |           1 | job_id,task_id,dag_id                                    |
	| test_db       | task_instance | ti_job_id    | 2020-11-25 06:30:22 | n_diff_pfx04 |          0 |           1 | job_id,task_id,dag_id,execution_date                     |
	| test_db       | task_instance | ti_job_id    | 2020-11-25 06:30:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index                        |
	| test_db       | task_instance | ti_job_id    | 2020-11-25 06:30:22 | size         |          1 |        NULL | Number of pages in the index                             |
	| test_db       | task_instance | ti_pool      | 2020-11-25 06:30:22 | n_diff_pfx01 |          0 |           1 | pool                                                     |
	| test_db       | task_instance | ti_pool      | 2020-11-25 06:30:22 | n_diff_pfx02 |          0 |           1 | pool,state                                               |
	| test_db       | task_instance | ti_pool      | 2020-11-25 06:30:22 | n_diff_pfx03 |          0 |           1 | pool,state,priority_weight                               |
	| test_db       | task_instance | ti_pool      | 2020-11-25 06:30:22 | n_diff_pfx04 |          0 |           1 | pool,state,priority_weight,task_id                       |
	| test_db       | task_instance | ti_pool      | 2020-11-25 06:30:22 | n_diff_pfx05 |          0 |           1 | pool,state,priority_weight,task_id,dag_id                |
	| test_db       | task_instance | ti_pool      | 2020-11-25 06:30:22 | n_diff_pfx06 |          0 |           1 | pool,state,priority_weight,task_id,dag_id,execution_date |
	| test_db       | task_instance | ti_pool      | 2020-11-25 06:30:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index                        |
	| test_db       | task_instance | ti_pool      | 2020-11-25 06:30:22 | size         |          1 |        NULL | Number of pages in the index                             |
	| test_db       | task_instance | ti_state     | 2020-11-25 06:30:22 | n_diff_pfx01 |          0 |           1 | state                                                    |
	| test_db       | task_instance | ti_state     | 2020-11-25 06:30:22 | n_diff_pfx02 |          0 |           1 | state,task_id                                            |
	| test_db       | task_instance | ti_state     | 2020-11-25 06:30:22 | n_diff_pfx03 |          0 |           1 | state,task_id,dag_id                                     |
	| test_db       | task_instance | ti_state     | 2020-11-25 06:30:22 | n_diff_pfx04 |          0 |           1 | state,task_id,dag_id,execution_date                      |
	| test_db       | task_instance | ti_state     | 2020-11-25 06:30:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index                        |
	| test_db       | task_instance | ti_state     | 2020-11-25 06:30:22 | size         |          1 |        NULL | Number of pages in the index                             |
	| test_db       | task_instance | ti_state_lkp | 2020-11-25 06:30:22 | n_diff_pfx01 |          0 |           1 | dag_id                                                   |
	| test_db       | task_instance | ti_state_lkp | 2020-11-25 06:30:22 | n_diff_pfx02 |          0 |           1 | dag_id,task_id                                           |
	| test_db       | task_instance | ti_state_lkp | 2020-11-25 06:30:22 | n_diff_pfx03 |          0 |           1 | dag_id,task_id,execution_date                            |
	| test_db       | task_instance | ti_state_lkp | 2020-11-25 06:30:22 | n_diff_pfx04 |          0 |           1 | dag_id,task_id,execution_date,state                      |
	| test_db       | task_instance | ti_state_lkp | 2020-11-25 06:30:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index                        |
	| test_db       | task_instance | ti_state_lkp | 2020-11-25 06:30:22 | size         |          1 |        NULL | Number of pages in the index                             |
	+---------------+---------------+--------------+---------------------+--------------+------------+-------------+----------------------------------------------------------+
	37 rows in set (0.00 sec)


	这个表，使用了联合索引做主键，这里主键的字段长度很长，然后又有多个二级索引，根据B+树的存储结果，二级索引后面又跟的是主键，所以会二级索引也会很大。

	index ti_state of table `airflow_v10`.`task_instance` 表示在等的是表task_instance的二级索引 ti_state 上面的锁;
	根据B+树索引的存储结构，辅助索引后面存储的是主键值。
	task_instance表的主键：PRIMARY KEY (`task_id`,`dag_id`,`execution_date`)
	因此，ti_state索引的存储结构为： `state`,`task_id`,`dag_id`,`execution_date`
	
	
7. 小结

	根据主键查询更新二级索引字段的值，会对该二级索引进行加锁。
	根据主键查询更新非二级索引字段的值，不会对表的二级索引进行加锁。
	
	参考实验笔记：《2020-11-30-锁主键索引此时是否会对二级索引加锁.sql》
	
