
常用查询测试
1. 测试用例
2. 全表扫描
3. 全索引扫描
4. 索引ref访问
5. 索引range访问
6. 被驱动表带索引访问
	6.1 关闭 BKA
	6.2 开启BKA 
	6.3 对比
7. 索引避免排序正向和反向


1. 测试用例

	create table t1(
		id int primary key, 
		a int, 
		b int, 
		index(a)
	);

	create table t2 like t1;

	drop procedure idata;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  while(i<=1000)do
		insert into t1 values(i, 1001-i, i);
		set i=i+1;
	  end while;
	  
	  set i=1;
	  while(i<=10000)do
		insert into t2 values(i, i, i);
		set i=i+1;
	  end while;

	end;;
	delimiter ;
	call idata();

	表 t1 里，插入了 1000 行数据，每一行的 a=1001-id 的值。
	也就是说，表 t1 中字段 a 是逆序的。
	同时，在表 t2 中插入了 1 万行数据。
	
		

	root@mysqldb 05:11:  [db1]> select count(*) from t1;
	+----------+
	| count(*) |
	+----------+
	|     1000 |
	+----------+
	1 row in set (0.01 sec)

	root@mysqldb 05:11:  [db1]> select count(*) from t2;
	+----------+
	| count(*) |
	+----------+
	|    10000 |
	+----------+
	1 row in set (0.00 sec)

	root@mysqldb 05:11:  [db1]> select count(*) from t1 inner join t2 on t1.a=t2.a;
	+----------+
	| count(*) |
	+----------+
	|     1000 |
	+----------+
	1 row in set (0.00 sec)

	
	
	set optimizer_switch='mrr=on,mrr_cost_based=off,batched_key_access=off';	

	root@mysqldb 05:57:  [db1]> show variables like '%optimizer_switch%';
	+------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Variable_name    | Value                                                                                                                                                                                                                                                                                                                                                                                                              |
	+------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| optimizer_switch | index_merge=on,index_merge_union=on,index_merge_sort_union=on,index_merge_intersection=on,engine_condition_pushdown=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=off,block_nested_loop=off,batched_key_access=off,materialization=on,semijoin=on,loosescan=on,firstmatch=on,duplicateweedout=on,subquery_materialization_cost_based=on,use_index_extensions=on,condition_fanout_filter=on,derived_merge=on |
	+------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)


2. 全表扫描
	desc select * from t1;
	pager cat >>/dev/null
	flush status;
	select * from t1;
	pager;
	show status like 'Handler_read%';
		
	root@mysqldb 06:01:  [db1]> desc select * from t1;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
	|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 1000 |   100.00 | NULL  |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)

	root@mysqldb 06:01:  [db1]> pager cat >>/dev/null
	PAGER set to 'cat >>/dev/null'
	root@mysqldb 06:01:  [db1]> flush status;
	Query OK, 0 rows affected (0.03 sec)

	root@mysqldb 06:01:  [db1]> select * from t1;
	1000 rows in set (0.01 sec)

	root@mysqldb 06:01:  [db1]> pager;
	
	root@mysqldb 06:01:  [db1]> show status like 'Handler_read%';
	+-----------------------+-------+
	| Variable_name         | Value |
	+-----------------------+-------+
	| Handler_read_first    | 1     |
	| Handler_read_key      | 1     |
	| Handler_read_last     | 0     |
	| Handler_read_next     | 0     |
	| Handler_read_prev     | 0     |
	| Handler_read_rnd      | 0     |
	| Handler_read_rnd_next | 1001  |
	+-----------------------+-------+
	7 rows in set (0.00 sec)


	Handler_read_first    增加1次用于初次定位
	Handler_read_key      增加1次
	Handler_read_rnd_next
		增加扫描行数; 
		全表扫描访问下一条数据
		Handler_read_rnd_next 通常代表着全表扫描，t1表有1000行记录，此时值为 1000
		我们前面说过因为ha_innobase::index_first也是封装的 ha_innobase::index_read，因此都需要+1。
		所以值为 1000 + 1 = 1001
		

