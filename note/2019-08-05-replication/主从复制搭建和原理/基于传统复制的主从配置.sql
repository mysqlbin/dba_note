
MySQL服务器的my.cnf配置文件中增加相关的参数

主的配置
1、配置文件需要开启的参数
server-id=3306100
log-bin=/data/mysql/mysql3306/logs/mysql-bin
binlog_format=row

另外建议把这些参数设置上：
max_binlog_size=512M
expire_logs_days=10


2、主上增加复制账号
grant repelication slave on *.* to 'rpl'@'%' identified by 'password';


3、从的配置
配置文件需要设置的参数
server-id=3306101 #从库的server-id跟主库不要一样
log-bin=/data/mysql/mysql3306/logs/mysql-bin #这个不是必须，但建议开启
log_slave_updates #不是必须，用于再把这个从库当成主库，多级主从，如果不开这个下一级从库就会取不到日志信息
binlog_format=row
master_info_repository=TABLE
relay_log_info_repository=TABLE
另外建议把这些参数设置上：
max_binlog_size=512M
expire_logs_days=10
-----------------------------------------------------------------------------------
然后在Slave上执行CHANGE MASTER TO即可。比如：
CHANGE MASTER TO MASTER_HOST='node1',MASTER_USER='repl',MASTER_PASSWORD='repl',MASTER_LOG_FILE='',MASTER_LOG_POS=INT;

其中 MASTER_LOG_FILE='',MASTER_LOG_POS='' 的获取方式:
1). 在线建立主从配置，MASTER_LOG_FILE和MASTER_LOG_POS是在 mysqldump 出来的文件里面获取的，例如在mysqldump出来的文件有下面这段命令：
change master to MASTER_LOG_FILE='mysql-bin.00001',MASTER_LOG_POS='11111111';
那么  MASTER_LOG_FILE='mysql-bin.00001',MASTER_LOG_POS='11111111';

2). 不是在线建立主从配置或者: 在主库执行 show master status\G; 即可以获取到 MASTER_LOG_FILE 和 MASTER_LOG_POS
	
----------------------------------------------------------------------------------

再启动start slave;即可


