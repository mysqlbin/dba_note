
可取值为0 1 2; 默认值为1。

在关闭时,参数 innodb_fast_shutdown 影响着表的存储引擎为InnoDB的行为.

如何快速关闭MySQL

mysql> show global variables like '%innodb_fast_shutdown%';
+----------------------+-------+
| Variable_name        | Value |
+----------------------+-------+
| innodb_fast_shutdown | 1     |
+----------------------+-------+
1 row in set (0.00 sec)



参考笔记：《2021-04-12-启动、关闭与恢复》