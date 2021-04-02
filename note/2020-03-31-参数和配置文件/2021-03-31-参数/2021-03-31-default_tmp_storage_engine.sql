

root@mysqldb 15:59:  [test_db]> show global variables like '%default_tmp_storage_engine%';
+----------------------------+--------+
| Variable_name              | Value  |
+----------------------------+--------+
| default_tmp_storage_engine | InnoDB |
+----------------------------+--------+
1 row in set (0.00 sec)


从5.7.5开始，新增一个系统选项 internal_tmp_disk_storage_engine 可定义磁盘临时表的引擎类型为 InnoDB，而在这以前，只能使用 MyISAM。
而在5.6.3以后新增的系统选项 default_tmp_storage_engine 是控制 CREATE TEMPORARY TABLE 创建的临时表的引擎类型，在以前默认是MEMORY，不要把这二者混淆了。


https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_tmp_storage_engine

https://mp.weixin.qq.com/s/ro-nNhCcYL-RabIjUZNDew   [MySQL FAQ]系列 — 什么情况下会用到临时表





mysql> show global status like '%tables%';
+-------------------------+-------+
| Variable_name           | Value |
+-------------------------+-------+
| Com_alter_tablespace    | 0     |
| Com_lock_tables         | 0     |
| Com_show_open_tables    | 0     |
| Com_show_tables         | 149   |
| Com_unlock_tables       | 4     |
| Created_tmp_disk_tables | 2436  |
| Created_tmp_tables      | 5339  |
| Open_tables             | 797   |
| Opened_tables           | 9176  |
| Slave_open_temp_tables  | 0     |
+-------------------------+-------+
10 rows in set (0.00 sec)