3. 全索引扫描

	desc select a from t1;
	flush status;
	pager cat >>/dev/null
	PAGER set to 'cat >>/dev/null'
	select a from t1;
	pager;
	show status like 'Handler_read%';

	root@mysqldb 06:10:  [db1]> 
	root@mysqldb 06:10:  [db1]> desc select a from t1;
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------------+
	|  1 | SIMPLE      | t1    | NULL       | index | NULL          | a    | 5       | NULL | 1000 |   100.00 | Using index |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

	root@mysqldb 06:10:  [db1]> flush status;
	Query OK, 0 rows affected (0.01 sec)

	root@mysqldb 06:10:  [db1]> pager cat >>/dev/null
	PAGER set to 'cat >>/dev/null'
	root@mysqldb 06:10:  [db1]> PAGER set to 'cat >>/dev/null'
	PAGER set to 'set to 'cat >>/dev/null''
	root@mysqldb 06:10:  [db1]> select a from t1;
	1000 rows in set (0.00 sec)

	root@mysqldb 06:10:  [db1]> pager;
	root@mysqldb 06:10:  [db1]> show status like 'Handler_read%';
	+-----------------------+-------+
	| Variable_name         | Value |
	+-----------------------+-------+
	| Handler_read_first    | 1     |
	| Handler_read_key      | 1     |
	| Handler_read_last     | 0     |
	| Handler_read_next     | 1000  |
	| Handler_read_prev     | 0     |
	| Handler_read_rnd      | 0     |
	| Handler_read_rnd_next | 0     |
	+-----------------------+-------+
	7 rows in set (0.01 sec)

	Handler_read_first 增加1次用于初次定位
	Handler_read_key   增加1次
	Handler_read_next
		通常代表着合理的使用了索引或者全索引扫描；
		在这里代表着合理的使用了索引-》Extra = Using index 
		按照索引顺序读下一行的请求数 即 增加扫描行数用于连续访问接下来的行
		t1表有1000行记录，此时值为 1000 即 按照索引顺序读下一行的请求数为 1000
	


4. 索引ref访问

	我这里因为是测试索引全是等于10的加上了force index

	desc select  * from t1 force index(a) where a=10;
	flush status;
	pager cat >>/dev/null
	select  * from t1 force index(a) where a=10;
	pager
	show status like 'Handler_read%';


	root@mysqldb 06:10:  [db1]> desc select  * from t1 force index(a) where a=10;
	+----+-------------+-------+------------+------+---------------+------+---------+-------+------+----------+-------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref   | rows | filtered | Extra |
	+----+-------------+-------+------------+------+---------------+------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t1    | NULL       | ref  | a             | a    | 5       | const |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+------+---------------+------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)

	root@mysqldb 06:22:  [db1]> flush status;
	Query OK, 0 rows affected (0.01 sec)

	root@mysqldb 06:22:  [db1]> pager cat >>/dev/null
	PAGER set to 'cat >>/dev/null'
	root@mysqldb 06:22:  [db1]> select  * from t1 force index(a) where a=10;
	1 row in set (0.00 sec)

	root@mysqldb 06:22:  [db1]> pager

	root@mysqldb 06:22:  [db1]> show status like 'Handler_read%';
	+-----------------------+-------+
	| Variable_name         | Value |
	+-----------------------+-------+
	| Handler_read_first    | 0     |
	| Handler_read_key      | 1     |
	| Handler_read_last     | 0     |
	| Handler_read_next     | 1     |
	| Handler_read_prev     | 0     |
	| Handler_read_rnd      | 0     |
	| Handler_read_rnd_next | 0     |
	+-----------------------+-------+
	7 rows in set (0.00 sec)

	Handler_read_key  增加1次这是用于初次定位
	Handler_read_next
		通常代表着合理的使用了索引或者全索引扫描；
		在这里代表着合理的使用了索引-》key = a
		按照索引顺序读下一行的请求数 即 增加扫描行数用于连续访问接下来的行
		t1表有1000行记录，满足条件的记录数有1条，此时值为 1 即 按照索引顺序读下一行的请求数为 1
	
