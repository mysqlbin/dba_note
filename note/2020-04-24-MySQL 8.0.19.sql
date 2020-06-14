


CREATE TABLE `t1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `t1` int(10) NOT NULL COMMENT '',
  `t2` int(10) NOT NULL COMMENT '',
  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
  `status` int(10) NOT NULL COMMENT '',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  PRIMARY KEY (`ID`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_status_createtime` (`status`, `createtime`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';

INSERT INTO `t1` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-24 18:55:00');


root@mysqldb 18:56:  [(none)]> 
root@mysqldb 18:56:  [(none)]> select version();
+-----------+
| version() |
+-----------+
| 8.0.19    |
+-----------+
1 row in set (0.00 sec)

root@mysqldb 18:56:  [(none)]> use zst;
Database changed
root@mysqldb 18:56:  [zst]> show global variables like '%isolation%';
+-----------------------+----------------+
| Variable_name         | Value          |
+-----------------------+----------------+
| transaction_isolation | READ-COMMITTED |
+-----------------------+----------------+
1 row in set (0.00 sec)

root@mysqldb 18:56:  [zst]> select * from t1 WHERE status = 0 AND (`createtime` BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE) AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));
Empty set (0.00 sec)





root@mysqldb 18:57:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
+----------------------------------------+-----------------------+-----------+-------------+-----------------------+-----------+---------------+-------------+------------------+
| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME            | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA        |
+----------------------------------------+-----------------------+-----------+-------------+-----------------------+-----------+---------------+-------------+------------------+
| 140669100232408:1074:140669104520840   |                219103 |        68 | t1          | NULL                  | TABLE     | IX            | GRANTED     | NULL             |
| 140669100232408:15:6:3:140669104517848 |                219103 |        68 | t1          | idx_status_createtime | RECORD    | X,REC_NOT_GAP | GRANTED     | 0, 0x5EA2C584, 1 |
| 140669100232408:15:4:2:140669104518192 |                219103 |        68 | t1          | PRIMARY               | RECORD    | X,REC_NOT_GAP | WAITING     | 1                |

| 140669100231536:1074:140669104514824   |                219102 |        69 | t1          | NULL                  | TABLE     | IX            | GRANTED     | NULL             |
| 140669100231536:15:5:2:140669104511880 |                219102 |        69 | t1          | idx_order_no          | RECORD    | X,REC_NOT_GAP | GRANTED     | '123456', 1      |
| 140669100231536:15:4:2:140669104512224 |                219102 |        69 | t1          | PRIMARY               | RECORD    | X,REC_NOT_GAP | GRANTED     | 1                |
+----------------------------------------+-----------------------+-----------+-------------+-----------------------+-----------+---------------+-------------+------------------+
6 rows in set (0.01 sec)



