


https://blog.csdn.net/dragonpeng2008/article/details/90200441


MongoDB 4.0 引入的事务功能，支持多文档ACID特性，例如使用 mongo shell 进行事务操作

 
> s = db.getMongo().startSession()
session { "id" : UUID("3bf55e90-5e88-44aa-a59e-a30f777f1d89") }
> s.startTransaction()
> session.getDatabase("mytest").coll01.insert({x: 1, y: 1})
WriteResult({ "nInserted" : 1 })
> session.getDatabase("mytest").coll02.insert({x: 1, y: 1})
WriteResult({ "nInserted" : 1 })
> s.commitTransaction()  （或者 s.abortTransaction()回滚事务）