5. 索引range访问
	desc select  * from t1 force index(a) where a>9 and a<12;
	flush status;
	pager cat >>/dev/null
	select  * from t1 force index(a) where a>9 and a<12;
	pager;
	show status like 'Handler_read%';

	root@mysqldb 21:58:  [db1]> desc select  * from t1 force index(a) where a>9 and a<12;
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | t1    | NULL       | range | a             | a    | 5       | NULL |    2 |   100.00 | Using index condition |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	root@mysqldb 21:58:  [db1]> flush status;
	Query OK, 0 rows affected (0.00 sec)

	root@mysqldb 21:58:  [db1]> pager cat >>/dev/null
	PAGER set to 'cat >>/dev/null'
	root@mysqldb 21:58:  [db1]> select  * from t1 force index(a) where a>9 and a<12;
	2 rows in set (0.00 sec)

	root@mysqldb 21:58:  [db1]> pager;

	root@mysqldb 21:58:  [db1]> show status like 'Handler_read%';
	+-----------------------+-------+
	| Variable_name         | Value |
	+-----------------------+-------+
	| Handler_read_first    | 0     |
	| Handler_read_key      | 1     |
	| Handler_read_last     | 0     |
	| Handler_read_next     | 2     |
	| Handler_read_prev     | 0     |
	| Handler_read_rnd      | 0     |
	| Handler_read_rnd_next | 0     |
	+-----------------------+-------+
	7 rows in set (0.01 sec)

	Handler_read_key  增加1次这是用于初次定位，
	Handler_read_next 
		通常代表着合理的使用了索引或者全索引扫描；
		在这里代表着合理的使用了索引-》key = a
		表示 按照索引顺序读下一行的请求数 即 增加扫描行数用于连续访问接下来的行 即 增加扫描行数次数用于接下来的数据访问
		t1表有1000行记录，满足条件的记录数有2条，此时值为 2 即 按照索引顺序读下一行的请求数为 2

	
