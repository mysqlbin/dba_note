




centOS 在线安装，此时版本 19.17.2 revision 5442
	-- 添加官方存储库
		sudo yum install yum-utils
		sudo rpm --import https://repo.yandex.ru/clickhouse/CLICKHOUSE-KEY.GPG
		sudo yum-config-manager --add-repo https://repo.yandex.ru/clickhouse/rpm/stable/x86_64

	-- 安装稳定版本
		sudo yum install clickhouse-server clickhouse-client

	-- 服务启动
		/etc/init.d/clickhouse-server start
	
	-- 服务重启
		/etc/init.d/clickhouse-server restart
		
		
		

clickhouse-client -h 192.168.0.242 --port 9000  -u default --password "123456abc"
shell> clickhouse-client -h 192.168.0.242 --port 9000  -u default --password "123456abc"
ClickHouse client version 21.11.4.14 (official build).
Connecting to 192.168.0.242:9000 as user default.
Connected to ClickHouse server version 21.11.4 revision 54450.

localhost.localdomain :) 

