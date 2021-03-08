1. 环境
2. 表结构和数据的初始化
3. 死锁日志分析
 3.1 当时的死锁日志类似下面的内容
 3.2 声明
 3.3 事务一的信息
 3.4 事务二的信息
 3.5 根据死锁信息分析出的两个事务的加锁规则和死锁成因
4. 根据上面的死锁日志分析和业务逻辑复现该死锁是如何形成的
5. 解决本案例死锁的办法之一
6. MySQL 8.0.19 版本测试本案例
7. 小结


####1. 环境
 事务隔离级别为RC读已提交
 MySQL版本为 5.7.26
 先介绍一下数据表情况，因为涉及到公司内部真实的数据，所以以下都做了模拟，但不会影响具体的分析。


####2. 表结构和数据的初始化
```
 CREATE TABLE `t1` (
   `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
   `t1` int(10) NOT NULL COMMENT '',
   `t2` int(10) NOT NULL COMMENT '',
   `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
   `status` int(10) NOT NULL COMMENT '状态',
   `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
   PRIMARY KEY (`ID`),
   KEY `idx_order_no` (`order_no`),
   KEY `idx_status_createtime` (`status`, `createtime`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='';


表中有3个索引，其中一个主键索引，两个辅助索引。 
插入一行记录
  INSERT INTO `t1` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-24 12:10:00');


  mysql> select ID,order_no, status, createtime from t1 where order_no='123456';
  +---------+-------------------+---------------------+
  | ID      | order_no | status | createtime          |
  +---------+-------------------+---------------------+
  | 1       | 123456   |   0    | 2020-04-24 12:10:00 |
  +---------+-------------------+---------------------+
  1 row in set (0.00 sec)
```


####3. 死锁日志分析
 3.1 当时的死锁日志类似下面的内容
```
  2020-04-24T12:18:06.804155+08:00 4106 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
  2020-04-24T12:18:06.804185+08:00 4106 [Note] InnoDB: 
  *** (1) TRANSACTION:

  TRANSACTION 18912896, ACTIVE 3 sec starting index read
  mysql tables in use 1, locked 1
  LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
  MySQL thread id 4108, OS thread handle 140149994698496, query id 31983724 localhost root Searching rows for update
  UPDATE t1 SET status = 5 WHERE status = 0 AND (`createtime` BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE) AND DATE_SUB(NOW(),INTERVAL 60 MINUTE))
  2020-04-24T12:18:06.804257+08:00 4106 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

  RECORD LOCKS space id 260 page no 3 n bits 72 index PRIMARY of table `sbtest`.`t1` trx id 18912896 lock_mode X locks rec but not gap waiting
  Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
   0: len 4; hex 00000001; asc ;;
   1: len 6; hex 000001209381; asc ;;
   2: len 7; hex 45000001d825b8; asc E % ;;
   3: len 4; hex 80000001; asc ;;
   4: len 4; hex 80000001; asc ;;
   5: len 6; hex 313233343536; asc 123456;;
   6: len 4; hex 80000001; asc ;;
   7: len 4; hex 5ea26698; asc ^ f ;;

  2020-04-24T12:18:06.805410+08:00 4106 [Note] InnoDB: *** (2) TRANSACTION:

  TRANSACTION 18912129, ACTIVE 42 sec updating or deleting
  mysql tables in use 1, locked 1
  4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 1
  MySQL thread id 4106, OS thread handle 140149998397184, query id 31985074 localhost root updating
  update t1 set status=1 where order_no='123456'
  2020-04-24T12:18:06.805467+08:00 4106 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

  RECORD LOCKS space id 260 page no 3 n bits 72 index PRIMARY of table `sbtest`.`t1` trx id 18912129 lock_mode X locks rec but not gap
  Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
   0: len 4; hex 00000001; asc ;;
   1: len 6; hex 000001209381; asc ;;
   2: len 7; hex 45000001d825b8; asc E % ;;
   3: len 4; hex 80000001; asc ;;
   4: len 4; hex 80000001; asc ;;
   5: len 6; hex 313233343536; asc 123456;;
   6: len 4; hex 80000001; asc ;;
   7: len 4; hex 5ea26698; asc ^ f ;;

  2020-04-24T12:18:06.805835+08:00 4106 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

  RECORD LOCKS space id 260 page no 5 n bits 72 index idx_status_createtime of table `sbtest`.`t1` trx id 18912129 lock_mode X locks rec but not gap waiting
  Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
   0: len 4; hex 80000000; asc ;;
   1: len 4; hex 5ea26698; asc ^ f ;;
   2: len 4; hex 00000001; asc ;;

  2020-04-24T12:18:06.806005+08:00 4106 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)