6. 被驱动表带索引访问
	desc select * from t1 STRAIGHT_JOIN t2  on t1.a=t2.a;
	flush status;
	pager cat >> /dev/null
	select * from t1 STRAIGHT_JOIN t2  on t1.a=t2.a;
	pager;
	show status like 'Handler_read%';
	
	6.1 关闭 BKA
		root@mysqldb 03:51:  [db1]> show variables like '%optimizer_switch%';
		+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Variable_name    | Value                                                                                                                                                                                                                                                                                                                                                                                                            |
		+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| optimizer_switch | index_merge=on,index_merge_union=on,index_merge_sort_union=on,index_merge_intersection=on,engine_condition_pushdown=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=on,block_nested_loop=on,batched_key_access=off,materialization=on,semijoin=on,loosescan=on,firstmatch=on,duplicateweedout=on,subquery_materialization_cost_based=on,use_index_extensions=on,condition_fanout_filter=on,derived_merge=on |
		+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)


		从 “mrr=on,mrr_cost_based=on,block_nested_loop=on,batched_key_access=off” 可以看到， BKA 默认是关闭的。
		
		root@mysqldb 03:48:  [db1]> desc select * from t1 STRAIGHT_JOIN  t2 on(t1.a=t2.a);
		+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+-------------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref      | rows | filtered | Extra       |
		+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+-------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | a             | NULL | NULL    | NULL     | 1000 |   100.00 | Using where |
		|  1 | SIMPLE      | t2    | NULL       | ref  | a             | a    | 5       | db1.t1.a |    1 |   100.00 | NULL        |
		+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+-------------+
		2 rows in set, 1 warning (0.00 sec)
		
		# 使用的是 NLJ 算法
		

		root@mysqldb 22:40:  [db1]> flush status;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 22:40:  [db1]> pager cat >> /dev/null
		PAGER set to 'cat >> /dev/null'
		root@mysqldb 22:40:  [db1]> select * from t1 STRAIGHT_JOIN t2  on t1.a=t2.a;
		1000 rows in set (0.01 sec)

		root@mysqldb 22:40:  [db1]> pager;

		root@mysqldb 22:40:  [db1]> show status like 'Handler_read%';
		+-----------------------+-------+
		| Variable_name         | Value |
		+-----------------------+-------+
		| Handler_read_first    | 1     |
		| Handler_read_key      | 1001  |
		| Handler_read_last     | 0     |
		| Handler_read_next     | 1000  |
		| Handler_read_prev     | 0     |
		| Handler_read_rnd      | 0     |
		| Handler_read_rnd_next | 1001  |
		+-----------------------+-------+
		7 rows in set (0.01 sec)
		
		Handler_read_first 增加一次作为驱动表t1全表扫描定位的开始
		接下来 Handler_read_rnd_next 扫描驱动表t1全部记录，每次扫描一行（一次）在t2表通过索引a定位一次 Handler_read_key 增加1次
		然后接下来在t2表通过索引a进行数据查找 Handler_read_next 增加为扫描的行数。
		
		Handler_read_key
			表示 根据索引读一行的请求数，如果该值较高，说明查询和表的索引正确
			驱动表t1需要定位1次
			被驱动表t2需要定位1000次，所以是每次定位都需要加1
			1 + 1000 = 1001
			
		Handler_read_rnd_next
			全表扫描访问下一条数据
			Handler_read_rnd_next 通常代表着全表扫描，t1表有1000行记录，此时值为 1000
			我们前面说过因为ha_innobase::index_first也是封装的 ha_innobase::index_read，因此都需要+1。
			所以值为 1000 + 1 = 1001
		
			
		
	6.2 开启BKA 
	
		set optimizer_switch='mrr=on,mrr_cost_based=off,batched_key_access=on';
		前两个参数的作用是要启用 MRR。这么做的原因是，BKA 算法的优化要依赖于 MRR。

		root@mysqldb 03:55:  [db1]> set optimizer_switch='mrr=on,mrr_cost_based=off,batched_key_access=on';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 04:08:  [db1]> show variables like '%optimizer_switch%';
		+------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Variable_name    | Value                                                                                                                                                                                                                                                                                                                                                                                                             |
		+------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| optimizer_switch | index_merge=on,index_merge_union=on,index_merge_sort_union=on,index_merge_intersection=on,engine_condition_pushdown=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=off,block_nested_loop=off,batched_key_access=on,materialization=on,semijoin=on,loosescan=on,firstmatch=on,duplicateweedout=on,subquery_materialization_cost_based=on,use_index_extensions=on,condition_fanout_filter=on,derived_merge=on |
		+------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.01 sec)

		
		
		从 “mrr=on,mrr_cost_based=off,block_nested_loop=off,batched_key_access=on” 可以看到， BKA 已经开启。
	
		root@mysqldb 22:45:  [db1]> flush status;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 22:45:  [db1]> pager cat >> /dev/null
		PAGER set to 'cat >> /dev/null'
		root@mysqldb 22:45:  [db1]> select * from t1 STRAIGHT_JOIN t2  on t1.a=t2.a;
		1000 rows in set (0.01 sec)

		root@mysqldb 22:45:  [db1]> pager;
		
		root@mysqldb 22:45:  [db1]> show status like 'Handler_read%';
		+-----------------------+-------+
		| Variable_name         | Value |
		+-----------------------+-------+
		| Handler_read_first    | 1     |
		| Handler_read_key      | 2001  |
		| Handler_read_last     | 0     |
		| Handler_read_next     | 1000  |
		| Handler_read_prev     | 0     |
		| Handler_read_rnd      | 1000  |
		| Handler_read_rnd_next | 1001  |
		+-----------------------+-------+
		7 rows in set (0.00 sec)

		
		Handler_read_first 增加一次作为驱动表t1全表扫描定位的开始
		接下来 Handler_read_rnd_next 扫描驱动表t1全部记录，每次扫描一行（一次）在t2表通过索引a定位一次 Handler_read_key 增加1次
		然后接下来在t2表通过索引a进行数据查找 Handler_read_next 增加为扫描的行数。
		
		Handler_read_key = 2001
			表示 根据索引读取一行的请求数，如果该值较高，说明查询和表的索引正确
			驱动表t1需要定位1次
			
		Handler_read_rnd_next = 1001
			全表扫描访问下一条数据
			
		Handler_read_rnd = 1000
			表示基于固定位置读取行的请求数, 如果您要执行需要对很多结果进行排序的查询，则此值很高
			说明了基于固定位置读取行的请求数为1000
			
			分析:
				这里因为用到了BKA优化 
				BKA 算法的优化要依赖于 MRR。
				所以 需要对 id 进行排序, MRR在 read_rnd_buffer 中按照 id 做了排序，所以最后得到的结果集也是按照主键 id 递增顺序的, 同时体现了 需要对很多结果进行排序的查询，此值很高
				因为驱动表有 1000 行记录需要在 MRR 中排序, 所以 Handler_read_rnd = 1000
				
				参考笔记 <2020-02-12-开启和关闭BKA的结果集对比.sql>
				
	6.3 对比 
		名称 					   开启BKA           关闭BKA             两者是否一致       
		Handler_read_first			1				     1         			一致
		Handler_read_key		    2001                 1001               不一致
		Handler_read_next		    1000                 1000               一致					
		Handler_read_rnd		    1000                 0                  不一致
		Handler_read_rnd_next		1001                 1001               一致
		JOIN算法                    BKA                 NLJ
		
		
		开启和关闭BKA算法在 Handler_read_key 变量值不一样的解读：
		
			开启BKA.Handler_read_key的值等于 2001 > 关闭BKA.Handler_read_key的值等于 1001, 说明了 开启BKA 能提升SQL语句的效率.
			
			Handler_read_key = 1+1000+1000(Handler_read_rnd)
			
		
