


master:
	mysql> show global status like '%read_ahead%';
	+---------------------------------------+----------+
	| Variable_name                         | Value    |
	+---------------------------------------+----------+
	| Innodb_buffer_pool_read_ahead_rnd     | 0        |
	| Innodb_buffer_pool_read_ahead         | 10850471 |
	| Innodb_buffer_pool_read_ahead_evicted | 238349   |
	+---------------------------------------+----------+
	3 rows in set (0.07 sec)
slave:
	mysql> show global status like '%read_ahead%';
	+---------------------------------------+----------+
	| Variable_name                         | Value    |
	+---------------------------------------+----------+
	| Innodb_buffer_pool_read_ahead_rnd     | 0        |
	| Innodb_buffer_pool_read_ahead         | 98575515 |
	| Innodb_buffer_pool_read_ahead_evicted | 1098094  |
	+---------------------------------------+----------+
	3 rows in set (0.01 sec)
		


	
mysql> show variables like '%buffer_pool%';
+-------------------------------------+----------------+
| Variable_name                       | Value          |
+-------------------------------------+----------------+
| innodb_buffer_pool_chunk_size       | 134217728      |
| innodb_buffer_pool_dump_at_shutdown | ON             |
| innodb_buffer_pool_dump_now         | OFF            |
| innodb_buffer_pool_dump_pct         | 25             |
| innodb_buffer_pool_filename         | ib_buffer_pool |
| innodb_buffer_pool_instances        | 3              |
| innodb_buffer_pool_load_abort       | OFF            |
| innodb_buffer_pool_load_at_startup  | ON             |
| innodb_buffer_pool_load_now         | OFF            |
| innodb_buffer_pool_size             | 3221225472     |
+-------------------------------------+----------------+
10 rows in set (0.00 sec)



mysql> show global status like '%Innodb_buffer_pool%';
+---------------------------------------+----------------------------------------------------+
| Variable_name                         | Value                                              |
+---------------------------------------+----------------------------------------------------+
| Innodb_buffer_pool_dump_status        | Dumping of buffer pool not started                 |   
| Innodb_buffer_pool_load_status        | Buffer pool(s) load completed at 190425  7:20:48   |
| Innodb_buffer_pool_resize_status      | Completed resizing buffer pool at 190924 15:04:53. |
| Innodb_buffer_pool_pages_data         | 603716                                             |  # 缓冲池的页数
| Innodb_buffer_pool_bytes_data         | 9891282944                                         |
| Innodb_buffer_pool_pages_dirty        | 16906                                              |  # 脏页页数
| Innodb_buffer_pool_bytes_dirty        | 276987904                                          |  # 
The total current number of bytes held in dirty pages in the InnoDB buffer pool
| Innodb_buffer_pool_pages_flushed      | 445374057                                          |  # 已经刷新到磁盘的页数
| Innodb_buffer_pool_pages_free         | 2049                                               |  # free list的页数
| Innodb_buffer_pool_pages_misc         | 49588                                              |  # 
InnoDB缓冲池中由于分配给管理开销（例如行锁或自适应哈希索引）而繁忙的页面数
该值=池中总页-（减）LRU列表的页数-（减）Free列表的页数。
select 655353-603716-2049 = 49588
| Innodb_buffer_pool_pages_total        | 655353                                             |  # 缓冲池的总页数
| Innodb_buffer_pool_read_ahead_rnd     | 0                                                  |
| Innodb_buffer_pool_read_ahead         | 10840015                                           |  # 通过预读(后台线程)读入innodb buffer pool中数据页数
| Innodb_buffer_pool_read_ahead_evicted | 238349                                             |  # 
无效预读页数(通过预读进入缓冲池的数据页没有被查询访问就被清理的pages); 用来判断预读的效率
| Innodb_buffer_pool_read_requests      | 70591185873                                        |  # 从缓冲池中读取页的次数
| Innodb_buffer_pool_reads              | 22795551                                           |  # 从物理磁盘读取页的次数
| Innodb_buffer_pool_wait_free          | 16                                                 |  # 等待申请缓冲池可用页的次数
| Innodb_buffer_pool_write_requests     | 7810823995                                         |  # 写入InnoDB缓冲池的次数
+---------------------------------------+----------------------------------------------------+
18 rows in set (0.10 sec)

		  
 mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.03 sec)

mysql> show global variables like '%buffer_pool_instance%';
+------------------------------+-------+
| Variable_name                | Value |
+------------------------------+-------+
| innodb_buffer_pool_instances | 3     |
+------------------------------+-------+
1 row in set (0.01 sec)

