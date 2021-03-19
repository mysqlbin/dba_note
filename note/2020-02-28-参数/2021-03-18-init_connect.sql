init-connect='SET NAMES utf8mb4'



root@mysqldb 11:10:  [(none)]> show variables like '%char%';
+--------------------------+----------------------------------+
| Variable_name            | Value                            |
+--------------------------+----------------------------------+
| character_set_client     | utf8mb4                          |
| character_set_connection | utf8mb4                          |
| character_set_database   | utf8mb4                          |
| character_set_filesystem | binary                           |
| character_set_results    | utf8mb4                          |
| character_set_server     | utf8mb4                          |
| character_set_system     | utf8                             |
| character_sets_dir       | /usr/local/mysql/share/charsets/ |
+--------------------------+----------------------------------+
8 rows in set (0.00 sec)

root@mysqldb 14:24:  [yldbs]> select szNickName from table_user where nPlayerId=1000;
+------------+
| szNickName |
+------------+
| *😆*         |
+------------+
1 row in set (0.00 sec)

------------------------------------------------------------------------------------


root@mysqldb 11:05:  [(none)]>  show variables like '%char%';
+--------------------------+----------------------------------+
| Variable_name            | Value                            |
+--------------------------+----------------------------------+
| character_set_client     | utf8                             |
| character_set_connection | utf8                             |
| character_set_database   | utf8mb4                          |
| character_set_filesystem | binary                           |
| character_set_results    | utf8                             |
| character_set_server     | utf8mb4                          |
| character_set_system     | utf8                             |
| character_sets_dir       | /usr/local/mysql/share/charsets/ |
+--------------------------+----------------------------------+
8 rows in set (0.00 sec)

上面的配置不支持存储表情

update table_user set szNickName='罗老师👿 时间管理大师👿 👿' where nPlayerId=1000;


------------------------------------------------------------------------------------

root@mysqldb 14:31:  [(none)]> show global variables like '%init%';
+------------------------+----------------+
| Variable_name          | Value          |
+------------------------+----------------+
| init_connect           | SET NAMES utf8 |
| init_file              |                |
| init_slave             |                |
| table_definition_cache | 1024           |
+------------------------+----------------+
4 rows in set (0.00 sec)

root@mysqldb 14:31:  [(none)]> show variables like '%char%';
+--------------------------+----------------------------------+
| Variable_name            | Value                            |
+--------------------------+----------------------------------+
| character_set_client     | utf8mb4                          |
| character_set_connection | utf8mb4                          |
| character_set_database   | utf8mb4                          |
| character_set_filesystem | binary                           |
| character_set_results    | utf8mb4                          |
| character_set_server     | utf8mb4                          |
| character_set_system     | utf8                             |
| character_sets_dir       | /usr/local/mysql/share/charsets/ |
+--------------------------+----------------------------------+
8 rows in set (0.00 sec)

