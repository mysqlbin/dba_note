

1. 首先，mysqldump 是1个逻辑备份

逻辑备份的原理/工作流程：

1. 加1个全局读锁，ftwrl(flush table with read lock)
2. 把事务隔离级别改为可重复读并启动1个事务来获取一致性视图
3. 获取一致性快照的binlog位点：binlog名称和位置点，或者GTID编号
4. unlock table 释放全局读锁
5. 循环备份表结构和数据
6. 备份完成之后，commit提交事务。