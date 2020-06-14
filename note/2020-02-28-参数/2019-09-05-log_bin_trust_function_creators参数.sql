
root@mysqldb 10:46:  [db1]> show variables like 'log_bin_trust_function_creators';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| log_bin_trust_function_creators | OFF   |
+---------------------------------+-------+
1 row in set (0.00 sec)


DROP FUNCTION IF EXISTS `get_rand_score`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `get_rand_score`(_nRound int) RETURNS int(11)
BEGIN
        DECLARE _result INT;
        SET _result = FLOOR(1 + (RAND() * _nRound));
        RETURN _result;
END
;;
DELIMITER ;

[Err] 1418 - This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)



相关参考： 
	https://www.cnblogs.com/kerrycode/p/7641835.html

	https://www.dgstack.cn/archives/1621.html
		
	
	https://www.jianshu.com/p/fcd57e83dce7  MySQL主从同步 使用函数报错
		
	https://dev.mysql.com/doc/refman/5.7/en/stored-programs-logging.html
	
log_bin_trust_function_creators 这个参数开启，是允许函数创建在binlog传递


主库开启log_bin_trust_function_creators参数后，进行创建函数，
从库没有开启 log_bin_trust_function_creators参数，会导致复制中断。

实验：
master：
 set global log_bin_trust_function_creators=1;
mysql> show global variables like '%log_bin_trust_function_creators%';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| log_bin_trust_function_creators | ON    |
+---------------------------------+-------+
1 row in set (0.00 sec)

slave:
 set global log_bin_trust_function_creators=0;
 mysql>  show global variables like '%log_bin_trust_function_creators%';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| log_bin_trust_function_creators | OFF   |
+---------------------------------+-------+
1 row in set (0.01 sec)
	


mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 11.111.11.11
                  Master_User: repl_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000290
          Read_Master_Log_Pos: 8654
               Relay_Log_File: database-06-relay-bin.000059
                Relay_Log_Pos: 8482
        Relay_Master_Log_File: mysql-bin.000290
             Slave_IO_Running: Yes
            Slave_SQL_Running: No
              Replicate_Do_DB: 
          Replicate_Ignore_DB: dezhou_web,niuniu_web
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 1418
                   Last_Error: Error 'This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)' on query. Default database: 'db2'. Query: 'CREATE DEFINER=`root`@`%` FUNCTION `get_rand_score`(_nRound int) RETURNS int(11)
BEGIN
        DECLARE _result INT;
        SET _result = FLOOR(1 + (RAND() * _nRound));
        RETURN _result;
END'
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 8309
              Relay_Log_Space: 9206
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
               Last_SQL_Errno: 1418
               Last_SQL_Error: Error 'This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)' on query. Default database: 'db2'. Query: 'CREATE DEFINER=`root`@`%` FUNCTION `get_rand_score`(_nRound int) RETURNS int(11)
BEGIN
        DECLARE _result INT;
        SET _result = FLOOR(1 + (RAND() * _nRound));
        RETURN _result;
END'
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 17
                  Master_UUID: 64f06970-098a-11e9-aee6-00163e020f37
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: 
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 190905 12:28:55
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 53ebf01e-bbec-11e8-9a62-00163e087d10:1-4,
64f06970-098a-11e9-aee6-00163e020f37:1-1715
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)

ERROR: 
No query specified


