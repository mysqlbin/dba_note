


现象描述：
	[root@node12 ~]# telnet 192.168.23.200 3306
	Trying 192.168.23.200...
	Connected to 192.168.23.200.
	Escape character is '^]'.
	lHost '192.168.23.200' is blocked because of many connection errors; 
	unblock with 'mysqladmin flush-hosts'Connection closed by foreign host.

解决办法:
	系统命令行下执行 mysqladmin flush-hosts 或者mysql命令行里执行flush hosts


参数：
	max_connect_errors 参数是一个MySQL中与安全有关的计数器值，他负责阻止过多尝试失败的客户端以防止暴力破解密码的情况，max_connect_errors的值与性能并无太大关系。
	防止错误连接数过多，暴力破解密码
	让这个IP不能登录，对其他人没影响，不会导致其他的性能问题。
	
小结：
	最大连接错误次数
	默认是1000远远是不够的, 可适当加大，防止频繁连接错误后，前端host被mysql拒绝掉.

	
相关参考
	https://mp.weixin.qq.com/s/RFWtdqgveeqP39-N1KmZ-w   MySQL异常访问的熔断机制

