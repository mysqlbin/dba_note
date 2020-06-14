

1. 创建角色和为角色分配权限	
2. 创建用户和为用户分配角色
3. 检查角色权限和显示角色权限
4. 撤消角色或角色权限
5. 删除角色
6. 相关参考


	
1. 创建角色和为角色分配权限	
	
	要创建角色，请使用CREATE ROLE：

		CREATE ROLE 'app_developer', 'app_read', 'app_write';

	为角色分配权限，使用与为用户分配权限相同的语法执行：

		GRANT ALL ON app_db.* TO 'app_developer';
		GRANT SELECT ON app_db.* TO 'app_read';
		GRANT INSERT, UPDATE, DELETE ON app_db.* TO 'app_write';
		
	
2. 创建用户和为用户分配角色

	现在假设您最初需要一个开发人员帐户，两个需要只读访问权的用户以及一个需要读取/写入权限的用户。
	使用CREATEUSER创建用户：

		CREATE USER 'dev1'@'192.168.0.%' IDENTIFIED BY '123456abc';
		CREATE USER 'read_user1'@'192.168.0.%' IDENTIFIED BY '123456abc';
		CREATE USER 'read_user2'@'192.168.0.%' IDENTIFIED BY '123456abc';
		CREATE USER 'rw_user1'@'192.168.0.%' IDENTIFIED BY '123456abc';		
				
				
	为用户分配角色:		
		GRANT 'app_developer' TO 'dev1'@'192.168.0.%';
		GRANT 'app_read' TO 'read_user1'@'192.168.0.%', 'read_user2'@'192.168.0.%';
		GRANT 'app_read', 'app_write' TO 'rw_user1'@'192.168.0.%';	
		
		'dev1'@'192.168.0.%' 用户所属 	app_developer 角色
		'read_user1'@'192.168.0.%' 和 'read_user2'@'192.168.0.%' 用户所属 	app_read 角色
		'rw_user1'@'192.168.0.%' 用户所属  'app_read', 'app_write' 角色 
			
			
3. 检查角色权限和显示角色权限
	
	检查角色权限
		
		要验证分配给用户的权限，使用 SHOW GRANTS。例如
			root@mysqldb 14:37:  [(none)]> SHOW GRANTS FOR 'dev1'@'192.168.0.%';
			+---------------------------------------------------+
			| Grants for dev1@192.168.0.%                       |
			+---------------------------------------------------+
			| GRANT USAGE ON *.* TO `dev1`@`192.168.0.%`        |
			| GRANT `app_developer`@`%` TO `dev1`@`192.168.0.%` |
			+---------------------------------------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 14:38:  [(none)]> SHOW GRANTS FOR 'read_user1'@'192.168.0.%';
			+----------------------------------------------------+
			| Grants for read_user1@192.168.0.%                  |
			+----------------------------------------------------+
			| GRANT USAGE ON *.* TO `read_user1`@`192.168.0.%`   |
			| GRANT `app_read`@`%` TO `read_user1`@`192.168.0.%` |
			+----------------------------------------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 14:39:  [(none)]> SHOW GRANTS FOR 'rw_user1'@'192.168.0.%';
			+------------------------------------------------------------------+
			| Grants for rw_user1@192.168.0.%                                  |
			+------------------------------------------------------------------+
			| GRANT USAGE ON *.* TO `rw_user1`@`192.168.0.%`                   |
			| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`192.168.0.%` |
			+------------------------------------------------------------------+
			2 rows in set (0.00 sec)

	如果要显示角色权限，添加一个 USING 来显示：

		root@mysqldb 14:39:  [(none)]> SHOW GRANTS FOR 'dev1'@'192.168.0.%' USING 'app_developer';
		+------------------------------------------------------------+
		| Grants for dev1@192.168.0.%                                |
		+------------------------------------------------------------+
		| GRANT USAGE ON *.* TO `dev1`@`192.168.0.%`                 |
		| GRANT ALL PRIVILEGES ON `app_db`.* TO `dev1`@`192.168.0.%` |
		| GRANT `app_developer`@`%` TO `dev1`@`192.168.0.%`          |
		+------------------------------------------------------------+
		3 rows in set (0.00 sec)
		
		root@mysqldb 14:43:  [(none)]> SHOW GRANTS FOR 'read_user1'@'192.168.0.%' USING 'app_read';
		+----------------------------------------------------------+
		| Grants for read_user1@192.168.0.%                        |
		+----------------------------------------------------------+
		| GRANT USAGE ON *.* TO `read_user1`@`192.168.0.%`         |
		| GRANT SELECT ON `app_db`.* TO `read_user1`@`192.168.0.%` |
		| GRANT `app_read`@`%` TO `read_user1`@`192.168.0.%`       |
		+------------------------
		
		root@mysqldb 14:43:  [(none)]> SHOW GRANTS FOR 'read_user2'@'192.168.0.%' USING 'app_read';
		+----------------------------------------------------------+
		| Grants for read_user2@192.168.0.%                        |
		+----------------------------------------------------------+
		| GRANT USAGE ON *.* TO `read_user2`@`192.168.0.%`         |
		| GRANT SELECT ON `app_db`.* TO `read_user2`@`192.168.0.%` |
		| GRANT `app_read`@`%` TO `read_user2`@`192.168.0.%`       |
		+----------------------------------------------------------+
		3 rows in set (0.00 sec)
		

		root@mysqldb 14:43:  [(none)]> SHOW GRANTS FOR 'rw_user1'@'192.168.0.%' USING 'app_write';
		+------------------------------------------------------------------------+
		| Grants for rw_user1@192.168.0.%                                        |
		+------------------------------------------------------------------------+
		| GRANT USAGE ON *.* TO `rw_user1`@`192.168.0.%`                         |
		| GRANT INSERT, UPDATE, DELETE ON `app_db`.* TO `rw_user1`@`192.168.0.%` |
		| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`192.168.0.%`       |
		+------------------------------------------------------------------------+
		3 rows in set (0.00 sec)


