获取慢日志统计
SELECT
	history.ts_max AS CreateTime,
	history.db_max AS dbname,
	fingerprint AS 'SQL语句',
	sum(history.query_time_sum) / sum(history.ts_cnt) AS '平均执行时长',
	sum(history.ts_cnt) AS '执行总次数',
	sum(history.query_time_sum) AS '执行总时长',
	sum(history.rows_examined_sum) AS '扫描总行数',
	sum(history.rows_sent_sum) AS '返回总行数'
FROM
	mysql_slow_query_review origin
JOIN mysql_slow_query_review_history history ON origin. `CHECKSUM` = history. `CHECKSUM` group by origin. `CHECKSUM`;

WHERE last_seen>='2020-09-01 18:21:23.000000' and  hostname_max = '' and 'db_max';

-------------------------------------------------------------------------------------------------------------------

SELECT
	history.ts_max AS CreateTime,
	history.db_max AS dbname,
	fingerprint AS 'SQL语句',
	sum(history.query_time_sum) / sum(history.ts_cnt) AS '平均执行时长',
	sum(history.ts_cnt) AS '执行总次数',
	sum(history.query_time_sum) AS '执行总时长',
	sum(history.rows_examined_sum) AS '扫描总行数',
	sum(history.rows_sent_sum) AS '返回总行数'
FROM
	mysql_slow_query_review origin INNER JOIN mysql_slow_query_review_history history ON origin. `CHECKSUM` = history. `CHECKSUM` 
WHERE
	(
		origin.last_seen >='2020-09-01 00:00:00'
		AND `history`.`hostname_max` = '192.168.0.252_niuniuh5_db'
		
		AND `history`.`ts_min` BETWEEN '2020-09-01 00:00:00'
		AND '2020-09-08 00:00:00'
	)
group by origin. `CHECKSUM`


	
	
--------------------------------------------------------


SELECT
	`mysql_slow_query_review`.`fingerprint` AS `SQLText`,
	`mysql_slow_query_review`.`checksum` AS `SQLId`,
	MAX(
		`mysql_slow_query_review_history`.`ts_max`
	) AS `CreateTime`,
	MAX(
		`mysql_slow_query_review_history`.`db_max`
	) AS `DBName`,
	(
		SUM(
			`mysql_slow_query_review_history`.`Query_time_sum`
		) / SUM(
			`mysql_slow_query_review_history`.`ts_cnt`
		)
	) AS `QueryTimeAvg`,
	SUM(
		`mysql_slow_query_review_history`.`ts_cnt`
	) AS `MySQLTotalExecutionCounts`,
	SUM(
		`mysql_slow_query_review_history`.`Query_time_sum`
	) AS `MySQLTotalExecutionTimes`,
	SUM(
		`mysql_slow_query_review_history`.`Rows_examined_sum`
	) AS `ParseTotalRowCounts`,
	SUM(
		`mysql_slow_query_review_history`.`Rows_sent_sum`
	) AS `ReturnTotalRowCounts`
FROM
	`mysql_slow_query_review`
INNER JOIN `mysql_slow_query_review_history` ON (
	`mysql_slow_query_review`.`checksum` = `mysql_slow_query_review_history`.`checksum`
)
WHERE
	(
		`mysql_slow_query_review_history`.`hostname_max` = '192.168.0.54:3306'
		AND `mysql_slow_query_review_history`.`ts_min` BETWEEN '2019-05-08 00:00:00'
		AND '2019-12-19 00:00:00'
	)
GROUP BY
	`mysql_slow_query_review`.`checksum`
ORDER BY
	`MySQLTotalExecutionCounts` DESC
LIMIT 2;

-------------------------------------------------------------------------------------------------------------------


#获取慢日志明细
SELECT
	ts_min AS '执行开始时间',
	db_max AS '数据库名',
	user_max AS '用户名',
	sample AS 'SQL语句',
	ts_cnt AS '本次统计该sql语句出现的次数',
	query_time_pct_95 AS '本次统计该sql语句95%耗时',
	query_time_sum AS '本次统计该sql语句花费的总时间(秒)',
	lock_time_sum AS '本次统计该sql语句锁定总时长(秒)',
	rows_examined_sum AS '本次统计该sql语句解析总行数',
	rows_sent_sum AS '本次统计该sql语句返回总行数'
FROM
	mysql_slow_query_review_history;