7. 索引避免排序正向和反向
	set optimizer_switch='mrr=on,mrr_cost_based=off,batched_key_access=off';
	
	排序正向
		desc select * from t1 force index(a) order by a;
		flush status;
		pager cat >> /dev/null
		select * from t1 force index(a) order by a;
		pager
		show status like 'Handler_read%';
		
		root@mysqldb 21:58:  [db1]> desc select * from t1 force index(a) order by a;
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
		| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
		|  1 | SIMPLE      | t1    | NULL       | index | NULL          | a    | 5       | NULL | 1000 |   100.00 | NULL  |
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
		1 row in set, 1 warning (0.00 sec)
		
		root@mysqldb 06:59:  [db1]> flush status;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 07:00:  [db1]> pager cat >> /dev/null
		PAGER set to 'cat >> /dev/null'
		root@mysqldb 07:00:  [db1]> select * from t1 force index(a) order by a;
		1000 rows in set (0.00 sec)

		root@mysqldb 07:00:  [db1]> pager

		root@mysqldb 07:00:  [db1]> show status like 'Handler_read%';
		+-----------------------+-------+
		| Variable_name         | Value |
		+-----------------------+-------+
		| Handler_read_first    | 1     |
		| Handler_read_key      | 1     |
		| Handler_read_last     | 0     |
		| Handler_read_next     | 1000  |
		| Handler_read_prev     | 0     |
		| Handler_read_rnd      | 0     |
		| Handler_read_rnd_next | 0     |
		+-----------------------+-------+
		7 rows in set (0.00 sec)
		
		Handler_read_first 用于定位索引的第一条数据
		Handler_read_key   增加1次这是用于初次定位
		Handler_read_next 
			通常代表着合理的使用了索引或者全索引扫描；
			在这里代表着合理的使用了索引-》key = a
			表示 按照索引顺序读下一行的请求数 即 增加扫描行数用于连续访问接下来的行 即 增加扫描行数次数用于接下来的数据访问
			t1表有1000行记录，满足条件的记录数有1000条，此时值为 1000 即 按照索引顺序读下一行的请求数为 1000

	排序反向
		flush status;
		desc  select * from t1 force index(a) order by a desc;
		pager cat >> /dev/null
		select * from t1 force index(a) order by a desc;
		pager;
		show status like 'Handler_read%';

		root@mysqldb 07:00:  [db1]> flush status;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 07:01:  [db1]> desc  select * from t1 force index(a) order by a desc;
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
		| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
		|  1 | SIMPLE      | t1    | NULL       | index | NULL          | a    | 5       | NULL | 1000 |   100.00 | NULL  |
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
		1 row in set, 1 warning (0.00 sec)

		root@mysqldb 07:01:  [db1]> pager cat >> /dev/null
		PAGER set to 'cat >> /dev/null'
		root@mysqldb 07:01:  [db1]> select * from t1 force index(a) order by a desc;
		1000 rows in set (0.01 sec)

		root@mysqldb 07:01:  [db1]> pager;
		root@mysqldb 07:01:  [db1]> show status like 'Handler_read%';
		+-----------------------+-------+
		| Variable_name         | Value |
		+-----------------------+-------+
		| Handler_read_first    | 0     |
		| Handler_read_key      | 1     |
		| Handler_read_last     | 1     |
		| Handler_read_next     | 0     |
		| Handler_read_prev     | 1000  |
		| Handler_read_rnd      | 0     |
		| Handler_read_rnd_next | 0     |
		+-----------------------+-------+
		7 rows in set (0.00 sec)
	
		Handler_read_prev	
			按照索引顺序读前一行（上一行）的请求数



	

	