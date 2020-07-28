
1. 官方文档参考
2. 官方文档前半部分翻译
3. 查看change buffer 的大小


1. 官方文档参考
	https://dev.mysql.com/doc/refman/5.7/en/innodb-change-buffer.html
	https://dev.mysql.com/doc/refman/5.7/en/faqs-innodb-change-buffer.html

2. 官方文档前半部分翻译

	The change buffer is a special data structure that caches changes to secondary index pages when those pages are not in the buffer pool. 
	The buffered changes, which may result from INSERT, UPDATE, or DELETE operations (DML), are merged later when the pages are loaded into the buffer pool by other read operations.
		-- 更改缓冲区是一种特殊的数据结构，用于在二级索引页不在缓冲池中时将更改缓存到二级索引页。 
		-- 可能由INSERT，UPDATE或DELETE操作（DML）导致的缓冲更改将在以后通过其他读取操作将页面加载到缓冲池中时合并。
		
		
	Unlike clustered indexes, secondary indexes are usually nonunique, and inserts into secondary indexes happen in a relatively random order. 
	Similarly, deletes and updates may affect secondary index pages that are not adjacently located in an index tree. 
	Merging cached changes at a later time, when affected pages are read into the buffer pool by other operations, avoids substantial random access I/O that would be required to read secondary index pages into the buffer pool from disk.
	
		-- 与聚簇索引不同，二级索引通常是非唯一的，并且二级索引中的插入以相对随机的顺序发生。
		-- 类似地，删除和更新可能会影响不在索引树中邻接的二级索引页。
		-- 当稍后通过其他操作将受影响的页读入缓冲池时，合并缓存的更改将避免从磁盘将辅助索引页读入缓冲池所需的大量随机访问I / O。
		
		
	Periodically, the purge operation that runs when the system is mostly idle, or during a slow shutdown, writes the updated index pages to disk. 
	The purge operation can write disk blocks for a series of index values more efficiently than if each value were written to disk immediately.
	
		-- 在系统大部分处于空闲状态或缓慢关闭期间运行的清除操作会定期将更新的索引页写入磁盘。
		-- 与将每个值立即写入磁盘相比，清除操作可以更有效地为一系列索引值写入磁盘块。
		
	Change buffer merging may take several hours when there are many affected rows and numerous secondary indexes to update.
	During this time, disk I/O is increased, which can cause a significant slowdown for disk-bound queries.
	Change buffer merging may also continue to occur after a transaction is committed, and even after a server shutdown and restart (see Section 14.22.2, “Forcing InnoDB Recovery” for more information).
	
		-- 当有许多受影响的行和许多辅助索引要更新时，更改缓冲区合并可能需要几个小时。
		-- 在此期间，磁盘I / O会增加，这可能会导致磁盘绑定查询的速度大大降低。
		-- 提交事务之后，甚至在服务器关闭并重新启动之后，更改缓冲区合并也可能继续发生（有关更多信息，请参见第14.22.2节“强制InnoDB恢复”）
		
		
	In memory, the change buffer occupies part of the buffer pool. 
	On disk, the change buffer is part of the system tablespace, where index changes are buffered when the database server is shut down.
		-- 在内存中，更改缓冲区占用了缓冲池的一部分。
		-- 在磁盘上，更改缓冲区是系统表空间的一部分，当数据库服务器关闭时，索引更改将存储在其中。
		---- 说明了 change buffer 实际上是可以持久化的数据， change buffer在内存中有拷贝， 也会被写入到共享表空间的 ibdata磁盘上。
		
	
	Change buffering is not supported for a secondary index if the index contains a descending index column or if the primary key includes a descending index column.
		-- 如果索引包含降序索引列或主键包含降序索引列，则辅助索引不支持更改缓冲。
		-- 降序索引用不到change buffer 优化特性。
		
