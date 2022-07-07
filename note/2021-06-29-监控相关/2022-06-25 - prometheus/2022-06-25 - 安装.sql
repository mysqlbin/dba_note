

解压:
tar xf prometheus-2.36.2.linux-amd64.tar.gz -C /usr/local/

重命名：

mv prometheus-2.36.2.linux-amd64 prometheus


/usr/local/prometheus/prometheus --config.file="/usr/local/prometheus/prometheus.yml"

-- nohup /usr/local/prometheus/prometheus --config.file="/usr/local/prometheus/prometheus.yml" &
 
[root@iZbp1co0b2dkojjkbk7r8cZ local]# /usr/local/prometheus/prometheus --config.file="/usr/local/prometheus/prometheus.yml"

ts=2022-06-25T12:38:45.686Z caller=main.go:491 level=info msg="No time or size retention was set so using the default time retention" duration=15d
ts=2022-06-25T12:38:45.686Z caller=main.go:535 level=info msg="Starting Prometheus Server" mode=server version="(version=2.36.2, branch=HEAD, revision=d7e7b8e04b5ecdc1dd153534ba376a622b72741b)"
ts=2022-06-25T12:38:45.686Z caller=main.go:540 level=info build_context="(go=go1.18.3, user=root@f051ce0d6050, date=20220620-13:21:35)"
ts=2022-06-25T12:38:45.686Z caller=main.go:541 level=info host_details="(Linux 3.10.0-862.14.4.el7.x86_64 #1 SMP Wed Sep 26 15:12:11 UTC 2018 x86_64 iZbp1co0b2dkojjkbk7r8cZ (none))"
ts=2022-06-25T12:38:45.686Z caller=main.go:542 level=info fd_limits="(soft=65535, hard=65535)"
ts=2022-06-25T12:38:45.686Z caller=main.go:543 level=info vm_limits="(soft=unlimited, hard=unlimited)"
ts=2022-06-25T12:38:45.687Z caller=web.go:553 level=info component=web msg="Start listening for connections" address=0.0.0.0:9090
ts=2022-06-25T12:38:45.688Z caller=main.go:972 level=info msg="Starting TSDB ..."
ts=2022-06-25T12:38:45.697Z caller=head.go:493 level=info component=tsdb msg="Replaying on-disk memory mappable chunks if any"
ts=2022-06-25T12:38:45.697Z caller=head.go:536 level=info component=tsdb msg="On-disk memory mappable chunks replay completed" duration=5.938µs
ts=2022-06-25T12:38:45.697Z caller=head.go:542 level=info component=tsdb msg="Replaying WAL, this may take a while"
ts=2022-06-25T12:38:45.698Z caller=tls_config.go:195 level=info component=web msg="TLS is disabled." http2=false
ts=2022-06-25T12:38:45.698Z caller=head.go:613 level=info component=tsdb msg="WAL segment loaded" segment=0 maxSegment=0
ts=2022-06-25T12:38:45.698Z caller=head.go:619 level=info component=tsdb msg="WAL replay completed" checkpoint_replay_duration=22.843µs wal_replay_duration=1.219721ms total_replay_duration=1.267489ms
ts=2022-06-25T12:38:45.703Z caller=main.go:993 level=info fs_type=EXT4_SUPER_MAGIC
ts=2022-06-25T12:38:45.703Z caller=main.go:996 level=info msg="TSDB started"
ts=2022-06-25T12:38:45.703Z caller=main.go:1177 level=info msg="Loading configuration file" filename=/usr/local/prometheus/prometheus.yml
ts=2022-06-25T12:38:45.703Z caller=main.go:1214 level=info msg="Completed loading of configuration file" filename=/usr/local/prometheus/prometheus.yml totalDuration=700.54µs db_storage=957ns remote_storage=3.693µs web_handler=456ns query_engine=775ns scrape=322.275µs scrape_sd=29.997µs notify=32.829µs notify_sd=22.002µs rules=4.972µs tracing=18.82µs
ts=2022-06-25T12:38:45.703Z caller=main.go:957 level=info msg="Server is ready to receive web requests."
ts=2022-06-25T12:38:45.704Z caller=manager.go:937 level=info component="rule manager" msg="Starting rule manager..."





http://101.37.253.14:9090/


[root@iZbp1co0b2dkojjkbk7r8cZ ~]# lsof -i:9090
COMMAND     PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
prometheu 32097 root    3u  IPv4 746896      0t0  TCP localhost:39010->localhost:websm (ESTABLISHED)
prometheu 32097 root    7u  IPv6 746718      0t0  TCP *:websm (LISTEN)
prometheu 32097 root   11u  IPv6 746897      0t0  TCP localhost:websm->localhost:39010 (ESTABLISHED)









解压:
tar xf node_exporter-1.3.1.linux-amd64.tar.gz -C /usr/local/

重命名：

mv node_exporter-1.3.1.linux-amd64 node_exporter









create user 'exporter'@'%' identified by 'exporter8866';
grant all privileges on *.* to 'exporter'@'%' with grant option;

[client]
host=101.37.253.14
port=3306
user=exporter
password=exporter8866


nohup /usr/local/mysqld_exporter/mysqld_exporter  --collect.info_schema.processlist --config.my-cnf=/usr/local/mysqld_exporter/.my.cnf &
nohup /usr/local/mysqld_exporter/mysqld_exporter  --config.my-cnf=/usr/local/mysqld_exporter/.my.cnf &


nohup /usr/local/mysqld_exporter/mysqld_exporter  --web.listen-address="101.37.253.14:9104" --collect.info_schema.processlist --config.my-cnf=/usr/local/mysqld_exporter/.my.cnf &



nohup /usr/local/mysqld_exporter/mysqld_exporter  --web.listen-address="101.37.253.14:9105" --collect.info_schema.processlist --config.my-cnf=/usr/local/mysqld_exporter/.my_test.cnf &

nohup /usr/local/mysqld_exporter/mysqld_exporter  --collect.info_schema.processlist --config.my-cnf=/usr/local/mysqld_exporter/.my_test.cnf &



http://101.37.253.14:9104/metrics



nohup /usr/local/grafana/bin/grafana-server &

	Grafana server is running with elevated privileges. This is not recommended
	Grafana-server Init Failed: Could not find config defaults, make sure homepath command line parameter is set or working directory is homepath


nohup ./grafana-server  &


vQBdXBaE3GjpMNzvrotxv44hZ0QxcJ