4. 撤消角色或角色权限

	正如可以授权某个用户的角色一样，可以从帐户中撤销这些角色：

		'dev1'@'192.168.0.%' 用户所属 	app_developer 角色
		'read_user1'@'192.168.0.%' 和 'read_user2'@'192.168.0.%' 用户所属 	app_read 角色
		'rw_user1'@'192.168.0.%' 用户所属  'app_read', 'app_write' 角色 
		语法 ： REVOKE role FROM user;  
		
		从 'rw_user1'@'192.168.0.%' 用户中撤销 app_write 角色
			root@mysqldb 05:27:  [(none)]> REVOKE app_write FROM 'rw_user1'@'192.168.0.%'; 
			Query OK, 0 rows affected (0.01 sec)

			root@mysqldb 05:28:  [(none)]> SHOW GRANTS FOR 'rw_user1'@'192.168.0.%' USING 'app_write';
			ERROR 3530 (HY000): `app_write`@`%` is not granted to `rw_user1`@`192.168.0.%`
					
			root@mysqldb 05:28:  [(none)]> SHOW GRANTS FOR 'rw_user1'@'192.168.0.%' USING 'app_read';
			+--------------------------------------------------------+
			| Grants for rw_user1@192.168.0.%                        |
			+--------------------------------------------------------+
			| GRANT USAGE ON *.* TO `rw_user1`@`192.168.0.%`         |
			| GRANT SELECT ON `app_db`.* TO `rw_user1`@`192.168.0.%` |
			| GRANT `app_read`@`%` TO `rw_user1`@`192.168.0.%`       |
			+--------------------------------------------------------+
			3 rows in set (0.00 sec)
		
					
		为用户重新分配角色:		
					
			root@mysqldb 05:29:  [(none)]> GRANT 'app_write' TO 'rw_user1'@'192.168.0.%';
			Query OK, 0 rows affected (0.01 sec)

			root@mysqldb 05:33:  [(none)]> SHOW GRANTS FOR 'rw_user1'@'192.168.0.%' USING 'app_read', 'app_write';
			+--------------------------------------------------------------------------------+
			| Grants for rw_user1@192.168.0.%                                                |
			+--------------------------------------------------------------------------------+
			| GRANT USAGE ON *.* TO `rw_user1`@`192.168.0.%`                                 |
			| GRANT SELECT, INSERT, UPDATE, DELETE ON `app_db`.* TO `rw_user1`@`192.168.0.%` |
			| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`192.168.0.%`               |
			+--------------------------------------------------------------------------------+
			3 rows in set (0.00 sec)
				
	假设想临时让所有用户只读，使用REVOKE从该 app_write 角色中撤消修改权限 ：
		
		root@mysqldb 15:02:  [(none)]> REVOKE INSERT, UPDATE, DELETE ON app_db.* FROM 'app_write';
		Query OK, 0 rows affected (0.04 sec)
		root@mysqldb 15:02:  [(none)]> SHOW GRANTS FOR 'rw_user1'@'192.168.0.%' USING 'app_write';
		+------------------------------------------------------------------+
		| Grants for rw_user1@192.168.0.%                                  |
		+------------------------------------------------------------------+
		| GRANT USAGE ON *.* TO `rw_user1`@`192.168.0.%`                   |
		| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`192.168.0.%` |
		+------------------------------------------------------------------+
		2 rows in set (0.00 sec)

	碰巧，某个角色完全没有任何权限，正如可以看到的那样 SHOW GRANTS （这个语句可以和角色一起使用，而不仅仅是查询用户权限可用）：
		root@mysqldb 15:02:  [(none)]> SHOW GRANTS FOR 'app_write';
		+---------------------------------------+
		| Grants for app_write@%                |
		+---------------------------------------+
		| GRANT USAGE ON *.* TO `app_write`@`%` |
		+---------------------------------------+
		1 row in set (0.00 sec)
	
		
	从角色中撤销权限会影响到该角色中任何用户的权限，因此 rw_user1 现在已经没有表修改权限（INSERT， UPDATE，和 DELETE权限已经没有了）：
				
		root@mysqldb 15:04:  [(none)]> SHOW GRANTS FOR 'rw_user1'@'192.168.0.%' USING 'app_read', 'app_write';
		+------------------------------------------------------------------+
		| Grants for rw_user1@192.168.0.%                                  |
		+------------------------------------------------------------------+
		| GRANT USAGE ON *.* TO `rw_user1`@`192.168.0.%`                   |
		| GRANT SELECT ON `app_db`.* TO `rw_user1`@`192.168.0.%`           |
		| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`192.168.0.%` |
		+------------------------------------------------------------------+
		3 rows in set (0.00 sec)
	 
	实际上， rw_user1 读/写用户已成为只读用户。对于被授予app_write角色的任何其他用户也会发生这种情况，说明修改使用角色而不必修改个人帐户的权限。
	
	要恢复角色的修改权限，只需重新授予它们即可：

		root@mysqldb 15:09:  [(none)]> GRANT INSERT, UPDATE, DELETE ON app_db.* TO 'app_write';
		Query OK, 0 rows affected (0.02 sec)

		root@mysqldb 15:11:  [(none)]> 
		root@mysqldb 15:11:  [(none)]> SHOW GRANTS FOR 'rw_user1'@'192.168.0.%' USING 'app_read', 'app_write';
		+--------------------------------------------------------------------------------+
		| Grants for rw_user1@192.168.0.%                                                |
		+--------------------------------------------------------------------------------+
		| GRANT USAGE ON *.* TO `rw_user1`@`192.168.0.%`                                 |
		| GRANT SELECT, INSERT, UPDATE, DELETE ON `app_db`.* TO `rw_user1`@`192.168.0.%` |
		| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`192.168.0.%`               |
		+--------------------------------------------------------------------------------+
		3 rows in set (0.00 sec)
	
	
	现在rw_user1再次具有修改权限，就像授权该app_write角色的其他任何帐户一样。


