/*官网:
https://dev.mysql.com/doc/refman/5.7/en/sys-statements-with-full-table-scans.html
*/
select * from sys.statements_with_full_table_scans where db = 'dezhou_db' order by exec_count desc;

select * from sys.statements_with_full_table_scans;

select * from sys.statements_with_full_table_scans order by exec_count desc;

一、

select * from sys.statements_with_full_table_scans order by exec_count desc;

select * from `performance_schema`.events_statements_summary_by_digest where digest='db988fa046c92ac4ce1ecbfc64852db5';

UPDATE `EnterPrise`
SET `Balance` = `ifnull` (`Balance`, ?)
WHERE
	`EnterPriseID` = (
		SELECT
			`AccountInfo`.`EnterPriseID`
		FROM
			`AccountInfo`
		WHERE
			`AccountName` = ?
	)

二、	
select * from `performance_schema`.events_statements_summary_by_digest where digest='4deab4448b08fed845eb2dfd45cd9a41';

SELECT
	COUNT(?) `totalCount`
FROM
	`EnterPrise` `e`
LEFT JOIN `accountinfo` `a` ON `e`.`EnterPriseID` = `a`.`EnterPriseID`
WHERE
	? = ?
AND `e`.`Status` != - ?
AND `e`.`CreateTime` >= ?
AND `e`.`CreateTime` < ?
AND `e`.`EnterPriseID` IN (SELECT `id` FROM `getent`)

三、
SELECT
	`enter`.`ExtendCode`,
	`enter`.`CreateTime`,
	`enter`.`EnterPriseID`,
	(
		SELECT
			`acc`.`AccountName`
		FROM
			`AccountInfo` `acc`
		WHERE
			`acc`.`AccountId` = `enter`.`AccountId`
		AND `acc`.`EnterPriseID` = `enter`.`EnterPriseID`
	) NAME,
	(
		SELECT
			COUNT(?)
		FROM
			`Table_User` `uses`
		WHERE
			`uses`.`extendCode` = `enter`.`ExtendCode`
	) `UserCount`,
	(
		SELECT
			SUM(`total_fee`)
		FROM
			`Table_pay_log` LOGS
		WHERE
			`logs`.`state` = ?
		AND `logs`.`nPlayerId` IN (
			SELECT
				`nPlayerId`
			FROM
				`Table_User` `us`
			WHERE
				`us`.`extendCode` = `enter`.`ExtendCode`
			AND `logs`.`create_date` > `us`.`BindingTime`
		)
	) `MoneyCount`
FROM
	`EnterPrise` `enter`
WHERE
	`enter`.`pid` = ?
AND `EnterPriseType` = ?
AND `enter`.`Status` = ?
ORDER BY
	`enter`.`CreateTime` DESC
LIMIT ?,...