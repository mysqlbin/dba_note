

1. set-gtid-purged=AUTO 
2. set-gtid-purged=OFF 
3. 小结


1. set-gtid-purged=AUTO 

	shell> /usr/bin/mysqldump -uroot -p$ --single-transaction --master-data=2 -R -E -B  aiuaiuh8_db  > aiuaiuh8_db_20200310_185007.dump


	shell> head -40 niuniu_db_20200310_185007.dump
	-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
	--
	-- Host: localhost    Database: aiuaiuh8_db
	-- ------------------------------------------------------
	-- Server version	5.7.26-log

	/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
	/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
	/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
	/*!40101 SET NAMES utf8mb4 */;
	/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
	/*!40103 SET TIME_ZONE='+00:00' */;
	/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
	/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
	/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
	/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
	SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
	SET @@SESSION.SQL_LOG_BIN= 0;

	--
	-- GTID state at the beginning of the backup 
	--

	SET @@GLOBAL.GTID_PURGED='7664fad8-49fd-11e8-a546-4201c0a8010a:1-766741,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-20227';

	--
	-- Position to start replication or point-in-time recovery from
	--

	-- CHANGE MASTER TO MASTER_LOG_FILE='mysql-bin.000233', MASTER_LOG_POS=314582450;

	--
	-- Current Database: `aiuaiuh8_db`
	--

	CREATE DATABASE /*!32312 IF NOT EXISTS*/ `aiuaiuh8_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

	USE `aiuaiuh8_db`;


2. set-gtid-purged=OFF 

	shell> /usr/bin/mysqldump -uroot -p${Password} --single-transaction --master-data=2 --set-gtid-purged=OFF -B aiuaiuh8_db --tables table_web_clubmemberproxy table_clubmemberAppLine |gzip  >  ${BAK_PATH}aiuaiuh8_db_2tables_${DATE}.dump.gz


	shell> head -30 aiuaiuh8_db_2tables_20200314_060001.dump
	-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
	--
	-- Host: localhost    Database: aiuaiuh8_db
	-- ------------------------------------------------------
	-- Server version	5.7.26-log

	/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
	/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
	/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
	/*!40101 SET NAMES utf8mb4 */;
	/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
	/*!40103 SET TIME_ZONE='+00:00' */;
	/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
	/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
	/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
	/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

	--
	-- Position to start replication or point-in-time recovery from
	--

	-- CHANGE MASTER TO MASTER_LOG_FILE='mysql-bin.000233', MASTER_LOG_POS=348293733;

	--
	-- Table structure for table `table_web_clubmemberproxy`
	--

	.............................
	
	
3. 小结

	set-gtid-purged 参数用来控制备份的内容是否记录  SET @@GLOBAL.GTID_PURGED 的信息。

	set-gtid-purged=OFF ：表示不记录 SET @@GLOBAL.GTID_PURGED 的信息。
	
	什么情况开启和关闭：
		用于在线建立从库的时候需要开启，备份则需要关闭。
	
	–set-gtid-purged=off： 表示不输出跟 GTID 相关的信息；
	