

rollback segments总数量：innodb_rollback_segments

通过 innodb_rollback_segments 参数的值可以了解到, Rollback Segments的个数是InnoDB系统启动时分配的.


设置回滚段 rollback segments 的数量.比如将 总共2G的undo tablespace, 切分成多少份 rollback segments; 默认 128 个 rollback segments, 实例初始化后中不可再修改. 每个 undo log seg 可以最多存放1024个事务.
rollback segment slot 0 固定在 ibdata中，而 rollback segment slot 1-32 为临时rollback segment，33-128才是普通事物的rollback segment。

《2020-06-05-undo log 和 purge线程的管理》

mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)


mysql> show global variables like '%innodb_rollback_segments%';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| innodb_rollback_segments | 128   |
+--------------------------+-------+
1 row in set (0.01 sec)
