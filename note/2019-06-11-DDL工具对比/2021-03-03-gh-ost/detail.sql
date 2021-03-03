[root@kp04 ghost]#  time ./gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="sbtest1" --alter="add column filed_04 int(10) not null default 0 comment 'filed_04'" --allow-on-master --execute
[2020/05/06 16:28:51] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/06 16:28:51] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000002, 137965242)
[2020/05/06 16:28:51] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
[2020/05/06 16:28:51] [info] binlogsyncer.go:723 rotate to (mysql-bin.000002, 137965242)
# Migrating `sbtest`.`sbtest1`; Ghost table is `sbtest`.`_sbtest1_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 16:28:51 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.sbtest1.sock
Copy: 0/5047883 0.0%; Applied: 0; Backlog: 0/1000; Time: 0s(total), 0s(copy); streamer: mysql-bin.000002:137967466; Lag: 0.04s, State: migrating; ETA: N/A
Copy: 0/5047883 0.0%; Applied: 0; Backlog: 0/1000; Time: 1s(total), 1s(copy); streamer: mysql-bin.000002:137970759; Lag: 0.22s, State: migrating; ETA: N/A
Copy: 0/5047883 0.0%; Applied: 0; Backlog: 0/1000; Time: 2s(total), 2s(copy); streamer: mysql-bin.000002:137971642; Lag: 1.05s, State: migrating; ETA: N/A
Copy: 6000/5047883 0.1%; Applied: 0; Backlog: 0/1000; Time: 3s(total), 3s(copy); streamer: mysql-bin.000002:139145273; Lag: 0.12s, State: migrating; ETA: 42m14s
Copy: 16000/5047883 0.3%; Applied: 0; Backlog: 0/1000; Time: 4s(total), 4s(copy); streamer: mysql-bin.000002:141099268; Lag: 0.08s, State: migrating; ETA: 21m6s
Copy: 30000/5047883 0.6%; Applied: 0; Backlog: 0/1000; Time: 5s(total), 5s(copy); streamer: mysql-bin.000002:143834022; Lag: 0.12s, State: migrating; ETA: 13m58s
Copy: 34000/5047883 0.7%; Applied: 0; Backlog: 0/1000; Time: 6s(total), 6s(copy); streamer: mysql-bin.000002:144618085; Lag: 0.18s, State: migrating; ETA: 14m47s
Copy: 42000/5047883 0.8%; Applied: 0; Backlog: 0/1000; Time: 7s(total), 7s(copy); streamer: mysql-bin.000002:146182104; Lag: 0.10s, State: migrating; ETA: 13m56s
Copy: 54000/5047883 1.1%; Applied: 0; Backlog: 0/1000; Time: 8s(total), 8s(copy); streamer: mysql-bin.000002:148526475; Lag: 0.12s, State: migrating; ETA: 12m21s
Copy: 61000/5047883 1.2%; Applied: 0; Backlog: 0/1000; Time: 9s(total), 9s(copy); streamer: mysql-bin.000002:149893495; Lag: 0.72s, State: migrating; ETA: 12m17s
Copy: 71000/5047883 1.4%; Applied: 0; Backlog: 0/1000; Time: 10s(total), 10s(copy); streamer: mysql-bin.000002:151848290; Lag: 0.11s, State: migrating; ETA: 11m42s
Copy: 81000/5047883 1.6%; Applied: 0; Backlog: 0/1000; Time: 11s(total), 11s(copy); streamer: mysql-bin.000002:153802689; Lag: 0.12s, State: migrating; ETA: 11m15s
Copy: 93000/5047883 1.8%; Applied: 0; Backlog: 0/1000; Time: 12s(total), 12s(copy); streamer: mysql-bin.000002:156146666; Lag: 0.21s, State: migrating; ETA: 10m40s
Copy: 94000/5047883 1.9%; Applied: 0; Backlog: 0/1000; Time: 14s(total), 13s(copy); streamer: mysql-bin.000002:156342548; Lag: 1.92s, State: migrating; ETA: 12m7s
Copy: 94000/5047883 1.9%; Applied: 0; Backlog: 0/1000; Time: 14s(total), 14s(copy); streamer: mysql-bin.000002:156342548; Lag: 2.12s, State: migrating; ETA: 12m18s
Copy: 97000/5047883 1.9%; Applied: 0; Backlog: 0/1000; Time: 15s(total), 15s(copy); streamer: mysql-bin.000002:156933577; Lag: 0.12s, State: migrating; ETA: 12m46s
Copy: 100000/5047883 2.0%; Applied: 0; Backlog: 0/1000; Time: 16s(total), 16s(copy); streamer: mysql-bin.000002:157520641; Lag: 0.54s, State: migrating; ETA: 13m12s
Copy: 100000/5047883 2.0%; Applied: 0; Backlog: 0/1000; Time: 17s(total), 17s(copy); streamer: mysql-bin.000002:157521043; Lag: 1.39s, State: migrating; ETA: 14m1s
Copy: 110000/5047883 2.2%; Applied: 0; Backlog: 0/1000; Time: 18s(total), 18s(copy); streamer: mysql-bin.000002:159476338; Lag: 0.12s, State: migrating; ETA: 13m28s
Copy: 118000/5047883 2.3%; Applied: 0; Backlog: 0/1000; Time: 19s(total), 19s(copy); streamer: mysql-bin.000002:161039155; Lag: 0.08s, State: migrating; ETA: 13m14s
Copy: 123000/5047883 2.4%; Applied: 0; Backlog: 0/1000; Time: 20s(total), 20s(copy); streamer: mysql-bin.000002:162017405; Lag: 0.12s, State: migrating; ETA: 13m21s
Copy: 128000/5047883 2.5%; Applied: 0; Backlog: 0/1000; Time: 21s(total), 21s(copy); streamer: mysql-bin.000002:162995255; Lag: 0.35s, State: migrating; ETA: 13m27s
Copy: 132000/5047883 2.6%; Applied: 0; Backlog: 0/1000; Time: 22s(total), 22s(copy); streamer: mysql-bin.000002:163777714; Lag: 0.19s, State: migrating; ETA: 13m39s
Copy: 132000/5047883 2.6%; Applied: 0; Backlog: 0/1000; Time: 23s(total), 23s(copy); streamer: mysql-bin.000002:163777714; Lag: 1.20s, State: migrating; ETA: 14m17s
Copy: 136000/5047883 2.7%; Applied: 0; Backlog: 0/1000; Time: 24s(total), 24s(copy); streamer: mysql-bin.000002:164562274; Lag: 0.12s, State: migrating; ETA: 14m27s
Copy: 148000/5047883 2.9%; Applied: 0; Backlog: 0/1000; Time: 25s(total), 25s(copy); streamer: mysql-bin.000002:166907053; Lag: 0.12s, State: migrating; ETA: 13m48s
Copy: 156000/5047883 3.1%; Applied: 0; Backlog: 0/1000; Time: 26s(total), 26s(copy); streamer: mysql-bin.000002:168470272; Lag: 0.32s, State: migrating; ETA: 13m35s
Copy: 156000/5047883 3.1%; Applied: 0; Backlog: 0/1000; Time: 27s(total), 27s(copy); streamer: mysql-bin.000002:168471167; Lag: 1.02s, State: migrating; ETA: 14m11s
Copy: 161000/5047883 3.2%; Applied: 0; Backlog: 0/1000; Time: 32s(total), 32s(copy); streamer: mysql-bin.000002:169449821; Lag: 0.22s, State: migrating; ETA: 16m12s
Copy: 161000/5047883 3.2%; Applied: 0; Backlog: 0/1000; Time: 28s(total), 30s(copy); streamer: mysql-bin.000002:169449821; Lag: 0.22s, State: migrating; ETA: 14m10s
Copy: 161000/5047883 3.2%; Applied: 0; Backlog: 0/1000; Time: 31s(total), 30s(copy); streamer: mysql-bin.000002:169449419; Lag: 0.22s, State: migrating; ETA: 15m26s
Copy: 162000/5047883 3.2%; Applied: 0; Backlog: 0/1000; Time: 33s(total), 33s(copy); streamer: mysql-bin.000002:169449821; Lag: 2.16s, State: migrating; ETA: 16m35s
Copy: 161000/5047883 3.2%; Applied: 0; Backlog: 0/1000; Time: 31s(total), 31s(copy); streamer: mysql-bin.000002:169449821; Lag: 0.22s, State: migrating; ETA: 15m48s
Copy: 165000/5047883 3.3%; Applied: 0; Backlog: 0/1000; Time: 34s(total), 34s(copy); streamer: mysql-bin.000002:170237684; Lag: 0.22s, State: migrating; ETA: 16m48s
Copy: 167000/5047883 3.3%; Applied: 0; Backlog: 0/1000; Time: 35s(total), 35s(copy); streamer: mysql-bin.000002:170629763; Lag: 0.56s, State: migrating; ETA: 17m3s
Copy: 167000/5047883 3.3%; Applied: 0; Backlog: 0/1000; Time: 36s(total), 36s(copy); streamer: mysql-bin.000002:170631461; Lag: 0.66s, State: migrating; ETA: 17m32s
Copy: 173000/5047883 3.4%; Applied: 0; Backlog: 0/1000; Time: 37s(total), 37s(copy); streamer: mysql-bin.000002:171804702; Lag: 0.32s, State: migrating; ETA: 17m23s
Copy: 174000/5047883 3.4%; Applied: 0; Backlog: 0/1000; Time: 38s(total), 38s(copy); streamer: mysql-bin.000002:172000987; Lag: 0.15s, State: migrating; ETA: 17m44s
Copy: 180000/5047883 3.6%; Applied: 0; Backlog: 0/1000; Time: 39s(total), 39s(copy); streamer: mysql-bin.000002:173174227; Lag: 0.12s, State: migrating; ETA: 17m35s
Copy: 193000/5047883 3.8%; Applied: 0; Backlog: 0/1000; Time: 40s(total), 40s(copy); streamer: mysql-bin.000002:175713593; Lag: 0.12s, State: migrating; ETA: 16m46s
Copy: 195000/5047883 3.9%; Applied: 0; Backlog: 0/1000; Time: 42s(total), 42s(copy); streamer: mysql-bin.000002:176104868; Lag: 0.92s, State: migrating; ETA: 17m31s
Copy: 195000/5047883 3.9%; Applied: 0; Backlog: 0/1000; Time: 41s(total), 42s(copy); streamer: mysql-bin.000002:176299857; Lag: 0.92s, State: migrating; ETA: 17m0s
Copy: 197000/5047883 3.9%; Applied: 0; Backlog: 0/1000; Time: 43s(total), 43s(copy); streamer: mysql-bin.000002:176497736; Lag: 0.14s, State: throttled, lag=2.167260s; ETA: 17m39s
Copy: 203000/5047883 4.0%; Applied: 0; Backlog: 0/1000; Time: 44s(total), 44s(copy); streamer: mysql-bin.000002:177673194; Lag: 0.11s, State: migrating; ETA: 17m30s
Copy: 211000/5047883 4.2%; Applied: 0; Backlog: 0/1000; Time: 45s(total), 45s(copy); streamer: mysql-bin.000002:179236815; Lag: 0.32s, State: migrating; ETA: 17m11s
Copy: 212000/5047883 4.2%; Applied: 0; Backlog: 0/1000; Time: 46s(total), 46s(copy); streamer: mysql-bin.000002:179433101; Lag: 0.75s, State: migrating; ETA: 17m29s
Copy: 213000/5047883 4.2%; Applied: 0; Backlog: 0/1000; Time: 47s(total), 47s(copy); streamer: mysql-bin.000002:179825136; Lag: 0.44s, State: migrating; ETA: 17m47s
Copy: 216000/5047883 4.3%; Applied: 0; Backlog: 0/1000; Time: 48s(total), 48s(copy); streamer: mysql-bin.000002:180217855; Lag: 0.07s, State: migrating; ETA: 17m54s
Copy: 217000/5047883 4.3%; Applied: 0; Backlog: 0/1000; Time: 49s(total), 49s(copy); streamer: mysql-bin.000002:180414543; Lag: 0.82s, State: migrating; ETA: 18m12s
Copy: 222000/5047883 4.4%; Applied: 0; Backlog: 0/1000; Time: 50s(total), 50s(copy); streamer: mysql-bin.000002:181393195; Lag: 0.09s, State: migrating; ETA: 18m7s
Copy: 230000/5047883 4.6%; Applied: 0; Backlog: 0/1000; Time: 51s(total), 51s(copy); streamer: mysql-bin.000002:182956411; Lag: 0.42s, State: migrating; ETA: 17m48s
Copy: 231000/5047883 4.6%; Applied: 0; Backlog: 0/1000; Time: 52s(total), 52s(copy); streamer: mysql-bin.000002:183153098; Lag: 0.50s, State: migrating; ETA: 18m4s
Copy: 231000/5047883 4.6%; Applied: 0; Backlog: 0/1000; Time: 53s(total), 53s(copy); streamer: mysql-bin.000002:183153098; Lag: 1.50s, State: migrating; ETA: 18m25s
Copy: 232000/5047883 4.6%; Applied: 0; Backlog: 0/1000; Time: 54s(total), 54s(copy); streamer: mysql-bin.000002:183348087; Lag: 2.50s, State: migrating; ETA: 18m41s
Copy: 234000/5047883 4.6%; Applied: 0; Backlog: 0/1000; Time: 55s(total), 55s(copy); streamer: mysql-bin.000002:183743756; Lag: 0.12s, State: migrating; ETA: 18m51s
Copy: 239000/5047883 4.7%; Applied: 0; Backlog: 0/1000; Time: 56s(total), 56s(copy); streamer: mysql-bin.000002:184721204; Lag: 0.11s, State: migrating; ETA: 18m47s
Copy: 244000/5047883 4.8%; Applied: 0; Backlog: 0/1000; Time: 57s(total), 57s(copy); streamer: mysql-bin.000002:185698650; Lag: 0.11s, State: migrating; ETA: 18m42s
Copy: 252000/5047883 5.0%; Applied: 0; Backlog: 0/1000; Time: 58s(total), 58s(copy); streamer: mysql-bin.000002:187261465; Lag: 0.42s, State: migrating; ETA: 18m24s
Copy: 255000/5047883 5.1%; Applied: 0; Backlog: 0/1000; Time: 1m0s(total), 59s(copy); streamer: mysql-bin.000002:187848533; Lag: 0.17s, State: migrating; ETA: 18m45s
Copy: 255000/5047883 5.1%; Applied: 0; Backlog: 0/1000; Time: 1m0s(total), 1m0s(copy); streamer: mysql-bin.000002:187848533; Lag: 1.52s, State: migrating; ETA: 18m48s
Copy: 289000/5047883 5.7%; Applied: 0; Backlog: 0/1000; Time: 1m5s(total), 1m6s(copy); streamer: mysql-bin.000002:194497941; Lag: 0.32s, State: migrating; ETA: 17m50s
Copy: 313000/5047883 6.2%; Applied: 0; Backlog: 0/1000; Time: 1m10s(total), 1m10s(copy); streamer: mysql-bin.000002:199190823; Lag: 0.12s, State: migrating; ETA: 17m39s
Copy: 332000/5047883 6.6%; Applied: 0; Backlog: 0/1000; Time: 1m15s(total), 1m15s(copy); streamer: mysql-bin.000002:202905352; Lag: 0.37s, State: migrating; ETA: 17m45s
Copy: 373000/5047883 7.4%; Applied: 0; Backlog: 0/1000; Time: 1m25s(total), 1m25s(copy); streamer: mysql-bin.000002:210799520; Lag: 0.20s, State: migrating; ETA: 17m47s
Copy: 380000/5047883 7.5%; Applied: 0; Backlog: 0/1000; Time: 1m30s(total), 1m30s(copy); streamer: mysql-bin.000002:212293930; Lag: 0.02s, State: migrating; ETA: 18m25s
Copy: 424000/5047883 8.4%; Applied: 0; Backlog: 0/1000; Time: 1m35s(total), 1m35s(copy); streamer: mysql-bin.000002:220889611; Lag: 0.12s, State: migrating; ETA: 17m16s
Copy: 443000/5047883 8.8%; Applied: 0; Backlog: 0/1000; Time: 1m40s(total), 1m40s(copy); streamer: mysql-bin.000002:224605345; Lag: 0.10s, State: migrating; ETA: 17m19s
Copy: 477000/5047883 9.4%; Applied: 0; Backlog: 0/1000; Time: 1m45s(total), 1m45s(copy); streamer: mysql-bin.000002:231250738; Lag: 0.12s, State: migrating; ETA: 16m46s
Copy: 502000/5047883 9.9%; Applied: 0; Backlog: 0/1000; Time: 1m50s(total), 1m50s(copy); streamer: mysql-bin.000002:236139818; Lag: 0.22s, State: migrating; ETA: 16m36s
Copy: 517000/5047883 10.2%; Applied: 0; Backlog: 0/1000; Time: 1m55s(total), 1m55s(copy); streamer: mysql-bin.000002:239075388; Lag: 0.87s, State: migrating; ETA: 16m47s
Copy: 548000/5047883 10.9%; Applied: 0; Backlog: 0/1000; Time: 2m0s(total), 2m0s(copy); streamer: mysql-bin.000002:245131789; Lag: 0.12s, State: migrating; ETA: 16m25s
Copy: 549000/5047883 10.9%; Applied: 0; Backlog: 0/1000; Time: 2m10s(total), 2m10s(copy); streamer: mysql-bin.000002:245329179; Lag: 2.46s, State: throttled, lag=2.143093s; ETA: 17m46s
Copy: 549000/5047883 10.9%; Applied: 0; Backlog: 0/1000; Time: 2m10s(total), 2m10s(copy); streamer: mysql-bin.000002:245329179; Lag: 2.46s, State: throttled, lag=2.143093s; ETA: 17m46s
Copy: 581000/5047883 11.5%; Applied: 0; Backlog: 0/1000; Time: 2m15s(total), 2m15s(copy); streamer: mysql-bin.000002:251586406; Lag: 0.61s, State: migrating; ETA: 17m18s
Copy: 590000/5047883 11.7%; Applied: 0; Backlog: 0/1000; Time: 2m20s(total), 2m20s(copy); streamer: mysql-bin.000002:253351534; Lag: 0.39s, State: migrating; ETA: 17m37s
Copy: 599000/5047883 11.9%; Applied: 0; Backlog: 0/1000; Time: 2m25s(total), 2m25s(copy); streamer: mysql-bin.000002:255115860; Lag: 1.02s, State: migrating; ETA: 17m57s
Copy: 617000/5047883 12.2%; Applied: 0; Backlog: 0/1000; Time: 2m30s(total), 2m30s(copy); streamer: mysql-bin.000002:258637096; Lag: 0.52s, State: migrating; ETA: 17m57s
Copy: 633000/5047883 12.5%; Applied: 0; Backlog: 0/1000; Time: 2m35s(total), 2m35s(copy); streamer: mysql-bin.000002:261765849; Lag: 0.60s, State: migrating; ETA: 18m1s
Copy: 663000/5047883 13.1%; Applied: 0; Backlog: 0/1000; Time: 2m40s(total), 2m40s(copy); streamer: mysql-bin.000002:267630866; Lag: 0.12s, State: migrating; ETA: 17m38s
Copy: 697000/5047883 13.8%; Applied: 0; Backlog: 0/1000; Time: 2m45s(total), 2m45s(copy); streamer: mysql-bin.000002:274275852; Lag: 0.12s, State: migrating; ETA: 17m10s
Copy: 715000/5047883 14.2%; Applied: 0; Backlog: 0/1000; Time: 2m50s(total), 2m50s(copy); streamer: mysql-bin.000002:277796602; Lag: 0.19s, State: migrating; ETA: 17m10s
Copy: 721000/5047883 14.3%; Applied: 0; Backlog: 0/1000; Time: 2m55s(total), 2m55s(copy); streamer: mysql-bin.000002:278969846; Lag: 2.74s, State: migrating; ETA: 17m30s
Copy: 734000/5047883 14.5%; Applied: 0; Backlog: 0/1000; Time: 3m0s(total), 3m0s(copy); streamer: mysql-bin.000002:281516245; Lag: 0.22s, State: migrating; ETA: 17m37s
Copy: 928000/5047883 18.4%; Applied: 0; Backlog: 0/1000; Time: 3m30s(total), 3m30s(copy); streamer: mysql-bin.000002:319430357; Lag: 0.07s, State: migrating; ETA: 15m32s
Copy: 948000/5047883 18.8%; Applied: 0; Backlog: 0/1000; Time: 4m0s(total), 4m0s(copy); streamer: mysql-bin.000002:323346801; Lag: 0.32s, State: migrating; ETA: 17m18s
Copy: 1022000/5047883 20.2%; Applied: 0; Backlog: 0/1000; Time: 4m30s(total), 4m30s(copy); streamer: mysql-bin.000002:337824076; Lag: 0.17s, State: migrating; ETA: 17m43s
Copy: 1119000/5047883 22.2%; Applied: 0; Backlog: 0/1000; Time: 5m0s(total), 5m0s(copy); streamer: mysql-bin.000002:356797358; Lag: 0.11s, State: migrating; ETA: 17m33s
Copy: 1230000/5047883 24.4%; Applied: 0; Backlog: 0/1000; Time: 5m30s(total), 5m30s(copy); streamer: mysql-bin.000002:378515226; Lag: 0.11s, State: migrating; ETA: 17m4s
Copy: 1286000/5047883 25.5%; Applied: 0; Backlog: 0/1000; Time: 6m30s(total), 6m30s(copy); streamer: mysql-bin.000002:389477984; Lag: 1.72s, State: migrating; ETA: 19m0s
Copy: 1409000/5047883 27.9%; Applied: 0; Backlog: 0/1000; Time: 7m30s(total), 7m30s(copy); streamer: mysql-bin.000002:413548963; Lag: 1.61s, State: throttled, lag=1.516920s; ETA: 19m22s
Copy: 1440000/5047883 28.5%; Applied: 0; Backlog: 0/1000; Time: 8m0s(total), 8m0s(copy); streamer: mysql-bin.000002:419611716; Lag: 0.10s, State: migrating; ETA: 20m2s
Copy: 1473000/5047883 29.2%; Applied: 0; Backlog: 0/1000; Time: 8m30s(total), 8m31s(copy); streamer: mysql-bin.000002:426081344; Lag: 1.05s, State: migrating; ETA: 20m37s
[mysql] 2020/05/06 16:38:02 packets.go:36: unexpected EOF
2020-05-06 16:38:02 ERROR invalid connection
2020-05-06 16:38:02 ERROR invalid connection
[mysql] 2020/05/06 16:38:02 packets.go:36: unexpected EOF
2020-05-06 16:38:02 ERROR invalid connection
2020-05-06 16:38:02 ERROR invalid connection
Copy: 1544000/5047883 30.6%; Applied: 0; Backlog: 0/1000; Time: 9m30s(total), 9m30s(copy); streamer: mysql-bin.000002:439975979; Lag: 1.58s, State: throttled, lag=1.597560s; ETA: 21m33s
Copy: 1613000/5047883 32.0%; Applied: 0; Backlog: 0/1000; Time: 12m0s(total), 12m0s(copy); streamer: mysql-bin.000002:453470956; Lag: 130.62s, State: migrating; ETA: 25m33s
Copy: 1613000/5047883 32.0%; Applied: 0; Backlog: 0/1000; Time: 12m0s(total), 12m0s(copy); streamer: mysql-bin.000002:453470956; Lag: 2.72s, State: migrating; ETA: 25m33s
Copy: 1677000/5047883 33.2%; Applied: 0; Backlog: 0/1000; Time: 12m30s(total), 12m30s(copy); streamer: mysql-bin.000002:465997361; Lag: 0.58s, State: migrating; ETA: 25m7s
Copy: 1744000/5047883 34.5%; Applied: 0; Backlog: 0/1000; Time: 13m0s(total), 13m0s(copy); streamer: mysql-bin.000002:479109348; Lag: 0.53s, State: migrating; ETA: 24m37s
Copy: 1818000/5047883 36.0%; Applied: 0; Backlog: 0/1000; Time: 13m30s(total), 13m30s(copy); streamer: mysql-bin.000002:493595338; Lag: 0.19s, State: migrating; ETA: 23m58s
Copy: 1832000/5047883 36.3%; Applied: 0; Backlog: 0/1000; Time: 14m0s(total), 14m0s(copy); streamer: mysql-bin.000002:496341131; Lag: 0.20s, State: migrating; ETA: 24m34s
Copy: 1913000/5047883 37.9%; Applied: 0; Backlog: 0/1000; Time: 14m30s(total), 14m30s(copy); streamer: mysql-bin.000002:512190976; Lag: 1.28s, State: migrating; ETA: 23m45s
Copy: 1930000/5047883 38.2%; Applied: 0; Backlog: 0/1000; Time: 15m0s(total), 15m0s(copy); streamer: mysql-bin.000002:515524855; Lag: 1.02s, State: migrating; ETA: 24m13s
Copy: 1989000/5047883 39.4%; Applied: 0; Backlog: 0/1000; Time: 15m30s(total), 15m30s(copy); streamer: mysql-bin.000002:527081601; Lag: 0.52s, State: migrating; ETA: 23m50s
Copy: 1995000/5047883 39.5%; Applied: 0; Backlog: 0/1000; Time: 16m0s(total), 16m0s(copy); streamer: mysql-bin.000002:528263969; Lag: 0.78s, State: migrating; ETA: 24m29s
Copy: 2057000/5047883 40.7%; Applied: 0; Backlog: 0/1000; Time: 16m30s(total), 16m30s(copy); streamer: mysql-bin.000002:540403252; Lag: 0.41s, State: migrating; ETA: 23m59s
Copy: 2149000/5047883 42.6%; Applied: 0; Backlog: 0/1000; Time: 17m0s(total), 17m0s(copy); streamer: mysql-bin.000002:558407196; Lag: 0.12s, State: migrating; ETA: 22m55s
Copy: 2262000/5047883 44.8%; Applied: 0; Backlog: 0/1000; Time: 17m30s(total), 17m30s(copy); streamer: mysql-bin.000002:580512312; Lag: 0.12s, State: migrating; ETA: 21m33s
Copy: 2328000/5047883 46.1%; Applied: 0; Backlog: 0/1000; Time: 18m0s(total), 18m0s(copy); streamer: mysql-bin.000002:593436798; Lag: 0.32s, State: migrating; ETA: 21m1s
Copy: 2393000/5047883 47.4%; Applied: 0; Backlog: 0/1000; Time: 18m30s(total), 18m30s(copy); streamer: mysql-bin.000002:606182975; Lag: 0.29s, State: migrating; ETA: 20m31s
Copy: 2467000/5047883 48.9%; Applied: 0; Backlog: 0/1000; Time: 19m0s(total), 19m0s(copy); streamer: mysql-bin.000002:620686387; Lag: 1.12s, State: migrating; ETA: 19m52s
Copy: 2520000/5047883 49.9%; Applied: 0; Backlog: 0/1000; Time: 19m30s(total), 19m30s(copy); streamer: mysql-bin.000002:631088037; Lag: 1.16s, State: throttled, lag=1.597433s; ETA: 19m33s
# Migrating `sbtest`.`sbtest1`; Ghost table is `sbtest`.`_sbtest1_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 16:28:51 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.sbtest1.sock
Copy: 2590000/5047883 51.3%; Applied: 0; Backlog: 0/1000; Time: 20m0s(total), 20m0s(copy); streamer: mysql-bin.000002:644806516; Lag: 0.50s, State: migrating; ETA: 18m58s
Copy: 2658000/5047883 52.7%; Applied: 0; Backlog: 0/1000; Time: 20m30s(total), 20m30s(copy); streamer: mysql-bin.000002:658126361; Lag: 0.37s, State: throttled, lag=1.612692s; ETA: 18m25s
Copy: 2749000/5047883 54.5%; Applied: 0; Backlog: 0/1000; Time: 21m0s(total), 21m0s(copy); streamer: mysql-bin.000002:675936191; Lag: 0.22s, State: migrating; ETA: 17m33s
Copy: 2848000/5047883 56.4%; Applied: 0; Backlog: 0/1000; Time: 21m30s(total), 21m30s(copy); streamer: mysql-bin.000002:695311413; Lag: 0.22s, State: migrating; ETA: 16m36s
Copy: 2945000/5047883 58.3%; Applied: 0; Backlog: 0/1000; Time: 22m0s(total), 22m0s(copy); streamer: mysql-bin.000002:714298441; Lag: 0.64s, State: migrating; ETA: 15m42s
Copy: 3000000/5047883 59.4%; Applied: 0; Backlog: 0/1000; Time: 22m30s(total), 22m30s(copy); streamer: mysql-bin.000002:725067617; Lag: 3.40s, State: migrating; ETA: 15m21s
Copy: 3057000/5047883 60.6%; Applied: 0; Backlog: 0/1000; Time: 23m0s(total), 23m0s(copy); streamer: mysql-bin.000002:736230672; Lag: 0.92s, State: migrating; ETA: 14m58s
Copy: 3115000/5047883 61.7%; Applied: 0; Backlog: 0/1000; Time: 23m30s(total), 23m30s(copy); streamer: mysql-bin.000002:747590386; Lag: 7.09s, State: throttled, lag=1.646059s; ETA: 14m34s
Copy: 3178000/5047883 63.0%; Applied: 0; Backlog: 0/1000; Time: 24m0s(total), 24m0s(copy); streamer: mysql-bin.000002:759931688; Lag: 0.78s, State: migrating; ETA: 14m7s
Copy: 3216000/5047883 63.7%; Applied: 0; Backlog: 0/1000; Time: 24m30s(total), 24m31s(copy); streamer: mysql-bin.000002:767381013; Lag: 3.78s, State: migrating; ETA: 13m57s
Copy: 3225000/5047883 63.9%; Applied: 0; Backlog: 0/1000; Time: 25m0s(total), 25m0s(copy); streamer: mysql-bin.000002:769159533; Lag: 0.93s, State: migrating; ETA: 14m7s
Copy: 3278000/5047883 64.9%; Applied: 0; Backlog: 0/1000; Time: 26m0s(total), 26m0s(copy); streamer: mysql-bin.000002:779557176; Lag: 0.49s, State: throttled, lag=1.507643s; ETA: 14m2s
Copy: 3321000/5047883 65.8%; Applied: 0; Backlog: 0/1000; Time: 26m30s(total), 26m30s(copy); streamer: mysql-bin.000002:787988193; Lag: 2.07s, State: migrating; ETA: 13m46s
Copy: 3363000/5047883 66.6%; Applied: 0; Backlog: 0/1000; Time: 27m0s(total), 27m0s(copy); streamer: mysql-bin.000002:796224431; Lag: 0.95s, State: migrating; ETA: 13m31s
Copy: 3431000/5047883 68.0%; Applied: 0; Backlog: 0/1000; Time: 27m30s(total), 27m30s(copy); streamer: mysql-bin.000002:809543122; Lag: 0.27s, State: migrating; ETA: 12m57s
Copy: 3457000/5047883 68.5%; Applied: 0; Backlog: 0/1000; Time: 28m0s(total), 28m0s(copy); streamer: mysql-bin.000002:814649963; Lag: 0.38s, State: migrating; ETA: 12m53s
Copy: 3482000/5047883 69.0%; Applied: 0; Backlog: 0/1000; Time: 28m30s(total), 28m30s(copy); streamer: mysql-bin.000002:819556999; Lag: 1.30s, State: throttled, lag=1.623312s; ETA: 12m49s
Copy: 3508000/5047883 69.5%; Applied: 0; Backlog: 0/1000; Time: 29m0s(total), 29m0s(copy); streamer: mysql-bin.000002:824669576; Lag: 0.52s, State: migrating; ETA: 12m43s
Copy: 3556000/5047883 70.4%; Applied: 0; Backlog: 0/1000; Time: 29m30s(total), 29m30s(copy); streamer: mysql-bin.000002:834080033; Lag: 0.32s, State: migrating; ETA: 12m22s
Copy: 3609000/5047883 71.5%; Applied: 0; Backlog: 0/1000; Time: 31m0s(total), 31m0s(copy); streamer: mysql-bin.000002:844484685; Lag: 1.16s, State: migrating; ETA: 12m21s
Copy: 3642000/5047883 72.1%; Applied: 0; Backlog: 0/1000; Time: 31m30s(total), 31m30s(copy); streamer: mysql-bin.000002:850964400; Lag: 0.29s, State: migrating; ETA: 12m9s
Copy: 3668000/5047883 72.7%; Applied: 0; Backlog: 0/1000; Time: 32m0s(total), 32m0s(copy); streamer: mysql-bin.000002:856070568; Lag: 0.15s, State: migrating; ETA: 12m2s
Copy: 3688000/5047883 73.1%; Applied: 0; Backlog: 0/1000; Time: 32m30s(total), 32m30s(copy); streamer: mysql-bin.000002:860001001; Lag: 4.55s, State: throttled, lag=1.588609s; ETA: 11m59s
Copy: 3766000/5047883 74.6%; Applied: 0; Backlog: 0/1000; Time: 33m0s(total), 33m0s(copy); streamer: mysql-bin.000002:875273568; Lag: 0.62s, State: migrating; ETA: 11m13s
Copy: 3860000/5047883 76.5%; Applied: 0; Backlog: 0/1000; Time: 33m30s(total), 33m30s(copy); streamer: mysql-bin.000002:893682585; Lag: 0.54s, State: migrating; ETA: 10m18s
Copy: 3940000/5047883 78.1%; Applied: 0; Backlog: 0/1000; Time: 34m0s(total), 34m0s(copy); streamer: mysql-bin.000002:909353322; Lag: 0.12s, State: migrating; ETA: 9m33s
[mysql] 2020/05/06 17:03:35 packets.go:36: unexpected EOF
2020-05-06 17:03:38 ERROR invalid connection
2020-05-06 17:03:38 ERROR invalid connection
Copy: 3978000/5047883 78.8%; Applied: 0; Backlog: 0/1000; Time: 35m0s(total), 35m0s(copy); streamer: mysql-bin.000002:916800221; Lag: 1.19s, State: throttled, lag=1.515923s; ETA: 9m24s
Copy: 3996000/5047883 79.2%; Applied: 0; Backlog: 0/1000; Time: 35m30s(total), 35m30s(copy); streamer: mysql-bin.000002:920350521; Lag: 0.81s, State: migrating; ETA: 9m20s
Copy: 4024000/5047883 79.7%; Applied: 0; Backlog: 0/1000; Time: 36m0s(total), 36m1s(copy); streamer: mysql-bin.000002:925853153; Lag: 0.26s, State: migrating; ETA: 9m9s
Copy: 4050000/5047883 80.2%; Applied: 0; Backlog: 0/1000; Time: 36m30s(total), 36m31s(copy); streamer: mysql-bin.000002:930958582; Lag: 4.10s, State: migrating; ETA: 8m59s
Copy: 4087000/5047883 81.0%; Applied: 0; Backlog: 0/1000; Time: 37m0s(total), 37m0s(copy); streamer: mysql-bin.000002:938222964; Lag: 0.42s, State: migrating; ETA: 8m41s
Copy: 4096000/5047883 81.1%; Applied: 0; Backlog: 0/1000; Time: 38m0s(total), 38m1s(copy); streamer: mysql-bin.000002:940003036; Lag: 0.22s, State: migrating; ETA: 8m49s
Copy: 4117000/5047883 81.6%; Applied: 0; Backlog: 0/1000; Time: 38m30s(total), 38m30s(copy); streamer: mysql-bin.000002:944136325; Lag: 0.63s, State: migrating; ETA: 8m42s
Copy: 4155000/5047883 82.3%; Applied: 0; Backlog: 0/1000; Time: 39m0s(total), 39m0s(copy); streamer: mysql-bin.000002:951593089; Lag: 0.62s, State: migrating; ETA: 8m22s
Copy: 4176000/5047883 82.7%; Applied: 0; Backlog: 0/1000; Time: 39m30s(total), 39m48s(copy); streamer: mysql-bin.000002:955710247; Lag: 1.62s, State: migrating; ETA: 8m18s
# Migrating `sbtest`.`sbtest1`; Ghost table is `sbtest`.`_sbtest1_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 16:28:51 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.sbtest1.sock
Copy: 4177000/5047883 82.7%; Applied: 0; Backlog: 0/1000; Time: 40m0s(total), 40m0s(copy); streamer: mysql-bin.000002:955909143; Lag: 0.91s, State: throttled, lag=4.898835s; ETA: 8m20s
Copy: 4187000/5047883 82.9%; Applied: 0; Backlog: 0/1000; Time: 40m30s(total), 40m30s(copy); streamer: mysql-bin.000002:957888230; Lag: 0.25s, State: migrating; ETA: 8m19s
Copy: 4239000/5047883 84.0%; Applied: 0; Backlog: 0/1000; Time: 41m0s(total), 41m0s(copy); streamer: mysql-bin.000002:968087087; Lag: 0.62s, State: migrating; ETA: 7m49s
Copy: 4257000/5047883 84.3%; Applied: 0; Backlog: 0/1000; Time: 41m30s(total), 41m32s(copy); streamer: mysql-bin.000002:971631581; Lag: 0.68s, State: migrating; ETA: 7m42s
Copy: 4296000/5047883 85.1%; Applied: 0; Backlog: 0/1000; Time: 42m30s(total), 42m29s(copy); streamer: mysql-bin.000002:979275164; Lag: 1.63s, State: migrating; ETA: 7m26s
Copy: 4306000/5047883 85.3%; Applied: 0; Backlog: 0/1000; Time: 43m0s(total), 43m0s(copy); streamer: mysql-bin.000002:981249354; Lag: 0.48s, State: migrating; ETA: 7m24s
Copy: 4356000/5047883 86.3%; Applied: 0; Backlog: 0/1000; Time: 43m30s(total), 43m30s(copy); streamer: mysql-bin.000002:991059808; Lag: 0.74s, State: throttled, lag=1.516568s; ETA: 6m54s
Copy: 4396000/5047883 87.1%; Applied: 0; Backlog: 0/1000; Time: 44m0s(total), 44m0s(copy); streamer: mysql-bin.000002:998915950; Lag: 0.32s, State: migrating; ETA: 6m31s
Copy: 4407000/5047883 87.3%; Applied: 0; Backlog: 0/1000; Time: 44m30s(total), 44m29s(copy); streamer: mysql-bin.000002:1001083695; Lag: 3.51s, State: throttled, lag=1.586052s; ETA: 6m28s
Copy: 4407000/5047883 87.3%; Applied: 0; Backlog: 0/1000; Time: 44m30s(total), 44m30s(copy); streamer: mysql-bin.000002:1001083695; Lag: 3.75s, State: throttled, lag=1.586052s; ETA: 6m28s
Copy: 4421000/5047883 87.6%; Applied: 0; Backlog: 0/1000; Time: 45m0s(total), 45m0s(copy); streamer: mysql-bin.000002:1003834379; Lag: 2.02s, State: migrating; ETA: 6m22s
Copy: 4480000/5047883 88.8%; Applied: 0; Backlog: 0/1000; Time: 45m30s(total), 45m30s(copy); streamer: mysql-bin.000002:1015401084; Lag: 0.52s, State: migrating; ETA: 5m46s
Copy: 4524000/5047883 89.6%; Applied: 0; Backlog: 0/1000; Time: 46m0s(total), 46m0s(copy); streamer: mysql-bin.000002:1024028381; Lag: 0.11s, State: migrating; ETA: 5m19s
Copy: 4628000/5047883 91.7%; Applied: 0; Backlog: 0/1000; Time: 46m30s(total), 46m30s(copy); streamer: mysql-bin.000002:1044389891; Lag: 0.13s, State: migrating; ETA: 4m13s
Copy: 4742000/5047883 93.9%; Applied: 0; Backlog: 0/1000; Time: 47m0s(total), 47m0s(copy); streamer: mysql-bin.000002:1066704721; Lag: 0.08s, State: migrating; ETA: 3m1s
Copy: 4751000/5047883 94.1%; Applied: 0; Backlog: 0/1000; Time: 47m5s(total), 47m5s(copy); streamer: mysql-bin.000002:1068466953; Lag: 0.12s, State: migrating; ETA: 2m56s
Copy: 4753000/5047883 94.2%; Applied: 0; Backlog: 0/1000; Time: 47m10s(total), 47m10s(copy); streamer: mysql-bin.000002:1068861805; Lag: 0.68s, State: migrating; ETA: 2m55s
Copy: 4757000/5047883 94.2%; Applied: 0; Backlog: 0/1000; Time: 47m15s(total), 47m15s(copy); streamer: mysql-bin.000002:1069647723; Lag: 1.11s, State: migrating; ETA: 2m53s
Copy: 4759000/5047883 94.3%; Applied: 0; Backlog: 0/1000; Time: 47m20s(total), 47m20s(copy); streamer: mysql-bin.000002:1070043618; Lag: 0.49s, State: migrating; ETA: 2m52s
Copy: 4762000/5047883 94.3%; Applied: 0; Backlog: 0/1000; Time: 47m25s(total), 47m25s(copy); streamer: mysql-bin.000002:1070631897; Lag: 2.59s, State: migrating; ETA: 2m50s
Copy: 4770000/5047883 94.5%; Applied: 0; Backlog: 0/1000; Time: 47m30s(total), 47m30s(copy); streamer: mysql-bin.000002:1072400444; Lag: 0.22s, State: migrating; ETA: 2m46s
Copy: 4777000/5047883 94.6%; Applied: 0; Backlog: 0/1000; Time: 47m35s(total), 47m35s(copy); streamer: mysql-bin.000002:1073773099; Lag: 2.81s, State: migrating; ETA: 2m41s
[2020/05/06 17:16:28] [info] binlogsyncer.go:723 rotate to (mysql-bin.000003, 4)
[2020/05/06 17:16:29] [info] binlogsyncer.go:723 rotate to (mysql-bin.000003, 4)
Copy: 4783000/5047883 94.8%; Applied: 0; Backlog: 0/1000; Time: 47m40s(total), 47m40s(copy); streamer: mysql-bin.000003:983357; Lag: 0.24s, State: migrating; ETA: 2m38s
Copy: 4794000/5047883 95.0%; Applied: 0; Backlog: 0/1000; Time: 47m45s(total), 47m45s(copy); streamer: mysql-bin.000003:3138380; Lag: 1.85s, State: migrating; ETA: 2m31s
Copy: 4795000/5047883 95.0%; Applied: 0; Backlog: 0/1000; Time: 47m50s(total), 47m50s(copy); streamer: mysql-bin.000003:3334628; Lag: 6.81s, State: migrating; ETA: 2m31s
Copy: 4795000/5047883 95.0%; Applied: 0; Backlog: 0/1000; Time: 47m55s(total), 47m55s(copy); streamer: mysql-bin.000003:3335870; Lag: 7.88s, State: throttled, lag=1.546254s; ETA: 2m31s
Copy: 4796000/5047883 95.0%; Applied: 0; Backlog: 0/1000; Time: 48m0s(total), 48m0s(copy); streamer: mysql-bin.000003:3536684; Lag: 0.82s, State: migrating; ETA: 2m31s
Copy: 4798000/5047883 95.0%; Applied: 0; Backlog: 0/1000; Time: 48m5s(total), 48m5s(copy); streamer: mysql-bin.000003:3928723; Lag: 3.51s, State: migrating; ETA: 2m30s
Copy: 4810000/5047883 95.3%; Applied: 0; Backlog: 0/1000; Time: 48m10s(total), 48m10s(copy); streamer: mysql-bin.000003:6281679; Lag: 0.38s, State: migrating; ETA: 2m22s
Copy: 4817000/5047883 95.4%; Applied: 0; Backlog: 0/1000; Time: 48m15s(total), 48m15s(copy); streamer: mysql-bin.000003:7653529; Lag: 1.63s, State: migrating; ETA: 2m18s
Copy: 4827000/5047883 95.6%; Applied: 0; Backlog: 0/1000; Time: 48m20s(total), 48m20s(copy); streamer: mysql-bin.000003:9812658; Lag: 0.12s, State: migrating; ETA: 2m12s
Copy: 4839000/5047883 95.9%; Applied: 0; Backlog: 0/1000; Time: 48m25s(total), 48m25s(copy); streamer: mysql-bin.000003:11969878; Lag: 0.03s, State: migrating; ETA: 2m5s
Copy: 4848000/5047883 96.0%; Applied: 0; Backlog: 0/1000; Time: 48m30s(total), 48m30s(copy); streamer: mysql-bin.000003:13736211; Lag: 0.12s, State: migrating; ETA: 1m59s
Copy: 4856000/5047883 96.2%; Applied: 0; Backlog: 0/1000; Time: 48m35s(total), 48m35s(copy); streamer: mysql-bin.000003:15304215; Lag: 2.33s, State: migrating; ETA: 1m55s
Copy: 4868000/5047883 96.4%; Applied: 0; Backlog: 0/1000; Time: 48m40s(total), 48m40s(copy); streamer: mysql-bin.000003:17658271; Lag: 1.30s, State: migrating; ETA: 1m47s
Copy: 4877000/5047883 96.6%; Applied: 0; Backlog: 0/1000; Time: 48m45s(total), 48m45s(copy); streamer: mysql-bin.000003:19423005; Lag: 0.22s, State: migrating; ETA: 1m42s
Copy: 4885000/5047883 96.8%; Applied: 0; Backlog: 0/1000; Time: 48m50s(total), 48m50s(copy); streamer: mysql-bin.000003:20991451; Lag: 0.12s, State: migrating; ETA: 1m37s
Copy: 4890000/5047883 96.9%; Applied: 0; Backlog: 0/1000; Time: 48m55s(total), 48m55s(copy); streamer: mysql-bin.000003:21973519; Lag: 0.12s, State: migrating; ETA: 1m34s
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:41 ERROR invalid connection
2020-05-06 17:18:41 ERROR invalid connection
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:41 ERROR invalid connection
2020-05-06 17:18:41 ERROR invalid connection
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:41 ERROR invalid connection
2020-05-06 17:18:41 ERROR invalid connection
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:41 ERROR invalid connection
2020-05-06 17:18:41 ERROR invalid connection
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:41 ERROR invalid connection
2020-05-06 17:18:41 ERROR invalid connection
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:41 ERROR invalid connection
2020-05-06 17:18:41 ERROR invalid connection
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:41 ERROR invalid connection
2020-05-06 17:18:41 ERROR invalid connection
[mysql] 2020/05/06 17:18:42 packets.go:36: unexpected EOF
2020-05-06 17:18:42 ERROR invalid connection
2020-05-06 17:18:42 ERROR invalid connection
[mysql] 2020/05/06 17:18:42 packets.go:36: unexpected EOF
2020-05-06 17:18:42 ERROR invalid connection
2020-05-06 17:18:42 ERROR invalid connection
[mysql] 2020/05/06 17:18:40 packets.go:36: unexpected EOF
2020-05-06 17:18:42 ERROR invalid connection
2020-05-06 17:18:42 ERROR invalid connection
[mysql] 2020/05/06 17:18:40 packets.go:36: unexpected EOF
2020-05-06 17:18:42 ERROR invalid connection
2020-05-06 17:18:42 ERROR invalid connection
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:42 ERROR invalid connection
2020-05-06 17:18:42 ERROR invalid connection
[mysql] 2020/05/06 17:18:41 packets.go:36: unexpected EOF
2020-05-06 17:18:42 ERROR invalid connection
2020-05-06 17:18:42 ERROR invalid connection
2020-05-06 17:18:42 ERROR invalid connection
2020-05-06 17:18:42 ERROR invalid connection
Copy: 4897000/5047883 97.0%; Applied: 0; Backlog: 0/1000; Time: 49m40s(total), 49m41s(copy); streamer: mysql-bin.000003:23344521; Lag: 1.51s, State: migrating; ETA: 1m31s
Copy: 4897000/5047883 97.0%; Applied: 0; Backlog: 0/1000; Time: 49m55s(total), 49m55s(copy); streamer: mysql-bin.000003:23344521; Lag: 1.51s, State: migrating; ETA: 1m32s
# Migrating `sbtest`.`sbtest1`; Ghost table is `sbtest`.`_sbtest1_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 16:28:51 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.sbtest1.sock
Copy: 4897000/5047883 97.0%; Applied: 0; Backlog: 0/1000; Time: 50m0s(total), 50m0s(copy); streamer: mysql-bin.000003:23345835; Lag: 61.50s, State: throttled, lag=1.514292s; ETA: 1m32s
Copy: 4900000/5047883 97.1%; Applied: 0; Backlog: 0/1000; Time: 50m5s(total), 50m5s(copy); streamer: mysql-bin.000003:23938661; Lag: 1.27s, State: throttled, lag=1.576376s; ETA: 1m30s
Copy: 4902000/5047883 97.1%; Applied: 0; Backlog: 0/1000; Time: 50m10s(total), 50m10s(copy); streamer: mysql-bin.000003:24333760; Lag: 0.88s, State: throttled, lag=1.572231s; ETA: 1m29s
Copy: 4902000/5047883 97.1%; Applied: 0; Backlog: 0/1000; Time: 50m15s(total), 50m15s(copy); streamer: mysql-bin.000003:24338784; Lag: 0.37s, State: throttled, lag=1.714198s; ETA: 1m29s
Copy: 4906000/5047883 97.2%; Applied: 0; Backlog: 0/1000; Time: 50m20s(total), 50m20s(copy); streamer: mysql-bin.000003:25128079; Lag: 0.49s, State: migrating; ETA: 1m27s
Copy: 4909000/5047883 97.2%; Applied: 0; Backlog: 0/1000; Time: 50m25s(total), 50m25s(copy); streamer: mysql-bin.000003:25720467; Lag: 0.25s, State: migrating; ETA: 1m25s
Copy: 4916000/5047883 97.4%; Applied: 0; Backlog: 0/1000; Time: 50m30s(total), 50m30s(copy); streamer: mysql-bin.000003:27094728; Lag: 0.38s, State: migrating; ETA: 1m21s
Copy: 4926000/5047883 97.6%; Applied: 0; Backlog: 0/1000; Time: 50m35s(total), 50m35s(copy); streamer: mysql-bin.000003:29055562; Lag: 0.31s, State: migrating; ETA: 1m15s
Copy: 4930000/5047883 97.7%; Applied: 0; Backlog: 0/1000; Time: 50m40s(total), 50m40s(copy); streamer: mysql-bin.000003:29842447; Lag: 1.02s, State: migrating; ETA: 1m12s
Copy: 4943000/5047883 97.9%; Applied: 0; Backlog: 0/1000; Time: 50m45s(total), 50m45s(copy); streamer: mysql-bin.000003:32393263; Lag: 0.43s, State: migrating; ETA: 1m4s
Copy: 4946000/5047883 98.0%; Applied: 0; Backlog: 0/1000; Time: 50m50s(total), 50m50s(copy); streamer: mysql-bin.000003:32984757; Lag: 0.89s, State: migrating; ETA: 1m2s
Copy: 4949000/5047883 98.0%; Applied: 0; Backlog: 0/1000; Time: 51m0s(total), 51m0s(copy); streamer: mysql-bin.000003:33577141; Lag: 0.79s, State: migrating; ETA: 1m1s
Copy: 4951000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m4s(total), 51m4s(copy); streamer: mysql-bin.000003:33971023; Lag: 0.88s, State: migrating; ETA: 59s
Copy: 4952000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m5s(total), 51m5s(copy); streamer: mysql-bin.000003:34167312; Lag: 0.43s, State: migrating; ETA: 59s
Copy: 4952000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m6s(total), 51m6s(copy); streamer: mysql-bin.000003:34168210; Lag: 1.17s, State: migrating; ETA: 59s
Copy: 4953000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m7s(total), 51m7s(copy); streamer: mysql-bin.000003:34363601; Lag: 1.40s, State: migrating; ETA: 58s
Copy: 4953000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m10s(total), 51m10s(copy); streamer: mysql-bin.000003:34364499; Lag: 3.94s, State: migrating; ETA: 58s
Copy: 4953000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m9s(total), 51m9s(copy); streamer: mysql-bin.000003:34364499; Lag: 2.95s, State: migrating; ETA: 58s
Copy: 4953000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m8s(total), 51m8s(copy); streamer: mysql-bin.000003:34364499; Lag: 1.94s, State: migrating; ETA: 58s
Copy: 4953000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m11s(total), 51m11s(copy); streamer: mysql-bin.000003:34364499; Lag: 4.94s, State: migrating; ETA: 58s
Copy: 4953000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m12s(total), 51m12s(copy); streamer: mysql-bin.000003:34367742; Lag: 4.20s, State: migrating; ETA: 58s
Copy: 4953000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m13s(total), 51m13s(copy); streamer: mysql-bin.000003:34368083; Lag: 5.20s, State: throttled, lag=1.599665s; ETA: 58s
Copy: 4953000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m14s(total), 51m14s(copy); streamer: mysql-bin.000003:34368982; Lag: 2.33s, State: throttled, lag=1.599665s; ETA: 58s
Copy: 4954000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m15s(total), 51m15s(copy); streamer: mysql-bin.000003:34568357; Lag: 0.07s, State: throttled, lag=3.028890s; ETA: 58s
Copy: 4954000/5047883 98.1%; Applied: 0; Backlog: 0/1000; Time: 51m16s(total), 51m16s(copy); streamer: mysql-bin.000003:34570821; Lag: 0.34s, State: migrating; ETA: 58s
Copy: 4955000/5047883 98.2%; Applied: 0; Backlog: 0/1000; Time: 51m17s(total), 51m17s(copy); streamer: mysql-bin.000003:34766710; Lag: 1.02s, State: migrating; ETA: 57s
Copy: 4956000/5047883 98.2%; Applied: 0; Backlog: 0/1000; Time: 51m19s(total), 51m19s(copy); streamer: mysql-bin.000003:34964565; Lag: 0.09s, State: migrating; ETA: 57s
Copy: 4955000/5047883 98.2%; Applied: 0; Backlog: 0/1000; Time: 51m18s(total), 51m18s(copy); streamer: mysql-bin.000003:34766710; Lag: 2.02s, State: migrating; ETA: 57s
Copy: 4960000/5047883 98.3%; Applied: 0; Backlog: 0/1000; Time: 51m20s(total), 51m20s(copy); streamer: mysql-bin.000003:35750579; Lag: 0.08s, State: migrating; ETA: 54s
Copy: 4963000/5047883 98.3%; Applied: 0; Backlog: 0/1000; Time: 51m21s(total), 51m21s(copy); streamer: mysql-bin.000003:36337652; Lag: 0.19s, State: migrating; ETA: 52s
Copy: 4964000/5047883 98.3%; Applied: 0; Backlog: 0/1000; Time: 51m23s(total), 51m23s(copy); streamer: mysql-bin.000003:36533943; Lag: 1.55s, State: migrating; ETA: 52s
Copy: 4964000/5047883 98.3%; Applied: 0; Backlog: 0/1000; Time: 51m22s(total), 51m22s(copy); streamer: mysql-bin.000003:36533943; Lag: 0.76s, State: migrating; ETA: 52s
Copy: 4966000/5047883 98.4%; Applied: 0; Backlog: 0/1000; Time: 51m24s(total), 51m24s(copy); streamer: mysql-bin.000003:36928729; Lag: 0.12s, State: migrating; ETA: 50s
Copy: 4967000/5047883 98.4%; Applied: 0; Backlog: 0/1000; Time: 51m25s(total), 51m25s(copy); streamer: mysql-bin.000003:37125422; Lag: 0.69s, State: migrating; ETA: 50s
Copy: 4968000/5047883 98.4%; Applied: 0; Backlog: 0/1000; Time: 51m26s(total), 51m26s(copy); streamer: mysql-bin.000003:37321311; Lag: 0.92s, State: migrating; ETA: 49s
Copy: 4969000/5047883 98.4%; Applied: 0; Backlog: 0/1000; Time: 51m28s(total), 51m28s(copy); streamer: mysql-bin.000003:37518003; Lag: 1.60s, State: migrating; ETA: 49s
Copy: 4969000/5047883 98.4%; Applied: 0; Backlog: 0/1000; Time: 51m27s(total), 51m27s(copy); streamer: mysql-bin.000003:37517602; Lag: 0.61s, State: migrating; ETA: 49s
Copy: 4970000/5047883 98.5%; Applied: 0; Backlog: 0/1000; Time: 51m29s(total), 51m29s(copy); streamer: mysql-bin.000003:37716250; Lag: 0.77s, State: throttled, lag=1.596755s; ETA: 48s
Copy: 4972000/5047883 98.5%; Applied: 0; Backlog: 0/1000; Time: 51m30s(total), 51m30s(copy); streamer: mysql-bin.000003:38110300; Lag: 0.41s, State: migrating; ETA: 47s
Copy: 4972000/5047883 98.5%; Applied: 0; Backlog: 0/1000; Time: 51m31s(total), 51m31s(copy); streamer: mysql-bin.000003:38111200; Lag: 1.17s, State: migrating; ETA: 47s
Copy: 4975000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m32s(total), 51m32s(copy); streamer: mysql-bin.000003:38699077; Lag: 0.46s, State: migrating; ETA: 45s
Copy: 4976000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m35s(total), 51m35s(copy); streamer: mysql-bin.000003:38895368; Lag: 2.64s, State: migrating; ETA: 44s
Copy: 4976000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m34s(total), 51m34s(copy); streamer: mysql-bin.000003:38895368; Lag: 1.64s, State: migrating; ETA: 44s
Copy: 4976000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m33s(total), 51m33s(copy); streamer: mysql-bin.000003:38895368; Lag: 0.64s, State: migrating; ETA: 44s
Copy: 4977000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m36s(total), 51m36s(copy); streamer: mysql-bin.000003:39093354; Lag: 0.58s, State: throttled, lag=1.543815s; ETA: 44s
Copy: 4977000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m37s(total), 51m37s(copy); streamer: mysql-bin.000003:39094627; Lag: 1.34s, State: throttled, lag=1.543815s; ETA: 44s
Copy: 4979000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m38s(total), 51m38s(copy); streamer: mysql-bin.000003:39487471; Lag: 0.18s, State: migrating; ETA: 42s
Copy: 4979000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m39s(total), 51m39s(copy); streamer: mysql-bin.000003:39487873; Lag: 1.05s, State: migrating; ETA: 42s
Copy: 4979000/5047883 98.6%; Applied: 0; Backlog: 0/1000; Time: 51m40s(total), 51m40s(copy); streamer: mysql-bin.000003:39488773; Lag: 1.95s, State: migrating; ETA: 42s
Copy: 4980000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m41s(total), 51m41s(copy); streamer: mysql-bin.000003:39688462; Lag: 0.12s, State: migrating; ETA: 42s
Copy: 4981000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m42s(total), 51m42s(copy); streamer: mysql-bin.000003:39885154; Lag: 0.58s, State: migrating; ETA: 41s
Copy: 4981000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m43s(total), 51m43s(copy); streamer: mysql-bin.000003:39886456; Lag: 0.32s, State: migrating; ETA: 41s
Copy: 4981000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m44s(total), 51m44s(copy); streamer: mysql-bin.000003:39886456; Lag: 1.32s, State: migrating; ETA: 41s
Copy: 4981000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m45s(total), 51m45s(copy); streamer: mysql-bin.000003:39886858; Lag: 2.02s, State: migrating; ETA: 41s
Copy: 4983000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m48s(total), 51m47s(copy); streamer: mysql-bin.000003:40282142; Lag: 0.19s, State: migrating; ETA: 40s
Copy: 4983000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m49s(total), 51m49s(copy); streamer: mysql-bin.000003:40282640; Lag: 3.39s, State: migrating; ETA: 40s
Copy: 4983000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m48s(total), 51m48s(copy); streamer: mysql-bin.000003:40282142; Lag: 2.39s, State: migrating; ETA: 40s
Copy: 4984000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m50s(total), 51m50s(copy); streamer: mysql-bin.000003:40478389; Lag: 1.58s, State: migrating; ETA: 39s
Copy: 4984000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m53s(total), 51m52s(copy); streamer: mysql-bin.000003:40479944; Lag: 2.18s, State: throttled, lag=1.986353s; ETA: 39s
Copy: 4984000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m54s(total), 51m54s(copy); streamer: mysql-bin.000003:40481713; Lag: 4.48s, State: throttled, lag=1.986353s; ETA: 39s
Copy: 4984000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m53s(total), 51m53s(copy); streamer: mysql-bin.000003:40479944; Lag: 4.58s, State: throttled, lag=1.986353s; ETA: 39s
Copy: 4984000/5047883 98.7%; Applied: 0; Backlog: 0/1000; Time: 51m55s(total), 51m55s(copy); streamer: mysql-bin.000003:40481713; Lag: 5.48s, State: throttled, lag=1.986353s; ETA: 39s
Copy: 4985000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 51m56s(total), 51m56s(copy); streamer: mysql-bin.000003:40680716; Lag: 0.77s, State: throttled, lag=5.581535s; ETA: 39s
Copy: 4985000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 51m57s(total), 51m57s(copy); streamer: mysql-bin.000003:40682734; Lag: 0.56s, State: migrating; ETA: 39s
Copy: 4986000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 51m58s(total), 51m58s(copy); streamer: mysql-bin.000003:40879024; Lag: 0.43s, State: migrating; ETA: 38s
Copy: 4986000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 51m59s(total), 51m59s(copy); streamer: mysql-bin.000003:40879522; Lag: 1.43s, State: migrating; ETA: 38s
Copy: 4986000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 52m0s(total), 52m0s(copy); streamer: mysql-bin.000003:40879522; Lag: 2.43s, State: migrating; ETA: 38s
Copy: 4986000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 52m1s(total), 52m1s(copy); streamer: mysql-bin.000003:40879923; Lag: 3.15s, State: migrating; ETA: 38s
Copy: 4986000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 52m2s(total), 52m2s(copy); streamer: mysql-bin.000003:40882173; Lag: 1.71s, State: migrating; ETA: 38s
Copy: 4987000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 52m3s(total), 52m3s(copy); streamer: mysql-bin.000003:41079159; Lag: 0.68s, State: throttled, lag=1.530656s; ETA: 38s
Copy: 4987000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 52m4s(total), 52m4s(copy); streamer: mysql-bin.000003:41082320; Lag: 0.50s, State: migrating; ETA: 38s
Copy: 4988000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 52m5s(total), 52m5s(copy); streamer: mysql-bin.000003:41278609; Lag: 0.93s, State: migrating; ETA: 37s
Copy: 4988000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 52m6s(total), 52m6s(copy); streamer: mysql-bin.000003:41278609; Lag: 1.93s, State: migrating; ETA: 37s
Copy: 4989000/5047883 98.8%; Applied: 0; Backlog: 0/1000; Time: 52m7s(total), 52m7s(copy); streamer: mysql-bin.000003:41475752; Lag: 0.78s, State: migrating; ETA: 36s
Copy: 4990000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m8s(total), 52m8s(copy); streamer: mysql-bin.000003:41671980; Lag: 1.12s, State: throttled, lag=1.527130s; ETA: 36s
Copy: 4990000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m9s(total), 52m9s(copy); streamer: mysql-bin.000003:41673251; Lag: 1.01s, State: throttled, lag=1.527130s; ETA: 36s
Copy: 4990000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m10s(total), 52m10s(copy); streamer: mysql-bin.000003:41673653; Lag: 1.92s, State: throttled, lag=1.527130s; ETA: 36s
Copy: 4990000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m11s(total), 52m11s(copy); streamer: mysql-bin.000003:41673996; Lag: 2.92s, State: migrating; ETA: 36s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m12s(total), 52m12s(copy); streamer: mysql-bin.000003:41872768; Lag: 0.57s, State: throttled, lag=2.415707s; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m13s(total), 52m13s(copy); streamer: mysql-bin.000003:41873170; Lag: 1.40s, State: throttled, lag=2.415707s; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m14s(total), 52m14s(copy); streamer: mysql-bin.000003:41875295; Lag: 1.39s, State: throttled, lag=1.652261s; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m15s(total), 52m15s(copy); streamer: mysql-bin.000003:41876038; Lag: 1.28s, State: throttled, lag=1.900777s; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m16s(total), 52m16s(copy); streamer: mysql-bin.000003:41878971; Lag: 0.18s, State: migrating; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m17s(total), 52m17s(copy); streamer: mysql-bin.000003:41879373; Lag: 1.07s, State: migrating; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m18s(total), 52m18s(copy); streamer: mysql-bin.000003:41881129; Lag: 1.34s, State: migrating; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m19s(total), 52m19s(copy); streamer: mysql-bin.000003:41881129; Lag: 2.34s, State: migrating; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m23s(total), 52m23s(copy); streamer: mysql-bin.000003:41883270; Lag: 3.52s, State: throttled, lag=1.567526s; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m22s(total), 52m22s(copy); streamer: mysql-bin.000003:41883270; Lag: 2.52s, State: throttled, lag=1.567526s; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m21s(total), 52m21s(copy); streamer: mysql-bin.000003:41883270; Lag: 1.52s, State: throttled, lag=1.567526s; ETA: 35s
Copy: 4991000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m20s(total), 52m20s(copy); streamer: mysql-bin.000003:41882868; Lag: 2.00s, State: throttled, lag=1.567526s; ETA: 35s
Copy: 4992000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m24s(total), 52m24s(copy); streamer: mysql-bin.000003:42084012; Lag: 0.12s, State: migrating; ETA: 35s
Copy: 4992000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m25s(total), 52m25s(copy); streamer: mysql-bin.000003:42084012; Lag: 0.12s, State: migrating; ETA: 35s
Copy: 4992000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m26s(total), 52m26s(copy); streamer: mysql-bin.000003:42085812; Lag: 0.95s, State: migrating; ETA: 35s
Copy: 4992000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m27s(total), 52m27s(copy); streamer: mysql-bin.000003:42086170; Lag: 1.95s, State: migrating; ETA: 35s
Copy: 4993000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m29s(total), 52m29s(copy); streamer: mysql-bin.000003:42282399; Lag: 3.15s, State: throttled, lag=1.516319s; ETA: 34s
Copy: 4993000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m28s(total), 52m28s(copy); streamer: mysql-bin.000003:42282058; Lag: 2.15s, State: migrating; ETA: 34s
Copy: 4993000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m30s(total), 52m30s(copy); streamer: mysql-bin.000003:42284665; Lag: 2.26s, State: throttled, lag=1.516319s; ETA: 34s
Copy: 4994000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m31s(total), 52m31s(copy); streamer: mysql-bin.000003:42480910; Lag: 1.28s, State: throttled, lag=2.249445s; ETA: 33s
Copy: 4994000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m32s(total), 52m32s(copy); streamer: mysql-bin.000003:42483682; Lag: 0.68s, State: throttled, lag=2.456523s; ETA: 34s
Copy: 4994000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m33s(total), 52m33s(copy); streamer: mysql-bin.000003:42485296; Lag: 1.00s, State: throttled, lag=1.577704s; ETA: 34s
Copy: 4994000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m35s(total), 52m35s(copy); streamer: mysql-bin.000003:42486041; Lag: 1.30s, State: migrating; ETA: 34s
Copy: 4994000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m34s(total), 52m34s(copy); streamer: mysql-bin.000003:42486041; Lag: 1.30s, State: migrating; ETA: 34s
Copy: 4994000/5047883 98.9%; Applied: 0; Backlog: 0/1000; Time: 52m36s(total), 52m36s(copy); streamer: mysql-bin.000003:42486842; Lag: 1.30s, State: migrating; ETA: 34s
Copy: 4995000/5047883 99.0%; Applied: 0; Backlog: 0/1000; Time: 52m37s(total), 52m37s(copy); streamer: mysql-bin.000003:42684641; Lag: 0.65s, State: migrating; ETA: 33s
Copy: 4995000/5047883 99.0%; Applied: 0; Backlog: 0/1000; Time: 52m38s(total), 52m38s(copy); streamer: mysql-bin.000003:42685541; Lag: 1.20s, State: migrating; ETA: 33s
Copy: 4996000/5047883 99.0%; Applied: 0; Backlog: 0/1000; Time: 52m39s(total), 52m39s(copy); streamer: mysql-bin.000003:42881832; Lag: 0.73s, State: migrating; ETA: 32s
Copy: 4996000/5047883 99.0%; Applied: 0; Backlog: 0/1000; Time: 52m40s(total), 52m40s(copy); streamer: mysql-bin.000003:42882234; Lag: 1.26s, State: migrating; ETA: 32s
Copy: 4998000/5047883 99.0%; Applied: 0; Backlog: 0/1000; Time: 52m41s(total), 52m41s(copy); streamer: mysql-bin.000003:43274816; Lag: 0.51s, State: migrating; ETA: 31s
Copy: 4999000/5047883 99.0%; Applied: 0; Backlog: 0/1000; Time: 52m42s(total), 52m42s(copy); streamer: mysql-bin.000003:43470705; Lag: 1.42s, State: migrating; ETA: 30s
Copy: 5000000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m44s(total), 52m44s(copy); streamer: mysql-bin.000003:43667354; Lag: 1.59s, State: migrating; ETA: 30s
Copy: 5000000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m43s(total), 52m43s(copy); streamer: mysql-bin.000003:43666952; Lag: 1.03s, State: migrating; ETA: 30s
Copy: 5000000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m45s(total), 52m45s(copy); streamer: mysql-bin.000003:43669449; Lag: 1.93s, State: throttled, lag=1.517106s; ETA: 30s
Copy: 5000000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m46s(total), 52m46s(copy); streamer: mysql-bin.000003:43669850; Lag: 1.12s, State: throttled, lag=1.517106s; ETA: 30s
Copy: 5001000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m47s(total), 52m47s(copy); streamer: mysql-bin.000003:43777365; Lag: 0.42s, State: throttled, lag=1.519787s; ETA: 29s
Copy: 5001000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m48s(total), 52m48s(copy); streamer: mysql-bin.000003:43779383; Lag: 0.81s, State: migrating; ETA: 29s
Copy: 5002000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m50s(total), 52m50s(copy); streamer: mysql-bin.000003:43885735; Lag: 1.64s, State: migrating; ETA: 29s
Copy: 5002000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m49s(total), 52m49s(copy); streamer: mysql-bin.000003:43885735; Lag: 0.64s, State: migrating; ETA: 29s
Copy: 5002000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m51s(total), 52m51s(copy); streamer: mysql-bin.000003:43886136; Lag: 2.11s, State: migrating; ETA: 29s
Copy: 5003000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m52s(total), 52m52s(copy); streamer: mysql-bin.000003:43993037; Lag: 1.43s, State: migrating; ETA: 28s
Copy: 5004000/5047883 99.1%; Applied: 0; Backlog: 0/1000; Time: 52m53s(total), 52m53s(copy); streamer: mysql-bin.000003:44100029; Lag: 0.49s, State: migrating; ETA: 27s
Copy: 5005000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 52m54s(total), 52m54s(copy); streamer: mysql-bin.000003:44206381; Lag: 0.46s, State: migrating; ETA: 27s
Copy: 5005000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 52m55s(total), 52m55s(copy); streamer: mysql-bin.000003:44206381; Lag: 1.46s, State: migrating; ETA: 27s
Copy: 5008000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 52m56s(total), 52m56s(copy); streamer: mysql-bin.000003:44526333; Lag: 0.02s, State: migrating; ETA: 25s
Copy: 5009000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 52m57s(total), 52m57s(copy); streamer: mysql-bin.000003:44632283; Lag: 0.82s, State: migrating; ETA: 24s
Copy: 5009000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 52m58s(total), 52m58s(copy); streamer: mysql-bin.000003:44632685; Lag: 1.72s, State: migrating; ETA: 24s
Copy: 5010000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 52m59s(total), 52m59s(copy); streamer: mysql-bin.000003:44738189; Lag: 2.72s, State: migrating; ETA: 24s
Copy: 5010000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 53m2s(total), 53m2s(copy); streamer: mysql-bin.000003:44739089; Lag: 4.02s, State: migrating; ETA: 24s
Copy: 5010000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 53m1s(total), 53m1s(copy); streamer: mysql-bin.000003:44739089; Lag: 2.92s, State: migrating; ETA: 24s
Copy: 5010000/5047883 99.2%; Applied: 0; Backlog: 0/1000; Time: 53m0s(total), 53m0s(copy); streamer: mysql-bin.000003:44739089; Lag: 2.02s, State: migrating; ETA: 24s
Copy: 5011000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m3s(total), 53m3s(copy); streamer: mysql-bin.000003:44848725; Lag: 0.40s, State: throttled, lag=4.416482s; ETA: 23s
Copy: 5011000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m4s(total), 53m4s(copy); streamer: mysql-bin.000003:44848725; Lag: 1.40s, State: throttled, lag=4.416482s; ETA: 23s
Copy: 5011000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m5s(total), 53m5s(copy); streamer: mysql-bin.000003:44853489; Lag: 0.09s, State: throttled, lag=1.610257s; ETA: 23s
Copy: 5011000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m6s(total), 53m6s(copy); streamer: mysql-bin.000003:44855906; Lag: 0.82s, State: migrating; ETA: 23s
Copy: 5011000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m7s(total), 53m7s(copy); streamer: mysql-bin.000003:44856804; Lag: 1.64s, State: migrating; ETA: 23s
Copy: 5012000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m8s(total), 53m8s(copy); streamer: mysql-bin.000003:44963108; Lag: 0.86s, State: migrating; ETA: 22s
Copy: 5013000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m9s(total), 53m9s(copy); streamer: mysql-bin.000003:45071304; Lag: 0.06s, State: migrating; ETA: 22s
Copy: 5013000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m10s(total), 53m10s(copy); streamer: mysql-bin.000003:45072202; Lag: 1.02s, State: migrating; ETA: 22s
Copy: 5013000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m11s(total), 53m11s(copy); streamer: mysql-bin.000003:45072202; Lag: 2.02s, State: migrating; ETA: 22s
Copy: 5014000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m12s(total), 53m12s(copy); streamer: mysql-bin.000003:45179349; Lag: 0.95s, State: throttled, lag=1.758912s; ETA: 21s
Copy: 5015000/5047883 99.3%; Applied: 0; Backlog: 0/1000; Time: 53m13s(total), 53m13s(copy); streamer: mysql-bin.000003:45286819; Lag: 0.15s, State: migrating; ETA: 20s
Copy: 5016000/5047883 99.4%; Applied: 0; Backlog: 0/1000; Time: 53m14s(total), 53m14s(copy); streamer: mysql-bin.000003:45392769; Lag: 0.74s, State: migrating; ETA: 20s
Copy: 5016000/5047883 99.4%; Applied: 0; Backlog: 0/1000; Time: 53m15s(total), 53m15s(copy); streamer: mysql-bin.000003:45393669; Lag: 1.42s, State: migrating; ETA: 20s
Copy: 5017000/5047883 99.4%; Applied: 0; Backlog: 0/1000; Time: 53m16s(total), 53m16s(copy); streamer: mysql-bin.000003:45498719; Lag: 1.87s, State: migrating; ETA: 19s
Copy: 5017000/5047883 99.4%; Applied: 0; Backlog: 0/1000; Time: 53m17s(total), 53m17s(copy); streamer: mysql-bin.000003:45500475; Lag: 1.56s, State: migrating; ETA: 19s
Copy: 5019000/5047883 99.4%; Applied: 0; Backlog: 0/1000; Time: 53m18s(total), 53m18s(copy); streamer: mysql-bin.000003:45712511; Lag: 0.43s, State: throttled, lag=1.564375s; ETA: 18s
Copy: 5019000/5047883 99.4%; Applied: 0; Backlog: 0/1000; Time: 53m19s(total), 53m19s(copy); streamer: mysql-bin.000003:45715333; Lag: 0.32s, State: migrating; ETA: 18s
Copy: 5020000/5047883 99.4%; Applied: 0; Backlog: 0/1000; Time: 53m21s(total), 53m20s(copy); streamer: mysql-bin.000003:45821283; Lag: 0.92s, State: migrating; ETA: 17s
Copy: 5020000/5047883 99.4%; Applied: 0; Backlog: 0/1000; Time: 53m21s(total), 53m21s(copy); streamer: mysql-bin.000003:45822183; Lag: 1.11s, State: migrating; ETA: 17s
Copy: 5021000/5047883 99.5%; Applied: 0; Backlog: 0/1000; Time: 53m22s(total), 53m22s(copy); streamer: mysql-bin.000003:45928709; Lag: 0.42s, State: migrating; ETA: 17s
Copy: 5021000/5047883 99.5%; Applied: 0; Backlog: 0/1000; Time: 53m23s(total), 53m23s(copy); streamer: mysql-bin.000003:45928709; Lag: 1.42s, State: migrating; ETA: 17s
Copy: 5024000/5047883 99.5%; Applied: 0; Backlog: 0/1000; Time: 53m24s(total), 53m24s(copy); streamer: mysql-bin.000003:46249701; Lag: 0.22s, State: migrating; ETA: 15s
Copy: 5025000/5047883 99.5%; Applied: 0; Backlog: 0/1000; Time: 53m25s(total), 53m25s(copy); streamer: mysql-bin.000003:46356455; Lag: 0.66s, State: migrating; ETA: 14s
Copy: 5029000/5047883 99.6%; Applied: 0; Backlog: 0/1000; Time: 53m26s(total), 53m26s(copy); streamer: mysql-bin.000003:46779163; Lag: 0.12s, State: migrating; ETA: 12s
Copy: 5032000/5047883 99.7%; Applied: 0; Backlog: 0/1000; Time: 53m27s(total), 53m27s(copy); streamer: mysql-bin.000003:47095613; Lag: 0.51s, State: migrating; ETA: 10s
Copy: 5032000/5047883 99.7%; Applied: 0; Backlog: 0/1000; Time: 53m29s(total), 53m29s(copy); streamer: mysql-bin.000003:47096015; Lag: 2.42s, State: migrating; ETA: 10s
Copy: 5032000/5047883 99.7%; Applied: 0; Backlog: 0/1000; Time: 53m28s(total), 53m28s(copy); streamer: mysql-bin.000003:47096015; Lag: 1.42s, State: migrating; ETA: 10s
Copy: 5035000/5047883 99.7%; Applied: 0; Backlog: 0/1000; Time: 53m30s(total), 53m30s(copy); streamer: mysql-bin.000003:47416363; Lag: 0.11s, State: migrating; ETA: 8s
Copy: 5037000/5047883 99.8%; Applied: 0; Backlog: 0/1000; Time: 53m31s(total), 53m31s(copy); streamer: mysql-bin.000003:47627761; Lag: 0.09s, State: migrating; ETA: 6s
Copy: 5039000/5047883 99.8%; Applied: 0; Backlog: 0/1000; Time: 53m33s(total), 53m33s(copy); streamer: mysql-bin.000003:47839966; Lag: 1.14s, State: migrating; ETA: 5s
Copy: 5039000/5047883 99.8%; Applied: 0; Backlog: 0/1000; Time: 53m32s(total), 53m32s(copy); streamer: mysql-bin.000003:47839966; Lag: 0.14s, State: migrating; ETA: 5s
Copy: 5044000/5047883 99.9%; Applied: 0; Backlog: 0/1000; Time: 53m34s(total), 53m34s(copy); streamer: mysql-bin.000003:48367816; Lag: 0.12s, State: migrating; ETA: 2s
Copy: 5044000/5047883 99.9%; Applied: 0; Backlog: 0/1000; Time: 53m35s(total), 53m35s(copy); streamer: mysql-bin.000003:48369117; Lag: 1.02s, State: migrating; ETA: 2s
Copy: 5045000/5047883 99.9%; Applied: 0; Backlog: 0/1000; Time: 53m36s(total), 53m36s(copy); streamer: mysql-bin.000003:48474664; Lag: 0.99s, State: migrating; ETA: 1s
Copy: 5066000/5047883 100.4%; Applied: 0; Backlog: 0/1000; Time: 54m0s(total), 54m2s(copy); streamer: mysql-bin.000003:50705524; Lag: 3.10s, State: migrating; ETA: due
Copy: 5079000/5047883 100.6%; Applied: 0; Backlog: 0/1000; Time: 54m30s(total), 54m30s(copy); streamer: mysql-bin.000003:52096962; Lag: 0.09s, State: migrating; ETA: due
Copy: 5112000/5047883 101.3%; Applied: 0; Backlog: 0/1000; Time: 55m0s(total), 55m0s(copy); streamer: mysql-bin.000003:55593398; Lag: 1.21s, State: migrating; ETA: due
Copy: 5123000/5047883 101.5%; Applied: 0; Backlog: 0/1000; Time: 55m30s(total), 55m30s(copy); streamer: mysql-bin.000003:56763128; Lag: 1.86s, State: migrating; ETA: due
Copy: 5154000/5047883 102.1%; Applied: 0; Backlog: 0/1000; Time: 56m0s(total), 56m0s(copy); streamer: mysql-bin.000003:60051637; Lag: 1.73s, State: migrating; ETA: due
Copy: 5176000/5047883 102.5%; Applied: 0; Backlog: 0/1000; Time: 56m30s(total), 56m30s(copy); streamer: mysql-bin.000003:62392954; Lag: 0.72s, State: migrating; ETA: due
Copy: 5200000/5047883 103.0%; Applied: 0; Backlog: 0/1000; Time: 57m0s(total), 57m1s(copy); streamer: mysql-bin.000003:64940317; Lag: 2.44s, State: migrating; ETA: due
Copy: 5220000/5047883 103.4%; Applied: 0; Backlog: 0/1000; Time: 57m30s(total), 57m30s(copy); streamer: mysql-bin.000003:67063666; Lag: 3.52s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 57m48s(total), 57m48s(copy); streamer: mysql-bin.000003:69182884; Lag: 1.43s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 57m50s(total), 57m48s(copy); streamer: mysql-bin.000003:69187128; Lag: 0.22s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 57m55s(total), 57m48s(copy); streamer: mysql-bin.000003:69189189; Lag: 4.03s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m0s(total), 57m48s(copy); streamer: mysql-bin.000003:69193092; Lag: 1.13s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m5s(total), 57m48s(copy); streamer: mysql-bin.000003:69195493; Lag: 1.27s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m10s(total), 57m48s(copy); streamer: mysql-bin.000003:69195834; Lag: 6.27s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m15s(total), 57m48s(copy); streamer: mysql-bin.000003:69199894; Lag: 2.82s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m20s(total), 57m48s(copy); streamer: mysql-bin.000003:69203740; Lag: 2.25s, State: migrating; ETA: due
# Migrating `sbtest`.`sbtest1`; Ghost table is `sbtest`.`_sbtest1_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 16:28:51 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.sbtest1.sock
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m22s(total), 57m48s(copy); streamer: mysql-bin.000003:69207301; Lag: 0.98s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m25s(total), 57m48s(copy); streamer: mysql-bin.000003:69208958; Lag: 2.44s, State: migrating; ETA: due
2020-05-06 17:27:20 ERROR Error 1205: Lock wait timeout exceeded; try restarting transaction
2020-05-06 17:27:20 ERROR Error 1205: Lock wait timeout exceeded; try restarting transaction
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m30s(total), 57m48s(copy); streamer: mysql-bin.000003:69212426; Lag: 3.53s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m35s(total), 57m48s(copy); streamer: mysql-bin.000003:69220135; Lag: 1.29s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m40s(total), 57m48s(copy); streamer: mysql-bin.000003:69223738; Lag: 0.84s, State: migrating; ETA: due
# Migrating `sbtest`.`sbtest1`; Ghost table is `sbtest`.`_sbtest1_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 16:28:51 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.sbtest1.sock
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m50s(total), 57m48s(copy); streamer: mysql-bin.000003:69232851; Lag: 1.56s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 1/1000; Time: 58m45s(total), 57m48s(copy); streamer: mysql-bin.000003:69228864; Lag: 0.86s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m46s(total), 57m48s(copy); streamer: mysql-bin.000003:69229637; Lag: 0.43s, State: migrating; ETA: due
2020-05-06 17:27:47 ERROR Error 1205: Lock wait timeout exceeded; try restarting transaction
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 58m55s(total), 57m48s(copy); streamer: mysql-bin.000003:69238260; Lag: 1.06s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m0s(total), 57m48s(copy); streamer: mysql-bin.000003:69245705; Lag: 0.18s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m5s(total), 57m48s(copy); streamer: mysql-bin.000003:69247765; Lag: 3.75s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m10s(total), 57m48s(copy); streamer: mysql-bin.000003:69253321; Lag: 1.15s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m15s(total), 57m48s(copy); streamer: mysql-bin.000003:69261052; Lag: 0.55s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m20s(total), 57m48s(copy); streamer: mysql-bin.000003:69267979; Lag: 0.52s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m25s(total), 57m48s(copy); streamer: mysql-bin.000003:69272498; Lag: 1.00s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m30s(total), 57m48s(copy); streamer: mysql-bin.000003:69275765; Lag: 2.43s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m35s(total), 57m48s(copy); streamer: mysql-bin.000003:69281322; Lag: 0.66s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m40s(total), 57m48s(copy); streamer: mysql-bin.000003:69285437; Lag: 2.01s, State: migrating; ETA: due
2020-05-06 17:28:35 ERROR Error 1205: Lock wait timeout exceeded; try restarting transaction
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m50s(total), 57m48s(copy); streamer: mysql-bin.000003:69292346; Lag: 1.57s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 59m55s(total), 57m48s(copy); streamer: mysql-bin.000003:69295106; Lag: 2.96s, State: migrating; ETA: due
# Migrating `sbtest`.`sbtest1`; Ghost table is `sbtest`.`_sbtest1_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 16:28:51 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.sbtest1.sock
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 1h0m0s(total), 57m48s(copy); streamer: mysql-bin.000003:69298603; Lag: 3.13s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 1h0m5s(total), 57m48s(copy); streamer: mysql-bin.000003:69302851; Lag: 0.68s, State: migrating; ETA: due
# Migrating `sbtest`.`sbtest1`; Ghost table is `sbtest`.`_sbtest1_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 16:28:51 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.sbtest1.sock
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 1h0m9s(total), 57m48s(copy); streamer: mysql-bin.000003:69306440; Lag: 0.96s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 1h0m10s(total), 57m48s(copy); streamer: mysql-bin.000003:69307743; Lag: 0.86s, State: migrating; ETA: due
Copy: 5240000/5240000 100.0%; Applied: 0; Backlog: 0/1000; Time: 1h0m15s(total), 57m48s(copy); streamer: mysql-bin.000003:69310473; Lag: 0.14s, State: migrating; ETA: due
[2020/05/06 17:29:10] [info] binlogsyncer.go:164 syncer is closing...
[2020/05/06 17:29:11] [error] binlogstreamer.go:77 close sync with err: sync is been closing...
[2020/05/06 17:29:11] [info] binlogsyncer.go:179 syncer is closed
[mysql] 2020/05/06 17:29:23 packets.go:122: closing bad idle connection: EOF
2020-05-06 17:29:24 ERROR Error 1146: Table 'sbtest._sbtest1_ghc' doesn't exist
2020-05-06 17:29:24 ERROR sql: database is closed
[mysql] 2020/05/06 17:29:24 packets.go:122: closing bad idle connection: EOF
# Done

real	60m35.574s
user	0m31.816s
sys	0m12.916s
