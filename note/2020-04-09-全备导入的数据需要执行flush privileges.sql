
现象:
	新的实例中, 导入 mysqldump 备份的全备之后, 业务数据库账号连接不上, 想修改密码但是提示以下错误
	mysql> alter user 'test_user'@'%' identified by '123456abc';
	ERROR 1396 (HY000): Operation ALTER USER failed for 'test_user'@'%'

解决办法
	通过 全备导入的数据需要执行 mysql> flush privileges;
		https://blog.csdn.net/boyheroes/article/details/87197013
		