mysql> select * from information_schema.innodb_buffer_pool_stats\G;
*************************** 1. row ***************************
                         POOL_ID: 0
                       POOL_SIZE: 65528
                    FREE_BUFFERS: 4001
                  DATABASE_PAGES: 84467
              OLD_DATABASE_PAGES: 31160
         MODIFIED_DATABASE_PAGES: 0
              PENDING_DECOMPRESS: 4875
                   PENDING_READS: 0
               PENDING_FLUSH_LRU: 0
              PENDING_FLUSH_LIST: 0
                PAGES_MADE_YOUNG: 1052635
            PAGES_NOT_MADE_YOUNG: 28993214
           PAGES_MADE_YOUNG_RATE: 0
       PAGES_MADE_NOT_YOUNG_RATE: 0
               NUMBER_PAGES_READ: 3846637
            NUMBER_PAGES_CREATED: 2953411
            NUMBER_PAGES_WRITTEN: 6825928
                 PAGES_READ_RATE: 0
               PAGES_CREATE_RATE: 0
              PAGES_WRITTEN_RATE: 0.181801654395055
                NUMBER_PAGES_GET: 12547254901
                        HIT_RATE: 1000
    YOUNG_MAKE_PER_THOUSAND_GETS: 0
NOT_YOUNG_MAKE_PER_THOUSAND_GETS: 0
         NUMBER_PAGES_READ_AHEAD: 1087426
       NUMBER_READ_AHEAD_EVICTED: 38656
                 READ_AHEAD_RATE: 0
         READ_AHEAD_EVICTED_RATE: 0
                    LRU_IO_TOTAL: 128
                  LRU_IO_CURRENT: 3
                UNCOMPRESS_TOTAL: 0
              UNCOMPRESS_CURRENT: 0
*************************** 2. row ***************************
                         POOL_ID: 1
                       POOL_SIZE: 65536
                    FREE_BUFFERS: 4000
                  DATABASE_PAGES: 84194
              OLD_DATABASE_PAGES: 31059
         MODIFIED_DATABASE_PAGES: 0
              PENDING_DECOMPRESS: 4819
                   PENDING_READS: 0
               PENDING_FLUSH_LRU: 0
              PENDING_FLUSH_LIST: 0
                PAGES_MADE_YOUNG: 1030992
            PAGES_NOT_MADE_YOUNG: 28364936
           PAGES_MADE_YOUNG_RATE: 0
       PAGES_MADE_NOT_YOUNG_RATE: 0
               NUMBER_PAGES_READ: 3834486
            NUMBER_PAGES_CREATED: 2953343
            NUMBER_PAGES_WRITTEN: 5525035
                 PAGES_READ_RATE: 0
               PAGES_CREATE_RATE: 0
              PAGES_WRITTEN_RATE: 0.0909008271975275
                NUMBER_PAGES_GET: 12222300502
                        HIT_RATE: 1000
    YOUNG_MAKE_PER_THOUSAND_GETS: 0
NOT_YOUNG_MAKE_PER_THOUSAND_GETS: 0
         NUMBER_PAGES_READ_AHEAD: 1075310
       NUMBER_READ_AHEAD_EVICTED: 39514
                 READ_AHEAD_RATE: 0
         READ_AHEAD_EVICTED_RATE: 0
                    LRU_IO_TOTAL: 128
                  LRU_IO_CURRENT: 3
                UNCOMPRESS_TOTAL: 0
              UNCOMPRESS_CURRENT: 0
*************************** 3. row ***************************
                         POOL_ID: 2
                       POOL_SIZE: 65528
                    FREE_BUFFERS: 4000
                  DATABASE_PAGES: 83976
              OLD_DATABASE_PAGES: 30978
         MODIFIED_DATABASE_PAGES: 0
              PENDING_DECOMPRESS: 4896
                   PENDING_READS: 0
               PENDING_FLUSH_LRU: 0
              PENDING_FLUSH_LIST: 0
                PAGES_MADE_YOUNG: 1011852
            PAGES_NOT_MADE_YOUNG: 29081281
           PAGES_MADE_YOUNG_RATE: 0
       PAGES_MADE_NOT_YOUNG_RATE: 0
               NUMBER_PAGES_READ: 3838654
            NUMBER_PAGES_CREATED: 2949708
            NUMBER_PAGES_WRITTEN: 5531567
                 PAGES_READ_RATE: 0
               PAGES_CREATE_RATE: 0
              PAGES_WRITTEN_RATE: 0
                NUMBER_PAGES_GET: 12126144167
                        HIT_RATE: 0
    YOUNG_MAKE_PER_THOUSAND_GETS: 0
NOT_YOUNG_MAKE_PER_THOUSAND_GETS: 0
         NUMBER_PAGES_READ_AHEAD: 1065298
       NUMBER_READ_AHEAD_EVICTED: 39248
                 READ_AHEAD_RATE: 0
         READ_AHEAD_EVICTED_RATE: 0
                    LRU_IO_TOTAL: 128
                  LRU_IO_CURRENT: 3
                UNCOMPRESS_TOTAL: 0
              UNCOMPRESS_CURRENT: 0
3 rows in set (0.00 sec)

ERROR: 
No query specified
