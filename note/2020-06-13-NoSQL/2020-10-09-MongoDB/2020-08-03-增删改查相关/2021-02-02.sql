
> db.table_play_back.remove()
2021-02-02T19:11:22.115+0800 E  QUERY    [js] uncaught exception: Error: remove needs a query :
DBCollection.prototype._parseRemove@src/mongo/shell/collection.js:357:15
DBCollection.prototype.remove@src/mongo/shell/collection.js:384:18
@(shell):1:1


> db.table_play_back.remove();
2021-02-02T19:13:21.249+0800 E  QUERY    [js] uncaught exception: Error: remove needs a query :
DBCollection.prototype._parseRemove@src/mongo/shell/collection.js:357:15
DBCollection.prototype.remove@src/mongo/shell/collection.js:384:18
@(shell):1:1


https://blog.csdn.net/mingtianhaiyouwo/article/details/50086453   mongodb删除数据 报 E QUERY Error: remove needs a query 的错误



> db.foo.remove({});
WriteResult({ "nRemoved" : 1 })
