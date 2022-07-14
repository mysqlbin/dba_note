

2022-07-01：-- 跟发哥对方案
1. 要讲清楚要做的事情，比如要写1个程序、具备实现什么功能
	
2. 时序图

3. 在文档列出mysqld_exporter能采集哪些指标

4. supervisord.conf 管理 .ini 
	


5. http://150.158.224.45/targets
	Prometheus 会自己监控 exporter 进程
	不需要判断进程状态
	
6. 
  http_sd_configs:
  - follow_redirects: true
    refresh_interval: 5m
    url: http://10.105.22.86:9219/	
	
	mysqld_exporter 跟  prometheus 不是部署在同一台机器上
	

7. net.ipv4.ip_local_port_range
	
	
Prometheus通过http_sd_config发现服务


查看进程的运行状态
	(venv4archery) [root@VM-0-110-centos dbops]# supervisorctl status
	archery                          RUNNING   pid 24307, uptime 20:20:53
	celeryworker                     RUNNING   pid 24306, uptime 20:20:53
	qcluster                         RUNNING   pid 24308, uptime 20:20:53

(venv4archery) [root@VM-0-110-centos dbops]# supervisorctl status archery
archery                          RUNNING   pid 24307, uptime 20:58:08


实例ID 对应 PID



cat mysqld_exporter.实例ID.conf
--web.listen-address=[IP]:[PORT] 
IP 怎么获取


$  cat mysqld_exporter.实例ID-端口号.ini
info_schema
[program:实例ID]  # 这个是进程的名字，自定义

directory = /opt/mysqld_exporter

command = /opt/mysqld_exporter/mysqld_exporter --web.listen-address=[IP]:[PORT]  --collect..processlist 
-- 读取整个command命令的内容，然后写入到配置文件中
-- 通过拼接 得到 这条命令：/opt/mysqld_exporter/mysqld_exporter --web.listen-address=[IP]:[PORT]  --collect.info_schema.processlist

autostart = true

startsecs = 5

autorestart = true

startretries = 3

redirect_stderr = true

stdout_logfile_maxbytes = 20MB

stdout_logfile_backups = 20

stdout_logfile = /var/log/supervisor/实例ID.log

environment=DATA_SOURCE_NAME_端口号='user:password@(hostname:3306)/'



---------------------------------------------------------------------------

使用环境变量运行时无需指定配置文件。

export DATA_SOURCE_NAME='user:password@(hostname:3306)/'
./mysqld_exporter <flags>


-- 如何启动？

/usr/bin/supervisord -c /etc/supervisord.conf      	# 启动，建议指定配置文件 
	-- 得到的结果
	





scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
	
	# 静态配置
    static_configs:
      - targets: ["localhost:9090","localhost:9100"]

  - job_name: "mysql_test"
    static_configs:
	  # 
      - targets: ["101.37.253.14:9104"]
		# 实例标签
        labels:
          instance: test_db



启动 peometheus 进程

	nohup /usr/local/prometheus/prometheus --config.file="/usr/local/prometheus/prometheus.yml" &


启动 mysqld_exporter 进程
	nohup /usr/local/mysqld_exporter/mysqld_exporter  --collect.info_schema.processlist --config.my-cnf=/usr/local/mysqld_exporter/.my.cnf &



服务发现



	通过基于文件的服务发现方式下，Prometheus会定时从文件中读取最新的 Target 信息

	通过这种方式，Prometheus会自动的周期性读取文件中的内容。当文件中定义的内容发生变化时，不需要对Prometheus进行任何的重启操作。
	

	prometheus 服务发现


	# 主配置文件

	$ cat prometheus.yml

	...

	  - job_name: 'mysqld_exporter'
		file_sd_configs:
		- files:
		  - '/usr/local/prometheus/sd_cfg/mysqld_exporter.yml'    # 采集文件名
		  refresh_interval: 15s    # 15s重载配置文件
		  
		  


	# 服务发现配置文件

	$ cat /usr/local/prometheus/sd_cfg/mysqld_exporter.yml

	- labels:
		
		instance: test_db
		
	  targets:

	  - [ECS_IP]:[PORT_TEST]



	- labels:

		alias : qa

		depart : "QA"

	  targets:

	  - [ECS_IP]:[PORT_QA]



	- labels:

		alias : pro1

		depart : "PRO"

	  targets:

	  - [ECS_IP]:[PORT_PRO1]



	- labels:

		alias : pro2

		depart : "PRO"

	  targets:

	  - [ECS_IP]:[PORT_PRO2]

	...