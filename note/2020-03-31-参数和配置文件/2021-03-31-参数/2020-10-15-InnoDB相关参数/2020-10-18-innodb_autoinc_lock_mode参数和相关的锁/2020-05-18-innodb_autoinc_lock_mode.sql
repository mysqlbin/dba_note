

1. 初始化表结构、数据、环境 
2. innodb_autoinc_lock_mode=2
3. innodb_autoinc_lock_mode=1
4. 小结


1. 初始化表结构、数据、环境 
	CREATE TABLE `sbtest2` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `k` int(10) unsigned NOT NULL DEFAULT '0',
	  `c` char(120) NOT NULL DEFAULT '',
	  `pad` char(60) NOT NULL DEFAULT '',
	  `d` int(10) NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `k_2` (`k`)
	) ENGINE=InnoDB AUTO_INCREMENT=500001 DEFAULT CHARSET=utf8mb4 MAX_ROWS=1000000;

	mysql> >select count(*) from sbtest2;
	+----------+
	| count(*) |
	+----------+
	|   500000 |
	+----------+
	1 row in set (0.34 sec)


	CREATE TABLE `sbtest2_new` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `k` int(10) unsigned NOT NULL DEFAULT '0',
	  `c` char(120) NOT NULL DEFAULT '',
	  `pad` char(60) NOT NULL DEFAULT '',
	  `d` int(10) NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `k_2` (`k`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


	mysql> >show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.01 sec)

	mysql> >show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)



2. innodb_autoinc_lock_mode=2
	mysql> >show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 2     |
	+--------------------------+-------+
	1 row in set (0.00 sec)


	mysql> INSERT INTO `sbtest2_new` (`id`, `k`, `c`, `pad`, `d`) SELECT `id`, `k`, `c`, `pad`, `d` from sbtest2 WHERE id between 1 and 500000;
	Query OK, 500000 rows affected (33.56 sec)
	Records: 500000  Duplicates: 0  Warnings: 0

	truncate table 	sbtest2_new;

	mysql> >INSERT INTO `sbtest2_new` (`id`, `k`, `c`, `pad`, `d`) SELECT `id`, `k`, `c`, `pad`, `d` from sbtest2 WHERE id between 1 and 500000;
	Query OK, 500000 rows affected (30.86 sec)
	Records: 500000  Duplicates: 0  Warnings: 0



3. innodb_autoinc_lock_mode=1

	mysql> >show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	truncate table 	sbtest2_new;

	mysql> >INSERT INTO `sbtest2_new` (`id`, `k`, `c`, `pad`, `d`) SELECT `id`, `k`, `c`, `pad`, `d` from sbtest2 WHERE id between 1 and 500000;
	Query OK, 500000 rows affected (29.95 sec)
	Records: 500000  Duplicates: 0  Warnings: 0

	truncate table 	sbtest2_new;


	mysql> >INSERT INTO `sbtest2_new` (`id`, `k`, `c`, `pad`, `d`) SELECT `id`, `k`, `c`, `pad`, `d` from sbtest2 WHERE id between 1 and 500000;
	Query OK, 500000 rows affected (27.60 sec)
	Records: 500000  Duplicates: 0  Warnings: 0

	truncate table 	sbtest2_new;


	mysql> >INSERT INTO `sbtest2_new` (`id`, `k`, `c`, `pad`, `d`) SELECT `id`, `k`, `c`, `pad`, `d` from sbtest2 WHERE id between 1 and 500000;
	Query OK, 500000 rows affected (31.35 sec)
	Records: 500000  Duplicates: 0  Warnings: 0

4. 小结

	innodb_autoinc_lock_mode=1 和 innodb_autoinc_lock_mode=2 ：
	
		通过 insert into t2 select t1 插入速度一样，只是说当innodb_autoinc_lock_mode=2，自增锁是在申请完成之后就释放，不需要等语句执行完成才释放自增锁，释放自增锁之后不会阻塞对表的插入语句，从而提升了性能。
	
	使用场景：类似于通过pt-osc工具做在线DDL时，当innodb_autoinc_lock_mode=2， 可以大大降低死锁发生的概率。
		

	
	