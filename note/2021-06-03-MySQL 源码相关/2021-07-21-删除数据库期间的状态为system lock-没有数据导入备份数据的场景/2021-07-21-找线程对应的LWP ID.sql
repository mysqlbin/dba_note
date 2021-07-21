

show processlist;
select * from performance_schema.threads;
select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
pstack $(pgrep -xn mysqld) > 1.sql



root@mysqldb 15:15:  [(none)]> show processlist;
+-----+----------+-----------------------+-------------+---------+-------+-------------+----------------------+
| Id  | User     | Host                  | db          | Command | Time  | State       | Info                 |
+-----+----------+-----------------------+-------------+---------+-------+-------------+----------------------+
|  27 | root     | localhost             | NULL        | Query   |     0 | starting    | show processlist     |
|  31 | dpc_user | h_tt_aaa.com.cn:49766 | niuniuh5_db | Sleep   | 17915 |             | NULL                 |
|  33 | dpc_user | 192.168.0.204:60104   | niuniuh5_db | Sleep   |  2939 |             | NULL                 |
|  34 | dpc_user | 192.168.0.204:60106   | niuniuh5_db | Sleep   |  2939 |             | NULL                 |
| 133 | root     | 192.168.0.220:54072   | NULL        | Sleep   |  1195 |             | NULL                 |
| 134 | root     | 192.168.0.220:54081   | NULL        | Sleep   |  1343 |             | NULL                 |
| 135 | root     | 192.168.0.220:54083   | NULL        | Sleep   |  1232 |             | NULL                 |
| 136 | root     | 192.168.0.220:54086   | niuniuh5_db | Sleep   |  1268 |             | NULL                 |
| 234 | root     | 192.168.0.220:54099   | niuniuh5_db | Sleep   |  1154 |             | NULL                 |
| 236 | dpc_user | 192.168.0.243:56966   | niuniuh5_db | Sleep   |   177 |             | NULL                 |
| 237 | dpc_user | 192.168.0.243:56968   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 238 | dpc_user | 192.168.0.243:56970   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 239 | dpc_user | 192.168.0.243:56972   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 240 | dpc_user | 192.168.0.243:56974   | niuniuh5_db | Sleep   |   266 |             | NULL                 |
| 241 | dpc_user | 192.168.0.243:56976   | niuniuh5_db | Sleep   |   258 |             | NULL                 |
| 242 | dpc_user | 192.168.0.243:56978   | niuniuh5_db | Sleep   |   217 |             | NULL                 |
| 243 | dpc_user | 192.168.0.243:56980   | niuniuh5_db | Sleep   |    97 |             | NULL                 |
| 244 | dpc_user | 192.168.0.243:56982   | niuniuh5_db | Sleep   |    37 |             | NULL                 |
| 245 | dpc_user | 192.168.0.243:56984   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 246 | dpc_user | 192.168.0.243:56986   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 247 | dpc_user | 192.168.0.243:56988   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 248 | dpc_user | 192.168.0.243:56990   | niuniuh5_db | Sleep   |   277 |             | NULL                 |
| 249 | dpc_user | 192.168.0.243:56992   | niuniuh5_db | Sleep   |   217 |             | NULL                 |
| 250 | dpc_user | 192.168.0.243:56994   | niuniuh5_db | Sleep   |   157 |             | NULL                 |
| 251 | dpc_user | 192.168.0.243:56996   | niuniuh5_db | Sleep   |    97 |             | NULL                 |
| 252 | dpc_user | 192.168.0.243:56998   | niuniuh5_db | Sleep   |    37 |             | NULL                 |
| 253 | dpc_user | 192.168.0.243:57000   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 254 | dpc_user | 192.168.0.243:57002   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 255 | dpc_user | 192.168.0.243:57004   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 256 | dpc_user | 192.168.0.243:57020   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 257 | dpc_user | 192.168.0.243:57022   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 258 | dpc_user | 192.168.0.243:57024   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 259 | dpc_user | 192.168.0.243:57026   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 260 | dpc_user | 192.168.0.243:57028   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 261 | dpc_user | 192.168.0.243:57030   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 262 | dpc_user | 192.168.0.243:57032   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 263 | dpc_user | 192.168.0.243:57034   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 264 | dpc_user | 192.168.0.243:57036   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 265 | dpc_user | 192.168.0.243:57038   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 266 | dpc_user | 192.168.0.243:57040   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 267 | dpc_user | 192.168.0.243:57042   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 268 | dpc_user | 192.168.0.243:57044   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 269 | dpc_user | 192.168.0.243:57046   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 270 | dpc_user | 192.168.0.243:57048   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 271 | dpc_user | 192.168.0.243:57050   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 272 | dpc_user | 192.168.0.243:57052   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 273 | dpc_user | 192.168.0.243:57054   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 274 | dpc_user | 192.168.0.243:57056   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 275 | dpc_user | 192.168.0.243:57058   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 276 | dpc_user | 192.168.0.243:57060   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 277 | dpc_user | 192.168.0.243:57062   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 278 | dpc_user | 192.168.0.243:57064   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 279 | dpc_user | 192.168.0.243:57066   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 280 | dpc_user | 192.168.0.243:57068   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 281 | dpc_user | 192.168.0.243:57070   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 282 | dpc_user | 192.168.0.243:57072   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 283 | dpc_user | 192.168.0.243:57074   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 284 | dpc_user | 192.168.0.243:57076   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 285 | dpc_user | 192.168.0.243:57078   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 286 | dpc_user | 192.168.0.243:57080   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 287 | dpc_user | 192.168.0.243:57082   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 288 | dpc_user | 192.168.0.243:57084   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 289 | dpc_user | 192.168.0.243:57086   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 290 | dpc_user | 192.168.0.243:57088   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 291 | dpc_user | 192.168.0.243:57090   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 292 | dpc_user | 192.168.0.243:57092   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 293 | dpc_user | 192.168.0.243:57094   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 294 | dpc_user | 192.168.0.243:57096   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 295 | dpc_user | 192.168.0.243:57098   | niuniuh5_db | Sleep   |   337 |             | NULL                 |
| 296 | dpc_user | 192.168.0.243:57108   | niuniuh5_db | Sleep   |   336 |             | NULL                 |
| 297 | dpc_user | 192.168.0.243:57110   | niuniuh5_db | Sleep   |   336 |             | NULL                 |
| 298 | dpc_user | 192.168.0.243:57116   | niuniuh5_db | Sleep   |   336 |             | NULL                 |
| 299 | dpc_user | 192.168.0.243:57118   | niuniuh5_db | Sleep   |   336 |             | NULL                 |
| 300 | dpc_user | 192.168.0.243:57128   | niuniuh5_db | Sleep   |   335 |             | NULL                 |
| 301 | dpc_user | 192.168.0.243:57130   | niuniuh5_db | Sleep   |   335 |             | NULL                 |
| 302 | dpc_user | 192.168.0.243:57132   | niuniuh5_db | Sleep   |   335 |             | NULL                 |
| 303 | dpc_user | 192.168.0.243:57134   | niuniuh5_db | Sleep   |   335 |             | NULL                 |
| 304 | dpc_user | 192.168.0.243:57136   | niuniuh5_db | Sleep   |   335 |             | NULL                 |
| 305 | dpc_user | 192.168.0.243:57138   | niuniuh5_db | Sleep   |   335 |             | NULL                 |
| 306 | dpc_user | 192.168.0.243:57140   | niuniuh5_db | Sleep   |   335 |             | NULL                 |
| 307 | dpc_user | 192.168.0.243:57142   | niuniuh5_db | Sleep   |   335 |             | NULL                 |
| 308 | dpc_user | 192.168.0.243:57158   | niuniuh5_db | Sleep   |   177 |             | NULL                 |
| 309 | dpc_user | 192.168.0.243:57160   | niuniuh5_db | Sleep   |   194 |             | NULL                 |
| 310 | dpc_user | 192.168.0.243:57162   | niuniuh5_db | Sleep   |   192 |             | NULL                 |
| 311 | dpc_user | 192.168.0.243:57164   | niuniuh5_db | Sleep   |   190 |             | NULL                 |
| 312 | dpc_user | 192.168.0.243:57166   | niuniuh5_db | Sleep   |   186 |             | NULL                 |
| 313 | dpc_user | 192.168.0.243:57168   | niuniuh5_db | Sleep   |   194 |             | NULL                 |
| 314 | dpc_user | 192.168.0.243:57170   | niuniuh5_db | Sleep   |   267 |             | NULL                 |
| 315 | dpc_user | 192.168.0.243:57172   | niuniuh5_db | Sleep   |   267 |             | NULL                 |
| 316 | dpc_user | 192.168.0.243:57186   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 317 | dpc_user | 192.168.0.243:57188   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 318 | dpc_user | 192.168.0.243:57190   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 319 | dpc_user | 192.168.0.243:57192   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 320 | dpc_user | 192.168.0.243:57194   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 321 | dpc_user | 192.168.0.243:57196   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 322 | dpc_user | 192.168.0.243:57198   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 323 | dpc_user | 192.168.0.243:57200   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 324 | dpc_user | 192.168.0.243:57214   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 325 | dpc_user | 192.168.0.243:57216   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 326 | dpc_user | 192.168.0.243:57218   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 327 | dpc_user | 192.168.0.243:57220   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 328 | dpc_user | 192.168.0.243:57222   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 329 | dpc_user | 192.168.0.243:57224   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 330 | dpc_user | 192.168.0.243:57226   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 331 | dpc_user | 192.168.0.243:57228   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
| 333 | root     | localhost             | NULL        | Query   |     5 | System lock | drop database sbtest |
+-----+----------+-----------------------+-------------+---------+-------+-------------+----------------------+
106 rows in set (0.00 sec)

