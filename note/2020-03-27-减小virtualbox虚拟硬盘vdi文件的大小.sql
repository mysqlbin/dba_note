


https://zhangnq.com/1777.html   减小virtualbox虚拟硬盘vdi文件的大小
  
 

[root@mgr9 ~]# dd if=/dev/zero of=/free bs=1M
dd: error writing ‘/free’: No space left on device
39270+0 records in
39269+0 records out
41176678400 bytes (41 GB) copied, 185.905 s, 221 MB/s


[root@mgr9 /]# ll
total 40211624
lrwxrwxrwx.   1 root root           7 Jun 15  2018 bin -> usr/bin
dr-xr-xr-x.   5 root root        4096 Aug  1  2018 boot
drwxr-xr-x.   5 root root          43 Mar 27 01:55 data
drwxr-xr-x   19 root root        3080 Mar 27 09:35 dev
drwxr-xr-x.  85 root root        8192 Mar 24 08:52 etc
-rw-r--r--    1 root root 41176678400 Mar 27 09:39 free
drwxr-xr-x.   3 root root          19 Jun 15  2018 home
lrwxrwxrwx.   1 root root           7 Jun 15  2018 lib -> usr/lib
lrwxrwxrwx.   1 root root           9 Jun 15  2018 lib64 -> usr/lib64
drwxr-xr-x.   2 root root           6 Nov  5  2016 media
drwxr-xr-x.   3 root root          19 Aug 10  2018 mnt
drwxr-xr-x    3 root root          22 Aug 10  2018 nfs_test
drwxr-xr-x.   6 root root          59 Nov 10  2018 opt
dr-xr-xr-x  111 root root           0 Mar 27  2020 proc
dr-xr-x---.  15 root root        4096 Mar 27 01:57 root
drwxr-xr-x   25 root root         800 Mar 27 09:35 run
lrwxrwxrwx.   1 root root           8 Jun 15  2018 sbin -> usr/sbin
drwxr-xr-x.   2 root root           6 Nov  5  2016 srv
dr-xr-xr-x   13 root root           0 Mar 27  2020 sys
drwxrwxrwt.  11 root root         179 Mar 27 09:36 tmp
drwxr-xr-x.  13 root root         155 Jun 15  2018 usr
drwxr-xr-x.  20 root root         278 May  9  2019 var


VBoxManage modifyhd D:\node\mgr9\mgr9.vdi --compact