```
3.2 声明：
  死锁日志中的TRANSACTION 18912129 记为 事务一 
  死锁日志中的TRANSACTION 18912896 记为 事务二
  分析死锁的时候，我习惯把事务编号小的定义为事务一

3.3 事务一的信息：
```
  事务一的SQL语句：
      update t1 set status=1 where order_no='123456'

  持有的锁信息：
      HOLDS THE LOCK(S) --用来表示这个事务持有哪些锁
      index PRIMARY of table `sbtest`.`t1` --表示加锁是在加在表t1 的索引PRIMARY 上
      n_fields 8: --表示这个记录是8列
      0: len 4; hex 00000001; asc ;; --是第一个字段，也就是主键字段 ID, 1从16进制转换为10进制, 得到的值为1
   
  所以事务一持有的锁: PRIMARY: record lock: [1]
    
  在等待的锁信息：
      index idx_status_createtime of table `sbtest`.`t1` --表示在等的是表t1 的辅助索引idx_status_createtime 上面的锁
      lock_mode X locks rec but not gap waiting --表示需要加一个排他锁（写锁），当前的状态是等待中
      Record lock --表示这是一个记录锁
      n_fields 3 --表示辅助索引idx_status_createtime的记录是3列, 根据索引的存储结构, 3列依次为 status、createtime、ID
      0: len 4; hex 80000000; asc ;; --status字段, 值为 0
      1: len 4; hex 5ea26698; asc ^ f ;; --createtime字段, 5ea26698 从16进制转换为10进制, 得到时间戳1587701400, 转换为具体的日期: 2020-04-24 12:10:00
      2: len 4; hex 00000001; asc ;; --ID字段, 1从16进制转换为10进制, 得到的值为1
   
   所以在等待事务二 辅助索引idx_status_createtime (status=0,createtime='2020-04-24 12:10:00',ID=1) 这一行的记录锁
```
 3.4 事务二的信息
```
  事务二的SQL语句
      UPDATE t1 SET status = 5 WHERE status = 0 AND (`createtime` BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE) AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));

  持有的锁信息
      根据事务一在等待事务二上表t1辅助索引idx_nStatus_CreateTime 上的行锁，所以推导出事务二持有表t1辅助索引idx_nStatus_CreateTime 上的行锁
      所以事务二持有的锁: idx_status_createtime: record lock: (status=0,createtime='2020-04-24 12:10:00',ID=1)
   
  在等待的锁信息
      index PRIMARY of table `sbtest`.`t1` --表示在等的是表t1 的主键索引 上面的锁
      lock_mode X locks rec but not gap waiting --表示需要加一个排他锁（写锁），当前的状态是等待中
      Record lock --是一个记录锁
      0: len 4; hex 00000001; asc ;; --是第一个字段，也就是主键字段 ID, 值为 1
   
   所以在等待事务一的: PRIMARY: record lock：(ID=1) 。
