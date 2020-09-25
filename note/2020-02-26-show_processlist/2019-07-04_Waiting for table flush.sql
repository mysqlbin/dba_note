

		
表现如下：

    use db不能进入数据库
    schema.processlist来看有大量的 Waiting for table flush
	
	说明了执行 use DB; 命令 需要关闭这个库下的所有表;


参考:
	https://mp.weixin.qq.com/s/Te4VngFwPvUHvGzbaTAobA   USE DB导致MySQL大堵塞故障？
	
	

