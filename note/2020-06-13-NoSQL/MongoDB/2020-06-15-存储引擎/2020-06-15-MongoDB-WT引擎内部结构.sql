
1. 内部缓存
2. Jounal 
3. checkpoint 

update 语句的更新流程
	1. 数据页不在内存中，先读入内存中
	2. 在内存中修改数据页的时候，会先把数据页拷贝出来成为一个新的数据页
	3. 然后在新的数据页上做修改
	4. 写 jounal 日志并且持久化
	5.  
	

使用WiredTiger，MongoDB支持对所有集合和索引进行压缩。 压缩可以最大程度地减少存储使用量，但会增加CPU的开销。



Wiredtiger采用 Copy on write（快照）的方式管理修改操作（insert、update、delete），
修改操作会先缓存在cache里，并持久化到WAL(Write ahead log)， 持久化时，修改操作不会在原来的leaf page上进行，而是写入新分配的page，每次checkpoint都会产生一个新的root page。


https://blog.csdn.net/gaozhigang/article/details/79241044  Mongodb存储特性与内部原理
https://docs.mongodb.com/manual/core/wiredtiger/ 
https://docs.mongodb.com/manual/core/wiredtiger/#storage-wiredtiger-checkpoints


这个描述得可以

	journal就是一个预写事务日志，来确保数据的持久性，wiredTiger每隔60秒（默认）， mongodb将对journal文件提交一个checkpoint
	
	checkpoint（检测点，将内存中的数据变更（脏页）flush到磁盘中的数据文件中，并做一个标记点，表示标记点之前的数据表示已经持久存储在了数据文件中，此时内存的数据与磁盘的数据一致；
	标记点之后的数据变更存在于内存和journal日志中。
	
	崩溃恢复的起点就从这个checkpoint开始。
	
	


