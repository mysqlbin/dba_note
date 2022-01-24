
SET optimizer_trace='enabled=on'; 
SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 

	

root@mysqldb 23:03:  [bak_niuniuh5_db]> show create table table_web_loginlog\G;
*************************** 1. row ***************************
       Table: table_web_loginlog
Create Table: CREATE TABLE `table_web_loginlog` (
  `Idx` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `nPlayerId` int(11) NOT NULL,
  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
  `szNickName` varchar(64) DEFAULT NULL,
  `nAction` int(11) NOT NULL DEFAULT '0',
  `szTime` timestamp NULL DEFAULT NULL,
  `loginIp` varchar(64) DEFAULT NULL,
  `strRe1` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`Idx`),
  KEY `idx_loginIp_szTime_nPlayerId` (`loginIp`,`szTime`,`nPlayerId`),
  KEY `idx_loginIp_szTime` (`loginIp`,`szTime`)
) ENGINE=InnoDB AUTO_INCREMENT=7135863 DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)


root@mysqldb 23:03:  [bak_niuniuh5_db]> SET optimizer_trace='enabled=on'; 
Query OK, 0 rows affected (0.00 sec)

root@mysqldb 23:03:  [bak_niuniuh5_db]> SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.13 sec)

root@mysqldb 10:29:  [bak_niuniuh5_db]> desc SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
+----+-------------+--------------------+------------+-------+-------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
| id | select_type | table              | partitions | type  | possible_keys                                   | key                          | key_len | ref  | rows   | filtered | Extra                    |
+----+-------------+--------------------+------------+-------+-------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
|  1 | SIMPLE      | table_web_loginlog | NULL       | range | idx_loginIp_szTime_nPlayerId,idx_loginIp_szTime | idx_loginIp_szTime_nPlayerId | 264     | NULL | 195588 |    90.00 | Using where; Using index |
+----+-------------+--------------------+------------+-------+-------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
1 row in set, 1 warning (0.00 sec)


