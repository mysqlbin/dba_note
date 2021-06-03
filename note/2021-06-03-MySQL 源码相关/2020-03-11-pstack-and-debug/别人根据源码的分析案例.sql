

学习源码的方式
	带问题学习源码注释
	如何通过源码分析自己遇到的问题
	收集利用debug/源码解决问题的文章，看看别人的思路

		https://mp.weixin.qq.com/s/Dr6UOpGWec2hrsUn2wsmbg   Searching rows for update状态初探

		https://mp.weixin.qq.com/s/6xLyXIEpWmHh4ahPtRRWpw   MySQL DBA如何"土土"地利用源码解决没有遇到过的错误？

		https://mp.weixin.qq.com/s/eia_MjATAsG-fqwlngT1WQ   深度分析 | GDB定位MySQL5.7特定版本hang死的故障分析#92108


			如何采集mysql调用栈信息：
			
				https://www.ibm.com/developerworks/cn/linux/l-cn-deadlock/index.html 
			
			获取 MySQL PID
				[root@env ~]# pgrep -xn mysqld
				1882	


小结
	工具箱: 
		拿堆栈, 找线程（函数）, 看文件名, 找入口,
		看结构, 读注释, …
	
	先pstack找到函数和对应的源码文件，看注释，通过到搜索引擎搜索函数，看看别人的分析，自己也尝试着分析。
	
pstack $(pgrep -xn mysqld)
