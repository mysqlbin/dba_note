


https://blog.csdn.net/saga_gallon/article/details/82770222  sysbench 1.0 下载安装
https://blog.51cto.com/bilibili/2173243?source=dra 

下载地址
wget https://github.com/akopytov/sysbench/archive/1.0.zip

安装
* 基本步骤
yum -y install  make automake libtool pkgconfig libaio-devel vim-common


./configure --with-mysql-includes=/usr/local/mysql/include --with-mysql-libs=/usr/local/mysql/lib && make && make install


[root@kp04 sysbench-1.0]# sysbench --version
sysbench 1.0.20



测试
1、 建测试表及数据：
线程，数据表大小及数量及其他参数按需求修改即可

set global sync_binlog=10000;
set global innodb_flush_log_at_trx_commit=2;
sysbench /usr/local/share/sysbench/oltp_read_write.lua --mysql-host=192.168.0.91 --mysql-port=3306 --mysql-user=root --mysql-password=123456abc --mysql-db=sbtest --table-size=1000000 --tables=1 --threads=2 prepare





set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;


