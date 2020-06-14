-- MySQL dump 10.13  Distrib 5.7.19, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: zst
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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

SET @@GLOBAL.GTID_PURGED='f7323d17-6442-11ea-8a77-080027758761:1-14';

--
-- Position to start replication or point-in-time recovery from
--

-- CHANGE MASTER TO MASTER_LOG_FILE='mysql-bin.000002', MASTER_LOG_POS=2696;

--
-- Current Database: `zst`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `zst` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `zst`;

--
-- Table structure for table `a`
--

DROP TABLE IF EXISTS `a`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `a` (
  `t1` varchar(10) DEFAULT NULL,
  `t2` varchar(10) DEFAULT NULL,
  `t3` char(10) DEFAULT NULL,
  `t4` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a`
--

LOCK TABLES `a` WRITE;
/*!40000 ALTER TABLE `a` DISABLE KEYS */;
INSERT INTO `a` VALUES ('1','1','1','1');
/*!40000 ALTER TABLE `a` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mytest`
--

DROP TABLE IF EXISTS `mytest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mytest` (
  `t1` varchar(10) DEFAULT NULL,
  `t2` varchar(10) DEFAULT NULL,
  `t3` char(10) DEFAULT NULL,
  `t4` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mytest`
--

LOCK TABLES `mytest` WRITE;
/*!40000 ALTER TABLE `mytest` DISABLE KEYS */;
INSERT INTO `mytest` VALUES ('a','bb','bb','ccc'),('d','ee','ee','fff'),('d',NULL,NULL,'fff');
/*!40000 ALTER TABLE `mytest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mytest01`
--

DROP TABLE IF EXISTS `mytest01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mytest01` (
  `t1` varchar(10) DEFAULT NULL,
  `t2` varchar(10) DEFAULT NULL,
  `t3` char(10) DEFAULT NULL,
  `t4` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=REDUNDANT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mytest01`
--

LOCK TABLES `mytest01` WRITE;
/*!40000 ALTER TABLE `mytest01` DISABLE KEYS */;
INSERT INTO `mytest01` VALUES ('a','bb','bb','ccc'),('d','ee','ee','fff'),('d',NULL,NULL,'fff');
/*!40000 ALTER TABLE `mytest01` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'mi8',8);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t`
--

DROP TABLE IF EXISTS `t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `a` int(11) DEFAULT NULL,
  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `t_modified` (`t_modified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t`
--

LOCK TABLES `t` WRITE;
/*!40000 ALTER TABLE `t` DISABLE KEYS */;
/*!40000 ALTER TABLE `t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t1`
--

DROP TABLE IF EXISTS `t1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t1` (
  `c1` int(10) unsigned NOT NULL DEFAULT '0',
  `c2` int(10) unsigned NOT NULL DEFAULT '0',
  `c3` int(10) unsigned NOT NULL DEFAULT '0',
  `c4` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`c1`),
  KEY `c2` (`c2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t1`
--

LOCK TABLES `t1` WRITE;
/*!40000 ALTER TABLE `t1` DISABLE KEYS */;
INSERT INTO `t1` VALUES (1,1,1,0),(3,3,3,0),(4,2,2,0),(6,2,5,0),(8,6,6,0),(10,4,4,0);
/*!40000 ALTER TABLE `t1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t1_10yi`
--

DROP TABLE IF EXISTS `t1_10yi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t1_10yi` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t1_10yi`
--

LOCK TABLES `t1_10yi` WRITE;
/*!40000 ALTER TABLE `t1_10yi` DISABLE KEYS */;
/*!40000 ALTER TABLE `t1_10yi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t2`
--

DROP TABLE IF EXISTS `t2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t2` (
  `id` int(11) NOT NULL,
  `a` int(11) DEFAULT NULL,
  `b` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `a` (`a`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t2`
--

LOCK TABLES `t2` WRITE;
/*!40000 ALTER TABLE `t2` DISABLE KEYS */;
/*!40000 ALTER TABLE `t2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t20190930`
--

DROP TABLE IF EXISTS `t20190930`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t20190930` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
  `tableid` int(11) NOT NULL,
  `playerid` int(11) NOT NULL,
  `szEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_playerid_tableid_szEndTime` (`playerid`,`tableid`,`szEndTime`),
  KEY `idx_playerid` (`playerid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t20190930`
--

LOCK TABLES `t20190930` WRITE;
/*!40000 ALTER TABLE `t20190930` DISABLE KEYS */;
/*!40000 ALTER TABLE `t20190930` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t20191007`
--

DROP TABLE IF EXISTS `t20191007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t20191007` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
  `tableid` int(11) NOT NULL,
  `playerid` int(11) NOT NULL,
  `szEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_szEndTime_playerid` (`szEndTime`,`playerid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t20191007`
--

LOCK TABLES `t20191007` WRITE;
/*!40000 ALTER TABLE `t20191007` DISABLE KEYS */;
INSERT INTO `t20191007` VALUES (1,1,1,'2019-09-26 12:38:35'),(2,2,2,'2019-09-30 12:38:43'),(3,3,3,'2019-09-30 12:38:57');
/*!40000 ALTER TABLE `t20191007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t2019100702`
--

DROP TABLE IF EXISTS `t2019100702`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t2019100702` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
  `tableid` int(11) NOT NULL,
  `playerid` int(11) NOT NULL,
  `szEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_szEndTime` (`szEndTime`),
  KEY `idx_playerid` (`playerid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t2019100702`
--

LOCK TABLES `t2019100702` WRITE;
/*!40000 ALTER TABLE `t2019100702` DISABLE KEYS */;
INSERT INTO `t2019100702` VALUES (1,1,1,'2019-09-26 12:38:35'),(2,2,2,'2019-09-30 12:38:43'),(3,3,3,'2019-09-30 12:38:57');
/*!40000 ALTER TABLE `t2019100702` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t2020`
--

DROP TABLE IF EXISTS `t2020`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t2020` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
  `tableid` int(11) NOT NULL,
  `playerid` int(11) NOT NULL,
  `szEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_szEndTime` (`szEndTime`),
  KEY `idx_playerid` (`playerid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t2020`
--

LOCK TABLES `t2020` WRITE;
/*!40000 ALTER TABLE `t2020` DISABLE KEYS */;
/*!40000 ALTER TABLE `t2020` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-15 13:30:45
