

调用存储过程

mysql> CALL add_t_user_memory(1000000);
ERROR 1114 (HY000): The table 't_user_memory' is full

出现内存已满时，修改 max_heap_table_size 参数的大小，我使用64M内存，插入了22W数据，看情况改，不过这个值不要太大，默认32M或者64M就好，生产环境不要乱尝试


https://blog.csdn.net/u012998306/article/details/88642207
https://www.jianshu.com/p/4c6d892894fc     mysql出现"the table is full"的问题

set global  max_heap_table_size=134217728;    # 128 MB
set global tmp_table_size=134217728;		  # 128 MB

show global variables like '%max_heap_table_size%';
show global variables like '%tmp_table_size%';


