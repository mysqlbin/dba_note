


This server is using MONGODB-CR, an authentication mechanism(认证机制) which has been removed from MongoDB 4.0. In order to upgrade the auth schema, first downgrade MongoDB binaries to version 3.6 and then run the authSchemaUpgrade command.


建议在3.6版将认证机制 MONOGDB-CR 更新为 SCRAM-SHA-1 ，后续的版本将不再支持MONOGDB-CR, 在4.0版本中, 已经把认证机制 MONOGDB-CR 移除.





Change Stream
    Change Stream是3.6的新特性，允许应用程序实时访问数据的变化，可以用来查询集合上的所有数据的更改，以便及时作出相应，利用Change Streams这个功能，应用可以实现构建实时数据同步。
	使用注意事项：
		1、必须是复制集或者分片。
		2、必须是wiretiger存储引擎，且是协议复制版本pv1。
		3、featureCompatibilityVersion参数必须设置成 “3.6”。

	
