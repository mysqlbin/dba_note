
root@mysqldb 16:26:  [performance_schema]> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)

[root@localhost ...]# date
2020年 06月 04日 星期四 16:27:14 CST


*************************** 37. row ***************************
                    trx_id: 1745287
                 trx_state: RUNNING
               trx_started: 2020-06-04 15:54:02
     trx_requested_lock_id: NULL
          trx_wait_started: NULL
                trx_weight: 0
       trx_mysql_thread_id: 6
                 trx_query: alter table table_clublogscore add index idx_szOrder(`szOrder`)
       trx_operation_state: NULL
         trx_tables_in_use: 1
         trx_tables_locked: 0
          trx_lock_structs: 0
     trx_lock_memory_bytes: 1136
           trx_rows_locked: 0
         trx_rows_modified: 0
   trx_concurrency_tickets: 0
       trx_isolation_level: REPEATABLE READ
         trx_unique_checks: 1
    trx_foreign_key_checks: 1
trx_last_foreign_key_error: NULL
 trx_adaptive_hash_latched: 0
 trx_adaptive_hash_timeout: 0
          trx_is_read_only: 0
trx_autocommit_non_locking: 0
37 rows in set, 2 warnings (0.00 sec)



UPDATE performance_schema.setup_instruments SET ENABLED = 'YES' WHERE NAME LIKE 'stage/innodb/alter%';
 
UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%stages%';


use performance_schema;
select * from setup_instruments where name like 'stage/innodb/alter%';
select * from setup_consumers where name like '%stages%';

root@mysqldb 16:26:  [performance_schema]> select * from setup_instruments where name like 'stage/innodb/alter%';
+------------------------------------------------------+---------+-------+
| NAME                                                 | ENABLED | TIMED |
+------------------------------------------------------+---------+-------+
| stage/innodb/alter table (end)                       | YES     | YES   |
| stage/innodb/alter table (flush)                     | YES     | YES   |
| stage/innodb/alter table (insert)                    | YES     | YES   |
| stage/innodb/alter table (log apply index)           | YES     | YES   |
| stage/innodb/alter table (log apply table)           | YES     | YES   |
| stage/innodb/alter table (merge sort)                | YES     | YES   |
| stage/innodb/alter table (read PK and internal sort) | YES     | YES   |
+------------------------------------------------------+---------+-------+
7 rows in set (0.00 sec)

root@mysqldb 16:26:  [performance_schema]> select * from setup_consumers where name like '%stages%';
+----------------------------+---------+
| NAME                       | ENABLED |
+----------------------------+---------+
| events_stages_current      | YES     |
| events_stages_history      | YES     |
| events_stages_history_long | YES     |
+----------------------------+---------+
3 rows in set (0.00 sec)


root@mysqldb 16:26:  [performance_schema]> select EVENT_NAME,WORK_COMPLETED,WORK_ESTIMATED from performance_schema.events_stages_current;
+---------------------------------------+----------------+----------------+
| EVENT_NAME                            | WORK_COMPLETED | WORK_ESTIMATED |
+---------------------------------------+----------------+----------------+
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/Waiting for next activation |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/query end                   |           NULL |           NULL |
| stage/sql/Sending data                |           NULL |           NULL |
+---------------------------------------+----------------+----------------+
47 rows in set (0.00 sec)




UPDATE performance_schema.setup_instruments SET ENABLED = 'NO' WHERE NAME LIKE 'stage/innodb/alter%';
 
UPDATE performance_schema.setup_consumers SET ENABLED = 'NO' WHERE NAME LIKE '%stages%';


