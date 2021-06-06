


pstack 介绍：
	栈（stack）又名堆栈  [zhàn]

	pstack 命令可显示每个进程的栈跟踪。
	
	pstack $(pgrep -xn mysqld) > 1.sql

安装 pstack：
	pstack: command not found
	解决办法：
		yum install gdb
		
	
通过 pstack 分析MySQL问题案例：
	https://www.jianshu.com/p/62eafbfd405b    MySQL：一个 innodb_thread_concurrency 设置不当引发的故障
	https://www.sohu.com/a/141131949_487514   MySQL所有操作hang住了，怎么破？ 
	https://www.jianshu.com/p/bfd4a88307f2    MySQL:简单insert 一秒原因排查
	https://www.jianshu.com/p/8db6a57f62c9    MySQL 记一次 Bug发现过程
	https://www.jianshu.com/p/e8b904e5e890	  MySQL：timestamp时区转换导致CPU %sy高的问题
	https://www.cnblogs.com/lonelyxmas/p/9825425.html  MySQL大事务导致的Insert慢的案例分析       
		  
	https://mp.weixin.qq.com/s/U3PJWI8l4DgJKm-p09Pc2Q  Drop Table对MySQL的性能影响分析​

		http://mysql.taobao.org/monthly/2016/01/07/   MySQL · 特性分析 · drop table的优化
		https://www.jianshu.com/p/a956a3e30eb6        随笔：Innodb truncate内存维护代价高于drop

		如何删除大表？  通过 pt-atchiver 归档或是最好的方式。
		停服的时候直接drop大表。
				
pstack 相关参考		
	https://www.cnblogs.com/lonelyxmas/p/10891649.html   MySQL 几种调式分析利器
	https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/pstack.html  pstack 跟踪进程栈
	https://www.cnblogs.com/kerrycode/p/5249968.html     linux pstack命令总结
	http://www.hellojava.com/a/77290.html  MySQL 几种调式分析利器

	

小结：
	自己模拟实验、自己制造环境 来学习

	当MySQL里有线程hang住时， 利用 pstack 排查由于哪些函数调用存在问题	
		

	连续多次查看这个进程的函数调用关系堆栈进行分析：
		当进程吊死时，多次使用 pstack 查看进程的函数调用堆栈，死锁线程将一直处于等锁的状态，对比多次的函数调用堆栈输出结果，确定哪两个线程（或者几个线程）一直没有变化且一直处于等锁的状态（可能存在两个线程 一直没有变化）。


pstack $(pgrep -xn mysqld) > 1.sql