
SET optimizer_trace='enabled=on'; 
select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 


root@mysqldb 18:32:  [bak_niuniuh5_db]> select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
+----------------------------------------------------+
| sum(case when nPlayerId != 1000 then 1 else 0 end) |
+----------------------------------------------------+
|                                                  0 |
+----------------------------------------------------+
1 row in set (0.10 sec)

root@mysqldb 18:32:  [bak_niuniuh5_db]> SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 
*************************** 1. row ***************************
                            QUERY: select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36'
                            TRACE: {
  "steps": [
    {
      "join_preparation": {
        "select#": 1,
        "steps": [
          {
            "expanded_query": "/* select#1 */ select sum((case when (`table_web_loginlog`.`nPlayerId` <> 1000) then 1 else 0 end)) AS `sum(case when nPlayerId != 1000 then 1 else 0 end)` from `table_web_loginlog` where ((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36'))"
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
              "original_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36'))",
              "steps": [
                {
                  "transformation": "equality_propagation",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36'))"
                },
                {
                  "transformation": "constant_propagation",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36'))"
                },
                {
                  "transformation": "trivial_condition_removal",
                  "resulting_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36'))"
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
              }
            ]
          },
          {
            "rows_estimation": [
              {
                "table": "`table_web_loginlog`",
                "range_analysis": {
                  "table_scan": {
                    "rows": 6634611,
                    "cost": 1.36e6
                  },
                  "potential_range_indexes": [
                    {
                      "index": "PRIMARY",
                      "usable": false,
                      "cause": "not_applicable"
                    },
                    {
                      "index": "idx_loginIp_szTime_nPlayerId",
                      "usable": true,
                      "key_parts": [
                        "loginIp",
                        "szTime",
                        "nPlayerId",
                        "Idx"
                      ]
                    }
                  ],
                  "best_covering_index_scan": {
                    "index": "idx_loginIp_szTime_nPlayerId",
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
                  "analyzing_range_alternatives": {
                    "range_scan_alternatives": [
                      {
                        "index": "idx_loginIp_szTime_nPlayerId",
                        "ranges": [
                          "192.168.0.71 <= loginIp <= 192.168.0.71 AND 0x5ef45b84 < szTime"
                        ],
                        "index_dives_for_eq_ranges": true,
                        "rowid_ordered": false,
                        "using_mrr": false,
                        "index_only": true,
                        "rows": 195588,
                        "cost": 45638,
                        "chosen": true
                      }
                    ],
                    "analyzing_roworder_intersect": {
                      "usable": false,
                      "cause": "too_few_roworder_scans"
                    }
                  },
                  "chosen_range_access_summary": {
                    "range_access_plan": {
                      "type": "range_scan",
                      "index": "idx_loginIp_szTime_nPlayerId",
                      "rows": 195588,
                      "ranges": [
                        "192.168.0.71 <= loginIp <= 192.168.0.71 AND 0x5ef45b84 < szTime"
                      ]
                    },
                    "rows_for_plan": 195588,
                    "cost_for_plan": 45638,
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
              "original_condition": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36'))",
              "attached_conditions_computation": [
              ],
              "attached_conditions_summary": [
                {
                  "table": "`table_web_loginlog`",
                  "attached": "((`table_web_loginlog`.`loginIp` = '192.168.0.71') and (`table_web_loginlog`.`szTime` > '2020-06-25 16:08:36'))"
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

