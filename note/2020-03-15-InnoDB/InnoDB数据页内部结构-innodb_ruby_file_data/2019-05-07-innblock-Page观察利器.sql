
约定
innblock的两个功能
	scan功能用于查找ibd文件中所有的索引页
	analyze功能用于扫描数据块里的row data

测试开始
	测试scan功能，扫描所有index page
	analyze功能展示
	
1、执行delete后还未commit的记录只打 delete 标记
2、执行update后还未commit的记录
	
	
约定：

index page（索引页、索引块），InnoDB表是基于聚集索引的索引组织表，整个表其实不是聚集索引，就是普通索引。
因此InnoDB表空间文件中，数据页其实也是索引页，所以下面我们统称为索引页，英文用page no表示。
每个索引页都有编号即page_no。

PAGE_NO:
 索引B树的根节点（root页）页编码。
 
help：

[n_rows]:number of records not include delete rows after pruge and INFIMUM/SUPREMUM(PAGE_N_RECS)
本索引页中的记录数，不含deleted且已被purged的记录，以及两个伪记录INFIMUM、SUPREMUM。

[del_bytes]:number of bytes in deleted records after purge(PAGE_GARBAGE)
本索引页中所有deleted了的且已被purged的记录的总大小。

 

二、innblock简介

本工具有2个功能。

第一个scan功能用于查找ibd文件中所有的索引页。

第二个analyze功能用于扫描数据块里的row data。


root@mysqldb 01:14:  [test_db]> show create table testblock\G;
*************************** 1. row ***************************
       Table: testblock
