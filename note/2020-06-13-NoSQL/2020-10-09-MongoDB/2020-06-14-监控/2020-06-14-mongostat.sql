
https://docs.mongodb.com/manual/reference/program/mongostat/
	
mongostat -h 192.168.1.31 -u admin -p admin --authenticationDatabase=admin
insert query update delete getmore command dirty used flushes vsize   res qrw arw net_in net_out conn                time
    *0    *0     *0     *0       0     2|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   167b   36.9k    2 Jun 14 22:21:54.911
    *0    *0     *0     *0       0     0|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   111b   36.5k    2 Jun 14 22:21:55.914
    *0    *0     *0     *0       0     1|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   112b   36.7k    2 Jun 14 22:21:56.911
    *0    *0     *0     *0       0     1|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   112b   36.6k    2 Jun 14 22:21:57.911
    *0    *0     *0     *0       0     0|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   111b   36.5k    2 Jun 14 22:21:58.914
    *0    *0     *0     *0       0     1|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   112b   36.7k    2 Jun 14 22:21:59.911
    *0    *0     *0     *0       0     0|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   111b   36.6k    2 Jun 14 22:22:00.911
    *0    *0     *0     *0       0     0|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   111b   36.5k    2 Jun 14 22:22:01.913
    *0    *0     *0     *0       0     1|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   112b   36.6k    2 Jun 14 22:22:02.911
    *0    *0     *0     *0       0     2|0  0.0% 0.0%       0 1.48G 83.0M 0|0 1|0   167b   36.8k    2 Jun 14 22:22:03.911

	
	
输出字段说明：

insert 表示每秒插入数据库的对象数量，如果跟在一个*后面，表示这是复制操作

query 每秒查询操作数量

update 每秒更新操作数量

delete 每秒删除操作数量

getmore 每秒get more操作的数量

command 每秒执行数据库命令操作的数量（比如插入、查找、更新、删除等等）

dirty   仅仅针对WiredTiger引擎，官网解释是脏数据字节的缓存百分比

used    仅仅针对WiredTiger引擎，官网解释是正在使用中的WiredTiger缓存百分比


flushes 每秒执行fsync操作的数量（将数据刷新到磁盘的次数）

mapped 映射数据的总量，以兆字节M表示。这里的数据是从上次mongostat显示到这次的数量

vsize mongod或mongos进程用掉的虚拟内存，以兆字节M表示

res   mongod 正在使用的内存大小

locked db 这里的值表示当前列出的数据库在锁定状态上花销的时间加上mongod进程在全局锁上花销的时间，以百分比表示

idx miss 表示需要一个页面错误来加载一个Btree节点的索引访问尝试的百分比

qr 客户端等待从MongoDB实例读操作的队列长度

qw 客户端等待从MongoDB实例写操作的队列长度

ar 正在执行读操作的客户端数量

aw 正在执行写操作的客户端数量

netIn MongoDB实例接收到的网络流量，用字节bytes表示，包括mongostat本身连接MongoDB实例产生的流量

netOut MongoDB实例发送出去的网络流量，用字节bytes表示，包括mongostat本身连接MongoDB实例产生的流量

conn 打开的连接数总数

set replica set的名称

repl replica set的状态 PRI 表示是Primary，SEC表示是Secondary


https://www.jianshu.com/p/49c40e053804?utm_campaign  MongoDB性能监控(1)—mongostat监控命令

