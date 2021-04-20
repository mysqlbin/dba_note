
1. 密码强度相关参数解释
2. validate_password_policy=LOW
3. 未启用密码插件的状态
4. 启用密码插件的状态
5. 相关参考


1. 密码强度相关参数解释

	1. validate_password_policy

		代表的密码策略，默认是MEDIUM 可配置的值有以下：

			0 or LOW：low
				仅需需符合密码长度（由参数validate_password_length指定）

			1 or MEDIUM：medium
				满足LOW策略，同时还需满足至少有1个数字，小写字母，大写字母和特殊字符
				这些又分别由 validate_password_number_count，validate_password_mixed_case_count，validate_password_special_char_count 这几个参数来控制。
				
			2 or STRONG：strong
				满足MEDIUM策略，同时密码不能存在字典文件（dictionary file）中



	2. validate_password_dictionary_file

		用于配置密码的字典文件，当validate_password_policy设置为STRONG时可以配置密码字典文件，字典文件中存在的密码不得使用。


	3. validate_password_length

		用来设置密码的最小长度，默认值是8


	4. validate_password_mixed_case_count  

		当validate_password_policy设置为MEDIUM或者STRONG时，密码中至少同时拥有的小写和大写字母的数量，默认是1最小是0；默认是至少拥有一个小写和一个大写字母。


	5. validate_password_number_count    

		当validate_password_policy设置为MEDIUM或者STRONG时，密码中至少拥有的数字的个数，默认1最小是0


	6. validate_password_special_char_count

		当validate_password_policy设置为MEDIUM或者STRONG时，密码中至少拥有的特殊字符的个数，默认1最小是0


2. validate_password_policy=LOW
	
	root@mysqldb 09:58:  [(none)]> create user 'user_0420'@'%' identified by '123456';
	ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
	-- 您的密码不符合当前的政策要求
	
	查看密码设置策略：
		root@mysqldb 09:57:  [(none)]> SHOW VARIABLES LIKE 'validate_password%';
		+--------------------------------------+--------+
		| Variable_name                        | Value  |
		+--------------------------------------+--------+
		| validate_password_check_user_name    | OFF    |
		| validate_password_dictionary_file    |        | 
		| validate_password_length             | 8      |   密码最少设置8位数
		| validate_password_mixed_case_count   | 1      |
		| validate_password_number_count       | 1      |
		| validate_password_policy             | MEDIUM |   默认值
		| validate_password_special_char_count | 1      |
		+--------------------------------------+--------+
		7 rows in set (0.00 sec)


	解决办法：
		mysql> set global validate_password_policy=LOW;
		
		root@mysqldb 10:00:  [(none)]> SHOW VARIABLES LIKE 'validate_password%';
		+--------------------------------------+-------+
		| Variable_name                        | Value |
		+--------------------------------------+-------+
		| validate_password_check_user_name    | OFF   |
		| validate_password_dictionary_file    |       |
		| validate_password_length             | 8     |    --密码最少设置8位数
		| validate_password_mixed_case_count   | 1     |
		| validate_password_number_count       | 1     |
		| validate_password_policy             | LOW   |
		| validate_password_special_char_count | 1     |
		+--------------------------------------+-------+
		7 rows in set (0.00 sec)
		
		root@mysqldb 10:00:  [(none)]>  create user 'user_0420'@'%' identified by '123456';
		ERROR 1819 (HY000): Your password does not satisfy the current policy requirements

		root@mysqldb 10:01:  [(none)]> create user 'user_0420'@'%' identified by '123456ab';
		Query OK, 0 rows affected (0.04 sec)
		
		
		root@mysqldb 10:02:  [(none)]> create user 'user_0421'@'%' identified by '123456abc';
		Query OK, 0 rows affected (0.04 sec)

	
	还原：
		mysql> set global validate_password_policy=MEDIUM;