root@mysqldb 15:17:  [(none)]> select * from performance_schema.threads;
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+-------------------+------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
| THREAD_ID | NAME                                   | TYPE       | PROCESSLIST_ID | PROCESSLIST_USER | PROCESSLIST_HOST | PROCESSLIST_DB | PROCESSLIST_COMMAND | PROCESSLIST_TIME | PROCESSLIST_STATE | PROCESSLIST_INFO                         | PARENT_THREAD_ID | ROLE | INSTRUMENTED | HISTORY | CONNECTION_TYPE | THREAD_OS_ID |
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+-------------------+------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
|         1 | thread/sql/main                        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |           532139 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12496 |
|         2 | thread/sql/thread_timer_notifier       | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |                1 | NULL | YES          | YES     | NULL            |        12497 |
|         3 | thread/innodb/io_ibuf_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12498 |
|         4 | thread/innodb/io_log_thread            | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12499 |
|         5 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12501 |
|         6 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12500 |
|         7 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12502 |
|         8 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12503 |
|         9 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12504 |
|        10 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12505 |
|        11 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12506 |
|        12 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12507 |
|        13 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12509 |
|        14 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12508 |
|        15 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12510 |
|        16 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12511 |
|        17 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12512 |
|        18 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12513 |
|        19 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12514 |
|        20 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12515 |
|        21 | thread/innodb/page_cleaner_thread      | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12516 |
|        23 | thread/innodb/srv_lock_timeout_thread  | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12521 |
|        24 | thread/innodb/srv_monitor_thread       | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12523 |
|        25 | thread/innodb/srv_error_monitor_thread | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12522 |
|        26 | thread/innodb/srv_master_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12524 |
|        27 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12527 |
|        28 | thread/innodb/srv_purge_thread         | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12525 |
|        29 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12528 |
|        30 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12526 |
|        31 | thread/innodb/buf_dump_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12531 |
|        32 | thread/innodb/dict_stats_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        12532 |
|        33 | thread/sql/signal_handler              | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                     |                1 | NULL | YES          | YES     | NULL            |        12537 |
|        34 | thread/sql/compress_gtid_table         | FOREGROUND |              1 | NULL             | NULL             | NULL           | Daemon              |           532139 | Suspending        | NULL                                     |                1 | NULL | YES          | YES     | NULL            |        12538 |
|       267 | thread/sql/one_connection              | FOREGROUND |            234 | root             | 192.168.0.220    | niuniuh5_db    | Sleep               |             1154 | NULL              | NULL                                     |                1 | NULL | YES          | YES     | TCP/IP          |        32750 |
|       269 | thread/sql/one_connection              | FOREGROUND |            236 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              177 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32361 |
|       270 | thread/sql/one_connection              | FOREGROUND |            237 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32372 |
|       271 | thread/sql/one_connection              | FOREGROUND |            238 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        13506 |
|       272 | thread/sql/one_connection              | FOREGROUND |            239 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32382 |
|       273 | thread/sql/one_connection              | FOREGROUND |            240 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              266 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32369 |
|       274 | thread/sql/one_connection              | FOREGROUND |            241 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              258 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32368 |
|       275 | thread/sql/one_connection              | FOREGROUND |            242 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              217 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32373 |
|       276 | thread/sql/one_connection              | FOREGROUND |            243 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |               97 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32366 |
|       277 | thread/sql/one_connection              | FOREGROUND |            244 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |               37 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32356 |
|       278 | thread/sql/one_connection              | FOREGROUND |            245 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32363 |
|       279 | thread/sql/one_connection              | FOREGROUND |            246 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32362 |
|       280 | thread/sql/one_connection              | FOREGROUND |            247 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        13505 |
|       281 | thread/sql/one_connection              | FOREGROUND |            248 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              277 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32359 |
|       282 | thread/sql/one_connection              | FOREGROUND |            249 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              217 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32364 |
|        60 | thread/sql/one_connection              | FOREGROUND |             27 | root             | localhost        | NULL           | Query               |                0 | Sending data      | select * from performance_schema.threads |             NULL | NULL | YES          | YES     | Socket          |        13978 |
|       283 | thread/sql/one_connection              | FOREGROUND |            250 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              157 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32357 |
|       284 | thread/sql/one_connection              | FOREGROUND |            251 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |               97 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32365 |
|       285 | thread/sql/one_connection              | FOREGROUND |            252 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |               37 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32360 |
|        64 | thread/sql/one_connection              | FOREGROUND |             31 | dpc_user         | h_tt_aaa.com.cn  | niuniuh5_db    | Sleep               |            17915 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        24842 |
|       286 | thread/sql/one_connection              | FOREGROUND |            253 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32371 |
|        66 | thread/sql/one_connection              | FOREGROUND |             33 | dpc_user         | 192.168.0.204    | niuniuh5_db    | Sleep               |             2939 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        13507 |
|        67 | thread/sql/one_connection              | FOREGROUND |             34 | dpc_user         | 192.168.0.204    | niuniuh5_db    | Sleep               |             2939 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        12541 |
|       287 | thread/sql/one_connection              | FOREGROUND |            254 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32370 |
|       288 | thread/sql/one_connection              | FOREGROUND |            255 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32398 |
|       289 | thread/sql/one_connection              | FOREGROUND |            256 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32395 |
|       290 | thread/sql/one_connection              | FOREGROUND |            257 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32412 |
|       291 | thread/sql/one_connection              | FOREGROUND |            258 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32396 |
|       292 | thread/sql/one_connection              | FOREGROUND |            259 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32416 |
|       293 | thread/sql/one_connection              | FOREGROUND |            260 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32381 |
|       294 | thread/sql/one_connection              | FOREGROUND |            261 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32386 |
|       295 | thread/sql/one_connection              | FOREGROUND |            262 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32399 |
|       296 | thread/sql/one_connection              | FOREGROUND |            263 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32402 |
|       297 | thread/sql/one_connection              | FOREGROUND |            264 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32403 |
|       298 | thread/sql/one_connection              | FOREGROUND |            265 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32390 |
|       299 | thread/sql/one_connection              | FOREGROUND |            266 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32394 |
|       300 | thread/sql/one_connection              | FOREGROUND |            267 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32379 |
|       301 | thread/sql/one_connection              | FOREGROUND |            268 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32414 |
|       302 | thread/sql/one_connection              | FOREGROUND |            269 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32388 |
|       303 | thread/sql/one_connection              | FOREGROUND |            270 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32380 |
|       304 | thread/sql/one_connection              | FOREGROUND |            271 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32406 |
|       305 | thread/sql/one_connection              | FOREGROUND |            272 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32423 |
|       306 | thread/sql/one_connection              | FOREGROUND |            273 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32385 |
|       307 | thread/sql/one_connection              | FOREGROUND |            274 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32417 |
|       308 | thread/sql/one_connection              | FOREGROUND |            275 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32418 |
|       309 | thread/sql/one_connection              | FOREGROUND |            276 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32393 |
|       310 | thread/sql/one_connection              | FOREGROUND |            277 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32415 |
|       311 | thread/sql/one_connection              | FOREGROUND |            278 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32397 |
|       312 | thread/sql/one_connection              | FOREGROUND |            279 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32401 |
|       313 | thread/sql/one_connection              | FOREGROUND |            280 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32387 |
|       314 | thread/sql/one_connection              | FOREGROUND |            281 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32389 |
|       315 | thread/sql/one_connection              | FOREGROUND |            282 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32391 |
|       316 | thread/sql/one_connection              | FOREGROUND |            283 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32407 |
|       317 | thread/sql/one_connection              | FOREGROUND |            284 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32383 |
|       318 | thread/sql/one_connection              | FOREGROUND |            285 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32400 |
|       319 | thread/sql/one_connection              | FOREGROUND |            286 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32384 |
|       320 | thread/sql/one_connection              | FOREGROUND |            287 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32409 |
|       321 | thread/sql/one_connection              | FOREGROUND |            288 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32413 |
|       322 | thread/sql/one_connection              | FOREGROUND |            289 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32410 |
|       323 | thread/sql/one_connection              | FOREGROUND |            290 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32404 |
|       324 | thread/sql/one_connection              | FOREGROUND |            291 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32411 |
|       325 | thread/sql/one_connection              | FOREGROUND |            292 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32392 |
|       326 | thread/sql/one_connection              | FOREGROUND |            293 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32405 |
|       327 | thread/sql/one_connection              | FOREGROUND |            294 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32408 |
|       328 | thread/sql/one_connection              | FOREGROUND |            295 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              337 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32427 |
|       329 | thread/sql/one_connection              | FOREGROUND |            296 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              336 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32428 |
|       330 | thread/sql/one_connection              | FOREGROUND |            297 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              336 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32422 |
|       331 | thread/sql/one_connection              | FOREGROUND |            298 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              336 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32426 |
|       332 | thread/sql/one_connection              | FOREGROUND |            299 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              336 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32431 |
|       333 | thread/sql/one_connection              | FOREGROUND |            300 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              335 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32435 |
|       334 | thread/sql/one_connection              | FOREGROUND |            301 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              335 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32442 |
|       335 | thread/sql/one_connection              | FOREGROUND |            302 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              335 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32430 |
|       336 | thread/sql/one_connection              | FOREGROUND |            303 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              335 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32429 |
|       337 | thread/sql/one_connection              | FOREGROUND |            304 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              335 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32433 |
|       338 | thread/sql/one_connection              | FOREGROUND |            305 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              335 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32434 |
|       339 | thread/sql/one_connection              | FOREGROUND |            306 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              335 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32432 |
|       340 | thread/sql/one_connection              | FOREGROUND |            307 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              335 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32441 |
|       341 | thread/sql/one_connection              | FOREGROUND |            308 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              177 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32450 |
|       342 | thread/sql/one_connection              | FOREGROUND |            309 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              194 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32445 |
|       343 | thread/sql/one_connection              | FOREGROUND |            310 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              192 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32444 |
|       344 | thread/sql/one_connection              | FOREGROUND |            311 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              190 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32440 |
|       345 | thread/sql/one_connection              | FOREGROUND |            312 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              186 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32439 |
|       346 | thread/sql/one_connection              | FOREGROUND |            313 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              194 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32443 |
|       347 | thread/sql/one_connection              | FOREGROUND |            314 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              267 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32446 |
|       348 | thread/sql/one_connection              | FOREGROUND |            315 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              267 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32453 |
|       349 | thread/sql/one_connection              | FOREGROUND |            316 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32456 |
|       350 | thread/sql/one_connection              | FOREGROUND |            317 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32454 |
|       351 | thread/sql/one_connection              | FOREGROUND |            318 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32451 |
|       352 | thread/sql/one_connection              | FOREGROUND |            319 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32464 |
|       353 | thread/sql/one_connection              | FOREGROUND |            320 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32455 |
|       354 | thread/sql/one_connection              | FOREGROUND |            321 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32452 |
|       355 | thread/sql/one_connection              | FOREGROUND |            322 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32457 |
|       356 | thread/sql/one_connection              | FOREGROUND |            323 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32461 |
|       357 | thread/sql/one_connection              | FOREGROUND |            324 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32358 |
|       358 | thread/sql/one_connection              | FOREGROUND |            325 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32463 |
|       359 | thread/sql/one_connection              | FOREGROUND |            326 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32467 |
|       360 | thread/sql/one_connection              | FOREGROUND |            327 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32468 |
|       361 | thread/sql/one_connection              | FOREGROUND |            328 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32462 |
|       362 | thread/sql/one_connection              | FOREGROUND |            329 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32465 |
|       363 | thread/sql/one_connection              | FOREGROUND |            330 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32466 |
|       364 | thread/sql/one_connection              | FOREGROUND |            331 | dpc_user         | 192.168.0.243    | niuniuh5_db    | Sleep               |              334 | NULL              | NULL                                     |             NULL | NULL | YES          | YES     | TCP/IP          |        32367 |
|       366 | thread/sql/one_connection              | FOREGROUND |            333 | root             | localhost        | NULL           | Query               |                5 | System lock       | drop database sbtest                     |             NULL | NULL | YES          | YES     | Socket          |          846 |
|       166 | thread/sql/one_connection              | FOREGROUND |            133 | root             | 192.168.0.220    | NULL           | Sleep               |             1195 | NULL              | NULL                                     |                1 | NULL | YES          | YES     | TCP/IP          |        32594 |
|       167 | thread/sql/one_connection              | FOREGROUND |            134 | root             | 192.168.0.220    | NULL           | Sleep               |             1343 | NULL              | NULL                                     |                1 | NULL | YES          | YES     | TCP/IP          |        32635 |
|       168 | thread/sql/one_connection              | FOREGROUND |            135 | root             | 192.168.0.220    | NULL           | Sleep               |             1232 | NULL              | NULL                                     |                1 | NULL | YES          | YES     | TCP/IP          |        32636 |
|       169 | thread/sql/one_connection              | FOREGROUND |            136 | root             | 192.168.0.220    | niuniuh5_db    | Sleep               |             1268 | NULL              | NULL                                     |                1 | NULL | YES          | YES     | TCP/IP          |        32659 |
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+-------------------+------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
139 rows in set (0.00 sec)