```

3.5 根据死锁信息分析出的两个事务的加锁规则和死锁成因


<div class="wiz-table-container" style="position: relative; padding: 0px;" contenteditable="false"><div class="wiz-table-body" contenteditable="false"><table style="width: 660px;"><tbody><tr><td align="left" valign="middle" style="width: 66px;">时间点</td><td align="left" valign="middle" style="width: 208px;">事务一</td><td align="left" valign="middle" style="width: 386px;">事务二</td></tr><tr><td align="left" valign="middle" style="width: 66px;"><span>T1</span><br></td><td align="left" valign="middle" style="width: 208px;">持有主键索引 ID=1 的记录锁, 锁的模式为排他锁</td><td align="left" valign="middle" style="width: 386px;"><br></td></tr><tr><td align="left" valign="middle" style="width: 66px;">T2</td><td align="left" valign="middle" style="width: 208px;"><br></td><td align="left" valign="middle" style="width: 386px;">持有辅助索引:<br>idx_status_createtime: record lock:&nbsp;status=0，createtime='2020-04-24 12:10:00', ID=1) 的记录锁，锁的模式为排他锁</td></tr><tr style="height: 33px;"><td align="left" valign="middle" style="width: 66px;">T3</td><td align="left" valign="middle" style="width: 208px;"><br></td><td align="left" valign="middle" style="width: 386px;">&nbsp;在等主键索引 ID=1 的记录锁&nbsp;</td></tr><tr><td align="left" valign="middle" style="width: 66px;">T4</td><td align="left" valign="middle" style="width: 208px;">在等辅助索引idx_status_createtime:&nbsp;<br>&nbsp; &nbsp;record lock: (status=0， createtime='2020-04-24 12:10:00'，ID=1)的记录锁</td><td align="left" valign="middle" style="width: 386px;"><br></td></tr><tr><td align="left" valign="middle" style="width: 659px;" rowspan="1" colspan="3">T3被T1阻塞，T4被T2阻塞，因此锁资源请求形成了环路，进而触发死锁检测, 因此导致了死锁。</td></tr></tbody></table></div></div>



####4. 根据上面的死锁分析和业务逻辑复现该死锁


<div class="wiz-table-container" style="position: relative; padding: 0px;" contenteditable="false"><div class="wiz-table-body" contenteditable="false"><table style="width: 664px;"><tbody><tr><td align="left" valign="middle" style="width: 66px;">时间点</td><td align="left" valign="middle" style="width: 226px;">事务一</td><td align="left" valign="middle" style="width: 369px;">事务二</td></tr><tr><td align="left" valign="middle" style="width: 66px;"><br></td><td align="left" valign="middle" style="width: 226px;"><span><span>begin;&nbsp;</span></span><span><br>select status from t1 where&nbsp;</span><br><span>&nbsp;order_no='123456' for update;&nbsp;</span><br></td><td align="left" valign="middle" style="width: 369px;"><br></td></tr><tr><td style="width: 66px;">T1</td><td style="width: 226px;"><span>持有主键索引 ID=1 的记录锁, 锁的模式为排他锁</span><br></td><td style="width: 369px;"><br></td></tr><tr><td align="left" valign="middle" style="width: 66px;"><br></td><td align="left" valign="middle" style="width: 226px;"><br></td><td align="left" valign="middle" style="width: 369px;">UPDATE t1 SET status = 5 WHERE&nbsp;status = 0 AND (createtime BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE)&nbsp;&nbsp;AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));</td></tr><tr><td style="width: 66px;">T2</td><td style="width: 226px;"><br></td><td style="width: 369px;"><span>持有辅助索引:</span><br><span>idx_status_createtime: (record lock: status=0, createtime='2020-04-24 12:10:00', ID=1) 的记录锁，锁的模式为排他锁</span><br></td></tr><tr><td style="width: 66px;">T3</td><td style="width: 226px;"><br></td><td style="width: 369px;"><span>&nbsp;在等主键索引 ID=1 的记录锁&nbsp;</span><br></td></tr><tr><td align="left" valign="middle" style="width: 66px;"><br></td><td align="left" valign="middle" style="width: 226px;">update t1 set status=1 where order_no='123456';</td><td align="left" valign="middle" style="width: 369px;"><br></td></tr><tr><td align="left" valign="middle" style="width: 66px;">T4</td><td align="left" valign="middle" style="width: 226px;"><span>在等辅助索引idx_status_createtime:&nbsp;</span><br><span>&nbsp; &nbsp;record lock: (status=0, createtime='2020-04-24 12:10:00'，ID=1)的记录锁</span><br></td><td align="left" valign="middle" style="width: 369px;"><br></td></tr><tr><td align="left" valign="middle" style="width: 662px;" rowspan="1" colspan="3">T3被T1阻塞，T4被T2阻塞，因此锁资源请求形成了环路，进而触发死锁检测, MySQL会把执行代价最小的事务回滚掉，让其它事务得以继续进行。&nbsp;</td></tr></tbody></table></div></div>


查看 information_schema 下的两个视图 innodb_locks 和 innodb_lock_waits 确认T1、T2、T3时刻持有的锁和在等待的锁的详情                   
```
   mysql> select * from information_schema.innodb_locks\G
  *************************** 1. row ***************************
      lock_id: 18912896:260:3:2 --请求的锁
  lock_trx_id: 18912896 --被阻塞的事务ID
    lock_mode: X --排他锁
    lock_type: RECORD --锁类型 记录锁
   lock_table: `sbtest`.`t1` --表
   lock_index: PRIMARY --索引为主键索引 
   lock_space: 260
    lock_page: 3
     lock_rec: 2 
    lock_data: 1 --请求加锁的row data，ID=1这行记录  
  *************************** 2. row ***************************
      lock_id: 18912129:260:3:2 --持有的锁
  lock_trx_id: 18912129 --持有锁的事务ID
    lock_mode: X --排他锁 LOCK_X
    lock_type: RECORD --锁类型 记录锁
   lock_table: `sbtest`.`t1` --表
   lock_index: PRIMARY --索引为主键索引 
   lock_space: 260 --table space id
    lock_page: 3 --page no
     lock_rec: 2 --heap no
    lock_data: 1 --被加锁的row data，ID=1这行记录
  2 rows in set (0.00 sec)