3. 未启用密码插件的状态
	
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)


	mysql> show plugins;
	+----------------------------+----------+--------------------+---------+---------+
	| Name                       | Status   | Type               | Library | License |
	+----------------------------+----------+--------------------+---------+---------+
	| binlog                     | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| mysql_native_password      | ACTIVE   | AUTHENTICATION     | NULL    | GPL     |
	| sha256_password            | ACTIVE   | AUTHENTICATION     | NULL    | GPL     |
	| InnoDB                     | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| INNODB_TRX                 | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_LOCKS               | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_LOCK_WAITS          | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_CMP                 | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_CMP_RESET           | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_CMPMEM              | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_CMPMEM_RESET        | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_CMP_PER_INDEX       | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_CMP_PER_INDEX_RESET | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_BUFFER_PAGE         | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_BUFFER_PAGE_LRU     | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_BUFFER_POOL_STATS   | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_TEMP_TABLE_INFO     | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_METRICS             | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_FT_DEFAULT_STOPWORD | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_FT_DELETED          | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_FT_BEING_DELETED    | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_FT_CONFIG           | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_FT_INDEX_CACHE      | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_FT_INDEX_TABLE      | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_TABLES          | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_TABLESTATS      | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_INDEXES         | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_COLUMNS         | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_FIELDS          | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_FOREIGN         | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_FOREIGN_COLS    | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_TABLESPACES     | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_DATAFILES       | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| INNODB_SYS_VIRTUAL         | ACTIVE   | INFORMATION SCHEMA | NULL    | GPL     |
	| MyISAM                     | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| MRG_MYISAM                 | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| MEMORY                     | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| CSV                        | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| PERFORMANCE_SCHEMA         | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| BLACKHOLE                  | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| partition                  | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| ARCHIVE                    | ACTIVE   | STORAGE ENGINE     | NULL    | GPL     |
	| FEDERATED                  | DISABLED | STORAGE ENGINE     | NULL    | GPL     |
	| ngram                      | ACTIVE   | FTPARSER           | NULL    | GPL     |
	+----------------------------+----------+--------------------+---------+---------+
	44 rows in set (0.00 sec)



4. 启用密码插件的状态

	方式1：
		INSTALL PLUGIN validate_password SONAME 'validate_password.so';
	
	方式2：
		plugin-load=validate_password.so

		validate-password=FORCE_PLUS_PERMANENT		

	mysql> show plugins;
	+----------------------------+----------+--------------------+----------------------+---------+
	| Name                       | Status   | Type               | Library              | License |
	+----------------------------+----------+--------------------+----------------------+---------+
	| binlog                     | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| mysql_native_password      | ACTIVE   | AUTHENTICATION     | NULL                 | GPL     |
	| sha256_password            | ACTIVE   | AUTHENTICATION     | NULL                 | GPL     |
	| InnoDB                     | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| INNODB_TRX                 | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_LOCKS               | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_LOCK_WAITS          | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_CMP                 | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_CMP_RESET           | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_CMPMEM              | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_CMPMEM_RESET        | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_CMP_PER_INDEX       | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_CMP_PER_INDEX_RESET | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_BUFFER_PAGE         | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_BUFFER_PAGE_LRU     | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_BUFFER_POOL_STATS   | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_TEMP_TABLE_INFO     | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_METRICS             | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_FT_DEFAULT_STOPWORD | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_FT_DELETED          | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_FT_BEING_DELETED    | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_FT_CONFIG           | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_FT_INDEX_CACHE      | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_FT_INDEX_TABLE      | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_TABLES          | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_TABLESTATS      | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_INDEXES         | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_COLUMNS         | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_FIELDS          | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_FOREIGN         | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_FOREIGN_COLS    | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_TABLESPACES     | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_DATAFILES       | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| INNODB_SYS_VIRTUAL         | ACTIVE   | INFORMATION SCHEMA | NULL                 | GPL     |
	| MyISAM                     | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| MRG_MYISAM                 | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| MEMORY                     | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| CSV                        | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| PERFORMANCE_SCHEMA         | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| BLACKHOLE                  | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| partition                  | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| ARCHIVE                    | ACTIVE   | STORAGE ENGINE     | NULL                 | GPL     |
	| FEDERATED                  | DISABLED | STORAGE ENGINE     | NULL                 | GPL     |
	| ngram                      | ACTIVE   | FTPARSER           | NULL                 | GPL     |
	| validate_password          | ACTIVE   | VALIDATE PASSWORD  | validate_password.so | GPL     |
	+----------------------------+----------+--------------------+----------------------+---------+
	45 rows in set (0.00 sec)
	
	
5. 相关参考
	
	https://mp.weixin.qq.com/s/m4cjDNCzVF0WNP-fRsfO1Q     安全为上，赶快启动MySQL密码审计插件吧
	
	https://mp.weixin.qq.com/s/8C50U5lPYtRYG4fU3p-JSw     年底了，你的数据库密码安全吗
	

	
