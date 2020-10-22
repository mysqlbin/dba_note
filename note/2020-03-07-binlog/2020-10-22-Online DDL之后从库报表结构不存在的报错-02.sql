








[root@localhost data]# cd test_db/
[root@localhost test_db]# ll
总用量 1724572
-rw-r-----. 1 mysql mysql        67 10月 19 11:52 db.opt
-rw-r-----. 1 mysql mysql      8828 10月 22 10:56 #sql-f1f_11.frm
-rw-r-----. 1 mysql mysql 876609536 10月 22 11:13 #sql-ib58-2480555926.ibd
-rw-r-----. 1 mysql mysql      8696 10月 19 11:52 t_20201019.frm
-rw-r-----. 1 mysql mysql    114688 10月 19 21:41 t_20201019.ibd
-rw-r-----. 1 mysql mysql      8804 10月 21 01:38 t_20201021.frm
-rw-r-----. 1 mysql mysql 889192448 10月 22 11:09 t_20201021.ibd
[root@localhost test_db]# ll
总用量 1724572
-rw-r-----. 1 mysql mysql        67 10月 19 11:52 db.opt
-rw-r-----. 1 mysql mysql      8828 10月 22 10:56 #sql-f1f_11.frm
-rw-r-----. 1 mysql mysql 876609536 10月 22 11:13 #sql-ib58-2480555926.ibd
-rw-r-----. 1 mysql mysql      8696 10月 19 11:52 t_20201019.frm
-rw-r-----. 1 mysql mysql    114688 10月 19 21:41 t_20201019.ibd
-rw-r-----. 1 mysql mysql      8804 10月 21 01:38 t_20201021.frm
-rw-r-----. 1 mysql mysql 889192448 10月 22 11:09 t_20201021.ibd
[root@localhost test_db]# mv t_20201021.frm t_20201021.frm.bak
[root@localhost test_db]# rz

[root@localhost test_db]# chown -R mysql:mysql t_20201021.frm
[root@localhost test_db]# date
2020年 10月 22日 星期四 16:40:34 CST





[root@localhost test_db]# /etc/init.d/mysql restart
Shutting down MySQL.......... SUCCESS! 
Starting MySQL............ SUCCESS! 

