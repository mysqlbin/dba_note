




> use admin
switched to db admin
> db.updateUser("webh5_user ",{roles:[ {role:"readWrite",db:"abc_h5"} ]})
2021-06-17T17:17:24.387+0800 E  QUERY    [js] uncaught exception: Error: Updating user failed: User webh5_user @admin not found :
_getErrorWithCode@src/mongo/shell/utils.js:25:13
DB.prototype.updateUser@src/mongo/shell/db.js:1420:11
@(shell):1:1




-- "webh5_user " 账号多了个空格。


