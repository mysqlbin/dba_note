

机器配置：4核、16GB内存、100GB的SSD盘
MySQL关键参数：双1，innodb_buffer_pool_size=12GB，innodb_buffer_pool_instances=3，关闭AHI

只写的TPS：
	
		 8线程		16线程		24线程
5.7.26   702    	634       	861
8.0.26   576   		685			1248


只写的情况下，TPS 8.0 比 5.7的要好


混合读写模式下，TPS、QPS，5.7 比 8.0的高

5.7.26，在24线程下跑，还是有存在比较多的缓冲池mutex争用，看来是内存不够用导致。


压测期间的缓冲池使用情况(5.7):
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13193183232
Dictionary memory allocated 259676
Buffer pool size   786336
Free buffers       3071
Database pages     783265
Old database pages 289074
Modified db pages  78880
Pending reads      0


压测期间的缓冲池使用情况(8.0):

----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13155827712
Dictionary memory allocated 612605
Buffer pool size   786360
Free buffers       178280
Database pages     604210
Old database pages 222978
Modified db pages  106379
