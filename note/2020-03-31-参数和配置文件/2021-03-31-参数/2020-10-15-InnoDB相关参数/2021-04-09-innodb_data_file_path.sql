

https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_data_file_path


定
定义InnoDB系统表空间数据文件的名称，大小和属性。如果未为innodb_data_file_path指定值，则默认行为是创建一个稍大于12MB的单个自动扩展数据文件，名为ibdata1。





innodb_data_file_path = ibdata1:10M:autoextend  改为   innodb_data_file_path = ibdata1:1G:autoextend

重启的时候 错误日志提示：
2019-01-31 07:03:40 21431 [Note] InnoDB: Initializing buffer pool, size = 8.0G
2019-01-31 07:03:40 21431 [Note] InnoDB: Completed initialization of buffer pool
2019-01-31 07:03:41 21431 [ERROR] InnoDB: auto-extending data file ./ibdata1 is of a different size 41600 pages (rounded down to MB) than specified in the .cnf file: initial 65536 pages, max 0 (relevant if non-zero) pages!
2019-01-31 07:03:41 21431 [ERROR] InnoDB: Could not open or create the system tablespace. If you tried to add new data files to the system tablespace, and it failed here, you should now edit innodb_data_file_path in my.cnf back to what it was, and remove the new ibdata files InnoDB created in this failed attempt. InnoDB only wrote those files full of zeros, but did not yet use them in any way. But be careful: do not remove old data files which contain your precious data!
2019-01-31 07:03:41 21431 [ERROR] Plugin 'InnoDB' init function returned error.
2019-01-31 07:03:41 21431 [ERROR] Plugin 'InnoDB' registration as a STORAGE ENGINE failed.
2019-01-31 07:03:41 21431 [ERROR] Unknown/unsupported storage engine: InnoDB
2019-01-31 07:03:41 21431 [ERROR] Aborting

应该这样改：
    innodb_data_file_path = 'ibdata1:10M:autoextend, ibdata2:1G:autoextend'

并且在一个实例下 innodb_data_file_path 只能增加，不能减少；除非新建实例。





