
1. 
[root@kp04 ~]# cat /sys/block/sda/queue/scheduler
noop deadline [cfq] 
[root@kp04 ~]# 
[root@kp04 ~]# 

2.
[root@kp04 ~]# sysctl -a | grep swappiness
sysctl: reading key "net.ipv6.conf.all.stable_secret"
sysctl: reading key "net.ipv6.conf.default.stable_secret"
sysctl: reading key "net.ipv6.conf.enp0s3.stable_secret"
sysctl: reading key "net.ipv6.conf.lo.stable_secret"
vm.swappiness = 10

3. 
[root@kp04 ~]# sysctl -a | grep dirty_ratio
sysctl: reading key "net.ipv6.conf.all.stable_secret"
sysctl: reading key "net.ipv6.conf.default.stable_secret"
sysctl: reading key "net.ipv6.conf.enp0s3.stable_secret"
sysctl: reading key "net.ipv6.conf.lo.stable_secret"
vm.dirty_ratio = 10
[root@kp04 ~]# 

4. 
[root@kp04 ~]# sysctl -a | grep dirty_background_ratio
sysctl: reading key "net.ipv6.conf.all.stable_secret"
sysctl: reading key "net.ipv6.conf.default.stable_secret"
sysctl: reading key "net.ipv6.conf.enp0s3.stable_secret"
sysctl: reading key "net.ipv6.conf.lo.stable_secret"
vm.dirty_background_ratio = 10


