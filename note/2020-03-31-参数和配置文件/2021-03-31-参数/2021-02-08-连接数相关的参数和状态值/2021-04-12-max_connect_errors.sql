
最大连接错误次数
默认是1000远远是不够的, 可适当加大，防止频繁连接错误后，前端host被mysql拒绝掉.


现象描述：
[root@node12 ~]# telnet 192.168.23.200 3306
Trying 192.168.23.200...
Connected to 192.168.23.200.
Escape character is '^]'.
lHost '192.168.23.200' is blocked because of many connection errors; 
unblock with 'mysqladmin flush-hosts'Connection closed by foreign host.

解决办法:
系统命令行下执行 mysqladmin flush-hosts 或者mysql命令行里执行flush hosts