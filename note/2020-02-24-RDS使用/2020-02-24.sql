

mysqlbin

LJB0302ljb!@#


相关参考：
	https://help.aliyun.com/document_detail/59980.html?spm=5176.208363.1107630.35.62e41313bgpmKr  MySQL/PostgreSQL/PPAS CloudDBA简介 
	https://help.aliyun.com/document_detail/26124.html?spm=a2c4g.11186623.6.607.31c74c07YystNY    使用流程
	https://yq.aliyun.com/topic/100?spm=5176.7920929.1290475.4.7d8842f8UB5CO7  MySQL和阿里云RDS应用和实践宝典-云栖社区-阿里云
	https://yq.aliyun.com/articles/9061?spm=a2c4e.11154837.793265.6.49c63a7fREwV4L    RDS MySql支持online ddl     # pt-osc 的相关原理


 
不支持TokuDB引擎。由于Percona已经不再对TokuDB提供支持，很多已知BUG无法修正，极端情况下会导致业务受损，因此RDS MySQL在2019年8月1日后将不再支持TokuDB引擎。引擎转换请参见【通知】TokuDB引擎转换为InnoDB引擎。

创建账号：
	create user test_user@'%' identified by '123456abc';
	grant insert,delete,update,select on *.* to test_user@'%';

思考：
	1. 如何使用 pt-osc
	

下面的内容来自公众号：DBA随笔
	https://mp.weixin.qq.com/s/j29s7qPv5zzi_aacj48V_Q    阿里云rds搭建MySQL主从复制的问题
	https://mp.weixin.qq.com/s/ua8lp2ISk_Y5pjsaq_O3RQ    阿里云RDS的一个alter操作问题
	https://mp.weixin.qq.com/s/tEM4WBqG76mc5qMNExlBCQ    阿里云RDS--MySQL数据库故障的思考
	https://mp.weixin.qq.com/s/bQ2Vv-CTzyo-UqO5l50BwA    一次MySQL线上数据恢复过程   # 利用 binlog2sql 进行恢复数据
	https://mp.weixin.qq.com/s/P0yejsiR6etVMTGA59l-cQ   利用frm文件和ibd文件恢复表数据

	这个人做了挺多的项目，值得自己学习。   # 笔记也做得很好
	
	
	
	

RDS 还不能恢复到指定误操作对应的位置。

 



  


