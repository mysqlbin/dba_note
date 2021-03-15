

mongoexport -h 192.168.0.242 --port 27017 -u admin -p admin --authenticationDatabase "admin" -d yldb -c t1 --type=json -o bike.csv 



/usr/local/mongodb/bin/mongoimport -h 192.168.0.242  -u "admin" -p "admin" --authenticationDatabase "admin" -d abc_db -c t1  --type json  --file bike.csv



[root@localhost ~]# mongoexport -h 192.168.0.242 --port 27017 -u admin -p admin --authenticationDatabase "admin" -d yldb -c t1 --type=json -o bike.csv 
2021-03-15T11:40:46.509+0800	connected to: mongodb://192.168.0.242:27017/
2021-03-15T11:40:46.626+0800	exported 20 records


[root@localhost ~]# cat bike.csv 
{"_id":{"$oid":"5f2784eb173400003d006f62"},"i":0.0,"username":"user0","age":37.0,"created":{"$date":"2020-08-03T03:30:51.511Z"}}
{"_id":{"$oid":"5f2784ec173400003d006f63"},"i":1.0,"username":"user1","age":33.0,"created":{"$date":"2020-08-03T03:30:52.004Z"}}
{"_id":{"$oid":"5f2784ec173400003d006f64"},"i":2.0,"username":"user2","age":95.0,"created":{"$date":"2020-08-03T03:30:52.006Z"}}
{"_id":{"$oid":"5f2784ec173400003d006f65"},"i":3.0,"username":"user3","age":97.0,"created":{"$date":"2020-08-03T03:30:52.008Z"}}
{"_id":{"$oid":"5f2784ec173400003d006f66"},"i":4.0,"username":"user4","age":43.0,"created":{"$date":"2020-08-03T03:30:52.01Z"}}
{"_id":{"$oid":"5f2785a9173400003d006f67"},"i":0.0,"username":"user0","age":1.0,"created":{"$date":"2020-08-03T03:34:01.057Z"}}
{"_id":{"$oid":"5f2785a9173400003d006f68"},"i":1.0,"username":"user1","age":0.0,"created":{"$date":"2020-08-03T03:34:01.058Z"}}
{"_id":{"$oid":"5f2785a9173400003d006f69"},"i":2.0,"username":"user2","age":1.0,"created":{"$date":"2020-08-03T03:34:01.06Z"}}
{"_id":{"$oid":"5f2785a9173400003d006f6a"},"i":3.0,"username":"user3","age":1.0,"created":{"$date":"2020-08-03T03:34:01.061Z"}}
{"_id":{"$oid":"5f2785a9173400003d006f6b"},"i":4.0,"username":"user4","age":0.0,"created":{"$date":"2020-08-03T03:34:01.063Z"}}
{"_id":{"$oid":"5f2785b6173400003d006f6c"},"i":0.0,"username":"user0","age":0.0,"created":{"$date":"2020-08-03T03:34:14.623Z"}}
{"_id":{"$oid":"5f2785b6173400003d006f6d"},"i":1.0,"username":"user1","age":3.0,"created":{"$date":"2020-08-03T03:34:14.626Z"}}
{"_id":{"$oid":"5f2785b6173400003d006f6e"},"i":2.0,"username":"user2","age":2.0,"created":{"$date":"2020-08-03T03:34:14.628Z"}}
{"_id":{"$oid":"5f2785b6173400003d006f6f"},"i":3.0,"username":"user3","age":3.0,"created":{"$date":"2020-08-03T03:34:14.63Z"}}
{"_id":{"$oid":"5f2785b6173400003d006f70"},"i":4.0,"username":"user4","age":1.0,"created":{"$date":"2020-08-03T03:34:14.632Z"}}
{"_id":{"$oid":"5f278782173400003d009681"},"i":0.0,"username":"user0","age":596277.0,"created":{"$date":"2020-08-03T03:41:54.045Z"}}
{"_id":{"$oid":"5f278782173400003d009682"},"i":1.0,"username":"user1","age":383322.0,"created":{"$date":"2020-08-03T03:41:54.048Z"}}
{"_id":{"$oid":"5f278782173400003d009683"},"i":2.0,"username":"user2","age":464760.0,"created":{"$date":"2020-08-03T03:41:54.05Z"}}
{"_id":{"$oid":"5f278782173400003d009684"},"i":3.0,"username":"user3","age":322662.0,"created":{"$date":"2020-08-03T03:41:54.051Z"}}
{"_id":{"$oid":"5f278782173400003d009685"},"i":4.0,"username":"user4","age":217580.0,"created":{"$date":"2020-08-03T03:41:54.053Z"}}


[root@localhost ~]# /usr/local/mongodb/bin/mongoimport -h 192.168.0.242  -u "admin" -p "admin" --authenticationDatabase "admin" -d abc_db -c t1  --type json  --file bike.csv
2021-03-15T11:43:23.731+0800	connected to: mongodb://192.168.0.242/
2021-03-15T11:43:24.132+0800	20 document(s) imported successfully. 0 document(s) failed to import.

