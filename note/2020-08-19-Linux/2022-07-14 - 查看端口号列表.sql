[root@localhost supervisor]#  netstat -tplugn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 192.168.56.106:64079    0.0.0.0:*               LISTEN      10468/mysqld_export
tcp        0      0 192.168.56.106:63954    0.0.0.0:*               LISTEN      10473/mysqld_export
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      898/sshd
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      1651/master
tcp        0      0 192.168.56.106:65252    0.0.0.0:*               LISTEN      10474/mysqld_export
tcp        0      0 192.168.56.106:9220     0.0.0.0:*               LISTEN      10433/python
tcp6       0      0 :::22                   :::*                    LISTEN      898/sshd
tcp6       0      0 ::1:25                  :::*                    LISTEN      1651/master
udp        0      0 0.0.0.0:54489           0.0.0.0:*                           6430/dhclient
udp        0      0 0.0.0.0:68              0.0.0.0:*                           6430/dhclient
udp6       0      0 :::39096                :::*                                6430/dhclient
IPv6/IPv4 Group Memberships
Interface       RefCnt Group
--------------- ------ ---------------------
lo              1      224.0.0.1
enp0s3          1      224.0.0.1
enp0s8          1      224.0.0.1
enp0s9          1      224.0.0.1
lo              1      ff02::1
lo              1      ff01::1
enp0s3          1      ff02::1:ff6c:3e95
enp0s3          1      ff02::1
enp0s3          1      ff01::1
enp0s8          1      ff02::1:ff0d:b4
enp0s8          1      ff02::1
enp0s8          1      ff01::1
enp0s9          1      ff02::1
enp0s9          1      ff01::1