root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
+--------+--------------+---------------------------------+------------+
| thd_id | THREAD_OS_ID | user                            | TYPE       |
+--------+--------------+---------------------------------+------------+
|      1 |        12496 | sql/main                        | BACKGROUND |
|      2 |        12497 | sql/thread_timer_notifier       | BACKGROUND |
|      3 |        12498 | innodb/io_ibuf_thread           | BACKGROUND |
|      4 |        12499 | innodb/io_log_thread            | BACKGROUND |
|      5 |        12501 | innodb/io_read_thread           | BACKGROUND |
|      6 |        12500 | innodb/io_read_thread           | BACKGROUND |
|      7 |        12502 | innodb/io_read_thread           | BACKGROUND |
|      8 |        12503 | innodb/io_read_thread           | BACKGROUND |
|      9 |        12504 | innodb/io_read_thread           | BACKGROUND |
|     10 |        12505 | innodb/io_read_thread           | BACKGROUND |
|     11 |        12506 | innodb/io_read_thread           | BACKGROUND |
|     12 |        12507 | innodb/io_read_thread           | BACKGROUND |
|     13 |        12509 | innodb/io_write_thread          | BACKGROUND |
|     14 |        12508 | innodb/io_write_thread          | BACKGROUND |
|     15 |        12510 | innodb/io_write_thread          | BACKGROUND |
|     16 |        12511 | innodb/io_write_thread          | BACKGROUND |
|     17 |        12512 | innodb/io_write_thread          | BACKGROUND |
|     18 |        12513 | innodb/io_write_thread          | BACKGROUND |
|     19 |        12514 | innodb/io_write_thread          | BACKGROUND |
|     20 |        12515 | innodb/io_write_thread          | BACKGROUND |
|     21 |        12516 | innodb/page_cleaner_thread      | BACKGROUND |
|     23 |        12521 | innodb/srv_lock_timeout_thread  | BACKGROUND |
|     24 |        12523 | innodb/srv_monitor_thread       | BACKGROUND |
|     25 |        12522 | innodb/srv_error_monitor_thread | BACKGROUND |
|     26 |        12524 | innodb/srv_master_thread        | BACKGROUND |
|     27 |        12527 | innodb/srv_worker_thread        | BACKGROUND |
|     28 |        12525 | innodb/srv_purge_thread         | BACKGROUND |
|     29 |        12528 | innodb/srv_worker_thread        | BACKGROUND |
|     30 |        12526 | innodb/srv_worker_thread        | BACKGROUND |
|     31 |        12531 | innodb/buf_dump_thread          | BACKGROUND |
|     32 |        12532 | innodb/dict_stats_thread        | BACKGROUND |
|     33 |        12537 | sql/signal_handler              | BACKGROUND |
|     34 |        12538 | sql/compress_gtid_table         | FOREGROUND |
|    267 |        32750 | root@192.168.0.220              | FOREGROUND |
|    269 |        32361 | dpc_user@192.168.0.243          | FOREGROUND |
|    270 |        32372 | dpc_user@192.168.0.243          | FOREGROUND |
|    271 |        13506 | dpc_user@192.168.0.243          | FOREGROUND |
|    272 |        32382 | dpc_user@192.168.0.243          | FOREGROUND |
|    273 |        32369 | dpc_user@192.168.0.243          | FOREGROUND |
|    274 |        32368 | dpc_user@192.168.0.243          | FOREGROUND |
|    275 |        32373 | dpc_user@192.168.0.243          | FOREGROUND |
|    276 |        32366 | dpc_user@192.168.0.243          | FOREGROUND |
|    277 |        32356 | dpc_user@192.168.0.243          | FOREGROUND |
|    278 |        32363 | dpc_user@192.168.0.243          | FOREGROUND |
|    279 |        32362 | dpc_user@192.168.0.243          | FOREGROUND |
|    280 |        13505 | dpc_user@192.168.0.243          | FOREGROUND |
|    281 |        32359 | dpc_user@192.168.0.243          | FOREGROUND |
|    282 |        32364 | dpc_user@192.168.0.243          | FOREGROUND |
|     60 |        13978 | root@localhost                  | FOREGROUND |
|    283 |        32357 | dpc_user@192.168.0.243          | FOREGROUND |
|    284 |        32365 | dpc_user@192.168.0.243          | FOREGROUND |
|    285 |        32360 | dpc_user@192.168.0.243          | FOREGROUND |
|     64 |        24842 | dpc_user@h_tt_aaa.com.cn        | FOREGROUND |
|    286 |        32371 | dpc_user@192.168.0.243          | FOREGROUND |
|     66 |        13507 | dpc_user@192.168.0.204          | FOREGROUND |
|     67 |        12541 | dpc_user@192.168.0.204          | FOREGROUND |
|    287 |        32370 | dpc_user@192.168.0.243          | FOREGROUND |
|    288 |        32398 | dpc_user@192.168.0.243          | FOREGROUND |
|    289 |        32395 | dpc_user@192.168.0.243          | FOREGROUND |
|    290 |        32412 | dpc_user@192.168.0.243          | FOREGROUND |
|    291 |        32396 | dpc_user@192.168.0.243          | FOREGROUND |
|    292 |        32416 | dpc_user@192.168.0.243          | FOREGROUND |
|    293 |        32381 | dpc_user@192.168.0.243          | FOREGROUND |
|    294 |        32386 | dpc_user@192.168.0.243          | FOREGROUND |
|    295 |        32399 | dpc_user@192.168.0.243          | FOREGROUND |
|    296 |        32402 | dpc_user@192.168.0.243          | FOREGROUND |
|    297 |        32403 | dpc_user@192.168.0.243          | FOREGROUND |
|    298 |        32390 | dpc_user@192.168.0.243          | FOREGROUND |
|    299 |        32394 | dpc_user@192.168.0.243          | FOREGROUND |
|    300 |        32379 | dpc_user@192.168.0.243          | FOREGROUND |
|    301 |        32414 | dpc_user@192.168.0.243          | FOREGROUND |
|    302 |        32388 | dpc_user@192.168.0.243          | FOREGROUND |
|    303 |        32380 | dpc_user@192.168.0.243          | FOREGROUND |
|    304 |        32406 | dpc_user@192.168.0.243          | FOREGROUND |
|    305 |        32423 | dpc_user@192.168.0.243          | FOREGROUND |
|    306 |        32385 | dpc_user@192.168.0.243          | FOREGROUND |
|    307 |        32417 | dpc_user@192.168.0.243          | FOREGROUND |
|    308 |        32418 | dpc_user@192.168.0.243          | FOREGROUND |
|    309 |        32393 | dpc_user@192.168.0.243          | FOREGROUND |
|    310 |        32415 | dpc_user@192.168.0.243          | FOREGROUND |
|    311 |        32397 | dpc_user@192.168.0.243          | FOREGROUND |
|    312 |        32401 | dpc_user@192.168.0.243          | FOREGROUND |
|    313 |        32387 | dpc_user@192.168.0.243          | FOREGROUND |
|    314 |        32389 | dpc_user@192.168.0.243          | FOREGROUND |
|    315 |        32391 | dpc_user@192.168.0.243          | FOREGROUND |
|    316 |        32407 | dpc_user@192.168.0.243          | FOREGROUND |
|    317 |        32383 | dpc_user@192.168.0.243          | FOREGROUND |
|    318 |        32400 | dpc_user@192.168.0.243          | FOREGROUND |
|    319 |        32384 | dpc_user@192.168.0.243          | FOREGROUND |
|    320 |        32409 | dpc_user@192.168.0.243          | FOREGROUND |
|    321 |        32413 | dpc_user@192.168.0.243          | FOREGROUND |
|    322 |        32410 | dpc_user@192.168.0.243          | FOREGROUND |
|    323 |        32404 | dpc_user@192.168.0.243          | FOREGROUND |
|    324 |        32411 | dpc_user@192.168.0.243          | FOREGROUND |
|    325 |        32392 | dpc_user@192.168.0.243          | FOREGROUND |
|    326 |        32405 | dpc_user@192.168.0.243          | FOREGROUND |
|    327 |        32408 | dpc_user@192.168.0.243          | FOREGROUND |
|    328 |        32427 | dpc_user@192.168.0.243          | FOREGROUND |
|    329 |        32428 | dpc_user@192.168.0.243          | FOREGROUND |
|    330 |        32422 | dpc_user@192.168.0.243          | FOREGROUND |
|    331 |        32426 | dpc_user@192.168.0.243          | FOREGROUND |
|    332 |        32431 | dpc_user@192.168.0.243          | FOREGROUND |
|    333 |        32435 | dpc_user@192.168.0.243          | FOREGROUND |
|    334 |        32442 | dpc_user@192.168.0.243          | FOREGROUND |
|    335 |        32430 | dpc_user@192.168.0.243          | FOREGROUND |
|    336 |        32429 | dpc_user@192.168.0.243          | FOREGROUND |
|    337 |        32433 | dpc_user@192.168.0.243          | FOREGROUND |
|    338 |        32434 | dpc_user@192.168.0.243          | FOREGROUND |
|    339 |        32432 | dpc_user@192.168.0.243          | FOREGROUND |
|    340 |        32441 | dpc_user@192.168.0.243          | FOREGROUND |
|    341 |        32450 | dpc_user@192.168.0.243          | FOREGROUND |
|    342 |        32445 | dpc_user@192.168.0.243          | FOREGROUND |
|    343 |        32444 | dpc_user@192.168.0.243          | FOREGROUND |
|    344 |        32440 | dpc_user@192.168.0.243          | FOREGROUND |
|    345 |        32439 | dpc_user@192.168.0.243          | FOREGROUND |
|    346 |        32443 | dpc_user@192.168.0.243          | FOREGROUND |
|    347 |        32446 | dpc_user@192.168.0.243          | FOREGROUND |
|    348 |        32453 | dpc_user@192.168.0.243          | FOREGROUND |
|    349 |        32456 | dpc_user@192.168.0.243          | FOREGROUND |
|    350 |        32454 | dpc_user@192.168.0.243          | FOREGROUND |
|    351 |        32451 | dpc_user@192.168.0.243          | FOREGROUND |
|    352 |        32464 | dpc_user@192.168.0.243          | FOREGROUND |
|    353 |        32455 | dpc_user@192.168.0.243          | FOREGROUND |
|    354 |        32452 | dpc_user@192.168.0.243          | FOREGROUND |
|    355 |        32457 | dpc_user@192.168.0.243          | FOREGROUND |
|    356 |        32461 | dpc_user@192.168.0.243          | FOREGROUND |
|    357 |        32358 | dpc_user@192.168.0.243          | FOREGROUND |
|    358 |        32463 | dpc_user@192.168.0.243          | FOREGROUND |
|    359 |        32467 | dpc_user@192.168.0.243          | FOREGROUND |
|    360 |        32468 | dpc_user@192.168.0.243          | FOREGROUND |
|    361 |        32462 | dpc_user@192.168.0.243          | FOREGROUND |
|    362 |        32465 | dpc_user@192.168.0.243          | FOREGROUND |
|    363 |        32466 | dpc_user@192.168.0.243          | FOREGROUND |
|    364 |        32367 | dpc_user@192.168.0.243          | FOREGROUND |
|    366 |          846 | root@localhost                  | FOREGROUND |
|    166 |        32594 | root@192.168.0.220              | FOREGROUND |
|    167 |        32635 | root@192.168.0.220              | FOREGROUND |
|    168 |        32636 | root@192.168.0.220              | FOREGROUND |
|    169 |        32659 | root@192.168.0.220              | FOREGROUND |
+--------+--------------+---------------------------------+------------+
139 rows in set (0.61 sec)

