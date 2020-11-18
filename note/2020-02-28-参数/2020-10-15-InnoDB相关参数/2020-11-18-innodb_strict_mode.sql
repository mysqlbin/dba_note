


innodb_strict_mode：
	严格模式;
	
	当创建表、修改表、创建索引等出现异常之后，如果开启严格模式，则直接报错; 如果是关闭严格模式，可以操作成功，只会有warnings提示。
	也用于检测行记录的大小，如果插入或者更新一行记录的长度大于一个数据页的一半，则报错。
	
	The innodb_strict_mode setting affects the handling of syntax errors for CREATE TABLE, ALTER TABLE, CREATE INDEX, and OPTIMIZE TABLE statements. 
	innodb_strict_mode also enables a record size check, so that an INSERT or UPDATE never fails due to the record being too large for the selected page size.




https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_strict_mode

https://mp.weixin.qq.com/s/w3ij101jzDlbu93i5J7uQg  故障分析 | MySQL TEXT 字段的限制


