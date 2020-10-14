



MySQL服务器的my.cnf配置文件中增加GTID相关的参数

主的配置
1、配置文件需要开启的参数
server-id=3306100
log-bin=/data/mysql/mysql3306/logs/mysql-bin
binlog_format=row
gtid-mode=on
enforce-gtid-consistency=1
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
gtid-mode=on
enforce-gtid-consistency=1
另外建议把这些参数设置上：
max_binlog_size=512M
expire_logs_days=10
然后在Slave上指定MASTER_AUTO_POSITION = 1执行CHANGE MASTER TO即可。比如：
CHANGE MASTER TO MASTER_HOST='node1',MASTER_USER='repl',MASTER_PASSWORD='repl',MASTER_AUTO_POSITION=1;
再启动start slave;即可



master:
mysqldump -uroot -p123456abc --single-transaction --master-data=2 -R -E -A > 0531.sql

grant REPLICATION slave *.* to 'repl_user'@'192.168.23.202' identified by '123456abc';


slave:

提示:
(ERROR 1840 (HY000) at line 24: @@GLOBAL.GTID_PURGED can only be set when @@GLOBAL.GTID_EXECUTED is empty.)
解决办法:
	reset master;   清空gtid信息

mysql -uroot -p < 0531.sql

reset master;


SET @@GLOBAL.GTID_PURGED='6d9e161b-64a6-11e8-9795-080027f9dcec:1-14';
思考：重启后看下复制还生效不。
答：肯定不生效啦。

SET @@GLOBAL.GTID_PURGED='13a4ac40-707c-11e8-97cb-0800276af808:1-7';


change master to master_host='192.168.0.52',master_user='app_user',master_password='123456abc',master_port=3307,master_auto_position=1;

--上面的笔记做得很垃圾。


参考笔记：《2020-10-14-基于GTID在线建从库.sql》

