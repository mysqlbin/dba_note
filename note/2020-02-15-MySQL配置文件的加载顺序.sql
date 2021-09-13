



了解一下mysql配置文件的加载顺序：

$ mysqld --help --verbose|grep -A1 -B1 cnf
Default options are read from the following files in the given order:
/etc/my.cnf  
/etc/mysql/my.cnf 
/usr/etc/my.cnf 
~/.my.cnf
mysql按照上面的顺序加载配置文件，后面的配置项会覆盖前面的。

