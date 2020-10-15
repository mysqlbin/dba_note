开启 GTID 的参数:
MySQL实例开启GTID模式：
gtid-mode = on
执行GTID一致性（使用GTID模式复制时，需要开启此参数，用来保证GTID一致性）：
enforce-gtid-consistency=1



效果:
每一个事务在集群中具有了唯一性的意义

作用:
	GTID带来最方便的作用就是搭建和维护一主多从复制.


生命周期:
生命周期就是指一个对象的生老病死


master:
reset master; 清除binlog，表示重新记录日志（日志名从01开始）


slave:
reset slave; 表示 把Retrieved_Gtid_Set清空
reset slave all; 表示删除从库的复制操作
reset master; 
清空GTID信息, 即重置gitd_executed和清除binlog


日常维护:
1032
1062
1236