线程号为 366 对应的LWP ID 为 846




Thread 2 (Thread 0x7fb9edbf1700 (LWP 846)):
#0  0x00007fbccef3dd7d in fsync () from /lib64/libpthread.so.0
#1  0x0000000000ff5610 in os_file_fsync_posix (file=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:3055
#2  os_file_flush_func (file=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:3170
#3  0x000000000118d8f9 in pfs_os_file_flush_func (src_line=5992, file=..., src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/os0file.ic:505
#4  fil_flush (space_id=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5992
#5  0x0000000000fd4af2 in log_write_flush_to_disk_low () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1156
#6  0x0000000000fd5c29 in log_write_up_to (lsn=<optimized out>, flush_to_disk=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1406
#7  0x00000000010d1b2d in trx_flush_log_if_needed_low (lsn=148036255452) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:1794
#8  trx_flush_log_if_needed (trx=0x7fbcc2ebb790, lsn=148036255452) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:1816
#9  trx_commit_in_memory (serialised=<optimized out>, mtr=<optimized out>, trx=0x7fbcc2ebb790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2043
#10 trx_commit_low (trx=0x7fbcc2ebb790, mtr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2180
#11 0x00000000010d1d34 in trx_commit (trx=0x7fbcc2ebb790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2204
#12 0x00000000010d3627 in trx_commit_for_mysql (trx=0x7fbcc2ebb790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2423
#13 0x0000000001176bac in dict_stats_exec_sql (pinfo=<optimized out>, sql=0x161f450 "PROCEDURE DELETE_FROM_INDEX_STATS () IS\nBEGIN\nDELETE FROM \"mysql/innodb_index_stats\" WHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nEND;\n", trx=0x7fbcc2ebb790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:324
#14 0x0000000001176ffb in dict_stats_drop_table (db_and_table=<optimized out>, errstr=0x7fb9edbeb580 "", errstr_sz=1024) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:3465
#15 0x0000000001050338 in row_drop_table_for_mysql (name=0x7fb9edbec720 "sbtest/table_clublogscore20111221", trx=0x7fbcc2ebb400, drop_db=true, nonatomic=<optimized out>, handler=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0mysql.cc:4341
#16 0x0000000000f883c2 in ha_innobase::delete_table (this=<optimized out>, name=0x7fb9edbedb30 "./sbtest/table_clublogscore20111221") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:12539
#17 0x000000000081e6d8 in ha_delete_table (thd=0x7fba44029300, table_type=<optimized out>, path=0x7fb9edbedb30 "./sbtest/table_clublogscore20111221", db=0x7fba441ae070 "sbtest", alias=0x7fba441ae077 "table_clublogscore20111221", generate_warning=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/handler.cc:2586
#18 0x0000000000d7f6fd in mysql_rm_table_no_locks (thd=0x7fba44029300, tables=0x7fba44062ee0, if_exists=true, drop_temporary=false, drop_view=true, dont_log_query=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_table.cc:2546
#19 0x0000000000cdf397 in mysql_rm_db (thd=0x7fba44029300, db=..., if_exists=<optimized out>, silent=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_db.cc:865
#20 0x0000000000d1a2e5 in mysql_execute_command (thd=0x7fba44029300, first_level=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:3818
#21 0x0000000000d1aaad in mysql_parse (thd=0x7fba44029300, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5582
#22 0x0000000000d1bcca in dispatch_command (thd=0x7fba44029300, com_data=0x7fb9edbf0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:1458
#23 0x0000000000d1cb74 in do_command (thd=0x7fba44029300) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:999
#24 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#25 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#26 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#27 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6

