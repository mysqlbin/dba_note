


(venv4archery) [root@localhost code]# python3 use_example.py
+----------+---------+-------------+-----------------+---------------------------------------------+----------------------------------------------------+---------------+--------------+---------------+--------------+---------+-------------+
| order_id |  stage  | error_level |   stage_status  |                error_message                |                        sql                         | affected_rows |   sequence   | backup_dbname | execute_time | sqlsha1 | backup_time |
+----------+---------+-------------+-----------------+---------------------------------------------+----------------------------------------------------+---------------+--------------+---------------+--------------+---------+-------------+
|    1     | CHECKED |      0      | Audit Completed |                     None                    |                     use sbtest                     |       0       | 0_0_00000000 |      None     |      0       |   None  |      0      |
|    2     | CHECKED |      2      | Audit Completed |         Set comments for table 't1'.        | create table t1(id int primary key,c1 int, c2 int) |       0       | 0_0_00000001 |      None     |      0       |   None  |      0      |
|          |         |             |                 | Column 'id' in table 't1' have no comments. |                                                    |               |              |               |              |         |             |
|          |         |             |                 | Column 'c1' in table 't1' have no comments. |                                                    |               |              |               |              |         |             |
|          |         |             |                 | Column 'c2' in table 't1' have no comments. |                                                    |               |              |               |              |         |             |
|    3     | CHECKED |      0      | Audit Completed |                     None                    |       insert into t1(id,c1,c2) values(1,1,1)       |       1       | 0_0_00000002 |      None     |      0       |   None  |      0      |
+----------+---------+-------------+-----------------+---------------------------------------------+----------------------------------------------------+---------------+--------------+---------------+--------------+---------+-------------+