2020-10-22T08:41:18.634785Z 0 [Note] Giving 2 client threads a chance to die gracefully
2020-10-22T08:41:18.634807Z 0 [Note] Shutting down slave threads
2020-10-22T08:41:18.651976Z 1 [Note] Slave I/O thread killed while reading event for channel ''
2020-10-22T08:41:18.651995Z 1 [Note] Slave I/O thread exiting for channel '', read up to log 'mysql-bin.000012', position 194
2020-10-22T08:41:20.700562Z 0 [Note] Forcefully disconnecting 1 remaining clients
2020-10-22T08:41:20.700623Z 0 [Note] Event Scheduler: Killing the scheduler thread, thread id 3
2020-10-22T08:41:20.700629Z 0 [Note] Event Scheduler: Waiting for the scheduler thread to reply
2020-10-22T08:41:20.701255Z 0 [Note] Event Scheduler: Stopped
2020-10-22T08:41:20.701268Z 0 [Note] Event Scheduler: Purging the queue. 0 events
2020-10-22T08:41:20.703700Z 0 [Note] Binlog end
2020-10-22T08:41:20.713003Z 0 [Note] Shutting down plugin 'ngram'
2020-10-22T08:41:20.713037Z 0 [Note] Shutting down plugin 'ARCHIVE'
2020-10-22T08:41:20.713042Z 0 [Note] Shutting down plugin 'partition'
2020-10-22T08:41:20.713045Z 0 [Note] Shutting down plugin 'BLACKHOLE'
2020-10-22T08:41:20.713049Z 0 [Note] Shutting down plugin 'PERFORMANCE_SCHEMA'
2020-10-22T08:41:20.713077Z 0 [Note] Shutting down plugin 'CSV'
2020-10-22T08:41:20.713082Z 0 [Note] Shutting down plugin 'MEMORY'
2020-10-22T08:41:20.713087Z 0 [Note] Shutting down plugin 'MRG_MYISAM'
2020-10-22T08:41:20.713092Z 0 [Note] Shutting down plugin 'MyISAM'
2020-10-22T08:41:20.713102Z 0 [Note] Shutting down plugin 'INNODB_SYS_VIRTUAL'
2020-10-22T08:41:20.713106Z 0 [Note] Shutting down plugin 'INNODB_SYS_DATAFILES'
2020-10-22T08:41:20.713110Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESPACES'
2020-10-22T08:41:20.713113Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN_COLS'
2020-10-22T08:41:20.713116Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN'
2020-10-22T08:41:20.713119Z 0 [Note] Shutting down plugin 'INNODB_SYS_FIELDS'
2020-10-22T08:41:20.713122Z 0 [Note] Shutting down plugin 'INNODB_SYS_COLUMNS'
2020-10-22T08:41:20.713136Z 0 [Note] Shutting down plugin 'INNODB_SYS_INDEXES'
2020-10-22T08:41:20.713139Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESTATS'
2020-10-22T08:41:20.713143Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLES'
2020-10-22T08:41:20.713146Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_TABLE'
2020-10-22T08:41:20.713149Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_CACHE'
2020-10-22T08:41:20.713152Z 0 [Note] Shutting down plugin 'INNODB_FT_CONFIG'
2020-10-22T08:41:20.713155Z 0 [Note] Shutting down plugin 'INNODB_FT_BEING_DELETED'
2020-10-22T08:41:20.713158Z 0 [Note] Shutting down plugin 'INNODB_FT_DELETED'
2020-10-22T08:41:20.713161Z 0 [Note] Shutting down plugin 'INNODB_FT_DEFAULT_STOPWORD'
2020-10-22T08:41:20.713165Z 0 [Note] Shutting down plugin 'INNODB_METRICS'
2020-10-22T08:41:20.713168Z 0 [Note] Shutting down plugin 'INNODB_TEMP_TABLE_INFO'
2020-10-22T08:41:20.713171Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_POOL_STATS'
2020-10-22T08:41:20.713175Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE_LRU'
2020-10-22T08:41:20.713178Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE'
2020-10-22T08:41:20.713181Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX_RESET'
2020-10-22T08:41:20.713184Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX'
2020-10-22T08:41:20.713187Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM_RESET'
2020-10-22T08:41:20.713190Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM'
2020-10-22T08:41:20.713193Z 0 [Note] Shutting down plugin 'INNODB_CMP_RESET'
2020-10-22T08:41:20.713196Z 0 [Note] Shutting down plugin 'INNODB_CMP'
2020-10-22T08:41:20.713199Z 0 [Note] Shutting down plugin 'INNODB_LOCK_WAITS'
2020-10-22T08:41:20.713202Z 0 [Note] Shutting down plugin 'INNODB_LOCKS'
2020-10-22T08:41:20.713206Z 0 [Note] Shutting down plugin 'INNODB_TRX'
2020-10-22T08:41:20.713209Z 0 [Note] Shutting down plugin 'InnoDB'
2020-10-22T08:41:20.713350Z 0 [Note] InnoDB: FTS optimize thread exiting.
2020-10-22T08:41:20.713626Z 0 [Note] InnoDB: Starting shutdown...
2020-10-22T08:41:20.813808Z 0 [Note] InnoDB: Dumping buffer pool(s) to /home/mysql/3306/data/ib_buffer_pool
2020-10-22T08:41:20.813996Z 0 [Note] InnoDB: Buffer pool(s) dump completed at 201022 16:41:20
2020-10-22T08:41:28.892434Z 0 [Note] InnoDB: Shutdown completed; log sequence number 1119114046
2020-10-22T08:41:28.908702Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
2020-10-22T08:41:28.916431Z 0 [Note] Shutting down plugin 'sha256_password'
2020-10-22T08:41:28.931004Z 0 [Note] Shutting down plugin 'mysql_native_password'
2020-10-22T08:41:28.977685Z 0 [Note] Shutting down plugin 'binlog'
2020-10-22T08:41:29.025220Z 0 [Note] /usr/local/mysql/bin/mysqld: Shutdown complete

