

11.性能调优
（1）监控磁盘状态

	iostat

（2）为提升性能检查索引和查询

	总的来说，扫描尽可能少的文档。

	保证没有冗余的索引，冗余的索引会占用磁盘空间、消耗更多的内存，在每次写入时还需做更多工作

（3）添加内存

	db.stats() //查看数据库数据占用大小状态
	dataSize 数据大小 和 indexSize 索引大小，如果两者的和大于内存，那么将会影响性能。

	storageSize 超过 dataSize 数据大小 两倍以上，就会因磁盘碎片而影响性能，需要压缩。

	
	
https://blog.csdn.net/jjwen/article/details/79977336   MongoDB的一些性能监控指标介绍


https://www.jianshu.com/p/da43f0234d47    shell下的查看当前Mongodb运行状态的两个重要命令(db.stats()&&db.db.serverStatus())

