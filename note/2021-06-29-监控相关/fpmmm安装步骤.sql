  6.1 安装 fpmmm相关
	shell> yum install php-cli php-process php-mysqli
	shell> cat << _EOF >/etc/php.d/fpmmm.ini
	variables_order = "EGPCS"
	date.timezone = 'Europe/Zurich'
	_EOF
    
  6.2 安装 zabbix 客户端
	shell> yum update
	shell> yum install zabbix-agent zabbix-sender
	
 6.3 配置 fpmmm:
 
	mkdir /etc/fpmmm
	
	把 fpmmm.conf 文件上传到 /etc/fpmmm 目录下
	
	chown -R zabbix: /etc/fpmmm
	
	mkdir /opt/fpmmm
	
	把 fpmmm-1.0.1.tar.gz 文件上传到 /root
	
	tar -zxvf  fpmmm-1.0.1.tar.gz
	
	pwd
	    /root/fpmmm-1.0.1
		
	cp -r * /opt/fpmmm/
	
	chown -R zabbix: /opt/fpmmm
	
	mkdir /tmp/fpmmm
	
	
  6.4 验证
	 /opt/fpmmm/bin/fpmmm --config=/etc/fpmmm/fpmmm.conf
	 