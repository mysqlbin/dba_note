

磁盘临时表使用的引擎默认是InnoDB, 是由参数  internal_tmp_disk_storage_engine 控制的.

当使用磁盘临时表的时候, 对应的就是一个没有显示索引的InnoDB表的排序过程.




从5.7.5开始，新增一个系统选项 internal_tmp_disk_storage_engine 可定义磁盘临时表的引擎类型为 InnoDB，而在这以前，只能使用 MyISAM。
而在5.6.3以后新增的系统选项 default_tmp_storage_engine 是控制 CREATE TEMPORARY TABLE 创建的临时表的引擎类型，在以前默认是MEMORY，不要把这二者混淆了。

	https://mp.weixin.qq.com/s/ro-nNhCcYL-RabIjUZNDew   [MySQL FAQ]系列 — 什么情况下会用到临时表

