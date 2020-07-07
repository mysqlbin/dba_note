
mysql> SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 
*************************** 1. row ***************************
                            QUERY: SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806
                            TRACE: {
  "steps": [
    {
      "join_preparation": {
        "select#": 1,
        "steps": [
          {
            "expanded_query": "/* select#1 */ select `table_cm`.`nClubID` AS `nClubId`,`table_cm`.`nExtenID` AS `nExtenID`,`table_cm`.`nPlayerID` AS `nPlayerID` from `table_cm` where ((`table_cm`.`nClubID` = 10017) and (`table_cm`.`nExtenID` = 132806))"
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
              "original_condition": "((`table_cm`.`nClubID` = 10017) and (`table_cm`.`nExtenID` = 132806))",
              "steps": [
                {
                  "transformation": "equality_propagation",
                  "resulting_condition": "(multiple equal(10017, `table_cm`.`nClubID`) and multiple equal(132806, `table_cm`.`nExtenID`))"
                },
                {
                  "transformation": "constant_propagation",
                  "resulting_condition": "(multiple equal(10017, `table_cm`.`nClubID`) and multiple equal(132806, `table_cm`.`nExtenID`))"
                },
                {
                  "transformation": "trivial_condition_removal",
                  "resulting_condition": "(multiple equal(10017, `table_cm`.`nClubID`) and multiple equal(132806, `table_cm`.`nExtenID`))"
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
                "table": "`table_cm`",
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
                "table": "`table_cm`",
                "field": "nClubID",
                "equals": "10017",
                "null_rejecting": false
              },
              {
                "table": "`table_cm`",
                "field": "nExtenID",
                "equals": "132806",
                "null_rejecting": false
              }
            ]
          },
          {
		  
			-- 预估不同单表访问方法的访问成本
            "rows_estimation": [
              {
                "table": "`table_cm`",
                "range_analysis": {
                  "table_scan": {
                    "rows": 94214,
                    "cost": 19518
                  },
				  
				  -- 分析可能使用的索引
                  "potential_range_indexes": [
                    {
                      "index": "PRIMARY",
                      "usable": false,
                      "cause": "not_applicable"
                    },
                    {
                      "index": "idx_nClubID_nExtenID_nPlayerID",
                      "usable": true,
                      "key_parts": [
                        "nClubID",
                        "nExtenID",
                        "nPlayerID",
                        "ID"
                      ]
                    }
                  ],
                  "best_covering_index_scan": {
                    "index": "idx_nClubID_nExtenID_nPlayerID",
                    "cost": 19039,
                    "chosen": true
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
                        "index": "idx_nClubID_nExtenID_nPlayerID",
                        "ranges": [
                          "10017 <= nClubID <= 10017 AND 132806 <= nExtenID <= 132806"
                        ],
                        "index_dives_for_eq_ranges": true,
                        "rowid_ordered": false,
                        "using_mrr": false,
                        "index_only": true,
                        "rows": 18088,
                        "cost": 3656.1,
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
                      "index": "idx_nClubID_nExtenID_nPlayerID",
                      "rows": 18088,
                      "ranges": [
                        "10017 <= nClubID <= 10017 AND 132806 <= nExtenID <= 132806"
                      ]
                    },
                    "rows_for_plan": 18088,
                    "cost_for_plan": 3656.1,
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
                "table": "`table_cm`",
                "best_access_path": {
                  "considered_access_paths": [
                    {
                      "access_type": "ref",
                      "index": "idx_nClubID_nExtenID_nPlayerID",
                      "rows": 18088,
                      "cost": 3656.1,
                      "chosen": true
                    },
                    {
                      "access_type": "range",
                      "range_details": {
                        "used_index": "idx_nClubID_nExtenID_nPlayerID"
                      },
                      "chosen": false,
                      "cause": "heuristic_index_cheaper"
                    }
                  ]
                },
                "condition_filtering_pct": 100,
                "rows_for_plan": 18088,
                "cost_for_plan": 3656.1,
                "chosen": true
              }
            ]
          },
          {
            "attaching_conditions_to_tables": {
              "original_condition": "((`table_cm`.`nExtenID` = 132806) and (`table_cm`.`nClubID` = 10017))",
              "attached_conditions_computation": [
              ],
              "attached_conditions_summary": [
                {
                  "table": "`table_cm`",
                  "attached": null
                }
              ]
            }
          },
          {
            "refine_plan": [
              {
                "table": "`table_cm`"
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