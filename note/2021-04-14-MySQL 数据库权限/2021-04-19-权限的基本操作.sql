


MySQL 5.7:
	授权方式：
		1. 
			grant select on *.* to 'wubx'@'%' identified by 'wubxwubx';
		2. 
			create user 'root'@'%' identified by '123456abc';
			grant all privileges on *.* to 'root'@'%' with grant option;
			
		3. 要用第2种方式，第1种方式会修改账号的密码
		
	
查看当前有哪些账号：
    select concat("\'", user, "\'", '@', "\'", host,"\'") as query from mysql.user;
    select * from mysql.user;
	
查看权限：
	show grants for 'wubx'@'192.168.11.218';
	

重命名：
	RENAME USER 'jeffrey'@'localhost' TO 'jeff'@'127.0.0.1';
	
修改密码：

	MySQL5.7:
		alter user 'wub'@'%' password('wubxwubx');
		alter user 'root'@'localhost' identified by 'wubxwubx';
			
	MySQL5.6:
		SET PASSWORD FOR 'test_user'@'%' = PASSWORD('123456abc');


删除用户：
	drop user 'slow_user'@'%';


MySQL 8.0:

	create user rpls_user@'%' identified by '123456abc';
	grant replication slave on *.* to rpls_user@'%';
		
	官方文档：
		https://dev.mysql.com/doc/refman/8.0/en/grant.html


	create user 'root'@'%' identified by '123456abc';
	grant all privileges on *.* to 'root'@'%' with grant option;