```


trx_id 为 18912129 向表 t1 加了一个 X 的记录锁， trx_id 为 18912896 的事务向表 t1 申请了一个 X 的记录锁，lock_data 的值为1 即记录的主键值为1，申请了相同的资源，因此这里会有等待。


  事务二更新语句的WHERE条件查询到的记录是为空的, 但是为什么会持有辅助索引idx_status_createtime上面的锁呢？
```
      mysql> select * from t1 WHERE status = 0 AND (`createtime` BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE) AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));
       Empty set (0.00 sec)
```
  原因：因为这里是辅助索引的范围查询更新，范围查询就会往后查找，刚好找到``` (status=0, createtime='2020-04-24 12:10:00') ```的记录才会停下来, 因此持有行锁：```(status=0, createtime='2020-04-24 12:10:00', ID=1)```                     


  MySQL8.0 版本information_schema中的innodb_locks和innodb_lock_waits表被移除，取而代之的是performance_schema中的data_locks和data_lock_waits表，通过 data_locks 可以看到数据加锁的详情。
  同时，下文会把这个案例在 MySQL 8.0.19 下做测试， 因为 MySQL 8.0记录了更详细的死锁日志，分析死锁会更加轻松。
```
  mysql> select * from information_schema.innodb_lock_waits\G;
  *************************** 1. row ***************************
  requesting_trx_id: 18912896 --请求锁资源的事务ID
  requested_lock_id: 18912896:260:3:2 --申请的锁的ID
    blocking_trx_id: 18912129 --持有锁的事务ID
   blocking_lock_id: 18912129:260:3:2 --持有的锁的ID
```


####5. 解决本案例死锁的办法之一
 经过跟相关的开发人员沟通, 事务一的 UPDATE语句可以不放在显示声明的事务内执行, 然后把更新语句移出显示声明的事务中就可以避免本案例的死锁。

####6. MySQL 8.0.19 版本测试本案例
 环境
```
  mysql> select version();
  +-----------+
  | version() |
  +-----------+
  | 8.0.19 |
  +-----------+
  1 row in set (0.00 sec)
  
  mysql> select @@session.transaction_isolation;
  +---------------------------------+
  | @@session.transaction_isolation |
  +---------------------------------+
  | READ-COMMITTED                  |
  +---------------------------------+
  1 row in set (0.00 sec)
