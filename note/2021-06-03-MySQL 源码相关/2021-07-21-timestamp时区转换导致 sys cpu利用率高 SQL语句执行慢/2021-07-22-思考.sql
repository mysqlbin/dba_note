
set global time_zone='+08:00'; 
	1. 对正在运行的数据库有什么影响 ？
	2. 不可以写进配置文件吗
	
	
mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | +08:00 |
+---------------+--------+
1 row in set (0.00 sec)

