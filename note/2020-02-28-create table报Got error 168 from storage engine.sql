
root@mysqldb 08:15:  [db1]> CREATE TABLE `t` (
    ->   `id` int(11) NOT NULL,
    ->   `c` int(11) DEFAULT NULL,
    ->   PRIMARY KEY (`id`)
    -> ) ENGINE=InnoDB;
ERROR 1030 (HY000): Got error 168 from storage engine

[SQL]CREATE TABLE `t_2100` (
  `c1` int(11) DEFAULT NULL,
  `c2` datetime(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
受影响的行: 0
时间: 0.032s



原因：
	[root@mgr9 db1]# lsof | grep delete

	mysqld    23023 29686   mysql  144uW     REG              253,2      98304    4500588 /data/mysql/mysql3306/data/db1/t.ibd (deleted)


	之前有 通过 rm 命令删除过 t.ibd 文件。
	
	