5. 删除角色

	要删除角色，请使用DROP ROLE：

		DROP ROLE 'app_read', 'app_write';
		
		删除角色会从授权它的每个帐户中撤消该角色。
	
		root@mysqldb 05:36:  [(none)]>  SHOW GRANTS FOR 'rw_user1'@'192.168.0.%';
		+------------------------------------------------+
		| Grants for rw_user1@192.168.0.%                |
		+------------------------------------------------+
		| GRANT USAGE ON *.* TO `rw_user1`@`192.168.0.%` |
		+------------------------------------------------+
		1 row in set (0.00 sec)

		root@mysqldb 05:36:  [(none)]>  SHOW GRANTS FOR 'read_user1'@'192.168.0.%';
		+--------------------------------------------------+
		| Grants for read_user1@192.168.0.%                |
		+--------------------------------------------------+
		| GRANT USAGE ON *.* TO `read_user1`@`192.168.0.%` |
		+--------------------------------------------------+
		1 row in set (0.00 sec)

		
	
6. 相关参考:
	https://mp.weixin.qq.com/s/84LPEz7Ki2iYYZ2Ax-l6cQ	 MySQL 8.0用户和角色管理 
	https://www.cndba.cn/Expect-le/article/3178          MySQL 8新特性--角色

	
	
思考:
	账号已经有所属角色, 是否还可以为账号单独授权/回收权限
	根据常识， 是可以的；需要通过实验验证下。
	
	
	