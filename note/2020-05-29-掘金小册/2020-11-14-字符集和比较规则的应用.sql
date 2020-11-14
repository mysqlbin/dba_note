

服务器级别
	mysql> show global variables like '%_server%';
	+---------------------------------+-----------------+
	| Variable_name                   | Value           |
	+---------------------------------+-----------------+
	| character_set_server            | utf8            |
	| collation_server                | utf8_general_ci |
	| innodb_ft_server_stopword_table |                 |
	+---------------------------------+-----------------+
	3 rows in set (0.00 sec)


	character_set_server ：服务器级别的字符集
	collation_server ：    服务器级别的比较规则


数据库级别
	mysql>show global variables like '%_database%';
	+------------------------+-----------------+
	| Variable_name          | Value           |
	+------------------------+-----------------+
	| character_set_database | utf8            |
	| collation_database     | utf8_general_ci |
	| skip_show_database     | OFF             |
	+------------------------+-----------------+
	3 rows in set (0.01 sec)

	character_set_database : 当前数据库的字符集
	collation_database : 	 当前数据库的比较规则

  

下面的几个变量跟乱码没有什么关系
	character_set_client·    ： 服务器认为请求是按照该系统变量指定的字符集进行编码的
	character_set_connection ： 服务器在处理请求时，会把请求字节序列从 character_set_client· 转换为 character_set_connection
	character_set_results	 ： 服务器采用该系统变量指定的字符集对返回客户端的字符串进行编码



服务器级别的字符集	
character-set-server = utf8mb4
服务器级别的排序规则
collation-server=utf8mb4_general_ci



https://blog.csdn.net/sun8112133/article/details/79921734


参数
	character-set-server = utf8，此时相关的系统变量如下
		mysql>show global variables like '%character%';
		+--------------------------+----------------------------------------------------------------+
		| Variable_name            | Value                                                          |
		+--------------------------+----------------------------------------------------------------+
		| character_set_client     | utf8                                                           |
		| character_set_connection | utf8                                                           |
		| character_set_database   | utf8                                                           |
		| character_set_filesystem | binary                                                         |
		| character_set_results    | utf8                                                           |
		| character_set_server     | utf8                                                           |
		| character_set_system     | utf8                                                           |
		| character_sets_dir       | /opt/mysql/mysql-5.7.19-linux-glibc2.12-x86_64/share/charsets/ |
		+--------------------------+----------------------------------------------------------------+
		8 rows in set (0.00 sec)


		root@localhost [(none)]>show global variables like '%collation_server%';
		+------------------+-----------------+
		| Variable_name    | Value           |
		+------------------+-----------------+
		| collation_server | utf8_general_ci |
		+------------------+-----------------+
		1 row in set (0.01 sec)

		root@localhost [(none)]>show global variables like '%collation_database%';
		+--------------------+-----------------+
		| Variable_name      | Value           |
		+--------------------+-----------------+
		| collation_database | utf8_general_ci |
		+--------------------+-----------------+
		1 row in set (0.01 sec)
		
	character-set-server = utf8mb4，此时相关的系统变量如下
	
		root@localhost [(none)]>show global variables like '%character%';
		+--------------------------+----------------------------------------------------------------+
		| Variable_name            | Value                                                          |
		+--------------------------+----------------------------------------------------------------+
		| character_set_client     | utf8mb4                                                        |
		| character_set_connection | utf8mb4                                                        |
		| character_set_database   | utf8mb4                                                        |
		| character_set_filesystem | binary                                                         |
		| character_set_results    | utf8mb4                                                        |
		| character_set_server     | utf8mb4                                                        |
		| character_set_system     | utf8                                                           |
		| character_sets_dir       | /opt/mysql/mysql-5.7.19-linux-glibc2.12-x86_64/share/charsets/ |
		+--------------------------+----------------------------------------------------------------+
		8 rows in set (0.00 sec)
	
		root@localhost [(none)]>show global variables like '%collation_server%';
		+------------------+--------------------+
		| Variable_name    | Value              |
		+------------------+--------------------+
		| collation_server | utf8mb4_general_ci |
		+------------------+--------------------+
		1 row in set (0.01 sec)

		root@localhost [(none)]>show global variables like '%collation_database%';
		+--------------------+--------------------+
		| Variable_name      | Value              |
		+--------------------+--------------------+
		| collation_database | utf8mb4_general_ci |
		+--------------------+--------------------+
		1 row in set (0.00 sec)
		
	