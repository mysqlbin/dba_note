
MySQL [db_plate]> select count(*) from t_sql_slowlog_record_detail_full;
+----------+
| count(*) |
+----------+
| 22831431 |
+----------+
1 row in set (7.79 sec)

MySQL [db_plate]> analyze table t_sql_slowlog_record_detail_full;
+-------------------------------------------+---------+----------+----------+
| Table                                     | Op      | Msg_type | Msg_text |
+-------------------------------------------+---------+----------+----------+
| db_plate.t_sql_slowlog_record_detail_full | analyze | status   | OK       |
+-------------------------------------------+---------+----------+----------+
1 row in set (0.01 sec)