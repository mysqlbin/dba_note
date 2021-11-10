


1. second_behind_master 可以作为1个参考值
2. 对比 GTID 的差值，也可以知道从库落后主库多少个事务
3. 对比 binlog + 位点，也可以知道从库落后主库多少日志


参考：《2021-11-08 - seconds_behind_master的计算方式.sql》
