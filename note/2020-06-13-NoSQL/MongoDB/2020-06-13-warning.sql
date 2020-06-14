


https://blog.csdn.net/sunbocong/article/details/78106096  关于 4个 warning 的说明 


shell> mongo
MongoDB shell version v4.2.7
connecting to: mongodb://10.31.76.149:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("a5b3ee58-47f6-46fa-8106-ed4e7d062c7d") }
MongoDB server version: 4.2.7
Server has startup warnings: 
2020-06-11T17:15:01.513+0800 I  STORAGE  [initandlisten] 
2020-06-11T17:15:01.513+0800 I  STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2020-06-11T17:15:01.513+0800 I  STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] 
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] 
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] 
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/enabled is 'always'.
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] **        We suggest setting it to 'never'
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] 
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/defrag is 'always'.
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] **        We suggest setting it to 'never'
2020-06-11T17:15:02.695+0800 I  CONTROL  [initandlisten] 
---
Enable MongoDB's free cloud-based monitoring service, which will then receive and display
metrics about your deployment (disk utilization, CPU, operation statistics, etc).

The monitoring data will be available on a MongoDB website with a unique URL accessible to you
and anyone you share the URL with. MongoDB may use this information to make product
improvements and to suggest MongoDB products and deployment options to you.

To enable free monitoring, run the following command: db.enableFreeMonitoring()
To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
---


