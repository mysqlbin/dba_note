
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


	