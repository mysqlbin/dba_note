

部分改进和特性:

	1. 提高SELECT COUNT(*) FROM tbl_name 语句的查询速度，注意只针对没有where条件的sql或者没有其他group by的查询语句。
		例如 select count(*) from t where a=x 则不能优化。

	2. 支持Skip Scan access 有点像跳跃索引扫描，看官方的例子
		
		CREATE TABLE t1 (f1 INT NOT NULL, f2 INT NOT NULL, PRIMARY KEY(f1, f2));
		INSERT INTO t1 VALUES(1,1), (1,2), (1,3), (1,4), (1,5),(2,1), (2,2), (2,3), (2,4), (2,5);
		INSERT INTO t1 SELECT f1, f2 + 5 FROM t1;
		INSERT INTO t1 SELECT f1, f2 + 10 FROM t1;
		INSERT INTO t1 SELECT f1, f2 + 20 FROM t1;
		INSERT INTO t1 SELECT f1, f2 + 40 FROM t1;
		
		ANALYZE TABLE t1;
		mysql> EXPLAIN SELECT f1, f2 FROM t1 WHERE f2 > 40;
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------+
		| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                                  |
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------+
		|  1 | SIMPLE      | t1    | NULL       | range | PRIMARY       | PRIMARY | 8       | NULL |   53 |   100.00 | Using where; Using index for skip scan |
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------+
		1 row in set, 1 warning (0.02 sec)

	  优化器能使用Skip Scan access必须满足:

		1. select的字段必须都在组合索引中，也即满足覆盖索引的条件。

		2. 索引最左前缀不在where条件中。(a,b,c,d) a 不在where 条件中，但是b c必须在。

		3. 查询只能涉及到一个单表。

        4. 查询sql不能使用group by 或者distinct

        5. where 条件中必须有非最左前缀必须有范围查询，比如索引是(a,b,c) where b>20 .
		
		个人感觉这个特性颠覆了DBA经常告诉开发的最左前缀原则,是对不合适索引设计的补充。
		尽管MySQL优化器越来越强大，但是开发创建索引时还是要尽可能的满足最左前缀原则。
		
		相关参考:
			https://mp.weixin.qq.com/s/J7LfZjhJak_rQ_Ft2sFmVQ  新特性解读 | MySQL 8.0 索引特性2-索引跳跃扫描 	
			https://mp.weixin.qq.com/s?__biz=MzI4NjExMDA4NQ==&mid=2648451273&idx=1&sn=7115fbb5926dec53a77e5065aaf07487&chksm=f3c97023c4bef935f692b7ec38b2c327ce837602a1df797910621c31bb4b7b0ed0975d6ee330&scene=21#wechat_redirect
			MySQL 最新的release notes 8.0.13 - 8.0.14
			https://mp.weixin.qq.com/s/9z81hnrh-lCibILEV0EGdg   干货 | 解读MySQL 8.0新特性：Skip Scan Ran
			https://dev.mysql.com/doc/refman/8.0/en/range-optimization.html   
			
	3. 还有其他数据文件加密和MRG 相关改进
	
	
	