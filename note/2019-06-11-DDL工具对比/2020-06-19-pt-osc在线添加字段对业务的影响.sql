


mysql> select hostname_max,client_max,user_max,ts_min,ts_max,ts_cnt,Query_time_sum,Query_time_min,Query_time_max,sample from mysql_slow_query_review_history where Query_time_sum > 10 and user_max not in ('root', 'read_user')  and hostname_max='192.168.1.10_db1';
+------------------+--------------+------------+----------------------------+----------------------------+--------+----------------+----------------+----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| hostname_max     | client_max   | user_max   | ts_min                     | ts_max                     | ts_cnt | Query_time_sum | Query_time_min | Query_time_max | sample                                                                                                                                                                                                                              |
+------------------+--------------+------------+----------------------------+----------------------------+--------+----------------+----------------+----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 192.168.1.99_db1 | 192.168.1.36 | tests_user | 2020-04-02 14:39:13.000000 | 2020-04-02 14:45:23.000000 |     33 |        17.7658 |       0.500495 |        0.61537 | call pr_club_write_score_detail9(10018,913020,17,'10018-913020-1585809539-70',70,20000,11,'2020-04-02 14:38:59','2020-04-02 14:39:31',186001,0,0,'',181040,40000,40000,40000,221040,0,110,'0318',11002,'','03180202')               |
| 192.168.1.99_db1 | 192.168.1.36 | tests_user | 2020-04-03 07:10:32.000000 | 2020-04-03 07:25:16.000000 |    234 |        326.553 |       0.501088 |        3.27782 | call pr_club_write_score_detail9(10058,543910,33,'10058-543910-1585869670-749',749,2000,0,'2020-04-03 07:21:10','2020-04-03 07:21:38',190434,0,0,'????',99760,40000,40000,-40000,59760,0,117,'',11701,'','????')                    |
| 192.168.1.99_db1 | 192.168.1.35 | tests_user | 2020-04-26 06:17:31.000000 | 2020-04-26 06:24:13.000000 |     51 |        58.4431 |       0.504081 |        7.28826 | call pr_club_write_score_detail9(10002,663212,3,'10002-663212-1587853434-1',1,1000,4,'2020-04-26 06:23:54','2020-04-26 06:24:05',120012,0,0,'',21000,2000,2000,-2000,19000,0,21,'0d1b06',2101,'','3d27320000000d1b061a0836111d195') |
+------------------+--------------+------------+----------------------------+----------------------------+--------+----------------+----------------+----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
3 rows in set (0.00 sec)


CREATE DEFINER=``@`%` PROCEDURE `pr_club_write_score_detail9`(
 IN $nClubID INT(11)
,IN $nTableID INT(11)
,IN $nChairID INT(11)
,IN $szToken VARCHAR(63)
,IN $nRound INT(11)
,IN $nBaseScore INT(11)
,IN $nPlayCount TINYINT(4)
,IN $tStartTime TIMESTAMP
,IN $tEndTime TIMESTAMP
,IN $nPlayerID INT(11)
,IN $bRobot TINYINT(4)
,IN $nBankID INT(11)
,IN $szCardData TEXT
,IN $nEnterScore BIGINT(20)
,IN $nBetScore INT(11)
,IN $nValidBet INT(11)
,IN $nResultMoney INT(11)
,IN $nPlayerScore BIGINT(20)
,IN $nTax INT(11)
,IN $nGameType INT(11)
,IN $nCardData TEXT
,IN $roomGrade INT
,IN $szExtChar VARCHAR(256)
,IN $CardData TEXT
)
BEGIN
/*
通用写明细战绩
*/
IF $bRobot=0 THEN
#真人的战绩
    INSERT INTO table_clubgamescoredetail 
            (
                nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
                tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,
                nBetScore,nValidBet,nResultMoney,
                nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,`CardData`
            )
    VALUES (
                $nClubID,$nTableID,$nChairID,$szToken,$nRound,$nBaseScore,$nPlayCount,
                $tStartTime,NOW(),$nPlayerID,$bRobot,$nBankID,$szCardData,$nEnterScore,
                $nBetScore,$nValidBet,$nResultMoney,
                $nPlayerScore,$nTax,$nGameType,$roomGrade,$nCardData,$szExtChar,$CardData
            );
ELSE
 
  
        
END