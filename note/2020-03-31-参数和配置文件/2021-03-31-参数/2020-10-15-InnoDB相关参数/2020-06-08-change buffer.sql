


innodb_change_buffer_max_size=25

-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 498, seg size 500, 3254 merges
merged operations:
 insert 39657, delete mark 5, delete 1
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2656009, node heap has 16 buffer(s)
Hash table size 2656009, node heap has 11 buffer(s)
Hash table size 2656009, node heap has 5 buffer(s)
Hash table size 2656009, node heap has 23 buffer(s)
Hash table size 2656009, node heap has 114 buffer(s)
Hash table size 2656009, node heap has 4 buffer(s)
Hash table size 2656009, node heap has 3 buffer(s)
Hash table size 2656009, node heap has 36 buffer(s)
1554.44 hash searches/s, 1938.31 non-hash searches/s

Ibuf：
    size：              表示已经合并记录页的数量；
    free list len：   表示空闲的 page => 代表了空闲列表的长度；
    seg size:          size + free list len 即 insert buffer 的大小
    merges：        表示已经合并的次数即执行 change buffer merge 后的次数；
    
merged operations： 表示合并操作的数量
    insert：             表示 insert buffer；
    delete mark：   表示 delete buffer；
    delete：            表示 purge buffer；
   
discarded operations：
    （舍弃/丢弃的操作） 表示当 Change Buffer 发生 merge 时， 表已经被删除， 此时就无需再将记录合并 (merge) 到辅助索引中了；
    Change Buffer中无需合并的次数；
	

insert buffer的效果 = merges / (insert + delete mark + delete) =  3254 / (39657 + 5 + 1)  * 100 = 8%；     相当于每10次更新操作合并1次刷盘。



mysql> set global innodb_change_buffer_max_size=5;
Query OK, 0 rows affected (0.00 sec)
set global innodb_change_buffer_max_size=5;


InnoDB存储引擎可以对 DML 操作-----INSERT DELETE UPDATE操作都进行缓冲, 他们分别是:
Insert Buffer、Delete Buffer、Purge Buffer

innodb_change_buffer_max_size=25
表示change buffer的大小最多只能占用 buffer pool 的25%.
(change buffer用的是 buffer pool中的内存)

innodb_change_buffering = all 
表示缓存所有操作
