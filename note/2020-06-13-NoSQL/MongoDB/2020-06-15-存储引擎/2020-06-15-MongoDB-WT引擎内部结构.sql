
1. 内部缓存
2. Jounal 
3. checkpoint 
4. 后台线程

语句的执行流程
	1. 客户端的数据进来；
	2. 数据操作写入到日志缓冲；
	3. 数据写入到数据缓冲；
	4. 返回操作结果到客户端(异步)；
	5. 后台线程进行日志缓冲中的数据刷盘，默认100毫秒（非常频繁），也可自行设置（30-60）；
	6. 后台线程进行数据缓冲中的数据刷盘，默认是60秒；

单节点上的update 语句的更新流程
	0. 客户端的数据进来；
	1. 数据页不在内存中，先读入内存中
	2. 在内存中修改数据页的时候，会先把数据页拷贝出来成为一个新的数据页
	3. 然后在新的数据页上做修改
	4. 写 jounal 日志到 journal buffer 中
	5. 返回操作结果到客户端(异步)；
	
	6. 后台线程进行日志缓冲中的数据刷盘，默认100毫秒（非常频繁），也可自行设置（30-60）；
	
	7. 后台线程进行数据缓冲中的脏数据刷盘，默认是60秒(触发checkpoint)；
		Wiredtiger采用 Copy on write（快照）的方式管理修改操作（insert、update、delete），
		数据页持久化时，修改操作不会在原来的leaf page上进行，而是写入新分配的page，每次checkpoint都会产生一个新的root page。




从上图可以看到，页面的修改并不是在原有的空间进行，而是将改变的页面在新的页面生成，在通过指针从新的生成的页面，指向未改变的页面。将新的根地址写入到 metadata 中。这样的处理的速度要比加锁，然后改变数据的方式要快的多。并且大部分MONGODB 处理的方式多是写，和读，大量的UPDATE 的并不多见。
	https://mp.weixin.qq.com/s/-LssIUI4fjwUVaAYvAyA8Q MONGODB Wiredtiger 为什么那么快？

https://blog.csdn.net/gaozhigang/article/details/79241044  Mongodb存储特性与内部原理
https://docs.mongodb.com/manual/core/wiredtiger/ 
https://docs.mongodb.com/manual/core/wiredtiger/#storage-wiredtiger-checkpoints


这个描述得可以

	journal就是一个预写事务日志，来确保数据的持久性，wiredTiger每隔60秒（默认）， mongodb将对journal文件提交一个checkpoint
	
	checkpoint（检测点，将内存中的数据变更（脏页）flush到磁盘中的数据文件中，并做一个标记点，表示标记点之前的数据已经持久存储在了数据文件中，标记点之前的内存数据与磁盘的数据一致，同时释放了缓冲池空间；
	
	检测点创建后，此前的journal日志即可清除。
	
	标记点之后的数据变更存在于内存和journal日志中。
	
	崩溃恢复的起点就从这个checkpoint开始，缩短了数据库的恢复时间。
	
	
	对于write操作，首先被持久写入journal，然后在内存中保存变更数据，条件满足后提交一个新的检测点，即检测点之前的数据只是在journal中持久存储，但并没有在mongodb的数据文件中持久化，延迟持久化可以提升磁盘效率，
	如果在提交checkpoint之前，mongodb异常退出，此后再次启动可以根据journal日志恢复数据。
	journal日志默认每个100毫秒同步磁盘一次，每100M数据生成一个新的journal文件同时会把日志同步到磁盘，journal默认使用了snappy压缩，检测点创建后，此前的journal日志即可清除。
	mongod可以禁用journal，这在一定程度上可以降低它带来的开支；对于单点mongod，关闭journal可能会在异常关闭时丢失checkpoint之间的数据（那些尚未提交到磁盘数据文件的数据）；
	对于replica set架构，持久性的保证稍高，但仍然不能保证绝对的安全（比如replica set中所有节点几乎同时退出时）。



