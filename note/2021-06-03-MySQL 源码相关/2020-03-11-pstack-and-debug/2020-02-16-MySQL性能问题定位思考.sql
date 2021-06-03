


https://mp.weixin.qq.com/s/IZHvI2HDcOpJJCnyaCSJuw     MySQL性能问题定位思考   # 总结得可以，抽出时间来拜读
https://mp.weixin.qq.com/s/ex8hSCa8tSFoVTbvmXzmRg     经典案例：磁盘I/O巨高排查全过程
	select 565123876918590 - 565121518602442 = 2358316148 bytes; 
	select 2358316148 / 1024 / 1024 = 2249 MB;
	
https://mp.weixin.qq.com/s/cO966Qvyf3kKQSlt49ke1A     优化系列 | 实例解析MySQL性能瓶颈排查定位

https://mp.weixin.qq.com/s/sAGFo-h1GCBhad1r1cEWTg     FAQ系列 | 是什么导致MySQL数据库服务器磁盘I/O高？

https://mp.weixin.qq.com/s/p2IBlGguf4Vaq_AO_jja9A     比较全面的MySQL优化参考（下篇）

https://mp.weixin.qq.com/s/d5jbmdu1Yc5CG1jgIkTUCQ     是谁，把InnoDB表上的DML搞慢的？

https://mp.weixin.qq.com/s/oi_opmAajpR1mJAFj8UtuA     《叶问》第13期
	MySQL binlog_format=mixed，可行吗，为什么
	MySQL误删除frm文件该怎么办？
	MySQL常用的SQL调优手段或工具有哪些
	MySQL反应慢的排查思路

	

https://www.jianshu.com/p/40bef28e84cf  MySQL：5.6 大事务show engine innodb status故障一例
	MySQL并不适合大事务，大概列举一些MySQL中大事务的影响：
		binlog文件作为一次写入，会在sync阶段消耗大量的IO，会导致全库hang主，状态大多为query end。
		大事务会造成导致主从延迟。
		大事务可能导致某些需要备份挂起，原因在于flush table with read lock，拿不到MDL GLOBAL 级别的锁，等待状态为 Waiting for global read lock。
		大事务可能导致更大Innodb row锁加锁范围，导致row锁等待问题。
		回滚困难。

http://blog.itpub.net/7728585/viewspace-2133674  mysql 大事物commit慢造成全库堵塞问题


https://www.cnblogs.com/wangdong/p/9232757.html   【原创】记一次MySQL大表高并发写入引发CPU飙升的排障过程
   # perf 工具的使用
	 参考命令如下，

	注意：下面命令在生产上执行时有较低概率会导致服务器hang死

	#生成mysql进程10秒内资源消耗采样报告

	sudo perf record -p `pidof mysqld` -g -o /tmp/perf.data sleep 10

	#查看报告

	sudo perf report -i /tmp/perf.data

http://www.fordba.com/percona-toolkit-pt-pmp.html    Percona-Toolkit系列之pt-pmp获取堆栈信息利器


# 跟 pstack 结合

# 自己也要做总结， 参考ZST培训的知识点
	
	
参数设置不合理     # 大多数情况下
IO能力不足
SQL效率低下


相关系列参考
	https://www.cnblogs.com/wangdong
	