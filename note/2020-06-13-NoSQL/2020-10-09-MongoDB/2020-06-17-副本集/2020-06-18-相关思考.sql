

1. MongoDB 副本集如何备份
2. MongoDB 副本集如何在线加入从库

3. 是否有类似 1032 和 1062 的错误，如果有的话，该如何解决



对副本集的成员恢复，需先切成单机版，mongorestore 必须指定 --oplogReplay 选项，以恢复到某一时刻的快照，最后还需填充oplog（增量数据以哪个位置点开始断点续传）
mongorestore -d local -c oplog.rs dump/oplog.bson，最后一步再切为副本集成员重新启动。










