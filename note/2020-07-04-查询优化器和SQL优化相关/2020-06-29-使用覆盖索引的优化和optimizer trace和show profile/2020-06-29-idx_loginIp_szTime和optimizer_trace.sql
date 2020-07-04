alter table table_web_loginlog add index idx_loginIp_szTime(loginIp, szTime), drop index idx_loginIp_szTime_nPlayerId;



SET optimizer_trace='enabled=on'; 
SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 

	
root@mysqldb 18:15:  [bak_niuniuh5_db]> SET optimizer_trace='enabled=on'; 
Query OK, 0 rows affected (0.00 sec)

root@mysqldb 18:15:  [bak_niuniuh5_db]> SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.24 sec)

root@mysqldb 18:15:  [bak_niuniuh5_db]> SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G;
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
            "condition_processing": {   -- 处理搜索条件
              "condition": "WHERE",
			  -- 原始搜索条件
              "original_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))",
              "steps": [
                {
				-- 等值传递转换
                  "transformation": "equality_propagation",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))"
                },
                {
				-- 常量传递转换  
                  "transformation": "constant_propagation",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))"
                },
                {
				-- 去除没用的条件
                  "transformation": "trivial_condition_removal",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36') and (`table_web_loginlog`.`nPlayerId` <> 1000))"
                }
              ]
            }
          },
          {
		    -- 替换虚拟生成列
            "substitute_generated_columns": {
            }
          },
          {
		    -- 表的依赖信息
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
              }
            ]
          },
          {
		    -- 预估不同单表访问方法的访问成本 
            "rows_estimation": [
              {
                "table": "`table_web_loginlog`",
                "range_analysis": {
                  "table_scan": {   -- 全表扫描的行数以及成本
                    "rows": 6634611,
                    "cost": 1.36e6
                  },
				  
				  -- 分析可能使用的索引
                  "potential_range_indexes": [
                    {
                      "index": "PRIMARY",    -- 主键不可用
                      "usable": false,
                      "cause": "not_applicable"
                    },
                    {
                      "index": "idx_loginIp_szTime",  --  idx_loginIp_szTime 可能被使用
                      "usable": true,
                      "key_parts": [
                        "loginIp",
                        "szTime",
                        "Idx"
                      ]
                    }
                  ],
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
					  --  使用 idx_loginIp_szTime 的成本分析
                        "index": "idx_loginIp_szTime",
                        "ranges": [
                          "192.168.0.71 <= loginIp <= 192.168.0.71 AND 0x5ef45b84 < szTime"
                        ],
                        "index_dives_for_eq_ranges": true,  -- 是否使用index dive
                        "rowid_ordered": false,  -- 使用该索引获取的记录是否按照主键排序
                        "using_mrr": false,      -- 是否使用mrr
                        "index_only": false,     -- 是否是索引覆盖访问
                        "rows": 202224,          -- 使用该索引获取的记录条数
                        "cost": 242670,          -- 使用该索引的成本
                        "chosen": true           -- 是否选择该索引
                      }
                    ],
                    "analyzing_roworder_intersect": {
                      "usable": false,
                      "cause": "too_few_roworder_scans"
                    }
                  },
				  
				  # 对于上述单表查询最优的访问方法
                  "chosen_range_access_summary": {
                    "range_access_plan": {
                      "type": "range_scan",
                      "index": "idx_loginIp_szTime",
                      "rows": 202224,
                      "ranges": [
                        "192.168.0.71 <= loginIp <= 192.168.0.71 AND 0x5ef45b84 < szTime"
                      ]
                    },
                    "rows_for_plan": 202224,
                    "cost_for_plan": 242670,
                    "chosen": true
                  }
                }
              }
            ]
          },
          {
		    -- 分析各种可能的执行计划
            "considered_execution_plans": [
              {
                "plan_prefix": [
                ],
                "table": "`table_web_loginlog`",
                "best_access_path": {
                  "considered_access_paths": [
                    { 
                      "access_type": "ref",      -- 等值查询
                      "index": "idx_loginIp_szTime",
                      "rows": 202224,
                      "cost": 125885,
                      "chosen": true
                    },
                    {
                      "rows_to_scan": 202224,
                      "access_type": "range",  -- 范围查询
                      "range_details": {
                        "used_index": "idx_loginIp_szTime"
                      },
                      "resulting_rows": 202224,
                      "cost": 283115,
                      "chosen": false
                    }
                  ]
                },
                "condition_filtering_pct": 100,
                "rows_for_plan": 202224,
                "cost_for_plan": 125885,
                "chosen": true
              }
            ]
          },
          {
            "access_type_changed": {
              "table": "`table_web_loginlog`",
              "index": "idx_loginIp_szTime",
              "old_type": "ref",
              "new_type": "range",
              "cause": "uses_more_keyparts"
            }
          },
          {
			-- 尝试给查询添加一些其他的查询条件
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
                "table": "`table_web_loginlog`",
                "pushed_index_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36'))",
                "table_condition_attached": "(`table_web_loginlog`.`nPlayerId` <> 1000)"
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


------------------------------------------------------------


