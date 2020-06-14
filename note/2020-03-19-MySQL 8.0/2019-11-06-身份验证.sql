
error 2059: Authentication plugin 'caching_sha2_password' cannot be loaded: /usr/lib64/mysql/plugin/caching_sha2_password.so: cannot open shared object file: No such file or directory

Last_IO_Error: error connecting to master 'mharpl@192.168.0.101:3306' - retry-time: 60 retries: 1 message: Authentication plugin 'caching_sha2_password' reported error: Authentication requires secure connection.


问题原因：

MySQL 8.0 GA之后默认的认证方式由mysql_native_password改为caching_sha2_password，低版本的MySQL客户端和驱动并不支持这一鉴权方式。
如果你习惯用命令行工具访问数据库升级一下官方的客户端并不麻烦，但如果你使用的是第三方的软件，能否及时与官方保持同步更新就要碰碰运气了。
解决办法：

ALTER USER 'user'@'host' IDENTIFIED WITH mysql_native_password BY 'password';





rm -rf /etc/init.d/mysql
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
/etc/init.d/mysql restart

