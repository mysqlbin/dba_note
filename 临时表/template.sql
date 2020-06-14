避免临时表，SQL语句性能提升100倍
http://ourmysql.com/archives/1307

InnoDB数据字典操作故障排除：
https://dev.mysql.com/doc/refman/5.6/en/innodb-troubleshooting-datadict.html

CREATE TEMPORARY TABLE SalesSummary (
	product_name VARCHAR(50) NOT NULL,
	total_sales DECIMAL(12,2) NOT NULL DEFAULT 0.00,
	avg_unit_price DECIMAL(7,2) NOT NULL DEFAULT 0.00,
	total_units_sold INT UNSIGNED NOT NULL DEFAULT 0
);


INSERT INTO SalesSummary
   (product_name, total_sales, avg_unit_price, total_units_sold)
    VALUES
    ('cucumber', 100.25, 90, 2);

	
DROP TEMPORARY TABLE SalesSummary;
如果尝试使用DROP TEMPORARY TABLE语句删除永久表，则会收到一条错误消息，
指出您尝试删除的表是未知的。




tmpdir=/data/mysql/mysql3306/tmp

mysql什么时候会生成磁盘上的临时表






select * from accountinfo group by TreeCode;
[Err] 1055 - Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'test.accountinfo.AccountId' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by


set @@global.sql_mode='sql_mode=STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';




























