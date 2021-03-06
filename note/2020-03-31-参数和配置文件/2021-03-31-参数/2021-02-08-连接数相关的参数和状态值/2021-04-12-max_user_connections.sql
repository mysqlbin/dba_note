


MySQL 同一个用户的最大连接数， 即每个用户只能打开的最大连接数。
测试
set  @@global.max_user_connections=1000;

ERROR 1203 (42000): User app_user already has more than 'max_user_connections' active connections



max_user_connections：限制每个用户的session连接个数，
例如max_user_connections=1 ，那么用户u1只能连接的session数为1，
如果还有用户u2，还是可以连接，这时用户u1和u2连接数分别为1

max_connections ：是对整个服务器的用户限制，整个服务器只能开这么多session，而不考虑用户！

https://www.cnblogs.com/gomysql/p/3834797.html(Too many connections解决方法)


通常控制最大连接数有两个参数控制max_connections（该实例允许最大的连接数 ），
max_user_connections（该实例允许每个用户的最大连接数），
通常情况下前期我们就需要规划好多少连接数合适。一般情况下建议不要超过300。
因为MySQL在连接数上升的情况下性能下降非常厉害，如果需要大量连接，这时可以引入thread_pool。
所以我们需要保持一个原则：系统创建的用户（给应用使用用户）数* max_user_connections  < max_connections。
这样就不会发生文章开始说的问题。

 
 
 show global status like 'max_used_connections';   #当前已使用的数据库连接数