2020-10-22T08:41:30.865281Z 0 [Warning] 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
2020-10-22T08:41:30.865378Z 0 [Warning] 'NO_AUTO_CREATE_USER' sql mode was not set.
2020-10-22T08:41:30.865404Z 0 [Note] --secure-file-priv is set to NULL. Operations related to importing and exporting data are disabled
2020-10-22T08:41:30.865471Z 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.22-log) starting as process 9715 ...
2020-10-22T08:41:30.944153Z 0 [Note] InnoDB: PUNCH HOLE support available
2020-10-22T08:41:30.944185Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2020-10-22T08:41:30.944192Z 0 [Note] InnoDB: Uses event mutexes
2020-10-22T08:41:30.944197Z 0 [Note] InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
2020-10-22T08:41:30.944203Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.3
2020-10-22T08:41:30.944208Z 0 [Note] InnoDB: Using Linux native AIO
2020-10-22T08:41:30.944733Z 0 [Note] InnoDB: Number of pools: 1
2020-10-22T08:41:30.944814Z 0 [Note] InnoDB: Using CPU crc32 instructions
2020-10-22T08:41:30.946875Z 0 [Note] InnoDB: Initializing buffer pool, total size = 10G, instances = 2, chunk size = 128M
2020-10-22T08:41:33.410349Z 0 [Note] InnoDB: Completed initialization of buffer pool
2020-10-22T08:41:44.706234Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
2020-10-22T08:41:50.459462Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
2020-10-22T08:41:56.553614Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
2020-10-22T08:41:56.567018Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 64 MB. Physically writing the file full; Please wait ...
2020-10-22T08:41:56.728223Z 0 [Note] InnoDB: File './ibtmp1' size is now 64 MB.
2020-10-22T08:41:56.735857Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
2020-10-22T08:41:56.735897Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
2020-10-22T08:41:56.736380Z 0 [Note] InnoDB: Waiting for purge to start
2020-10-22T08:41:56.786628Z 0 [Note] InnoDB: Waiting for purge to start
2020-10-22T08:41:56.837414Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 15161ms. The settings might not be optimal. (flushed=0 and evicted=0, during the time.)
2020-10-22T08:41:56.842474Z 0 [Note] InnoDB: 5.7.22 started; log sequence number 1119114046
2020-10-22T08:41:56.843070Z 0 [Note] InnoDB: Loading buffer pool(s) from /home/mysql/3306/data/ib_buffer_pool
2020-10-22T08:41:56.974039Z 0 [Note] Plugin 'FEDERATED' is disabled.
2020-10-22T08:41:57.216150Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
2020-10-22T08:41:57.216376Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
2020-10-22T08:41:57.216521Z 0 [Note] IPv6 is available.
2020-10-22T08:41:57.216556Z 0 [Note]   - '::' resolves to '::';
2020-10-22T08:41:57.216632Z 0 [Note] Server socket created on IP: '::'.
2020-10-22T08:41:57.259760Z 0 [Warning] 'user' entry 'root@localhost' ignored in --skip-name-resolve mode.
2020-10-22T08:41:57.260212Z 0 [Warning] 'user' entry 'mysql.session@localhost' ignored in --skip-name-resolve mode.
2020-10-22T08:41:57.260234Z 0 [Warning] 'user' entry 'mysql.sys@localhost' ignored in --skip-name-resolve mode.
2020-10-22T08:41:57.260759Z 0 [Warning] 'db' entry 'performance_schema mysql.session@localhost' ignored in --skip-name-resolve mode.
2020-10-22T08:41:57.260776Z 0 [Warning] 'db' entry 'sys mysql.sys@localhost' ignored in --skip-name-resolve mode.
2020-10-22T08:41:57.261353Z 0 [Warning] 'proxies_priv' entry '@ root@localhost' ignored in --skip-name-resolve mode.
2020-10-22T08:41:57.281336Z 0 [Note] InnoDB: Buffer pool(s) load completed at 201022 16:41:57
2020-10-22T08:41:57.311735Z 0 [Warning] 'tables_priv' entry 'user mysql.session@localhost' ignored in --skip-name-resolve mode.
2020-10-22T08:41:57.311848Z 0 [Warning] 'tables_priv' entry 'sys_config mysql.sys@localhost' ignored in --skip-name-resolve mode.
2020-10-22T08:41:57.327425Z 0 [Warning] Neither --relay-log nor --relay-log-index were used; so replication may break when this MySQL server acts as a slave and has his hostname changed!! Please use '--relay-log=localhost-relay-bin' to avoid this problem.
2020-10-22T08:41:57.348297Z 0 [Warning] Recovery from master pos 194 and file mysql-bin.000011 for channel ''. Previous relay log pos and relay log file had been set to 367, ./localhost-relay-bin.000024 respectively.
2020-10-22T08:41:57.556840Z 1 [Warning] Storing MySQL user name or password information in the master info repository is not secure and is therefore not recommended. Please consider using the USER and PASSWORD connection options for START SLAVE; see the 'START SLAVE Syntax' in the MySQL Manual for more information.
2020-10-22T08:41:57.584206Z 2 [Note] Slave SQL thread for channel '' initialized, starting replication in log 'mysql-bin.000011' at position 194, relay log './localhost-relay-bin.000027' position: 4
2020-10-22T08:41:57.587847Z 1 [Note] Slave I/O thread for channel '': connected to master 'rpl@192.168.0.201:3306',replication started in log 'mysql-bin.000011' at position 194
2020-10-22T08:41:57.692630Z 0 [Note] Event Scheduler: Loaded 0 events
2020-10-22T08:41:57.799553Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
Version: '5.7.22-log'  socket: '/home/mysql/3306/data/3306.sock'  port: 3306  MySQL Community Server (GPL)
2020-10-22T08:41:57.818255Z 3 [Note] Event Scheduler: scheduler thread started with id 3
2020-10-22T08:41:59.461700Z 2 [ERROR] Slave SQL for channel '': Error 'Duplicate column name 'b'' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null', Error_code: 1060
2020-10-22T08:41:59.510573Z 2 [Warning] Slave: Duplicate column name 'b' Error_code: 1060
2020-10-22T08:41:59.510598Z 2 [ERROR] Error running query, slave SQL thread aborted. Fix the problem, and restart the slave SQL thread with "SLAVE START". We stopped at log 'mysql-bin.000011' position 194






mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.201
                  Master_User: rpl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000012
          Read_Master_Log_Pos: 194
               Relay_Log_File: localhost-relay-bin.000028
                Relay_Log_Pos: 367
        Relay_Master_Log_File: mysql-bin.000011
             Slave_IO_Running: Yes
            Slave_SQL_Running: No
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 1060
                   Last_Error: Error 'Duplicate column name 'b'' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null'
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 194
              Relay_Log_Space: 1545
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: NULL
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 1060
               Last_SQL_Error: Error 'Duplicate column name 'b'' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null'
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 330607
                  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: 
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 201022 16:41:59
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79
            Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-78
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)

ERROR: 
No query specified


set gtid_next='9e520b78-013c-11eb-a84c-0800271bf591:79';
begin;
commit;
set gtid_next=automatic;
	
start slave;
show slave status\G;

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.201
                  Master_User: rpl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000012
          Read_Master_Log_Pos: 194
               Relay_Log_File: localhost-relay-bin.000030
                Relay_Log_Pos: 407
        Relay_Master_Log_File: mysql-bin.000012
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 194
              Relay_Log_Space: 705
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 330607
                  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79
            Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-79
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)



mysql> select * from t_20201021 limit 1\G;
*************************** 1. row ***************************
        id: 1
      name: 13f94a8edb
       age: 1
    ismale: 2
   id_card: e3dedf84fb490f2334b219b043603b
     test1: a0f157eb2e39ee3a546085771e829d065758eec63c9fc5fe1efe863d4fc5ca03这里是做普通索引和唯一索引的插入性能对比测试
     test2: dc0fec1ecea82878b20e68ab98aa082b4c1b03d9d19f1cb67b5a85f176675b75这里是做普通索引和唯一索引的插入性能对比测试
