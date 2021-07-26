

CREATE TABLE `t_20210722` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
`name` varchar(32) not NULL default '',
`age` int(11) not NULL default 0,
`createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
PRIMARY KEY (`id`),
KEY `idx_createTime` (`createTime`)
) ENGINE=InnoDB;

truncate table t_20210722;

mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | SYSTEM |
+---------------+--------+
1 row in set (0.01 sec)


/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=5000000 --concurrency=50 --query='select now()'


[coding001@voice ~]$ top
top - 11:19:41 up 9 days, 20:17,  6 users,  load average: 43.46, 32.76, 19.46
Tasks: 131 total,   2 running, 129 sleeping,   0 stopped,   0 zombie
%Cpu0  : 44.7 us, 43.3 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 12.0 si,  0.0 st
%Cpu1  : 44.9 us, 44.9 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 10.3 si,  0.0 st
%Cpu2  : 45.7 us, 42.3 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 12.0 si,  0.0 st
%Cpu3  : 48.3 us, 40.7 sy,  0.0 ni,  0.3 id,  0.0 wa,  0.0 hi, 10.6 si,  0.0 st
KiB Mem : 16266300 total,  8982532 free,  2392244 used,  4891524 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13453260 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.4g   1.6g  12704 S 266.4 10.1  77:13.22 mysqld                                                                                                                                                                                                   
23113 coding0+  20   0 2466772   2052   1468 S 124.6  0.0   2:07.19 mysqlslap                                                                                                                                                                                                
23232 root      20   0  466188  49968  10656 R   6.0  0.3   0:00.55 yum                                                                                                                                                                                                      
 1052 coding0+  20   0  147768  41760   1404 S   1.0  0.3 577:31.83 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39640   1320 S   1.0  0.2 579:19.39 skynet                    
 
 
 
vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
51  0      0   9238      2   5006    0    0     0     0 4449 66005 45 55  0  0  0
53  0      0   9239      2   5006    0    0     0     0 4561 66000 46 54  0  0  0
52  0      0   9239      2   5006    0    0     0     0 4601 66283 45 55  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4678 66100 46 54  0  0  0
53  0      0   9239      2   5006    0    0     0     0 4795 65506 44 56  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4835 65984 44 56  0  0  0
52  0      0   9239      2   5006    0    0     0     0 4821 67179 45 55  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4806 65777 45 55  0  0  0
41  0      0   9239      2   5006    0    0     0     0 4798 65444 44 55  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4815 65235 45 55  0  0  0
51  0      0   9239      2   5006    0    0     0     0 4804 66225 46 54  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4797 65457 45 55  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4804 65464 45 55  0  0  0
51  0      0   9239      2   5006    0    0     0     0 4797 65226 44 56  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4784 65450 45 55  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4792 64998 46 55  0  0  0
52  0      0   9239      2   5006    0    0     0     0 4818 65232 45 55  0  0  0
50  0      0   9239      2   5006    0    0     0     0 4639 64987 46 54  0  0  0
50  0      0   9239      2   5006    0    0     0    24 4784 64676 45 54  0  0  0
51  0      0   9238      2   5006    0    0     0     0 4862 65497 45 55  0  0  0
53  0      0   9234      2   5006    0    0     0     0 4828 63913 44 56  0  0  0
51  0      0   9230      2   5006    0    0     0     0 4845 64305 46 54  0  0  0
51  0      0   9226      2   5006    0    0     0    16 4896 64050 46 55  0  0  0
53  0      0   9222      2   5006    0    0     0     0 4846 64845 45 55  0  0  0
53  0      0   9221      2   5006    0    0     0     0 4828 63331 47 54  0  0  0
53  0      0   9220      2   5006    0    0     0    68 4855 63963 46 54  0  0  0
52  0      0   9217      2   5006    0    0     0     0 4836 64431 47 53  0  0  0
52  0      0   9199      2   5006    0    0    12     0 4909 64298 45 54  0  0  0
52  0      0   9198      2   5006    0    0     0     0 4869 64789 45 55  0  0  0
51  0      0   9190      2   5006    0    0     0     0 4789 63816 45 55  0  0  0
52  0      0   9190      2   5006    0    0     0     0 4788 64333 46 54  0  0  0
52  0      0   9200      2   5006    0    0     0     0 4841 64197 46 54  1  0  0
51  0      0   9240      2   5006    0    0     0    12 4773 64898 44 56  0  0  0
51  0      0   9240      2   5006    0    0     0     0 4670 65352 44 56  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4726 66114 45 55  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4825 67136 43 57  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4804 68228 45 55  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4791 68521 45 55  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4799 68167 45 55  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4791 67077 45 55  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4808 65759 46 54  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4816 65801 46 55  0  0  0
50  0      0   9240      2   5006    0    0     0     0 4810 66002 44 56  0  0  0
49  0      0   9240      2   5006    0    0     0     0 4789 65284 45 56  0  0  0
51  0      0   9240      2   5006    0    0     0     0 4790 64113 44 56  0  0  0
51  0      0   9240      2   5006    0    0     0     0 4801 64221 44 56  0  0  0
51  0      0   9240      2   5006    0    0     0     0 4797 65612 46 55  0  0  0
51  0      0   9240      2   5006    0    0     0     0 4807 65187 46 54  0  0  0


[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=5000000 --concurrency=50 --query='select now()'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 169.174 seconds
	Minimum number of seconds to run all queries: 169.174 seconds
	Maximum number of seconds to run all queries: 169.174 seconds
	Number of clients running queries: 50
	Average number of queries per client: 100000





--------------------------------------------------------------------------------------------------------------------------------------------

truncate table t_20210722;

mysql> select count(*) from t_20210722;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.00 sec)



set global time_zone="+8:00";


mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | +08:00 |
+---------------+--------+
1 row in set (0.01 sec)


/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=30 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'


[coding001@voice ~]$ top
top - 11:10:07 up 9 days, 20:08,  6 users,  load average: 29.20, 11.01, 5.01
Tasks: 130 total,   3 running, 127 sleeping,   0 stopped,   0 zombie
%Cpu0  : 39.0 us, 49.4 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 11.6 si,  0.0 st
%Cpu1  : 45.2 us, 42.1 sy,  0.0 ni,  0.6 id,  0.0 wa,  0.0 hi, 12.1 si,  0.0 st
%Cpu2  : 42.2 us, 45.0 sy,  0.0 ni,  0.3 id,  0.0 wa,  0.0 hi, 12.5 si,  0.0 st
%Cpu3  : 43.0 us, 44.2 sy,  0.0 ni,  0.3 id,  0.0 wa,  0.0 hi, 12.5 si,  0.0 st
KiB Mem : 16266300 total,  9048588 free,  2354028 used,  4863684 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13491476 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.4g   1.6g  12704 S 264.2 10.1  58:41.41 mysqld                                                                                                                                                                                                   
22673 coding0+  20   0 2466908   2052   1468 S 128.8  0.0   0:44.94 mysqlslap                                                                                                                                                                                                
22764 root      20   0  156800   5312   4012 R   8.9  0.0   0:00.33 sshd                                                                                                                                                                                                     
 1052 coding0+  20   0  147768  41760   1404 S   1.0  0.3 577:20.84 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39640   1320 S   1.0  0.2 579:08.33 skynet                                                                                                                                                                                                   
22636 coding0+  20   0  162104   2328   1600 R   1.0  0.0   0:00.24 top                         


[coding001@voice ~]$ vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
52  0      0   9269      2   4978    0    0     0     4   10    3  0  1 99  0  0
50  0      0   9269      2   4978    0    0     0     0 4856 64341 45 55  0  0  0
51  0      0   9269      2   4978    0    0     0     0 4797 61982 43 57  0  0  0
42  0      0   9269      2   4978    0    0     0     0 4805 62819 44 56  0  0  0
51  0      0   9269      2   4978    0    0     0     0 4834 63298 43 57  0  0  0
50  0      0   9269      2   4978    0    0     0     0 4709 63084 43 57  0  0  0
50  0      0   9269      2   4978    0    0     0     0 4720 63561 43 56  1  0  0
50  0      0   9269      2   4978    0    0     0     0 4827 64479 45 55  0  0  0
51  0      0   9269      2   4978    0    0     0     0 4841 63717 41 58  0  0  0
51  0      0   9269      2   4978    0    0     0     0 4689 63163 44 56  0  0  0
50  0      0   9269      2   4978    0    0     0     0 4529 64316 44 56  0  0  0
51  0      0   9269      2   4978    0    0     0     0 4573 63396 42 58  0  0  0
52  0      0   9269      2   4978    0    0     0     0 4841 64770 44 56  0  0  0
50  0      0   9269      2   4978    0    0     0     0 4836 63829 44 57  0  0  0
50  0      0   9269      2   4978    0    0     0     0 4864 63692 44 56  0  0  0
50  0      0   9269      2   4978    0    0     0   192 4822 63263 42 58  0  0  0
52  0      0   9269      2   4978    0    0     0     0 4854 62260 45 55  0  0  0
52  0      0   9266      2   4978    0    0     0    16 4961 61276 44 56  1  0  0
51  0      0   9265      2   4978    0    0     0     0 4910 63100 42 57  0  0  0
52  0      0   9266      2   4978    0    0     0     0 4681 61779 44 56  1  0  0
51  0      0   9265      2   4978    0    0     0     0 4991 61676 42 59  0  0  0
51  0      0   9265      2   4978    0    0     0     0 4609 62425 44 56  0  0  0
51  0      0   9265      2   4978    0    0     0     0 4805 62789 42 58  0  0  0
51  0      0   9265      2   4978    0    0     0     0 4744 60698 41 59  1  0  0
51  0      0   9266      2   4978    0    0     0     0 4873 61319 43 57  0  0  0
51  0      0   9266      2   4978    0    0     0     0 4840 63220 44 56  0  0  0
54  0      0   9267      2   4978    0    0     0     4 4876 62007 45 55  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4822 63030 44 56  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4951 63423 43 56  1  0  0
50  0      0   9268      2   4978    0    0     0     0 4801 61966 43 57  0  0  0
52  0      0   9268      2   4978    0    0     0     0 4867 63496 43 57  1  0  0
52  0      0   9268      2   4978    0    0     0     0 4821 62611 44 56  0  0  0
51  0      0   9268      2   4978    0    0     0     0 4883 63517 42 58  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4831 62589 43 57  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4819 62913 43 57  0  0  0
52  0      0   9268      2   4978    0    0     0     0 4855 63374 44 56  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4822 63636 43 57  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4788 63205 43 57  0  0  0
53  0      0   9268      2   4978    0    0     0     0 4921 63755 44 56  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4822 63647 43 57  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4805 63192 42 58  0  0  0
53  0      0   9268      2   4978    0    0     0     0 4933 63244 42 57  1  0  0
50  0      0   9268      2   4978    0    0     0     0 4825 63182 44 56  1  0  0
50  0      0   9268      2   4978    0    0     0     0 4885 63170 43 57  0  0  0
50  0      0   9268      2   4978    0    0     0     0 4797 63544 43 57  0  0  0
^C

[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=5000000 --concurrency=50 --query='select now()'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 166.855 seconds
	Minimum number of seconds to run all queries: 166.855 seconds
	Maximum number of seconds to run all queries: 166.855 seconds
	Number of clients running queries: 50
	Average number of queries per client: 100000


[coding001@voice ~]$ sudo perf top -p 20583 > 1.sq
 PerfTop:    9969 irqs/sec  kernel:47.3%  exact:  0.0% lost: 0/0 drop: 0/51364 [4000Hz cpu-clock],  (target_pid: 20583)
-------------------------------------------------------------------------------

     4.87%  [kernel]            [k] finish_task_switch
     4.76%  [kernel]            [k] _raw_spin_unlock_irqrestore
     3.53%  mysqld              [.] MYSQLparse
     3.37%  [kernel]            [k] ipt_do_table
     2.02%  libc-2.17.so        [.] __memmove_ssse3_back
     1.66%  libpthread-2.17.so  [.] __libc_recv
     1.23%  mysqld              [.] dispatch_command
     1.23%  mysqld              [.] my_hash_sort_bin
     1.19%  [kernel]            [k] nf_iterate
     0.93%  mysqld              [.] lex_one_token
     0.85%  [kernel]            [k] __audit_syscall_exit
     0.82%  [kernel]            [k] tcp_ack
     0.82%  mysqld              [.] pfs_start_stage_v1
     0.82%  libpthread-2.17.so  [.] pthread_getspecific
     0.80%  [kernel]            [k] tcp_recvmsg
     0.80%  [vdso]              [.] __vdso_gettimeofday
     0.73%  libpthread-2.17.so  [.] __libc_send
     0.73%  [kernel]            [k] system_call_after_swapgs
     0.72%  [kernel]            [k] fget[coding001@voice ~]$ 
	