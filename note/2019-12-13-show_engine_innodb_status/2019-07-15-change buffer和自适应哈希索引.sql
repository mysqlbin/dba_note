
insert buffer的效果计算新增了几个例子；
自适应哈希索引的掌握；
学习如何统计 Mysql 服务器状态信息  https://blog.csdn.net/zdplife/article/details/94296959
InnoDB存储引擎会监控对表上二级索引的查找，如果发现某二级索引被频繁访问，那么二级索引成为热数据，建立哈希索引可以带来查询速度上的提升；

1. 
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 458, seg size 460, 2749 merges
merged operations:
 insert 28004, delete mark 1800, delete 195
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 50999279, node heap has 4568 buffer(s)
12.74 hash searches/s, 9.56 non-hash searches/s


2.  metadata_locks_hash_instances = 8; 
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 4023, seg size 4025, 70665 merges
merged operations:
 insert 6832, delete mark 35305047, delete 2357657
discarded operations:
 insert 0, delete mark 0, delete 0
# 自适应哈希索引的大小
Hash table size 2656321, node heap has 78 buffer(s)
Hash table size 2656321, node heap has 104 buffer(s)
Hash table size 2656321, node heap has 108 buffer(s)
Hash table size 2656321, node heap has 147 buffer(s)
Hash table size 2656321, node heap has 55 buffer(s)
Hash table size 2656321, node heap has 98 buffer(s)
Hash table size 2656321, node heap has 111 buffer(s)
Hash table size 2656321, node heap has 9450 buffer(s)

# 每秒使用自适应哈希索引搜索的次数，每秒无法使用自适应哈希索引搜索的次数
11.78 hash searches/s, 16.17 non-hash searches/s


-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 4023, seg size 4025, 70667 merges
merged operations:
 insert 6837, delete mark 35305047, delete 2357657
discarded operations:
 insert 0, delete mark 0, delete 0
 
10.69 hash searches/s, 18.00 non-hash searches/s
 --------------------------------------------------
 
 
3.
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 49228, free list len 1025705, seg size 1074934, 205606103 merges
merged operations:
 insert 777138260, delete mark 2020, delete 1865
discarded operations:
 insert 20182, delete mark 0, delete 0
Hash table size 13279583, node heap has 944 buffer(s)
Hash table size 13279583, node heap has 2068 buffer(s)
Hash table size 13279583, node heap has 1742 buffer(s)
Hash table size 13279583, node heap has 2180 buffer(s)
Hash table size 13279583, node heap has 1056 buffer(s)
Hash table size 13279583, node heap has 584 buffer(s)
Hash table size 13279583, node heap has 830 buffer(s)
Hash table size 13279583, node heap has 3831 buffer(s)
10421.93 hash searches/s, 868.60 non-hash searches/s


4. 
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------

# Ibuf 表示已经合并页的数量，free list len 表示空闲列表长度，seg size 表示 Insert Buffer 的大小，merges 表示合并次数，
Ibuf: size 1, free list len 80, seg size 82, 2639224 merges

# 分别查看 Insert Buffer, Delete Buffer, Purge Buffer 的次数
merged operations:
 insert 4178472, delete mark 151972, delete 60065
 
# 不需要合并的次数 
discarded operations:
 insert 0, delete mark 0, delete 0
 
# 自适应 hash 索引的大小
Hash table size 276671, node heap has 5 buffer(s)
Hash table size 276671, node heap has 21 buffer(s)
Hash table size 276671, node heap has 56 buffer(s)
Hash table size 276671, node heap has 210 buffer(s)
Hash table size 276671, node heap has 8 buffer(s)
Hash table size 276671, node heap has 111 buffer(s)
Hash table size 276671, node heap has 9 buffer(s)
Hash table size 276671, node heap has 33 buffer(s)

# 通过 hash 索引查询每秒个数，无法通过 hash 索引查询每秒的个数
4798.09 hash searches/s, 600.67 non-hash searches/s



https://blog.csdn.net/zdplife/article/details/94296959     学习如何统计 Mysql 服务器状态信息

