
参考： http://wubx.net/mysql-5-7-class-repl-online-2-gtid-repl/

实现步骤：

1. 所有的Server执行
set @@global.enforce_gtid_consistency = warn;


特别注意： 这一步是关建的一步使用不能出现警告。

2. 所有的server上执行：
set @@global.enforce_gtid_consistency = on;


3.所有的Server上执行（不关心最先最后，但要执行完）：

set @@global.gtid_mode = off_permissive;

 
4. 执行：
set @@global.gtid_mode=on_permissive;

确认传统的binlog复制完毕,该值为0
show status like 'ongoing_anonymous_transaction_count';


5. 需要所有的节点都确认为0.
show status like 'ongoing_anonymous_transaction_count';
需要所有的节点都确认为0. 所有的节点也可以执行一下: flush logs; 用于切换一下日志。

6. 所有的节点启用gtid_mode
set @@global.gtid_mode=on;


7. 把 gtid_mode = on 相关配置写入配置文件(从库要写吗？)

gtid_mode=on
enforce_gtid_consistency=on

show status like '%gtid_mode%';
show global status like '%enforce_gtid_consistency%';

8. 启用Gtid的自动查找节点复制：

stop slave;


change master  to master_host='192.168.0.12',master_port=3306,master_user='repl_channel',master_password='123456abc',master_auto_position=1 for channel 'node12';

change master  to master_host='192.168.0.13',master_port=3306,master_user='repl_channel',master_password='123456abc',master_auto_position=1 for channel 'node13';

#change master to master_auto_position=1 for channel 'node12';

#change master to master_auto_position=1 for channel 'node13';

start slave;