3. 查看change buffer 的大小
	
	-- 查看change buffer中有多少个数据页
	SELECT (SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
		   WHERE PAGE_TYPE LIKE 'IBUF%') AS change_buffer_pages;


	-- 查看 change buffer中的数据页占用BP缓冲池的比例
	SELECT (SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
		   WHERE PAGE_TYPE LIKE 'IBUF%') AS change_buffer_pages,
		   (SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE) AS total_pages,
		   (SELECT ((change_buffer_pages/total_pages)*100))
		   AS change_buffer_page_percentage;

	show global status like '%Innodb_buffer_pool_pages_total%';


	sELECT * FROM performance_schema.setup_instruments
		   WHERE NAME LIKE '%wait/synch/mutex/innodb/ibuf%';


	SELECT (SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE
		   WHERE PAGE_TYPE LIKE 'IBUF%') AS change_buffer_pages
		   
		   
		
	注意事项：
			
		查询 INNODB_BUFFER_PAGE 表可能会产生大量的性能开销，在生产环境上迫不得已的时候才使用，比如用来排查change buffer相关的问题。
		
		
	
mysql> show engine innodb status\G;


	-------------------------------------
	INSERT BUFFER AND ADAPTIVE HASH INDEX
	-------------------------------------
	Ibuf: size 1, free list len 9126, seg size 9128, 357066 merges
	merged operations:
	 insert 762160, delete mark 110896, delete 1056
	discarded operations:
	 insert 0, delete mark 0, delete 0
	Hash table size 298897, node heap has 62 buffer(s)
	Hash table size 298897, node heap has 5 buffer(s)
	Hash table size 298897, node heap has 2 buffer(s)
	Hash table size 298897, node heap has 210 buffer(s)
	Hash table size 298897, node heap has 10 buffer(s)
	Hash table size 298897, node heap has 87 buffer(s)
	Hash table size 298897, node heap has 4 buffer(s)
	Hash table size 298897, node heap has 12 buffer(s)
	1536.28 hash searches/s, 12.87 non-hash searches/s


mysql> SELECT (SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE WHERE PAGE_TYPE LIKE 'IBUF%') AS change_buffer_pages;
+---------------------+
| change_buffer_pages |
+---------------------+
|                 114 |
+---------------------+
1 row in set (0.75 sec)



size:     The number of pages used within the change buffer.   --在更改缓冲区内使用的页数;
		  Change buffer size is equal to seg size - (1 + free list len). The 1 + value represents the change buffer header page.
		  
seg size: The size of the change buffer, in pages.
		    --更改缓冲区的大小，以页为单位
			

root@mysqldb 16:18:  [(none)]> show global status like '%page%';
+----------------------------------+----------+
| Variable_name                    | Value    |
+----------------------------------+----------+
| Innodb_buffer_pool_pages_data    | 61326    |
| Innodb_buffer_pool_pages_dirty   | 0        |
| Innodb_buffer_pool_pages_flushed | 9466339  |
| Innodb_buffer_pool_pages_free    | 12000    |
| Innodb_buffer_pool_pages_misc    | 393      |
| Innodb_buffer_pool_pages_total   | 73719    |
| Innodb_dblwr_pages_written       | 8537270  |
| Innodb_page_size                 | 16384    |
| Innodb_pages_created             | 1566325  |
| Innodb_pages_read                | 21852155 |
| Innodb_pages_written             | 9478302  |
| Tc_log_max_pages_used            | 0        |
| Tc_log_page_size                 | 0        |
| Tc_log_page_waits                | 0        |
+----------------------------------+----------+
14 rows in set (0.01 sec)



