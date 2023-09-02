

不用业务字段做主键的原因： 
	1. 业务字段不一定是递增的，有可能会造成主键索引的页分裂，导致性能不稳定。 
	2. 二级索引存储的值是主键，如果使用业务字段占用大小不好控制，如果业务字段过长可能会导致二级索引占用空间过大，利用率不高。



InnoDB B+树主键索引的叶子节点存的是什么
	数据页，数据页中存放的是行记录
	
	
二级索引：根据字段的顺序以索引的形式进行存放。



<<<<<<< HEAD
create table T(
  id int primary key, 
  k int not null default 0, 
  name varchar(16),
  index (`k)
engine=InnoDB;
	
	

=======


create table T(
  id int primary key, 
  k int not null, 
  name varchar(16),
  index (k))
 engine=InnoDB;
 
		
(100,1)、(200,2)、(300,3)、(500,5) 和 (600,6)；		 



CREATE TABLE `t_user` (
  `id` int(11) NOT NULL auto_increment comment "id",
  `name` varchar(32) NOT NULL default "" comment "姓名",
  `age` int(11) NOT NULL default 0 comment "年龄",
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB comment = "用户表";

insert t_user(name,age) values("李四",25);
insert t_user(name,age) values("王五",25);
insert t_user(name,age) values("张三",25);
insert t_user(name,age) values("张三",25);
insert t_user(name,age) values("李四",25);

用户表, 有主键和idx_name；



select count(*) as aggregate from `t_clock_activity` inner join `t_clock_activity_conf` as `ac` on `ac`.`activity_id` = `t_clock_activity`.`id` where `t_clock_activity`.`app_id` = 'appeoE182Hv9561' and `t_clock_activity`.`resource_id` = 'c_63b449e4bae9e_rVVn4wSI1659' and `t_clock_activity`.`type` = '0' and `ac`.`clock_play_type` = '2' and `t_clock_activity`.`id` in ('ac_6404b500197c1_4Od4aYJK') and `t_clock_activity`.`state` in ('0', '1')


inner join关联查询sql拆解：
	1. 先查询关联表的数据： select * from t_clock_activity where `t_clock_activity`.`app_id` = 'appeoE182Hv9561' and `t_clock_activity`.`resource_id` = 'c_63b449e4bae9e_rVVn4wSI1659' and `t_clock_activity`.`type` = '0' and `ac`.`clock_play_type` = '2' and `t_clock_activity`.`id` in ('ac_6404b500197c1_4Od4aYJK') and `t_clock_activity`.`state` in ('0', '1')
	
	2. 再查询被关联表的数据，查询条件为  select * from t_clock_activity_conf where 
		
>>>>>>> 7d0e35f7692865d63f1c14a17a9009c909c045d0
