

1. 如果要做 binlog server， 那么在哪一台从库做备份，就做对应备份从库的 binlog server。

2. 基于全备加增量binlog的恢复，速度慢

3. 利用现有的延迟从库做数据恢复，速度更快


 