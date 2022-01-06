char(n) ：
	
	固定长度类型
	
	从存储的角度：
		不管字符长度够不够10个，实际存储还是占用10个字符串长度；
		
	缺点：占用空间；
	
	适用场景：存储密码的 md5 值，固定长度的，使用 char 非常合适。 

varchar(n) ：

	可变长度类型
	
	从存储的角度：
		varchar(10) 字符长度最大不能超过10个，使用了多少个字符串长度，实际存储就占用几个字符串长度;
		varchar(10) 中 10 的涵义最多存放 10 个字符，varchar(10) 和 varchar(20) 存储 'hello' 字符串所占空间一样
	
	适用场景：存储字符串长度不固定的数据

从含义、存储的角度、适应场景来说明

所以，从空间上考虑 varcahr 比较合适。


2021-08-19-char和varchar




验证 char:

	drop table if exists tchar;
	CREATE TABLE `tchar` (
	  `id` int(10) unsigned NOT NULL DEFAULT '0',
	  `c1` char(20) NOT NULL DEFAULT '',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	insert into tchar values (1, concat('a', repeat(' ',19)));
	insert into tchar values (2, concat(' ', repeat('a',19)));
	insert into tchar values (3, 'a');
	insert into tchar values (4, ' ');
	insert into tchar values (5, '');

	mysql> select id,concat('000',c1,'$$$'),length(c1) from tchar ;
	+----+----------------------------+------------+
	| id | concat('000',c1,'$$$')     | length(c1) |
	+----+----------------------------+------------+
	|  1 | 000a$$$                    |          1 |
	|  2 | 000 aaaaaaaaaaaaaaaaaaa$$$ |         20 |
	|  3 | 000a$$$                    |          1 |
	|  4 | 000$$$                     |          0 |
	|  5 | 000$$$                     |          0 |
	+----+----------------------------+------------+
	5 rows in set (0.00 sec)


验证 varchar:

	CREATE TABLE `tvarchar` (
	  `id` int(10) unsigned NOT NULL DEFAULT '0',
	  `c1` varchar(20) NOT NULL DEFAULT '',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	insert into tvarchar values (1, concat('a', repeat(' ',19)));
	insert into tvarchar values (2, concat(' ', repeat('a',19)));
	insert into tvarchar values (3, 'a');
	insert into tvarchar values (4, ' ');
	insert into tvarchar values (5, '');
	insert into tvarchar values (6, '');
	
	mysql> select id,concat('000',c1,'$$$'),length(c1) from tvarchar;
	+----+----------------------------+------------+
	| id | concat('000',c1,'$$$')     | length(c1) |
	+----+----------------------------+------------+
	|  1 | 000a                   $$$ |         20 |
	|  2 | 000 aaaaaaaaaaaaaaaaaaa$$$ |         20 |
	|  3 | 000a$$$                    |          1 |
	|  4 | 000 $$$                    |          1 |
	|  5 | 000$$$                     |          0 |
	|  6 | 000$$$                     |          0 |
	+----+----------------------------+------------+
	6 rows in set (0.00 sec)


	
	
	