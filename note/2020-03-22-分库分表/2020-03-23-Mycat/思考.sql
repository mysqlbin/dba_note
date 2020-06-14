

1. Mycat 只能跑单机模式吗
	没有自带的高可用, 可以用 两个节点的Mycat + Keepalived 实现 Mycat 的高可用
	
2. 现有的数据如何迁移到 Mycat ?
	mysqldump 导入

3. 通过 Mycat 分库分表之后还可以正常归档历史数据吗
	可以.
	
4. 分库分表的初衷

5. 存储过程做不了分库分表?

6. 这3个分别是什么日志

	-rw-r--r--. 1 root root 11624476 Oct 28 15:03 mycat.log
	-rw-r--r--. 1 root root      192 Oct 28 01:06 switch.log
	-rw-r--r--. 1 root root    11536 Oct 28 15:03 wrapper.log

7.  Mycat 支持多表 Join 吗？
	答： Mycat 目前支持 2 个表 Join，后续会支持多表 Join，具体 Join 请看 Mycat 权威指南对应章节
	验证一下.
	
8. 分片之后表的DDL 
	支持 pt-osc

9. MySQL 分片节点发生主从切换, 此时有业务在写, 其它分片会发生什么事情?

10. mycat 所在节点是否需要安装 MySQL
	要安装MySQL 客户端

11. 分片模式的对比 

12. 支持事务吗
	支持.
	
	
13. 分片扩容问题
 
14. 是否支持存储过程.

Mycat的问题总结：
    1. 聚合/排序的支持度非常有限，而且在很多场景下还存在结果不正确、执行异常等问题
    2. 针对between A and B语法，hash拆分算法计算出来的范围有误   

	# 这个需要验证.
	
	
MyCat-Web