Create Table: CREATE TABLE `testblock` (
  `id1` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `id3` int(11) DEFAULT NULL,
  PRIMARY KEY (`id1`),
  KEY `name` (`name`),
  KEY `id3` (`id3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
1 row in set (0.00 sec)



root@mysqldb 01:14:  [test_db]> insert into testblock values(1,'gao',1),(2,'gao',2),(3,'gao',3),(4,'gao',4);


1. 测试scan功能，扫描所有index page

[root@mgr9 test_db]# ./innblock testblock.ibd scan 16

Datafile Total Size:131072
===INDEX_ID:16430
level0 total block is (1)
block_no:         3,level:   0|*|
===INDEX_ID:16431
level0 total block is (1)
block_no:         4,level:   0|*|
===INDEX_ID:16432
level0 total block is (1)
block_no:         5,level:   0|*|

我们发现有3个索引，索引ID（INDEX_ID）分别是 16430、16431、16432，查看数据字典确认
root@mysqldb 01:15:  [test_db]> select b.name, a.name, index_id, type, a.SPACE, a.PAGE_NO, FILE_FORMAT, ROW_FORMAT from information_schema.INNODB_SYS_INDEXES a, information_schema.INNODB_SYS_TABLES b where a.table_id = b.table_id and a.space <> 0 and b.name = 'test_db/testblock';
+-------------------+---------+----------+------+-------+---------+-------------+------------+
| name              | name    | index_id | type | SPACE | PAGE_NO | FILE_FORMAT | ROW_FORMAT |
+-------------------+---------+----------+------+-------+---------+-------------+------------+
| test_db/testblock | PRIMARY |    16430 |    3 |  3978 |       3 | Barracuda   | Dynamic    |
| test_db/testblock | name    |    16431 |    0 |  3978 |       4 | Barracuda   | Dynamic    |
| test_db/testblock | id3     |    16432 |    0 |  3978 |       5 | Barracuda   | Dynamic    |
+-------------------+---------+----------+------+-------+---------+-------------+------------+
3 rows in set (0.00 sec)

https://dev.mysql.com/doc/refman/5.7/en/innodb-sys-indexes-table.html  （PAGE_NO,SPACE,index_id的解读）



CREATE TABLE `testblock2` (
  `id1` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `id3` int(11) DEFAULT NULL,
  PRIMARY KEY (`id1`),
  KEY `name` (`name`),
  KEY `id3` (`id3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4

root@mysqldb 01:14:  [test_db]> insert into testblock2 values(1,'gao',1),(2,'gao',2),(3,'gao',3),(4,'gao',4);

Datafile Total Size:131072
===INDEX_ID:16433
level0 total block is (1)
block_no:         3,level:   0|*|
===INDEX_ID:16434
level0 total block is (1)
block_no:         4,level:   0|*|
===INDEX_ID:16435
level0 total block is (1)
block_no:         5,level:   0|*|


root@mysqldb 01:15:  [test_db]> select b.name, a.name, index_id, type, a.SPACE, a.PAGE_NO, FILE_FORMAT, ROW_FORMAT from information_schema.INNODB_SYS_INDEXES a, information_schema.INNODB_SYS_TABLES b where a.table_id = b.table_id and a.space <> 0 and b.name = 'test_db/testblock2';
+--------------------+---------+----------+------+-------+---------+-------------+------------+
| name               | name    | index_id | type | SPACE | PAGE_NO | FILE_FORMAT | ROW_FORMAT |
+--------------------+---------+----------+------+-------+---------+-------------+------------+
| test_db/testblock2 | PRIMARY |    16433 |    3 |  3979 |       3 | Barracuda   | Dynamic    |
| test_db/testblock2 | name    |    16434 |    0 |  3979 |       4 | Barracuda   | Dynamic    |
| test_db/testblock2 | id3     |    16435 |    0 |  3979 |       5 | Barracuda   | Dynamic    |
+--------------------+---------+----------+------+-------+---------+-------------+------------+
3 rows in set (0.01 sec)


2. analyze功能展示

我们选取 pageno=3 那个索引页进行扫描，可见下面信息

[root@mgr9 test_db]# ./innblock testblock.ibd 3 16

==== Block base info ====
block_no:3          space_id:3978         index_id:16430       
slot_nums:2         heaps_rows:6          n_rows:4         
heap_top:244        del_bytes:0           last_ins_offset:220        
page_dir:2          page_n_dir:3          
leaf_inode_space:3978       leaf_inode_pag_no:2         
leaf_inode_offset:242       
no_leaf_inode_space:3978    no_leaf_inode_pag_no:2         
no_leaf_inode_offset:50        
last_modify_lsn:21883572296
page_type:B+_TREE level:0         
==== Block list info ====
-----Total used rows:6 used rows list(logic):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) normal record offset:127 heapno:2 n_owned 0,delflag:N minflag:0 rectype:0
(3) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
(6) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
-----Total used rows:6 used rows list(phy):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
(3) normal record offset:127 heapno:2 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(6) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
-----Total del rows:0 del rows list(logic):
-----Total slot:2 slot list:
(1) SUPREMUM slot offset:112 n_owned:5
(2) INFIMUM slot offset:99 n_owned:1



测试开始：
	
mysql> show create table testblock\G;
*************************** 1. row ***************************
       Table: testblock
Create Table: CREATE TABLE `testblock` (
  `id1` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `id3` int(11) DEFAULT NULL,
  PRIMARY KEY (`id1`),
  KEY `name` (`name`),
  KEY `id3` (`id3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
1 row in set (0.00 sec)

mysql> insert into testblock values(1,'gao',1),(2,'gao',2),(3,'gao',3),(4,'gao',4);

[root@mgr9 test_db]# ./innblock testblock.ibd 3 16      

==== Block base info ====
block_no:3          space_id:3981         index_id:16439       
slot_nums:2         heaps_rows:6          n_rows:4         
heap_top:244        del_bytes:0           last_ins_offset:220        
page_dir:2          page_n_dir:3          
leaf_inode_space:3981       leaf_inode_pag_no:2         
leaf_inode_offset:242       
no_leaf_inode_space:3981    no_leaf_inode_pag_no:2         
no_leaf_inode_offset:50        
last_modify_lsn:21883612404
page_type:B+_TREE level:0         
==== Block list info ====
-----Total used rows:6 used rows list(logic):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) normal record offset:127 heapno:2 n_owned 0,delflag:N minflag:0 rectype:0
(3) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
(6) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
-----Total used rows:6 used rows list(phy):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
(3) normal record offset:127 heapno:2 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(6) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
-----Total del rows:0 del rows list(logic):
-----Total slot:2 slot list:
(1) SUPREMUM slot offset:112 n_owned:5
(2) INFIMUM slot offset:99 n_owned:1


1、执行delete后还未commit的记录只打 delete 标记
发起事务，先执行delete，暂不commit

mysql> begin; delete from testblock where id1=1;

[root@mgr9 test_db]# ./innblock testblock.ibd 3 16

==== Block base info ====
block_no:3          space_id:3981         index_id:16439       
slot_nums:2         heaps_rows:6          n_rows:4         
heap_top:244        del_bytes:0           last_ins_offset:220        
page_dir:2          page_n_dir:3          
leaf_inode_space:3981       leaf_inode_pag_no:2         
leaf_inode_offset:242       
no_leaf_inode_space:3981    no_leaf_inode_pag_no:2         
no_leaf_inode_offset:50        
last_modify_lsn:21883616910
page_type:B+_TREE level:0         
==== Block list info ====
-----Total used rows:6 used rows list(logic):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) normal record offset:127 heapno:2 n_owned 0,delflag:Y minflag:0 rectype:0
(3) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
(6) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
-----Total used rows:6 used rows list(phy):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
(3) normal record offset:127 heapno:2 n_owned 0,delflag:Y minflag:0 rectype:0
(4) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(6) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
-----Total del rows:0 del rows list(logic):
-----Total slot:2 slot list:
(1) SUPREMUM slot offset:112 n_owned:5
(2) INFIMUM slot offset:99 n_owned:1

我们看到其中有一条记录是

(2) normal record offset:127 heapno:2 n_owned 0,delflag:Y minflag:0 rectype:0
其 delflag = Y，offset = 127，这条记录只是delete，但还没 commit，也还没被 purged，因此不会出现在 del rows list链表中。

同时注意到几个信息：

del_bytes:0
n_rows:4  
heaps_rows:6


三个信息结合起来看，表示还没有真正被清除的数据。
所以执行 delete删除操作没有 commit，只是打了一个删除标记。

delete commit后：

[root@mgr9 test_db]# ./innblock testblock.ibd 3 16

==== Block base info ====
block_no:3          space_id:3981         index_id:16439       
slot_nums:2         heaps_rows:6          n_rows:3         
heap_top:244        del_bytes:31          last_ins_offset:0          
page_dir:2          page_n_dir:3          
leaf_inode_space:3981       leaf_inode_pag_no:2         
leaf_inode_offset:242       
no_leaf_inode_space:3981    no_leaf_inode_pag_no:2         
no_leaf_inode_offset:50        
last_modify_lsn:21883617347
page_type:B+_TREE level:0         
==== Block list info ====
-----Total used rows:5 used rows list(logic):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(3) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
(5) SUPREMUM record offset:112 heapno:1 n_owned 4,delflag:N minflag:0 rectype:3
-----Total used rows:5 used rows list(phy):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) SUPREMUM record offset:112 heapno:1 n_owned 4,delflag:N minflag:0 rectype:3
(3) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
-----Total del rows:1 del rows list(logic):
(1) normal record offset:127 heapno:2 n_owned 0,delflag:Y minflag:0  rectype:0
-----Total slot:2 slot list:
(1) SUPREMUM slot offset:112 n_owned:4
(2) INFIMUM slot offset:99 n_owned:1

我们看到，执行commit，这条偏移量为127的记录被purged后入了del rows list链表

(1) normal record offset:127 heapno:2 n_owned 0,delflag:Y minflag:0  rectype:0
其delflag = Y，同时我们观察到

del_bytes:31 //上一次看到的值是 0
n_rows:3 //上一次看到的值是 4
heaps_rows:6 //和上一次的值一样，因为这里计算的是物理记录数
可见，commit且被purged的数据才是真正的删除（清除）。


2、执行update后还未commit的记录

发起事务，先执行update，暂不commit

mysql> begin; update  testblock  set name='lu' where id1=1;
[root@mgr9 test_db]# ./innblock testblock.ibd 3 16
==== Block base info ====
block_no:3          space_id:3985         index_id:16463       
slot_nums:2         heaps_rows:6          n_rows:4         
heap_top:244        del_bytes:1           last_ins_offset:127        
page_dir:5          page_n_dir:0          
leaf_inode_space:3985       leaf_inode_pag_no:2         
leaf_inode_offset:242       
no_leaf_inode_space:3985    no_leaf_inode_pag_no:2         
no_leaf_inode_offset:50        
last_modify_lsn:21883715006
page_type:B+_TREE level:0         
==== Block list info ====
-----Total used rows:6 used rows list(logic):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) normal record offset:127 heapno:2 n_owned 0,delflag:N minflag:0 rectype:0
(3) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
(6) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
-----Total used rows:6 used rows list(phy):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
(3) normal record offset:127 heapno:2 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(6) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
-----Total del rows:0 del rows list(logic):
-----Total slot:2 slot list:
(1) SUPREMUM slot offset:112 n_owned:5
(2) INFIMUM slot offset:99 n_owned:1


执行 update 之后 commit:
root@mysqldb 18:37:  [test_db]> commit;

[root@mgr9 test_db]# ./innblock testblock.ibd 3 16

==== Block base info ====
block_no:3          space_id:3985         index_id:16463       
slot_nums:2         heaps_rows:6          n_rows:4         
heap_top:244        del_bytes:1           last_ins_offset:127        
page_dir:5          page_n_dir:0          
leaf_inode_space:3985       leaf_inode_pag_no:2         
leaf_inode_offset:242       
no_leaf_inode_space:3985    no_leaf_inode_pag_no:2         
no_leaf_inode_offset:50        
last_modify_lsn:21883715006
page_type:B+_TREE level:0         
==== Block list info ====
-----Total used rows:6 used rows list(logic):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) normal record offset:127 heapno:2 n_owned 0,delflag:N minflag:0 rectype:0
(3) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
(6) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
-----Total used rows:6 used rows list(phy):
(1) INFIMUM record offset:99 heapno:0 n_owned 1,delflag:N minflag:0 rectype:2
(2) SUPREMUM record offset:112 heapno:1 n_owned 5,delflag:N minflag:0 rectype:3
(3) normal record offset:127 heapno:2 n_owned 0,delflag:N minflag:0 rectype:0
(4) normal record offset:158 heapno:3 n_owned 0,delflag:N minflag:0 rectype:0
(5) normal record offset:189 heapno:4 n_owned 0,delflag:N minflag:0 rectype:0
(6) normal record offset:220 heapno:5 n_owned 0,delflag:N minflag:0 rectype:0
-----Total del rows:0 del rows list(logic):
-----Total slot:2 slot list:
(1) SUPREMUM slot offset:112 n_owned:5
(2) INFIMUM slot offset:99 n_owned:1



