#!/bin/bash
DIR="$( cd "$( dirname "$0"  )" && pwd  )"
cd $DIR


:<<EOF
1. 安装工具pt-query-digest
2. 授权
create  database monitor_db DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
create user 'slow_monitor'@'%' identified by 'abc123456';
grant insert,delete,update,select on monitor_db.* to 'slow_monitor'@'%' with grant option;
3. 导入 '收集慢日志的2个表.sql' 

EOF



#配置把慢查询解析之后写入数据库的连接地址
monitor_db_host="192.168.0.252"
monitor_db_port=3306
monitor_db_user="slow_monitor"
monitor_db_password="abc123456"
monitor_db_database="monitor_db"

#实例慢日志位置
slowquery_file="/mydata/mysql/mysql3306/data/slow.log"

#pt-query-digest的
pt_query_digest="/usr/bin/pt-query-digest"

#实例连接信息
hostname="192.168.0.252_test_db" # 用于区分实例

#获取上次分析时间，初始化时请删除 last_analysis_time_$hostname文件，可分析全部日志数据
if [ -s last_analysis_time_$hostname ]; then
    last_analysis_time=`cat last_analysis_time_$hostname`
else
    last_analysis_time='1000-01-01 00:00:00'
fi

#收集日志
#RDS需要增加--no-version-check选项
$pt_query_digest \
--user=$monitor_db_user --password=$monitor_db_password --port=$monitor_db_port \
--review h=$monitor_db_host,D=$monitor_db_database,t=mysql_slow_query_review  \
--history h=$monitor_db_host,D=$monitor_db_database,t=mysql_slow_query_review_history  \
--no-report --limit=100% --charset=utf8mb4 \
--since "$last_analysis_time" \
--filter="\$event->{Bytes} = length(\$event->{arg}) and \$event->{hostname}=\"$hostname\"  and \$event->{client}=\$event->{ip} " \
$slowquery_file > /tmp/analysis_slow_query.log

echo `date +"%Y-%m-%d %H:%M:%S"`>last_analysis_time_$hostname
