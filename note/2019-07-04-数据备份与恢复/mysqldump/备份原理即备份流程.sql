

1. 执行 flush table with read lock；
   
	用途/作用：
		通过获取全局读锁，让整个实例不能写，只能读， 这时候就可以获取到一致性的 show master status; 命令的信息，包括 File、Position和GTID。(这里的结论是在实验中得到的。)
		不加锁的话，备份系统的备份得到的库不是一个逻辑时间点，这个视图是逻辑不一致的。
		不通过FTWRL命令对整个实例加锁， 备份得到的数据跟备份的逻辑时间点不一致，最终结果导致备份数据会产生不一致。  
		
	造成的影响：
		期间整个实例不能写，只能读；
		如果在主库进行备份，释放全局读锁之前不能写，对在线业务造成影响；
		如果在从库进行备份，释放全局读锁之前不能写，也就意味应用relay log不能进行SQL的重放，造成延迟；

	所以，备份要在从库并且是业务低峰期进行备份，这时候造成的影响最小。
	
	可见，了解原理挺重要的。
	
 2. 执行 SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ; START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */; 
   作用：
     在RR隔离级别下， 通过START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */;启动一个事务 来获取一致性视图也就是一致性数据快照。
     如果在备份执行期间，某个InnoDB引擎表还没开始备份之前， 该表有做删除一行记录操作并执行成功， 当备份到该表时，根据MVCC的read view可见性判断规则，这时候备份该删除行之前的数据实际上是从 undo中取出来的。

	 /*!40100*/表示主版本大于 4，小版本大于 01 这个 with consistent snapshot语法才能生效； 如果不满足版本要求，那么with consistent snapshot语法是不生效的，只会执行start transaction，不会执行 withconsistent snapshot 。
	 
   管理：
       由 --single-transaction 参数来控制， 备份时使用 --single-transaction 参数， 就能获取到支持事务引擎表的数据一致性；
	   
3. 执行 show master status；语句
    作用： 
        GTID模式下读取一致性的GTID信息；
            在备份文件里可以看到 set @@global.gtid_purged='' 这条命令； 
        非GTID模式下读取一致性的复制位点信息（File 和 Position）；
            在备份文件里可以看到 change master to master_log_file='' , master_log_pos= ; 这条命令； 
			
	 管理：
        由参数  --master-data 控制：
        默认是 1， 不注释 change master to 命令；
        设置为 2， 注释 change master to 命令；
		
4. 执行 unlock tables;语句释放全局读锁；
   这时候数据库可以正常写入。
   
5. 执行 savepoint sp语句； 创建一个保存点；

6. 正式备份数据
	先执行 show create table `t1`; 语句； 作用是获取表结构
	执行 SELECT * FROM `t1`; 语句； 作用是开始导数据；
	 
7. 导出表数据完成之后， 执行 rollback to savepoint sp 语句；
    作用是 释放该表MDL的读锁，使其它会话的DDL语句可以正常执行； 在这里的作用是释放 t1 的 MDL 锁。
    重复步骤 6， 直到其它表备份完成；

8. 备份完成之后， 执行 release savepoint sp; 释放保存点。
	备份文件的最后有 '-- Dump completed on 2020-03-14 21:10:51'  字样，意味着本次备份是正常的。
	


    
  