```
事务的执行顺序
<div class="wiz-table-container" style="position: relative; padding: 0px;" contenteditable="false"><div class="wiz-table-body" contenteditable="false"><table style="width: 648px;"><tbody><tr><td colspan="1" rowspan="1" style="width: 71px;">时间点</td> <td colspan="1" rowspan="1" style="width: 220px;">事务一</td> <td colspan="1" rowspan="1" style="width: 358px;">事务二</td></tr><tr><td colspan="1" rowspan="1" style="width: 71px;">T1</td> <td colspan="1" rowspan="1" style="width: 220px;"><span><span>begin;&nbsp;</span></span><span><br>select status from t1 where&nbsp;</span><br><span>&nbsp;order_no='123456' for update;&nbsp;</span><br></td> <td colspan="1" rowspan="1" style="width: 358px;"><br></td></tr><tr><td colspan="1" rowspan="1" style="width: 71px;">T2</td> <td colspan="1" rowspan="1" style="width: 220px;"><br></td> <td colspan="1" rowspan="1" style="width: 358px;">UPDATE t1 SET status = 5 WHERE&nbsp;status = 0 AND (`createtime` BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE)&nbsp;&nbsp;AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));</td></tr><tr><td colspan="1" rowspan="1" style="width: 71px;">T3</td> <td colspan="1" rowspan="1" style="width: 220px;">update t1 set status=1 where order_no='123456';</td> <td colspan="1" rowspan="1" style="width: 358px;"><br><br>ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction</td></tr></tbody></table></div></div>



查看 information_schema.innodb_locks 确认T1、T2 时刻持有的锁和在等待的锁的详情  

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+-----------------------+-----------+---------------+-------------+------------------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME            | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA        |
	+----------------------------------------+-----------------------+-----------+-------------+-----------------------+-----------+---------------+-------------+------------------+
	| 140472041388912:1072:140471938672632   |                212055 |     30483 | t1          | NULL                  | TABLE     | IX            | GRANTED     | NULL             |
	| 140472041388912:15:6:2:140471938669688 |                212055 |     30483 | t1          | idx_status_createtime | RECORD    | X,REC_NOT_GAP | GRANTED     | 0, 0x5EA26698, 1 |
	| 140472041388912:15:4:2:140471938670032 |                212055 |     30483 | t1          | PRIMARY               | RECORD    | X,REC_NOT_GAP | WAITING     | 1                |
	| 140472041388040:1072:140471938666488   |                212052 |     30481 | t1          | NULL                  | TABLE     | IX            | GRANTED     | NULL             |
	| 140472041388040:15:5:2:140471938663448 |                212052 |     30481 | t1          | idx_order_no          | RECORD    | X,REC_NOT_GAP | GRANTED     | '123456', 1      |
	| 140472041388040:15:4:2:140471938663792 |                212052 |     30481 | t1          | PRIMARY               | RECORD    | X,REC_NOT_GAP | GRANTED     | 1                |
	+----------------------------------------+-----------------------+-----------+-------------+-----------------------+-----------+---------------+-------------+------------------+
	6 rows in set (0.00 sec)
  事务一在T1时刻持有的锁：
	INDEX_NAME=PRIMARY，LOCK_TYPE=RECORD，LOCK_STATUS=GRANTED，LOCK_DATA=1 : ```PRIMARY: record lock: [1]```
	INDEX_NAME=idx_order_no，LOCK_TYPE=RECORD，LOCK_STATUS=GRANTED，LOCK_DATA='123456', 1 : ```idx_order_no: record lock: (order='123456',ID=1)```
  事务二持有的锁：
	INDEX_NAME=idx_status_createtime ，LOCK_TYPE=RECORD，LOCK_STATUS=GRANTED，LOCK_DATA='0, 0x5EA26698, 1': ```(status=0, createtime='2020-04-24 12:10:00', ID=1)```
  事务二在等待的锁：
	INDEX_NAME=PRIMARY，LOCK_TYPE=RECORD，LOCK_STATUS=WAITING, LOCK_DATA=1 表示 事务二在等的锁为: ```PRIMARY: record lock: [1]```


死锁日志
```   
  2020-04-24 12:15:36 0x7fc1947ea700
  *** (1) TRANSACTION:
  TRANSACTION 212055, ACTIVE 1 sec starting index read
  mysql tables in use 1, locked 1
  LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
  MySQL thread id 30432, OS thread handle 140468864067328, query id 135057 localhost root Searching rows for update
  UPDATE t1 SET status = 5 WHERE status = 0 AND (`createtime` BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE) AND DATE_SUB(NOW(),INTERVAL 60 MINUTE))

  *** (1) HOLDS THE LOCK(S): --持有的锁
  RECORD LOCKS space id 15 page no 6 n bits 72 index idx_status_createtime of table `sbtest`.`t1` trx id 212055 lock_mode X locks rec but not gap
  Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
   0: len 4; hex 80000000; asc ;; 
   1: len 4; hex 5ea26698; asc ^ f ;; 
   2: len 4; hex 00000001; asc ;; 

  *** (1) WAITING FOR THIS LOCK TO BE GRANTED: --在等待的锁
  RECORD LOCKS space id 15 page no 4 n bits 72 index PRIMARY of table `sbtest`.`t1` trx id 212055 lock_mode X locks rec but not gap waiting
  Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
   0: len 4; hex 00000001; asc ;; 
   1: len 6; hex 000000033c54; asc <T;;
   2: len 7; hex 0200000ff80e6a; asc j;;
   3: len 4; hex 80000001; asc ;;
   4: len 4; hex 80000001; asc ;;
   5: len 6; hex 313233343536; asc 123456;; 
   6: len 4; hex 80000001; asc ;;
   7: len 4; hex 5ea26698; asc ^ f ;; 

  *** (2) TRANSACTION:
  TRANSACTION 212052, ACTIVE 68 sec updating or deleting
  mysql tables in use 1, locked 1
  LOCK WAIT 4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 1
  MySQL thread id 30430, OS thread handle 140468857743104, query id 135061 localhost root updating
  update t1 set status=1 where order_no='123456'

  *** (2) HOLDS THE LOCK(S): --持有的锁
  RECORD LOCKS space id 15 page no 4 n bits 72 index PRIMARY of table `sbtest`.`t1` trx id 212052 lock_mode X locks rec but not gap
  Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
   0: len 4; hex 00000001; asc ;; 
   1: len 6; hex 000000033c54; asc <T;;
   2: len 7; hex 0200000ff80e6a; asc j;;
   3: len 4; hex 80000001; asc ;;
   4: len 4; hex 80000001; asc ;;
   5: len 6; hex 313233343536; asc 123456;; 
   6: len 4; hex 80000001; asc ;;
   7: len 4; hex 5ea26698; asc ^ f ;; 

  *** (2) WAITING FOR THIS LOCK TO BE GRANTED: --在等待的锁
  RECORD LOCKS space id 15 page no 6 n bits 72 index idx_status_createtime of table `sbtest`.`t1` trx id 212052 lock_mode X locks rec but not gap waiting
  Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
   0: len 4; hex 80000000; asc ;; 
   1: len 4; hex 5ea26698; asc ^ f ;; 
   2: len 4; hex 00000001; asc ;; 

  *** WE ROLL BACK TRANSACTION (1)
```

可以看到， MySQL 8.0版本的死锁日志更加完整了：把事务持有的锁和在等待的锁的详情都记录下来了。

###7. 小结

1. 死锁一般可以结合死锁日志、加锁规则和业务场景来做相关的分析

2. 辅助索引的范围查询更新加锁，需要往后找到一条满足条件的记录才会停止扫描

3. 加锁是在加在索引上的，当表中有多个索引，只会对必要的索引加锁，例如本案例中的表t1有3个索引，分别为 PRIMARY KEY、idx_order_no和idx_status_createtime，当执行 select * from t1 where order_no='123456' for update; 语句后，会对索引 PRIMARY KEY、idx_order_no 的记录进行加锁，并不会对索引 idx_status_createtime 的记录进行加锁。

4. MySQL 8.0版本通过 performance_schema.data_locks 可以看到事务持有的锁列表和在等待的锁的列表。

   同时，MySQL 8.0版本记录的死锁日志更加完整了，不再需要根据死锁日志中的锁等待的记录信息推导出另一个事务持有的锁信息，分析死锁会更加轻松。