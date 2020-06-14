


root@localhost [(none)]>drop database zst;
ERROR 1010 (HY000): Error dropping database (can't rmdir './zst/', errno: 17)
root@localhost [(none)]>show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| zst                |
+--------------------+
5 rows in set (0.00 sec)



[root@env zst]# ll
total 952
-rw-r--r-- 1 root root 485385 Oct 25 19:58 mytest01.txt
-rw-r--r-- 1 root root 485385 Oct 25 18:25 mytest.txt
[root@env zst]# rm -rf *
[root@env zst]# ll
total 0





root@localhost [(none)]>drop database zst;
Query OK, 0 rows affected (0.00 sec)

root@localhost [(none)]>show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

