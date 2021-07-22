[coding001@db-a ~]$ sudo  pt-table-checksum --nocheck-replication-filters --no-check-binlog-format  --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='123456',P=3306 --databases=dezhou_db
Checking if all tables can be checksummed ...
Starting checksum ...
            TS ERRORS  DIFFS     ROWS  DIFF_ROWS  CHUNKS SKIPPED    TIME TABLE
07-16T17:36:10      0      0       23          0       1       0   0.025 dezhou_db.accountinfo
07-16T17:36:10      0      0        1          0       1       0   0.023 dezhou_db.accountinrole
07-16T17:36:10      0      0       37          0       1       0   0.023 dezhou_db.accountorroleinrule
07-16T17:36:10      0      0        0          0       1       0   0.023 dezhou_db.clubbackgroundoperationlog
07-16T17:36:10      0      0        0          0       1       0   0.024 dezhou_db.enterpricemanage
07-16T17:36:10      0      0       23          0       1       0   0.026 dezhou_db.enterprise
07-16T17:36:10      0      0        0          0       1       0   0.024 dezhou_db.enterpriseauth
07-16T17:36:10      0      0      759          0       1       0   0.025 dezhou_db.enterpriselog
07-16T17:36:10      0      0      404          0       1       0   0.025 dezhou_db.operationslog
07-16T17:36:10      0      0      397          0       1       0   0.026 dezhou_db.rechargedetail
07-16T17:36:10      0      0        1          0       1       0   0.023 dezhou_db.roleinfo
07-16T17:36:10      0      0      125          0       1       0   0.024 dezhou_db.ruleinfo
07-16T17:36:10      0      0      123          0       1       0   0.024 dezhou_db.sys_code
07-16T17:36:10      0      0        0          0       1       0   0.024 dezhou_db.systemlog
07-16T17:36:11      0      0     1694          0       1       0   0.026 dezhou_db.table_bet_inout
07-16T17:36:11      0      1        0     135201       1       0   0.443 dezhou_db.table_career
07-16T17:36:11      0      0      100          0       1       0   0.025 dezhou_db.table_club_application
07-16T17:36:11      0      0       24          0       1       0   0.023 dezhou_db.table_club_diamond_pay_config
07-16T17:36:11      0      0      120          0       1       0   0.023 dezhou_db.table_club_event
07-16T17:36:11      0      0      119          0       1       0   0.024 dezhou_db.table_club_info
07-16T17:36:11      0      0       31          0       1       0   0.023 dezhou_db.table_club_info_notauthority
07-16T17:36:11      0      0       10          0       1       0   0.024 dezhou_db.table_club_level
07-16T17:36:11      0      0     2194          0       1       0   0.027 dezhou_db.table_club_log_diamond
07-16T17:36:11      0      0    11486          0       1       0   0.059 dezhou_db.table_club_log_gold
07-16T17:36:11      0      0     1229          0       1       0   0.026 dezhou_db.table_club_log_platform_score
07-16T17:36:11      0      0        0          0       1       0   0.023 dezhou_db.table_club_log_platform_tax
07-16T17:36:11      0      0     4329          0       1       0   0.033 dezhou_db.table_club_log_score
07-16T17:36:11      0      0      455          0       1       0   0.024 dezhou_db.table_club_member
07-16T17:36:11      0      0      330          0       1       0   0.023 dezhou_db.table_club_member_authority
07-16T17:36:11      0      0       12          0       1       0   0.023 dezhou_db.table_club_member_insurance_rebate
07-16T17:36:11      0      0       72          0       1       0   0.023 dezhou_db.table_credit_log
07-16T17:36:12      0      0    15328          0       1       0   0.157 dezhou_db.table_game_score
07-16T17:36:12      0      0      638          0       1       0   0.026 dezhou_db.table_gameju_data
07-16T17:36:12      0      0        1          0       1       0   0.023 dezhou_db.table_global_config
07-16T17:36:12      0      1        0        336       1       0   0.023 dezhou_db.table_gradescore
07-16T17:36:12      0      0      148          0       1       0   0.023 dezhou_db.table_hand_map_data
07-16T17:36:12      0      0      484          0       1       0   0.026 dezhou_db.table_info
07-16T17:36:12      0      0      394          0       1       0   0.023 dezhou_db.table_insurance_record
07-16T17:36:12      0      0      340          0       1       0   0.024 dezhou_db.table_manager_login_token
07-16T17:36:12      0      0        0          0       1       0   0.022 dezhou_db.table_manual
07-16T17:36:12      0      0        1          0       1       0   0.024 dezhou_db.table_marquee_msg
07-16T17:36:12      0      0        0          0       1       0   0.023 dezhou_db.table_mutex_user
07-16T17:36:12      0      0        5          0       1       0   0.021 dezhou_db.table_number
07-16T17:36:12      0      0     4628          0       1       0   0.058 dezhou_db.table_paiju_data
07-16T17:36:12      0      0        6          0       1       0   0.025 dezhou_db.table_pay_log
07-16T17:36:12      0      0       87          0       1       0   0.023 dezhou_db.table_pay_pre
07-16T17:36:12      0      1        0         64       1       0   0.023 dezhou_db.table_statistics_clubrate
07-16T17:36:12      0      1        0         15       1       0   0.023 dezhou_db.table_statistics_creditscore
07-16T17:36:12      0      1        0        163       1       0   0.023 dezhou_db.table_statistics_download
07-16T17:36:12      0      1        0       1390       1       0   0.023 dezhou_db.table_statistics_extendesc
07-16T17:36:12      0      0       29          0       1       0   0.023 dezhou_db.table_tax_winner_total
07-16T17:36:12      0      0      338          0       1       0   0.026 dezhou_db.table_user
07-16T17:36:12      0      0        0          0       1       0   0.023 dezhou_db.table_user_headpic_verify
07-16T17:36:12      0      0      892          0       1       0   0.025 dezhou_db.table_user_msg
07-16T17:36:12      0      0    15327          0       1       0   0.106 dezhou_db.table_user_playdata
07-16T17:36:12      0      0        0          0       1       0   0.024 dezhou_db.table_user_rewards
07-16T17:36:12      0      0        2          0       1       0   0.022 dezhou_db.table_web_clubauthority
07-16T17:36:12      0      1        0        348       1       0   0.023 dezhou_db.table_web_havelog
07-16T17:36:13      0      0   115414          0       1       0   0.440 dezhou_db.table_web_loginlog
07-16T17:36:13      0      0      200          0       1       0   0.025 dezhou_db.table_web_money
07-16T17:36:13      0      1        0     215978       1       0   0.258 dezhou_db.table_web_totalinline_min
07-16T17:36:13      0      1        0        373       1       0   0.024 dezhou_db.table_web_totallogin
07-16T17:36:13      0      1      156          0       1       0   0.024 dezhou_db.table_zhanji_details