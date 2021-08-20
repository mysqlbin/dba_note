

1. ALTER TABLE `t_role_90`  ROW_FORMAT=DYNAMIC; 命令是否会同步到从库不？
	不会。
	
2. MySQL的一个表最多可以有多少个字段？
	这个是1个伪命题
	

3. varchar(N) N 大于属于大对象字段
	在COMPACT行记录格式+有行溢出的场景下，varchar(N) 的字节长度大于768字节算是大字段。

4. 
	Antelope格式下的COMPACT大字段按照 DICT_ANTELOPE_MAX_INDEX_COL_LEN（768）字节溢出页。varchar(100)没有存储为溢出页。

	Barracuda的DYNAMIC和COMPRESSED格式下只有长字段才会用20字节溢出页的方式，varchar(100)也没有存储为溢出页。

	-- 理解了。
		
5. 2个字段溢出，2个字段都有对应的 20字节的指针保留在行记录中吗
	1. 首先，要明白，有这种可能吗
		可以验证下
		答：是的。
		参考笔记：
			《2020-11-18-行溢出的进阶-varchar 9000.sql》
			《2021-08-19-latin1 Compact 大字段varchar() .sql》
		
		
6. MySQL 插入数据的总字节数大于8126导致数据写入失败
	
	Row size too large (> 8126). Changing some ... ... 。
	-- 复现了，参考笔记：
		《2020-11-18-insert出现8126的错误-latin1 varchar(100) Compact.sql》
		《2020-11-18-insert出现8126的错误-latin1 varchar(100) dynamic.sql》
		《2021-08-19-latin1 Compact 大字段varchar() .sql》
		
	
7. 参数innodb_strict_mode
	参考笔记：《2020-11-18-innodb_strict_mode.sql》
	
8. text、blob、longtext 各自可以存储多少字节的数据
	
	参考笔记：《2020-11-17-196_Compact_utf8_text文本型.sql》
	
9. 理解某篇文章通过修改row_format=dynamic解决插入数据报错问题
	
	https://blog.opskumu.com/mysql-blob.html
		修改参数：
			innodb_file_format=BARRACUDA
			row_format=dynamic
	-- 可以做为案例来讲解，体现了自己对行记录格式的深入研究。
	
	按照这种算法，查询之前某个出问题的用户 Blob 字段占用为 7602 「表中有 48 个 blob 字段」，加上其它的占用超过 8kB 就导致 了 Row size too large (> 8126). Changing some ... ... 。
	
	-- 有表结构设计不合理的原因。
	-- 这里理解了。
	-- Compact的行溢出：Compact行记录格式的多个字段行溢出，每个字段存储 768+20 字节在数据页中，超过一定数量(10字段都溢出)，报错....
		mysql> select 8098/768;
		+----------+
		| 8098/768 |
		+----------+
		|  10.5443 |
		+----------+
		1 row in set (0.00 sec)
	
	-- 这种场景下，行记录格式改为  dynamic， 10个字段都溢出，每个字段存储 20 字节的指针在数据页中，不会报错。
		
		mysql> select 8098/20;
		+----------+
		| 8098/20  |
		+----------+
		| 404.9000 |
		+----------+
		1 row in set (0.00 sec)

	-- 没有行溢出，但是单行的长度大于8126，Compact和Dynamic都一样报错
		
		-- 参考笔记：《2020-11-18-insert出现8126的错误-latin1 varchar(100) Compact.sql》和 《2020-11-18-insert出现8126的错误-latin1 varchar(100) dynamic.sql》
		
	
10. 关于参数值的修改

	SET GLOBAL innodb_file_format=BARRACUDA;  --修改之后，ROW_FORMAT=Compact是不是不生效了？不是的。
	ALTER TABLE `t_role_90`  ROW_FORMAT=DYNAMIC;  -- 会重建表吗？ 根据原理，是重建表。

	

11. 当 varchar(n) 中的 n 大于特定值时，MySQL 会自动将其转换成 text

	大于 255，varchar 自动转换成 tinytext

	大于 500，varchar 自动转换成 text

	大于 20000，varchar 自动转换成 mediumtext

	-- 这个在哪里有提到