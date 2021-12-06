

5.6 
	复制方面
		支持GTID复制
		半同步复制
		支持延迟从库的复制 
		
    支持Online DDL 
    支持BP缓冲池的预热功能，数据库重启后，BP缓冲池的热点数据还存在，5.7版本是默认开启的
    
5.7 
	复制方面
	
		组复制，也就是MGR
		增强半同步复制
		基于行的并行复制 
		
    在线修改BP缓冲池大小
        使用不当，会造成DML阻塞。
        遇到过在线收缩BP缓冲池空间，导致阻塞业务的DML请求。
		
    支持json字段
    

8.0

    快速加列(什么时候也能支持快速加索引就好了) -> 8.0.12
	支持原生的物理备份  -> 8.0.17
	hash join、优化了唯一索引的1个加锁BUG -> 8.0.18
	
    支持在线关闭和开启Redo Log，加快逻辑备份的导入。  -> 8.0.21
	
        ALTER INSTANCE ENABLE INNODB REDO_LOG; 
        ALTER INSTANCE DISABLE INNODB REDO_LOG;
	
	
	
https://www.cnblogs.com/ivictor/p/9807284.html   MySQL 5.6, 5.7, 8.0的新特性