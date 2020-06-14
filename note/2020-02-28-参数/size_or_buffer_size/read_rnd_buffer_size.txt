

show global variables like 'read_rnd_buffer_size';


排序缓冲, 用于存储并排序 MRR优化特性中的主键ID. 


除了MRR用到，这里也用到了用于 二次排序的时候对排序好的数据按照primary key(ROW_ID)按照分块的方式再次排序，意义同样在回表取数据可以尽量顺序化.


MRR执行流程：
 根据索引 a，定位到满足条件的记录，将 id 值放入 read_rnd_buffer 中 ;
 将 read_rnd_buffer 中的 id 进行递增排序；
 排序后的 id 数组，依次到主键 id 索引中查记录，并作为结果返回。
 

参考:
	MySQL实战45讲中的 35 | join语句怎么优化？