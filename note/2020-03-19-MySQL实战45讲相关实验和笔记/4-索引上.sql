

不用业务字段做主键的原因： 
	1. 业务字段不一定是递增的，有可能会造成主键索引的页分裂，导致性能不稳定。 
	2. 二级索引存储的值是主键，如果使用业务字段占用大小不好控制，如果业务字段过长可能会导致二级索引占用空间过大，利用率不高。



InnoDB B+树主键索引的叶子节点存的是什么
	数据页，数据页中存放的是行记录
	
	
二级索引：根据字段的顺序以索引的形式进行存放。



create table T(
  id int primary key, 
  k int not null default 0, 
  name varchar(16),
  index (`k)
engine=InnoDB;
	
	

