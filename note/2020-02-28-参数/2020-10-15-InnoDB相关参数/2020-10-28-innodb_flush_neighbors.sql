
		
	


在什么情景下使用:
	1. SSD盘下     关闭 innodb_flush_neighbors
	2. 机械硬盘下  开启 innodb_flush_neighbors
	
	在 MySQL 5.6和5.7中，innodb_flush_neighbors 参数的默认值为1 。	
	在 MySQL 8.0 中，innodb_flush_neighbors 参数的默认值已经是0 了。
	-- MySQL 也在适配硬件的发展变化。
	
参考： 
	
	https://dev.mysql.com/doc/refman/5.6/en/innodb-parameters.html#sysvar_innodb_flush_neighbors
	https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_neighbors
	https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_neighbors
	https://www.cnblogs.com/geaozhang/p/7265261.html#gongzuoyuanli    （InnoDB关键特性之刷新邻接页-异步IO）


官方文档
	When the table data is stored on a traditional HDD storage device, flushing such neighbor pages in one operation reduces I/O overhead (primarily for disk seek operations) compared to flushing individual pages at different times. 
	For table data stored on SSD, seek time is not a significant factor and you can set this option to 0 to spread out write operations. For related information, 
	当表数据存储在传统的HDD存储设备上时，与在不同时间刷新单个页面相比，在一次操作中刷新此类相邻页面可减少I / O开销（主要用于磁盘查找操作）。 
	对于存储在SSD上的表数据，查找时间不是重要因素，您可以将此选项设置为0以分散写操作。
	
