
SET optimizer_trace='enabled=on';
SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 
mysql> SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 
*************************** 1. row ***************************
                            QUERY: SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806
                            TRACE: {
  "steps": [
    {
      "join_preparation": {
        "select#": 1,
        "steps": [
          {
            "expanded_query": "/* select#1 */ select `table_dm`.`nClubID` AS `nClubId`,`table_dm`.`nExtenID` AS `nExtenID`,`table_dm`.`nPlayerID` AS `nPlayerID` from `table_dm` where ((`table_dm`.`nClubID` = 10017) and (`table_dm`.`nExtenID` = 132806))"
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
              "original_condition": "((`table_dm`.`nClubID` = 10017) and (`table_dm`.`nExtenID` = 132806))",
              "steps": [
                {
                  "transformation": "equality_propagation",
                  "resulting_condition": "(multiple equal(10017, `table_dm`.`nClubID`) and multiple equal(132806, `table_dm`.`nExtenID`))"
                },
                {
                  "transformation": "constant_propagation",
                  "resulting_condition": "(multiple equal(10017, `table_dm`.`nClubID`) and multiple equal(132806, `table_dm`.`nExtenID`))"
                },
                {
                  "transformation": "trivial_condition_removal",
                  "resulting_condition": "(multiple equal(10017, `table_dm`.`nClubID`) and multiple equal(132806, `table_dm`.`nExtenID`))"
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
                "table": "`table_dm`",
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
                "table": "`table_dm`",
                "field": "nClubID",
                "equals": "10017",
                "null_rejecting": false
              },
              {
                "table": "`table_dm`",
                "field": "nExtenID",
                "equals": "132806",
                "null_rejecting": false
              }
            ]
          },
          {
            "rows_estimation": [
              {
                "table": "`table_dm`",
                "range_analysis": {
                  "table_scan": {
                    "rows": 91626,
                    "cost": 18936
                  },
                  "potential_range_indexes": [
                    {
                      "index": "PRIMARY",
                      "usable": false,
                      "cause": "not_applicable"
                    },
                    {
                      "index": "idx_nClubID_nExtenID",
                      "usable": true,
                      "key_parts": [
                        "nClubID",
                        "nExtenID",
                        "ID"
                      ]
                    }
                  ],
                  "setup_range_conditions": [
                  ],
                  "group_index_range": {
                    "chosen": false,
                    "cause": "not_group_by_or_distinct"
                  },
                  "analyzing_range_alternatives": {
                    "range_scan_alternatives": [
                      {
                        "index": "idx_nClubID_nExtenID",
                        "ranges": [
                          "10017 <= nClubID <= 10017 AND 132806 <= nExtenID <= 132806"
                        ],
                        "index_dives_for_eq_ranges": true,
                        "rowid_ordered": true,
                        "using_mrr": false,
                        "index_only": false,
                        "rows": 18284,
                        "cost": 21942,
                        "chosen": false,
                        "cause": "cost"
                      }
                    ],
                    "analyzing_roworder_intersect": {
                      "usable": false,
                      "cause": "too_few_roworder_scans"
                    }
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
                "table": "`table_dm`",
                "best_access_path": {
                  "considered_access_paths": [
                    {
                      "access_type": "ref",
                      "index": "idx_nClubID_nExtenID",
                      "rows": 18284,
                      "cost": 5483.8,
                      "chosen": true
                    },
                    {
                      "rows_to_scan": 91626,
                      "access_type": "scan",
                      "resulting_rows": 91626,
                      "cost": 18934,
                      "chosen": false
                    }
                  ]
                },
                "condition_filtering_pct": 100,
                "rows_for_plan": 18284,
                "cost_for_plan": 5483.8,
                "chosen": true
              }
            ]
          },
          {
            "attaching_conditions_to_tables": {
              "original_condition": "((`table_dm`.`nExtenID` = 132806) and (`table_dm`.`nClubID` = 10017))",
              "attached_conditions_computation": [
              ],
              "attached_conditions_summary": [
                {
                  "table": "`table_dm`",
                  "attached": null
                }
              ]
            }
          },
          {
            "refine_plan": [
              {
                "table": "`table_dm`"
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