createTime: 2020-10-04 13:46:19.201
         b: NULL
1 row in set (0.00 sec)




[root@localhost test_db]# ll
总用量 1724584
-rw-r-----. 1 mysql mysql        67 10月 19 11:52 db.opt
-rw-r-----. 1 mysql mysql      8828 10月 22 10:56 #sql-f1f_11.frm
-rw-r-----. 1 mysql mysql 876609536 10月 22 11:13 #sql-ib58-2480555926.ibd
-rw-r-----. 1 mysql mysql      8696 10月 19 11:52 t_20201019.frm
-rw-r-----. 1 mysql mysql    114688 10月 19 21:41 t_20201019.ibd
-rw-r--r--. 1 mysql mysql      8828 10月 22 10:53 t_20201021.frm
-rw-r-----. 1 mysql mysql      8804 10月 21 01:38 t_20201021.frm.bak
-rw-r-----. 1 mysql mysql 889192448 10月 22 11:09 t_20201021.ibd



  

相关参考：

	http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html
	https://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting-datadict.htmlIf 
	
		this occurs, try the following procedure to resolve the problem:
			如果发生这种情况，请尝试以下步骤解决问题：
		Create a matching .frm file in some other database directory and copy it to the database directory where the orphan table is located.
			在其他一些数据库目录中创建一个匹配的.frm文件，并将其复制到孤立表所在的数据库目录中。

		Issue DROP TABLE for the original table. That should successfully drop the table and InnoDB should print a warning to the error log that the .ibd file was missing.
			发出原始表的DROP TABLE。 那应该成功删除该表，并且InnoDB应该在错误日志中显示一个警告，指出.ibd文件丢失。


----------------------------------------------------------------------------------------------------

mysql> flush logs;
Query OK, 0 rows affected (0.02 sec)

mysql> flush logs;
Query OK, 0 rows affected (0.02 sec)

mysql> alter table t_20201021 add column b int(11) default null;
Query OK, 0 rows affected (3 min 43.11 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000008 |      1179 |
| mysql-bin.000009 |       839 |
| mysql-bin.000010 |       241 |
| mysql-bin.000011 |       446 |
| mysql-bin.000012 |       194 |
+------------------+-----------+
5 rows in set (0.03 sec)


ysql> show global variables like '%recovery%';
+-----------------------------+-------+
| Variable_name               | Value |
+-----------------------------+-------+
| binlog_gtid_simple_recovery | ON    |
| innodb_force_recovery       | 0     |
| relay_log_recovery          | ON    |
+-----------------------------+-------+
3 rows in set (0.01 sec)



mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| t_20201019        |
| t_20201021        |
+-------------------+
2 rows in set (0.00 sec)

mysql> select * from t_20201019 limit 1;
+----+----+------+---------------------+
| ID | t1 | t2   | t3                  |
+----+----+------+---------------------+
|  3 |  3 |    3 | 2020-10-02 23:45:20 |
+----+----+------+---------------------+
1 row in set (0.00 sec)