root@mysqldb 23:03:  [bak_niuniuh5_db]> SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 
*************************** 1. row ***************************
                            QUERY: SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000
                            TRACE: {
  "steps": [
    {
      "join_preparation": {
        "select#": 1,
        "steps": [
          {
            "expanded_query": "/* select#1 */ select count(0) AS `count(*)` from `table_web_loginlog` where ((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))"
          }
        ]
      }
    },
    {
      "join_optimization": {
        "select#": 1,
        "steps": [
          {
            "condition_processing": {
              "condition": "WHERE",
              "original_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))",
              "steps": [
                {
                  "transformation": "equality_propagation",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))"
                },
                {
                  "transformation": "constant_propagation",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))"
                },
                {
                  "transformation": "trivial_condition_removal",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))"
                }
              ]
            }
          },
          {
            "substitute_generated_columns": {
            }
          },
          {
            "table_dependencies": [
              {
                "table": "`table_web_loginlog`",
                "row_may_be_null": false,
                "map_bit": 0,
                "depends_on_map_bits": [
                ]
              }
            ]
          },
          {
            "ref_optimizer_key_uses": [
              {
                "table": "`table_web_loginlog`",
                "field": "loginIp",
                "equals": "'192.168.0.71'",
                "null_rejecting": false
              },
              {
                "table": "`table_web_loginlog`",
                "field": "loginIp",
                "equals": "'192.168.0.71'",
                "null_rejecting": false
              }
            ]
          },
          {
		  
			-- 预估不同单表访问方法的访问成本
            "rows_estimation": [
              {
                "table": "`table_web_loginlog`",
                "range_analysis": {
                  "table_scan": {
                    "rows": 6634611,
                    "cost": 1.36e6
                  },
				   -- 分析可能使用的索引
                  "potential_range_indexes": [
                    {
                      "index": "PRIMARY",         -- 主键不可用
                      "usable": false,
                      "cause": "not_applicable"
                    },
                    {
                      "index": "idx_loginIp_szTime_nPlayerId",    -- idx_loginIp_szTime_nPlayerId 可能被使用
                      "usable": true,
                      "key_parts": [
                        "loginIp",
                        "szTime",
                        "nPlayerId",
                        "Idx"
                      ]
                    },
                    {
                      "index": "idx_loginIp_szTime",    -- idx_loginIp_szTime 可能被使用
                      "usable": true,
                      "key_parts": [
                        "loginIp",
                        "szTime",
                        "Idx"
                      ]
                    }
                  ],
                  "best_covering_index_scan": {      -- 最优的办法是使用覆盖索引扫描
                    "index": "idx_loginIp_szTime_nPlayerId",  -- idx_loginIp_szTime_nPlayerId 被使用
                    "cost": 1.55e6,
                    "chosen": false,
                    "cause": "cost"
                  },
                  "setup_range_conditions": [
                  ],
                  "group_index_range": {
                    "chosen": false,
                    "cause": "not_group_by_or_distinct"
                  },
				  
				  -- 分析各种可能使用的索引的成本
                  "analyzing_range_alternatives": {
                    "range_scan_alternatives": [
                      {
						-- 使用 idx_loginIp_szTime_nPlayerId 的成本分析
                        "index": "idx_loginIp_szTime_nPlayerId",
                        "ranges": [
                          "192.168.0.71 <= loginIp <= 192.168.0.71 AND 0x5ef45b84 < szTime"
                        ],
                        "index_dives_for_eq_ranges": true,  -- 是否使用index dive 
                        "rowid_ordered": false,
                        "using_mrr": false,
                        "index_only": true, -- 是否使用覆盖索引
                        "rows": 195588,   -- 使用该索引获取的记录条数  
                        "cost": 45638,    -- 使用该索引的成本
                        "chosen": true    -- 是否选择 idx_loginIp_szTime_nPlayerId 索引，是。
                      },
                      {
                        "index": "idx_loginIp_szTime",
                        "ranges": [
                          "192.168.0.71 <= loginIp <= 192.168.0.71 AND 0x5ef45b84 < szTime"
                        ],
                        "index_dives_for_eq_ranges": true,
                        "rowid_ordered": false,
                        "using_mrr": false,
                        "index_only": false,
                        "rows": 202224,   -- 使用该索引获取的记录条数
                        "cost": 242670,   -- 使用该索引的成本
                        "chosen": false,
                        "cause": "cost"   --  因为成本太大所以不选择该索引
                      }
                    ],
					
                    "analyzing_roworder_intersect": {
                      "usable": false,
                      "cause": "too_few_roworder_scans"
                    }
                  },
				  -- 对于上述单表查询最优的访问方法
                  "chosen_range_access_summary": {
                    "range_access_plan": {
                      "type": "range_scan",
                      "index": "idx_loginIp_szTime_nPlayerId",  -- idx_loginIp_szTime_nPlayerId 索引
                      "rows": 195588,   -- 需要扫描的行数
                      "ranges": [
                        "192.168.0.71 <= loginIp <= 192.168.0.71 AND 0x5ef45b84 < szTime"
                      ]
                    },
                    "rows_for_plan": 195588,   
                    "cost_for_plan": 45638,    -- 代价
                    "chosen": true
                  }
                }
              }
            ]
          },
          {
            "considered_execution_plans": [
              {
                "plan_prefix": [
                ],
                "table": "`table_web_loginlog`",
                "best_access_path": {
                  "considered_access_paths": [
                    {
                      "access_type": "ref",
                      "index": "idx_loginIp_szTime_nPlayerId",
                      "rows": 195588,
                      "cost": 45638,
                      "chosen": true
                    },
                    {
                      "access_type": "ref",
                      "index": "idx_loginIp_szTime",
                      "rows": 202224,
                      "cost": 125885,
                      "chosen": false
                    },
                    {
                      "rows_to_scan": 195588,
                      "access_type": "range",
                      "range_details": {
                        "used_index": "idx_loginIp_szTime_nPlayerId"
                      },
                      "resulting_rows": 195588,
                      "cost": 84756,
                      "chosen": false
                    }
                  ]
                },
                "condition_filtering_pct": 100,
                "rows_for_plan": 195588,
                "cost_for_plan": 45638,
                "chosen": true
              }
            ]
          },
          {
            "access_type_changed": {
              "table": "`table_web_loginlog`",
              "index": "idx_loginIp_szTime_nPlayerId",
              "old_type": "ref",
              "new_type": "range",
              "cause": "uses_more_keyparts"
            }
          },
          {
            "attaching_conditions_to_tables": {
              "original_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))",
              "attached_conditions_computation": [
              ],
              "attached_conditions_summary": [
                {
                  "table": "`table_web_loginlog`",
                  "attached": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))"
                }
              ]
            }
          },
          {
            "refine_plan": [
              {
                "table": "`table_web_loginlog`"
              }
            ]
          }
        ]
      }
    },
    {
      "join_execution": {
        "select#": 1,
        "steps": [
        ]
      }
    }
  ]
}
MISSING_BYTES_BEYOND_MAX_MEM_SIZE: 0
          INSUFFICIENT_PRIVILEGES: 0
1 row in set (0.00 sec)

ERROR: 
No query specified
