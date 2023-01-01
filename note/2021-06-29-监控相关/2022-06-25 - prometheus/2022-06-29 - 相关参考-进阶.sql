


https://blog.csdn.net/w2009211777/article/details/123950688   Prometheus服务发现机制

https://mp.weixin.qq.com/s/L_-rm2uYW4KwncQZhYNtTg  技术分享 | 阿里云 RDS 监控可以不那么“难看”



1. 定时调用云数据库API，获取实例列表
2. 



1. 通过阿里云 API，获取所有 RDS 信息；
2. 根据获取的信息为每个 RDS 生成 mysqld_exporter 启动脚本，并通过 supervisor 控制自启动；
3. 根据获取的信息更新 sd_cfg/mysqld_exporter.yml，实现服务自发现；
4. 最后，计划任务定期去扫阿里云 API，判断是否有新的 RDS 创建/删除

至此，再也不用人肉去加监控了，脚本不死，一切自动。