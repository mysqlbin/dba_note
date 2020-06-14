

mysqldump -uroot -p123456abc --single-transaction --master-data=2 > backup.sql  
mysqldump: [Warning] Using a password on the command line interface can be insecure

MySQL8.0使用mysqldump不能使用-p直接带密码，会出现
mysqldump: [Warning] Using a password on the command line interface can be insecure.



mysqldump -uroot -p123456abc --single-transaction --master-data=2 -A > backup.sql  


2020-02-03T02:27:31.226376Z	29979 Connect	root@localhost on  using Socket
2020-02-03T02:27:31.226971Z	29979 Query	select @@version_comment limit 1
2020-02-03T02:27:31.227781Z	29979 Query	show status
2020-02-03T02:27:31.236519Z	29979 Quit	
2020-02-03T02:27:31.670335Z	29980 Connect	root@localhost on  using Socket
2020-02-03T02:27:31.670975Z	29980 Query	/*!40100 SET @@SQL_MODE='' */
2020-02-03T02:27:31.672165Z	29980 Query	/*!40103 SET TIME_ZONE='+00:00' */
2020-02-03T02:27:31.672700Z	29980 Query	/*!80000 SET SESSION information_schema_stats_expiry=0 */
2020-02-03T02:27:31.701639Z	29980 Query	SET SESSION NET_READ_TIMEOUT= 700, SESSION NET_WRITE_TIMEOUT= 700
2020-02-03T02:27:31.701895Z	29980 Query	FLUSH /*!40101 LOCAL */ TABLES
2020-02-03T02:27:31.714225Z	29980 Query	FLUSH TABLES WITH READ LOCK
2020-02-03T02:27:31.714526Z	29980 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2020-02-03T02:27:31.714665Z	29980 Query	START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */
2020-02-03T02:27:31.714897Z	29980 Query	SHOW VARIABLES LIKE 'gtid\_mode'
2020-02-03T02:27:31.716915Z	29980 Query	SELECT @@GLOBAL.GTID_EXECUTED
2020-02-03T02:27:31.717165Z	29980 Query	SHOW MASTER STATUS
2020-02-03T02:27:31.717374Z	29980 Query	UNLOCK TABLES
2020-02-03T02:27:31.717535Z	29980 Query	SELECT LOGFILE_GROUP_NAME, FILE_NAME, TOTAL_EXTENTS, INITIAL_SIZE, ENGINE, EXTRA FROM INFORMATION_SCHEMA.FILES WHERE FILE_TYPE = 'UNDO LOG' AND FILE_NAME IS NOT NULL AND LOGFILE_GROUP_NAME IS NOT NULL GROUP BY LOGFILE_GROUP_NAME, FILE_NAME, ENGINE, TOTAL_EXTENTS, INITIAL_SIZE ORDER BY LOGFILE_GROUP_NAME
2020-02-03T02:27:31.730963Z	29980 Query	SELECT DISTINCT TABLESPACE_NAME, FILE_NAME, LOGFILE_GROUP_NAME, EXTENT_SIZE, INITIAL_SIZE, ENGINE FROM INFORMATION_SCHEMA.FILES WHERE FILE_TYPE = 'DATAFILE' ORDER BY TABLESPACE_NAME, LOGFILE_GROUP_NAME
2020-02-03T02:27:31.732024Z	29980 Query	SHOW DATABASES
2020-02-03T02:27:31.749557Z	29980 Query	SHOW VARIABLES LIKE 'ndbinfo\_version'
2020-02-03T02:27:31.750976Z	29980 Init DB	db3
2020-02-03T02:27:31.751117Z	29980 Query	SHOW CREATE DATABASE IF NOT EXISTS `db3`
2020-02-03T02:27:31.751354Z	29980 Query	SAVEPOINT sp
2020-02-03T02:27:31.751517Z	29980 Query	show tables
2020-02-03T02:27:31.753070Z	29980 Query	show table status like 'test1'
2020-02-03T02:27:31.754299Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.754483Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.754618Z	29980 Query	show create table `test1`
2020-02-03T02:27:31.755244Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.755424Z	29980 Query	show fields from `test1`
2020-02-03T02:27:31.757254Z	29980 Query	show fields from `test1`
2020-02-03T02:27:31.758628Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `test1`
2020-02-03T02:27:31.758958Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.759097Z	29980 Query	use `db3`
2020-02-03T02:27:31.759392Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.759596Z	29980 Query	SHOW TRIGGERS LIKE 'test1'
2020-02-03T02:27:31.760836Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.761019Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.761247Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'db3' AND TABLE_NAME = 'test1'
2020-02-03T02:27:31.761695Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.761846Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.761998Z	29980 Query	RELEASE SAVEPOINT sp
2020-02-03T02:27:31.762149Z	29980 Init DB	db4
2020-02-03T02:27:31.762279Z	29980 Query	SHOW CREATE DATABASE IF NOT EXISTS `db4`
2020-02-03T02:27:31.762437Z	29980 Query	SAVEPOINT sp
2020-02-03T02:27:31.762595Z	29980 Query	show tables
2020-02-03T02:27:31.763634Z	29980 Query	show table status like 'test2'
2020-02-03T02:27:31.764807Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.764991Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.765150Z	29980 Query	show create table `test2`
2020-02-03T02:27:31.778467Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.778739Z	29980 Query	show fields from `test2`
2020-02-03T02:27:31.779780Z	29980 Query	show fields from `test2`
2020-02-03T02:27:31.780705Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `test2`
2020-02-03T02:27:31.780932Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.781084Z	29980 Query	use `db4`
2020-02-03T02:27:31.781322Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.781575Z	29980 Query	SHOW TRIGGERS LIKE 'test2'
2020-02-03T02:27:31.782375Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.782552Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.782832Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'db4' AND TABLE_NAME = 'test2'
2020-02-03T02:27:31.783190Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.783424Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.783615Z	29980 Query	RELEASE SAVEPOINT sp
2020-02-03T02:27:31.783748Z	29980 Init DB	mysql
2020-02-03T02:27:31.783852Z	29980 Query	SHOW CREATE DATABASE IF NOT EXISTS `mysql`
2020-02-03T02:27:31.784060Z	29980 Query	SAVEPOINT sp
2020-02-03T02:27:31.784289Z	29980 Query	show tables
2020-02-03T02:27:31.785526Z	29980 Query	show table status like 'columns\_priv'
2020-02-03T02:27:31.786738Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.786921Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.787056Z	29980 Query	show create table `columns_priv`
2020-02-03T02:27:31.787526Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.787738Z	29980 Query	show fields from `columns_priv`
2020-02-03T02:27:31.788759Z	29980 Query	show fields from `columns_priv`
2020-02-03T02:27:31.789735Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `columns_priv`
2020-02-03T02:27:31.789986Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.790117Z	29980 Query	use `mysql`
2020-02-03T02:27:31.790306Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.790512Z	29980 Query	SHOW TRIGGERS LIKE 'columns\_priv'
2020-02-03T02:27:31.791277Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.791545Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.791857Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'columns_priv'
2020-02-03T02:27:31.792237Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.792429Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.792646Z	29980 Query	show table status like 'component'
2020-02-03T02:27:31.794106Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.794249Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.794489Z	29980 Query	show create table `component`
2020-02-03T02:27:31.794928Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.795121Z	29980 Query	show fields from `component`
2020-02-03T02:27:31.796069Z	29980 Query	show fields from `component`
2020-02-03T02:27:31.797043Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `component`
2020-02-03T02:27:31.797239Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.797502Z	29980 Query	use `mysql`
2020-02-03T02:27:31.797702Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.797927Z	29980 Query	SHOW TRIGGERS LIKE 'component'
2020-02-03T02:27:31.798988Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.799197Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.799426Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'component'
2020-02-03T02:27:31.799906Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.800070Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.800262Z	29980 Query	show table status like 'db'
2020-02-03T02:27:31.801733Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.801880Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.802144Z	29980 Query	show create table `db`
2020-02-03T02:27:31.802736Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.802938Z	29980 Query	show fields from `db`
2020-02-03T02:27:31.804107Z	29980 Query	show fields from `db`
2020-02-03T02:27:31.805285Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `db`
2020-02-03T02:27:31.805619Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.805768Z	29980 Query	use `mysql`
2020-02-03T02:27:31.805917Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.806140Z	29980 Query	SHOW TRIGGERS LIKE 'db'
2020-02-03T02:27:31.806983Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.807156Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.807380Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'db'
2020-02-03T02:27:31.807726Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.807939Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.808150Z	29980 Query	show table status like 'default\_roles'
2020-02-03T02:27:31.809462Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.809643Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.809798Z	29980 Query	show create table `default_roles`
2020-02-03T02:27:31.810168Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.810360Z	29980 Query	show fields from `default_roles`
2020-02-03T02:27:31.811325Z	29980 Query	show fields from `default_roles`
2020-02-03T02:27:31.812301Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `default_roles`
2020-02-03T02:27:31.812579Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.812857Z	29980 Query	use `mysql`
2020-02-03T02:27:31.813031Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.813263Z	29980 Query	SHOW TRIGGERS LIKE 'default\_roles'
2020-02-03T02:27:31.814051Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.814290Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.814473Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'default_roles'
2020-02-03T02:27:31.814829Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.814996Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.815166Z	29980 Query	show table status like 'engine\_cost'
2020-02-03T02:27:31.816439Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.816645Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.816831Z	29980 Query	show create table `engine_cost`
2020-02-03T02:27:31.817291Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.817546Z	29980 Query	show fields from `engine_cost`
2020-02-03T02:27:31.818906Z	29980 Query	show fields from `engine_cost`
2020-02-03T02:27:31.819959Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `engine_cost`
2020-02-03T02:27:31.820218Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.820552Z	29980 Query	use `mysql`
2020-02-03T02:27:31.820759Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.820991Z	29980 Query	SHOW TRIGGERS LIKE 'engine\_cost'
2020-02-03T02:27:31.821872Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.822103Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.822360Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'engine_cost'
2020-02-03T02:27:31.822716Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.822908Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.823110Z	29980 Query	show table status like 'func'
2020-02-03T02:27:31.824541Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.824752Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.824962Z	29980 Query	show create table `func`
2020-02-03T02:27:31.825350Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.825572Z	29980 Query	show fields from `func`
2020-02-03T02:27:31.826527Z	29980 Query	show fields from `func`
2020-02-03T02:27:31.827401Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `func`
2020-02-03T02:27:31.827681Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.827831Z	29980 Query	use `mysql`
2020-02-03T02:27:31.828106Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.828321Z	29980 Query	SHOW TRIGGERS LIKE 'func'
2020-02-03T02:27:31.829130Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.829253Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.829461Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'func'
2020-02-03T02:27:31.829847Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.829993Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.830232Z	29980 Query	show table status like 'global\_grants'
2020-02-03T02:27:31.831442Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.831604Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.831733Z	29980 Query	show create table `global_grants`
2020-02-03T02:27:31.832108Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.832432Z	29980 Query	show fields from `global_grants`
2020-02-03T02:27:31.833469Z	29980 Query	show fields from `global_grants`
2020-02-03T02:27:31.834371Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `global_grants`
2020-02-03T02:27:31.834867Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.835071Z	29980 Query	use `mysql`
2020-02-03T02:27:31.835295Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.835536Z	29980 Query	SHOW TRIGGERS LIKE 'global\_grants'
2020-02-03T02:27:31.836260Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.836503Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.836770Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'global_grants'
2020-02-03T02:27:31.837136Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.837274Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.837563Z	29980 Query	show table status like 'gtid\_executed'
2020-02-03T02:27:31.838777Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.839026Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.839160Z	29980 Query	show create table `gtid_executed`
2020-02-03T02:27:31.839939Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.840082Z	29980 Query	show fields from `gtid_executed`
2020-02-03T02:27:31.840986Z	29980 Query	show fields from `gtid_executed`
2020-02-03T02:27:31.841713Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.841870Z	29980 Query	use `mysql`
2020-02-03T02:27:31.842044Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.842289Z	29980 Query	SHOW TRIGGERS LIKE 'gtid\_executed'
2020-02-03T02:27:31.843050Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.843200Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.843361Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'gtid_executed'
2020-02-03T02:27:31.843694Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.843926Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.844236Z	29980 Query	show table status like 'help\_category'
2020-02-03T02:27:31.845325Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.845507Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.845671Z	29980 Query	show create table `help_category`
2020-02-03T02:27:31.846040Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.846266Z	29980 Query	show fields from `help_category`
2020-02-03T02:27:31.847372Z	29980 Query	show fields from `help_category`
2020-02-03T02:27:31.848570Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `help_category`
2020-02-03T02:27:31.849030Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.849246Z	29980 Query	use `mysql`
2020-02-03T02:27:31.849425Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.849670Z	29980 Query	SHOW TRIGGERS LIKE 'help\_category'
2020-02-03T02:27:31.850549Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.850694Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.850847Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'help_category'
2020-02-03T02:27:31.851127Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.851256Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.851408Z	29980 Query	show table status like 'help\_keyword'
2020-02-03T02:27:31.852501Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.852624Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.852891Z	29980 Query	show create table `help_keyword`
2020-02-03T02:27:31.853535Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.853778Z	29980 Query	show fields from `help_keyword`
2020-02-03T02:27:31.855330Z	29980 Query	show fields from `help_keyword`
2020-02-03T02:27:31.856294Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `help_keyword`
2020-02-03T02:27:31.856942Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.857085Z	29980 Query	use `mysql`
2020-02-03T02:27:31.857307Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.857497Z	29980 Query	SHOW TRIGGERS LIKE 'help\_keyword'
2020-02-03T02:27:31.858191Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.858338Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.858521Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'help_keyword'
2020-02-03T02:27:31.858807Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.858925Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.859096Z	29980 Query	show table status like 'help\_relation'
2020-02-03T02:27:31.860245Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.860454Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.860635Z	29980 Query	show create table `help_relation`
2020-02-03T02:27:31.861013Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.861191Z	29980 Query	show fields from `help_relation`
2020-02-03T02:27:31.862227Z	29980 Query	show fields from `help_relation`
2020-02-03T02:27:31.863069Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `help_relation`
2020-02-03T02:27:31.863986Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.864121Z	29980 Query	use `mysql`
2020-02-03T02:27:31.864301Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.864532Z	29980 Query	SHOW TRIGGERS LIKE 'help\_relation'
2020-02-03T02:27:31.865248Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.865532Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.865808Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'help_relation'
2020-02-03T02:27:31.866173Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.866403Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:31.866592Z	29980 Query	show table status like 'help\_topic'
2020-02-03T02:27:31.867719Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:31.867919Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.868153Z	29980 Query	show create table `help_topic`
2020-02-03T02:27:31.868654Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:31.868852Z	29980 Query	show fields from `help_topic`
2020-02-03T02:27:31.869843Z	29980 Query	show fields from `help_topic`
2020-02-03T02:27:31.971994Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `help_topic`
2020-02-03T02:27:31.997403Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:31.997822Z	29980 Query	use `mysql`
2020-02-03T02:27:31.998286Z	29980 Query	select @@collation_database
2020-02-03T02:27:31.998706Z	29980 Query	SHOW TRIGGERS LIKE 'help\_topic'
2020-02-03T02:27:32.000648Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.000958Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.001413Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'help_topic'
2020-02-03T02:27:32.002162Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.002621Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.002961Z	29980 Query	show table status like 'innodb\_index\_stats'
2020-02-03T02:27:32.005737Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.006076Z	29980 Query	show fields from `innodb_index_stats`
2020-02-03T02:27:32.008506Z	29980 Query	show fields from `innodb_index_stats`
2020-02-03T02:27:32.010728Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `innodb_index_stats`
2020-02-03T02:27:32.012431Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.012857Z	29980 Query	use `mysql`
2020-02-03T02:27:32.013369Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.013798Z	29980 Query	SHOW TRIGGERS LIKE 'innodb\_index\_stats'
2020-02-03T02:27:32.015326Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.015541Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.015724Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'innodb_index_stats'
2020-02-03T02:27:32.016173Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.016356Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.016589Z	29980 Query	show table status like 'innodb\_table\_stats'
2020-02-03T02:27:32.018183Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.018426Z	29980 Query	show fields from `innodb_table_stats`
2020-02-03T02:27:32.019658Z	29980 Query	show fields from `innodb_table_stats`
2020-02-03T02:27:32.020913Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `innodb_table_stats`
2020-02-03T02:27:32.021446Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.021679Z	29980 Query	use `mysql`
2020-02-03T02:27:32.021952Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.022240Z	29980 Query	SHOW TRIGGERS LIKE 'innodb\_table\_stats'
2020-02-03T02:27:32.023211Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.023410Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.023694Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'innodb_table_stats'
2020-02-03T02:27:32.024118Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.024299Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.024526Z	29980 Query	show table status like 'password\_history'
2020-02-03T02:27:32.026045Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.026240Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.026395Z	29980 Query	show create table `password_history`
2020-02-03T02:27:32.026992Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.027326Z	29980 Query	show fields from `password_history`
2020-02-03T02:27:32.029394Z	29980 Query	show fields from `password_history`
2020-02-03T02:27:32.030645Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `password_history`
2020-02-03T02:27:32.031083Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.031264Z	29980 Query	use `mysql`
2020-02-03T02:27:32.031539Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.031742Z	29980 Query	SHOW TRIGGERS LIKE 'password\_history'
2020-02-03T02:27:32.032717Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.032915Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.033206Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'password_history'
2020-02-03T02:27:32.033648Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.033825Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.034110Z	29980 Query	show table status like 'plugin'
2020-02-03T02:27:32.035832Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.036012Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.036262Z	29980 Query	show create table `plugin`
2020-02-03T02:27:32.036686Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.036927Z	29980 Query	show fields from `plugin`
2020-02-03T02:27:32.038189Z	29980 Query	show fields from `plugin`
2020-02-03T02:27:32.039555Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `plugin`
2020-02-03T02:27:32.039840Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.040094Z	29980 Query	use `mysql`
2020-02-03T02:27:32.040364Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.040959Z	29980 Query	SHOW TRIGGERS LIKE 'plugin'
2020-02-03T02:27:32.042120Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.042302Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.042572Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'plugin'
2020-02-03T02:27:32.043016Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.043180Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.043435Z	29980 Query	show table status like 'procs\_priv'
2020-02-03T02:27:32.044601Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.044837Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.044935Z	29980 Query	show create table `procs_priv`
2020-02-03T02:27:32.045383Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.045573Z	29980 Query	show fields from `procs_priv`
2020-02-03T02:27:32.046452Z	29980 Query	show fields from `procs_priv`
2020-02-03T02:27:32.047222Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `procs_priv`
2020-02-03T02:27:32.047551Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.047686Z	29980 Query	use `mysql`
2020-02-03T02:27:32.047900Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.048086Z	29980 Query	SHOW TRIGGERS LIKE 'procs\_priv'
2020-02-03T02:27:32.048747Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.048863Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.049010Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'procs_priv'
2020-02-03T02:27:32.049477Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.049636Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.049806Z	29980 Query	show table status like 'proxies\_priv'
2020-02-03T02:27:32.051214Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.051494Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.051655Z	29980 Query	show create table `proxies_priv`
2020-02-03T02:27:32.052114Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.052314Z	29980 Query	show fields from `proxies_priv`
2020-02-03T02:27:32.053366Z	29980 Query	show fields from `proxies_priv`
2020-02-03T02:27:32.054160Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `proxies_priv`
2020-02-03T02:27:32.054393Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.054616Z	29980 Query	use `mysql`
2020-02-03T02:27:32.054758Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.054958Z	29980 Query	SHOW TRIGGERS LIKE 'proxies\_priv'
2020-02-03T02:27:32.055665Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.055877Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.056085Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'proxies_priv'
2020-02-03T02:27:32.056553Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.056665Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.056896Z	29980 Query	show table status like 'role\_edges'
2020-02-03T02:27:32.058081Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.058383Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.058574Z	29980 Query	show create table `role_edges`
2020-02-03T02:27:32.058881Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.059027Z	29980 Query	show fields from `role_edges`
2020-02-03T02:27:32.059845Z	29980 Query	show fields from `role_edges`
2020-02-03T02:27:32.060611Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `role_edges`
2020-02-03T02:27:32.060775Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.060915Z	29980 Query	use `mysql`
2020-02-03T02:27:32.061085Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.061235Z	29980 Query	SHOW TRIGGERS LIKE 'role\_edges'
2020-02-03T02:27:32.061873Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.061981Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.062273Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'role_edges'
2020-02-03T02:27:32.062609Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.062752Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.062890Z	29980 Query	show table status like 'server\_cost'
2020-02-03T02:27:32.064085Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.064221Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.064550Z	29980 Query	show create table `server_cost`
2020-02-03T02:27:32.065060Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.065259Z	29980 Query	show fields from `server_cost`
2020-02-03T02:27:32.066100Z	29980 Query	show fields from `server_cost`
2020-02-03T02:27:32.066967Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `server_cost`
2020-02-03T02:27:32.067220Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.067358Z	29980 Query	use `mysql`
2020-02-03T02:27:32.067803Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.067930Z	29980 Query	SHOW TRIGGERS LIKE 'server\_cost'
2020-02-03T02:27:32.068589Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.068728Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.068867Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'server_cost'
2020-02-03T02:27:32.069302Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.069491Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.069742Z	29980 Query	show table status like 'servers'
2020-02-03T02:27:32.070880Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.071050Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.071168Z	29980 Query	show create table `servers`
2020-02-03T02:27:32.071642Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.072010Z	29980 Query	show fields from `servers`
2020-02-03T02:27:32.072964Z	29980 Query	show fields from `servers`
2020-02-03T02:27:32.073823Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `servers`
2020-02-03T02:27:32.074117Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.074310Z	29980 Query	use `mysql`
2020-02-03T02:27:32.074525Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.074782Z	29980 Query	SHOW TRIGGERS LIKE 'servers'
2020-02-03T02:27:32.075732Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.075940Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.076135Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'servers'
2020-02-03T02:27:32.076661Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.076864Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.077070Z	29980 Query	show table status like 'slave\_master\_info'
2020-02-03T02:27:32.078389Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.078652Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.078842Z	29980 Query	show create table `slave_master_info`
2020-02-03T02:27:32.079400Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.079642Z	29980 Query	show fields from `slave_master_info`
2020-02-03T02:27:32.080916Z	29980 Query	show fields from `slave_master_info`
2020-02-03T02:27:32.081992Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.082127Z	29980 Query	use `mysql`
2020-02-03T02:27:32.082340Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.082581Z	29980 Query	SHOW TRIGGERS LIKE 'slave\_master\_info'
2020-02-03T02:27:32.083252Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.083496Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.083689Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'slave_master_info'
2020-02-03T02:27:32.084046Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.084246Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.084411Z	29980 Query	show table status like 'slave\_relay\_log\_info'
2020-02-03T02:27:32.085593Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.085726Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.085920Z	29980 Query	show create table `slave_relay_log_info`
2020-02-03T02:27:32.086451Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.086714Z	29980 Query	show fields from `slave_relay_log_info`
2020-02-03T02:27:32.087808Z	29980 Query	show fields from `slave_relay_log_info`
2020-02-03T02:27:32.088797Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.088955Z	29980 Query	use `mysql`
2020-02-03T02:27:32.089198Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.089408Z	29980 Query	SHOW TRIGGERS LIKE 'slave\_relay\_log\_info'
2020-02-03T02:27:32.090211Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.090403Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.090630Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'slave_relay_log_info'
2020-02-03T02:27:32.090958Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.091132Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.091329Z	29980 Query	show table status like 'slave\_worker\_info'
2020-02-03T02:27:32.092778Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.092905Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.093085Z	29980 Query	show create table `slave_worker_info`
2020-02-03T02:27:32.093742Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.094001Z	29980 Query	show fields from `slave_worker_info`
2020-02-03T02:27:32.094971Z	29980 Query	show fields from `slave_worker_info`
2020-02-03T02:27:32.095893Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `slave_worker_info`
2020-02-03T02:27:32.096101Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.096248Z	29980 Query	use `mysql`
2020-02-03T02:27:32.096464Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.096614Z	29980 Query	SHOW TRIGGERS LIKE 'slave\_worker\_info'
2020-02-03T02:27:32.097188Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.097407Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.097723Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'slave_worker_info'
2020-02-03T02:27:32.098022Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.098137Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.098306Z	29980 Query	show table status like 'tables\_priv'
2020-02-03T02:27:32.099299Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.099475Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.099598Z	29980 Query	show create table `tables_priv`
2020-02-03T02:27:32.099934Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.100089Z	29980 Query	show fields from `tables_priv`
2020-02-03T02:27:32.101056Z	29980 Query	show fields from `tables_priv`
2020-02-03T02:27:32.101951Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `tables_priv`
2020-02-03T02:27:32.102176Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.102299Z	29980 Query	use `mysql`
2020-02-03T02:27:32.102443Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.102655Z	29980 Query	SHOW TRIGGERS LIKE 'tables\_priv'
2020-02-03T02:27:32.103407Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.103558Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.103716Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'tables_priv'
2020-02-03T02:27:32.104011Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.104123Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.104266Z	29980 Query	show table status like 'time\_zone'
2020-02-03T02:27:32.105311Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.105472Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.105602Z	29980 Query	show create table `time_zone`
2020-02-03T02:27:32.105996Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.106249Z	29980 Query	show fields from `time_zone`
2020-02-03T02:27:32.107112Z	29980 Query	show fields from `time_zone`
2020-02-03T02:27:32.107916Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `time_zone`
2020-02-03T02:27:32.108145Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.108331Z	29980 Query	use `mysql`
2020-02-03T02:27:32.108549Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.108742Z	29980 Query	SHOW TRIGGERS LIKE 'time\_zone'
2020-02-03T02:27:32.109537Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.109723Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.109971Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'time_zone'
2020-02-03T02:27:32.110371Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.110546Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.110755Z	29980 Query	show table status like 'time\_zone\_leap\_second'
2020-02-03T02:27:32.111973Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.112208Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.112423Z	29980 Query	show create table `time_zone_leap_second`
2020-02-03T02:27:32.112765Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.112922Z	29980 Query	show fields from `time_zone_leap_second`
2020-02-03T02:27:32.113918Z	29980 Query	show fields from `time_zone_leap_second`
2020-02-03T02:27:32.114842Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `time_zone_leap_second`
2020-02-03T02:27:32.115165Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.115330Z	29980 Query	use `mysql`
2020-02-03T02:27:32.115567Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.115828Z	29980 Query	SHOW TRIGGERS LIKE 'time\_zone\_leap\_second'
2020-02-03T02:27:32.116662Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.116853Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.117183Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'time_zone_leap_second'
2020-02-03T02:27:32.117650Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.117858Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.118064Z	29980 Query	show table status like 'time\_zone\_name'
2020-02-03T02:27:32.119131Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.119289Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.119497Z	29980 Query	show create table `time_zone_name`
2020-02-03T02:27:32.119813Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.119973Z	29980 Query	show fields from `time_zone_name`
2020-02-03T02:27:32.120782Z	29980 Query	show fields from `time_zone_name`
2020-02-03T02:27:32.121530Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `time_zone_name`
2020-02-03T02:27:32.121693Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.121837Z	29980 Query	use `mysql`
2020-02-03T02:27:32.121970Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.122208Z	29980 Query	SHOW TRIGGERS LIKE 'time\_zone\_name'
2020-02-03T02:27:32.122935Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.123063Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.123210Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'time_zone_name'
2020-02-03T02:27:32.123572Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.123689Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.123978Z	29980 Query	show table status like 'time\_zone\_transition'
2020-02-03T02:27:32.125049Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.125230Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.125421Z	29980 Query	show create table `time_zone_transition`
2020-02-03T02:27:32.125794Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.125955Z	29980 Query	show fields from `time_zone_transition`
2020-02-03T02:27:32.126829Z	29980 Query	show fields from `time_zone_transition`
2020-02-03T02:27:32.127632Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `time_zone_transition`
2020-02-03T02:27:32.127934Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.128069Z	29980 Query	use `mysql`
2020-02-03T02:27:32.128246Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.128446Z	29980 Query	SHOW TRIGGERS LIKE 'time\_zone\_transition'
2020-02-03T02:27:32.129188Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.129368Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.129772Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'time_zone_transition'
2020-02-03T02:27:32.130149Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.130341Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.130555Z	29980 Query	show table status like 'time\_zone\_transition\_type'
2020-02-03T02:27:32.131784Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.132005Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.132172Z	29980 Query	show create table `time_zone_transition_type`
2020-02-03T02:27:32.132709Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.132942Z	29980 Query	show fields from `time_zone_transition_type`
2020-02-03T02:27:32.133942Z	29980 Query	show fields from `time_zone_transition_type`
2020-02-03T02:27:32.134925Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `time_zone_transition_type`
2020-02-03T02:27:32.135302Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.135494Z	29980 Query	use `mysql`
2020-02-03T02:27:32.135611Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.135823Z	29980 Query	SHOW TRIGGERS LIKE 'time\_zone\_transition\_type'
2020-02-03T02:27:32.136588Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.136713Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.136961Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'time_zone_transition_type'
2020-02-03T02:27:32.137354Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.137488Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.137613Z	29980 Query	show table status like 'user'
2020-02-03T02:27:32.138782Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.139001Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.139231Z	29980 Query	show create table `user`
2020-02-03T02:27:32.139804Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.139959Z	29980 Query	show fields from `user`
2020-02-03T02:27:32.141233Z	29980 Query	show fields from `user`
2020-02-03T02:27:32.142459Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `user`
2020-02-03T02:27:32.142876Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.143025Z	29980 Query	use `mysql`
2020-02-03T02:27:32.143205Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.143399Z	29980 Query	SHOW TRIGGERS LIKE 'user'
2020-02-03T02:27:32.144174Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.144368Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.144615Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'mysql' AND TABLE_NAME = 'user'
2020-02-03T02:27:32.145016Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.145161Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.145357Z	29980 Query	RELEASE SAVEPOINT sp
2020-02-03T02:27:32.145536Z	29980 Query	show table status like 'general\_log'
2020-02-03T02:27:32.147879Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.148088Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.148191Z	29980 Query	show create table `general_log`
2020-02-03T02:27:32.148376Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.148567Z	29980 Query	show fields from `general_log`
2020-02-03T02:27:32.149388Z	29980 Query	show fields from `general_log`
2020-02-03T02:27:32.150178Z	29980 Query	show table status like 'slow\_log'
2020-02-03T02:27:32.152176Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.152395Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.152593Z	29980 Query	show create table `slow_log`
2020-02-03T02:27:32.152760Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.152872Z	29980 Query	show fields from `slow_log`
2020-02-03T02:27:32.153894Z	29980 Query	show fields from `slow_log`
2020-02-03T02:27:32.154712Z	29980 Init DB	sbtest
2020-02-03T02:27:32.154912Z	29980 Query	SHOW CREATE DATABASE IF NOT EXISTS `sbtest`
2020-02-03T02:27:32.155155Z	29980 Query	SAVEPOINT sp
2020-02-03T02:27:32.155364Z	29980 Query	show tables
2020-02-03T02:27:32.156105Z	29980 Query	RELEASE SAVEPOINT sp
2020-02-03T02:27:32.156340Z	29980 Init DB	test_20191101
2020-02-03T02:27:32.156515Z	29980 Query	SHOW CREATE DATABASE IF NOT EXISTS `test_20191101`
2020-02-03T02:27:32.156690Z	29980 Query	SAVEPOINT sp
2020-02-03T02:27:32.156874Z	29980 Query	show tables
2020-02-03T02:27:32.157740Z	29980 Query	show table status like 't1'
2020-02-03T02:27:32.158799Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.158960Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.159124Z	29980 Query	show create table `t1`
2020-02-03T02:27:32.159601Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.159791Z	29980 Query	show fields from `t1`
2020-02-03T02:27:32.178084Z	29980 Query	show fields from `t1`
2020-02-03T02:27:32.178967Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `t1`
2020-02-03T02:27:32.179152Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.179331Z	29980 Query	use `test_20191101`
2020-02-03T02:27:32.179465Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.179668Z	29980 Query	SHOW TRIGGERS LIKE 't1'
2020-02-03T02:27:32.180381Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.180601Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.180767Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'test_20191101' AND TABLE_NAME = 't1'
2020-02-03T02:27:32.181149Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.181306Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.181524Z	29980 Query	show table status like 't2'
2020-02-03T02:27:32.182645Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.182788Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.182900Z	29980 Query	show create table `t2`
2020-02-03T02:27:32.183494Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.183669Z	29980 Query	show fields from `t2`
2020-02-03T02:27:32.184527Z	29980 Query	show fields from `t2`
2020-02-03T02:27:32.185256Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `t2`
2020-02-03T02:27:32.185670Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.185908Z	29980 Query	use `test_20191101`
2020-02-03T02:27:32.186116Z	29980 Query	select @@collation_database
2020-02-03T02:27:32.186401Z	29980 Query	SHOW TRIGGERS LIKE 't2'
2020-02-03T02:27:32.187131Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.187280Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.187518Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'test_20191101' AND TABLE_NAME = 't2'
2020-02-03T02:27:32.187923Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.188129Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:32.188317Z	29980 Query	show table status like 't3'
2020-02-03T02:27:32.189305Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:32.189533Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:32.189653Z	29980 Query	show create table `t3`
2020-02-03T02:27:32.191423Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:32.191644Z	29980 Query	show fields from `t3`
2020-02-03T02:27:32.192550Z	29980 Query	show fields from `t3`
2020-02-03T02:27:32.193338Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `t3`
2020-02-03T02:27:34.701306Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:34.775673Z	29980 Query	use `test_20191101`
2020-02-03T02:27:34.776119Z	29980 Query	select @@collation_database
2020-02-03T02:27:34.776525Z	29980 Query	SHOW TRIGGERS LIKE 't3'
2020-02-03T02:27:34.831674Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:34.831857Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:34.832122Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'test_20191101' AND TABLE_NAME = 't3'
2020-02-03T02:27:34.832742Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:34.832944Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:34.833169Z	29980 Query	show table status like 't\_2103'
2020-02-03T02:27:34.836073Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:34.836206Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:34.836324Z	29980 Query	show create table `t_2103`
2020-02-03T02:27:34.892810Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:34.893158Z	29980 Query	show fields from `t_2103`
2020-02-03T02:27:34.895457Z	29980 Query	show fields from `t_2103`
2020-02-03T02:27:34.897472Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `t_2103`
2020-02-03T02:27:34.897918Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:34.898154Z	29980 Query	use `test_20191101`
2020-02-03T02:27:34.898328Z	29980 Query	select @@collation_database
2020-02-03T02:27:34.898602Z	29980 Query	SHOW TRIGGERS LIKE 't\_2103'
2020-02-03T02:27:34.900124Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:34.900391Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:34.900595Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'test_20191101' AND TABLE_NAME = 't_2103'
2020-02-03T02:27:34.901211Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:34.901370Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:34.901543Z	29980 Query	show table status like 'table\_third\_order'
2020-02-03T02:27:34.904474Z	29980 Query	SET SQL_QUOTE_SHOW_CREATE=1
2020-02-03T02:27:34.904639Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:34.904866Z	29980 Query	show create table `table_third_order`
2020-02-03T02:27:34.907066Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:34.907299Z	29980 Query	show fields from `table_third_order`
2020-02-03T02:27:34.910261Z	29980 Query	show fields from `table_third_order`
2020-02-03T02:27:34.912746Z	29980 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `table_third_order`
2020-02-03T02:27:34.913197Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:34.913436Z	29980 Query	use `test_20191101`
2020-02-03T02:27:34.913607Z	29980 Query	select @@collation_database
2020-02-03T02:27:34.913879Z	29980 Query	SHOW TRIGGERS LIKE 'table\_third\_order'
2020-02-03T02:27:34.915360Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:34.915632Z	29980 Query	SET SESSION character_set_results = 'binary'
2020-02-03T02:27:34.915854Z	29980 Query	SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'test_20191101' AND TABLE_NAME = 'table_third_order'
2020-02-03T02:27:34.916545Z	29980 Query	SET SESSION character_set_results = 'utf8mb4'
2020-02-03T02:27:34.916702Z	29980 Query	ROLLBACK TO SAVEPOINT sp
2020-02-03T02:27:34.916862Z	29980 Query	RELEASE SAVEPOINT sp
2020-02-03T02:27:35.153127Z	29980 Quit	
