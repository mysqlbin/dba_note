
1. 
CREATE TABLE `t1_1yi` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP PROCEDURE IF EXISTS insertbatch_1yi;
CREATE PROCEDURE insertbatch_1yi()
BEGIN
DECLARE i INT;
  SET i=1;
	start transaction;
  WHILE(i<=100000000) DO
    INSERT INTO zst.t1_1yi(id)VALUES(i);
    SET i=i+1; 
  END WHILE;
	commit;
END;

root@localhost [zst]>call insertbatch_1yi();
/usr/local/mysql/bin/mysqld_safe: line 198:  2555 Killed                  nohup /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/data/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/data/mysql/mysql3306/data/mysql.pid --socket=/tmp/mysql3306.sock --port=3306 < /dev/null > /dev/null 2>&1
ERROR 2013 (HY000): Lost connection to MySQL server during query


2. 
CREATE TABLE `t1_10yi` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP PROCEDURE IF EXISTS insertbatch_10yi;
CREATE PROCEDURE insertbatch_10yi()
BEGIN
DECLARE i INT;
  SET i=1;
	start transaction;
  WHILE(i<=1000000000) DO
    INSERT INTO zst.t1_10yi(id)VALUES(i);
    SET i=i+1; 
  END WHILE;
	commit;
END;

root@localhost [zst]>call insertbatch_10yi();
ERROR 2013 (HY000): Lost connection to MySQL server during query
