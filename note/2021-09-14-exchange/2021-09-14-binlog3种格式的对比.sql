
statement、row、mixed

从 含义、优点、缺点 这几个维度进行比较。

含义：
	statement 在 binlog 中记录的是 SQL 的原始语句
	row 在 binlog 中记录的行
	mixed 是一种折衷方案，是statement和row的结合，MySQL 会自动判断选择的是statement还是row
	
优点
	statement 写 binlog 占用的磁盘空间少
	row： 可以保证主从数据的一致性

缺点：
	statement 和 mixed 格式可以会导致主从数据不一致。
	row 写 binlog占用的磁盘空间相对较多。
	
	

相关参考：
		
	24: MySQL主从原理和binlog的3种格式 还有 双M结构的循环复制
	24-statement格式下delete语句带有 limit-可能会导致主从数据不一致.sql
	24-statement格式下-insert into select 语句先执行后有对原表做insert操作-可能会导致主从数据不一致.sql
