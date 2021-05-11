
1. 重要选项和参数
2. 常用备份命令


1. 重要选项和参数
	
    -B, --databases
        表示只导出单个库

    --tables Overrides option --databases (-B)
         表示通过 -B --tables 只导出指定表

    -d, --no-data          No row information.
         表示备份不导出表数据, 只导出表结构

    -R, --routines Dump stored routines (functions and procedures).
        备份存储过程和函数
		
    -E, --events Dump events.
        备份事件
    
    --lock-all-tables： 
             备份期间整个实例全程锁表， 不可以写，只可以读；
			 
    --lock-tables：
            备份到该表的时候才加MDL读锁；
            备份期间只对执行select语句导出表数据的时候加MDL读锁；
			
	–add-locks： 
		设置为 0，表示在输出的文件结果里，不增加 LOCK TABLES <code>t</code> WRITE; 语句；

	
    --single-transaction
        获取支持事务引擎表的一致性备份;
		在导出数据的时候不需要对表加表锁，而是使用 START TRANSACTION WITH CONSISTENT SNAPSHOT 的方法；
		
   --master-data    
        该选项自动关闭--lock-tables选项.
        
		不指定 --single-transaction选项， 只指定  --master-data选项自动关闭 --lock-tables选项， 同时还会打开--lock-all-tables， 备份过程中整个实例全程锁表。
		指定 --single-transaction、--master-data选项，  会自动开启 --lock-tables参数。
    
	–no-create-info：        
		表示不需要导出表结构
	
	–set-gtid-purged=off：   
		表示不输出跟 GTID 相关的信息；
		--
		-- GTID state at the beginning of the backup 
		--

		SET @@GLOBAL.GTID_PURGED='f7323d17-6442-11ea-8a77-080027758761:1-14';
			
	–result-file：          
		表示指定了输出文件的路径，其中 client 表示生成的文件是在客户端机器上的。

	
	
2. 常用备份命令
	
    导出全库：
        mysqldump -uroot -p123456abc --single-transaction --master-data=2 -A > backup.sql  
		
        mysqldump -uroot -p@ly242yhn%. --single-transaction --master-data=2 -A -R -E > backup.sql  
		
        mysqldump -uroot -p@ly242yhn%. --single-transaction --master-data=2 -A -R -E |gzip > backup.dump.gz  
		
		flush privileges;
		
		
		# done 
    导出单个库:
        mysqldump -uroot -p123456abc  --single-transaction --master-data=2 -B zst > backup.sql  
		# done  
    导出单个表：
        mysqldump -uroot -p123456abc  --single-transaction --master-data=2 -B zst --tables t1 >  backup.sql
		# done 
	导出多个表:
		mysqldump -uroot -p123456abc  --single-transaction --master-data=2 -B zst --tables  table_name1 table_name2 table_name3  >  backup.sql
		# done 
    导出表数据不导出表结构: 
        mysqldump -uroot -p123456abc  --single-transaction --master-data=2 -–no-create-info -B zst --tables  t1 >  backup.sql
		# done
    导出表结构不导出表的数据: 
        mysqldump -uroot -p123456abc  --single-transaction --master-data=2 -d zst t1 >  backup.sql
        # done
		
	导出存储过程：
		只导出存储过程和函数(不导出结构和数据，要同时导出结构的话，需要同时使用-d)
		mysqldump -uroot -p123456abc  --single-transaction --master-data=2 -B zst -R -ndt > backup.sql  
		# done
	where 条件
	
		mysqldump -uroot -p --single-transaction --master-data=2 -t db_name --tables table_name --where='bRobot = 1' |gzip > 2019.dump.gz
		# done
	
		
	①同时导出结构以及数据时可同时省略-d和-t
	②同时 不 导出结构和数据可使用-ntd
	③只导出存储过程和函数可使用-R -ntd
	④导出所有(结构&数据&存储过程&函数&事件&触发器)使用-R -E(相当于①，省略了-d -t;触发器默认导出)
	⑤只导出结构&函数&事件&触发器使用 -R -E -d	
	
	
	mysqldump --add-locks=0 -uroot -p123456abc -d db1 >  backup.sql
	
	
	