root@mysqldb 16:15:  [(none)]> SELECT * FROM INFORMATION_SCHEMA.INNODB_BUFFER_PAGE WHERE PAGE_TYPE LIKE 'IBUF%';                        
+---------+----------+-------+-------------+-------------+------------+-----------+-----------+---------------------+---------------------+-------------+------------+------------+----------------+-----------+-----------------+------------+---------+--------+-----------------+
| POOL_ID | BLOCK_ID | SPACE | PAGE_NUMBER | PAGE_TYPE   | FLUSH_TYPE | FIX_COUNT | IS_HASHED | NEWEST_MODIFICATION | OLDEST_MODIFICATION | ACCESS_TIME | TABLE_NAME | INDEX_NAME | NUMBER_RECORDS | DATA_SIZE | COMPRESSED_SIZE | PAGE_STATE | IO_FIX  | IS_OLD | FREE_PAGE_CLOCK |
+---------+----------+-------+-------------+-------------+------------+-----------+-----------+---------------------+---------------------+-------------+------------+------------+----------------+-----------+-----------------+------------+---------+--------+-----------------+
|       0 |      218 |  2160 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475371404 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842290 |
|       0 |      279 |  3213 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533479 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |      460 |  2211 |           1 | IBUF_BITMAP |          1 |         0 | NO        |        370155087054 |                   0 |  2475436066 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842409 |
|       0 |     1918 |  3237 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533530 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1999 |  2184 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2476234747 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     2148 |  3201 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533456 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     3087 |  2226 |           1 | IBUF_BITMAP |          1 |         0 | NO        |        370155117681 |                   0 |  2481024571 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7843493 |
|       0 |     3212 |  3195 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533426 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     5149 |  2640 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533335 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     5645 |  2175 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2486787230 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     5735 |  3231 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533518 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     5992 |  3210 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533475 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     6873 |  3198 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533450 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     7087 |  2592 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533113 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     7396 |  2166 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2487113716 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1107 |  3183 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2477783002 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1170 |  3174 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2477782825 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1275 |  2151 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475202571 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842290 |
|       0 |     1490 |  3042 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2478037631 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     2193 |  2147 |       32769 | IBUF_BITMAP |          1 |         0 | NO        |        370154517098 |                   0 |  2476867719 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7843051 |
|       0 |     2447 |  2106 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488653342 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     2819 |  3465 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475414248 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842991 |
|       0 |     3099 |     0 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2073033603 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842717 |
|       0 |     3143 |  3246 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533546 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     3527 |  3177 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2477782816 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     3739 |  3219 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533489 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     4283 |   876 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475334797 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842877 |
|       0 |     4692 |  2244 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475401661 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     4877 |  2604 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533162 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     4920 |  3249 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533556 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     4945 |  2133 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475329620 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7843560 |
|       0 |     5395 |  3267 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475633912 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842946 |
|       0 |     5736 |     0 |           4 | IBUF_INDEX  |          1 |         0 | NO        |        370155115445 |                   0 |  2475436012 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842717 |
|       0 |     6679 |  3252 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533561 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     6779 |  2136 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475438008 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7842946 |
|       0 |     7422 |  3192 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533418 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     7967 |  3234 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533525 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     8146 |  3462 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475359529 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |      845 |  3228 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533511 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1029 |  3207 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533466 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1109 |  3243 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533537 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1219 |  3264 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2484064938 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7843559 |
|       0 |     1731 |  3216 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533483 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1751 |  2157 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2487113712 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     1841 |  3222 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533504 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     2130 |  2616 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533209 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     2602 |  3225 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533507 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     2769 |  2172 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475346778 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     4214 |  2628 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533308 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     5385 |  3186 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533403 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     5724 |  2097 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2487481483 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     6938 |  3518 |       32769 | IBUF_BITMAP |          1 |         0 | NO        |        370153270401 |                   0 |  2475224204 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7836031 |
|       0 |     8071 |  3204 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533460 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       0 |     8119 |  3189 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533408 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |      890 |     0 |       65537 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475483489 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7761070 |
|       1 |     2256 |  3518 |           1 | IBUF_BITMAP |          1 |         0 | NO        |        370152618183 |                   0 |  2475180293 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7760665 |
|       1 |     3930 |  3464 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475359449 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7760405 |
|       1 |     5226 |  3485 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475356474 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7760819 |
|       1 |     5836 |  3269 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2476234977 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     5974 |    14 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475393063 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7760454 |
|       1 |     6118 |  3176 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2477765875 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7761495 |
|       1 |     6826 |  3482 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533081 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     6969 |  2249 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475393921 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     2157 |     0 |       16385 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475483270 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     2766 |  2624 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533262 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     4033 |  2099 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2476074203 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     4047 |  3474 |       16385 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475226121 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7750963 |
|       1 |     5057 |  2102 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488653346 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     5591 |  3500 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2487383835 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7761671 |
|       1 |     5775 |  2588 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533104 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     6463 |  3506 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2476359980 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     7763 |  3491 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2476330698 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |      512 |  3497 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2485165158 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7761662 |
|       1 |     1169 |  2192 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475432930 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     1413 |  2648 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533364 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     1597 |  2909 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475620199 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7761066 |
|       1 |     2141 |  3518 |       49153 | IBUF_BITMAP |          1 |         0 | NO        |        370153918031 |                   0 |  2475289287 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7755306 |
|       1 |     3676 |  2147 |       49153 | IBUF_BITMAP |          1 |         0 | NO        |        370155115445 |                   0 |  2476867674 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7761658 |
|       1 |     4197 |  2636 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533330 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     6260 |  2612 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533188 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       1 |     6687 |  3476 |           1 | IBUF_BITMAP |          1 |         0 | NO        |        370155026358 |                   0 |  2477523112 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7761199 |
|       1 |     7472 |  2600 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533140 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |       40 |  3474 |       32769 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475226429 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7737428 |
|       2 |      717 |  3518 |       65537 | IBUF_BITMAP |          1 |         0 | NO        |        370153934938 |                   0 |  2475331854 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7745286 |
|       2 |     1467 |  2620 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533227 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     2162 |  2134 |           1 | IBUF_BITMAP |          1 |         0 | NO        |        370154355596 |                   0 |  2476234904 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7748005 |
|       2 |     2345 |  2632 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533324 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     2414 |  2608 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533183 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     2485 |  2908 |           1 | IBUF_BITMAP |          1 |         0 | NO        |        370154351079 |                   0 |  2475393696 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7746867 |
|       2 |     2795 |  3184 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533385 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     4244 |  3475 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2476239122 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747563 |
|       2 |     4501 |    13 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475437820 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747223 |
|       2 |     4557 |  2251 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2478037606 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7748050 |
|       2 |     4925 |  2254 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2477443432 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     5308 |  2164 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475393816 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     5392 |  2212 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2471046034 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747223 |
|       2 |     6534 |     0 |       32769 | IBUF_BITMAP |          1 |         0 | NO        |        370153955630 |                   0 |  2475483229 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747554 |
|       2 |     8152 |  2596 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533132 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |      103 |  2143 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2476234181 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |      175 |  2152 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475397398 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7748169 |
|       2 |      574 |  2248 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475406599 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7748169 |
|       2 |     2409 |  2147 |       65537 | IBUF_BITMAP |          1 |         0 | NO        |        370154465504 |                   0 |  2476867517 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     2501 |  3262 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2477354712 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     2691 |  3268 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475633955 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747548 |
|       2 |     3089 |  2584 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533100 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     3189 |  2137 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2476234722 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     3235 |  2101 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475356498 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747000 |
|       2 |     4949 |  2104 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2475354886 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747452 |
|       2 |     5116 |  3265 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2477354708 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     5207 |  3178 |           1 | IBUF_BITMAP |          1 |         0 | NO        |        370154624422 |                   0 |  2477765845 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747911 |
|       2 |      439 |  3181 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2477801317 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
|       2 |     2546 |  3518 |       16385 | IBUF_BITMAP |          1 |         0 | NO        |        370152859562 |                   0 |  2475202412 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |         7735841 |
|       2 |     6633 |  2098 |           1 | IBUF_BITMAP |          1 |         0 | NO        |        370154315808 |                   0 |  2475354947 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | NO     |         7747450 |
|       2 |     7011 |  2644 |           1 | IBUF_BITMAP |          0 |         0 | NO        |                   0 |                   0 |  2488533341 | NULL       | NULL       |              0 |         0 |               0 | FILE_PAGE  | IO_NONE | YES    |               0 |
+---------+----------+-------+-------------+-------------+------------+-----------+-----------+---------------------+---------------------+-------------+------------+------------+----------------+-----------+-----------------+------------+---------+--------+-----------------+
114 rows in set (0.86 sec)
