mysql> SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G;
*************************** 1. row ***************************
                            QUERY: select * from msg where operator=0 limit 10
                            TRACE: {
  "steps": [
    {
      "join_preparation": {
        "select#": 1,
        "steps": [
          {
            "expanded_query": "/* select#1 */ select `msg`.`id` AS `id`,`msg`.`title` AS `title`,`msg`.`content` AS `content`,`msg`.`type` AS `type`,`msg`.`custom` AS `custom`,`msg`.`send_type` AS `send_type`,`msg`.`channel` AS `channel`,`msg`.`target` AS `target`,`msg`.`push_time` AS `push_time`,`msg`.`send_time` AS `send_time`,`msg`.`operator` AS `operator`,`msg`.`created_time` AS `created_time`,`msg`.`updated_time` AS `updated_time` from `msg` where (`msg`.`operator` = 0) limit 10"
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
              "original_condition": "(`msg`.`operator` = 0)",
              "steps": [
                {
                  "transformation": "equality_propagation",
                  "resulting_condition": "multiple equal(0, `msg`.`operator`)"
                },
                {
                  "transformation": "constant_propagation",
                  "resulting_condition": "multiple equal(0, `msg`.`operator`)"
                },
                {
                  "transformation": "trivial_condition_removal",
                  "resulting_condition": "multiple equal(0, `msg`.`operator`)"
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
                "table": "`msg`",
                "row_may_be_null": false,
                "map_bit": 0,
                "depends_on_map_bits": [
                ]
              }
            ]
          },
          {
            "ref_optimizer_key_uses": [
            ]
          },
          {
            "rows_estimation": [
              {
                "table": "`msg`",
                "table_scan": {
                  "rows": 1602795,
                  "cost": 28795
                }
              }
            ]
          },
          {
            "considered_execution_plans": [
              {
                "plan_prefix": [
                ],
                "table": "`msg`",
                "best_access_path": {
                  "considered_access_paths": [
                    {
                      "rows_to_scan": 1602795,
                      "access_type": "scan",
                      "resulting_rows": 1.6e6,
                      "cost": 349354,
                      "chosen": true
                    }
                  ]
                },
                "condition_filtering_pct": 100,
                "rows_for_plan": 1.6e6,
                "cost_for_plan": 349354,
                "chosen": true
              }
            ]
          },
          {
            "attaching_conditions_to_tables": {
              "original_condition": "(`msg`.`operator` = 0)",
              "attached_conditions_computation": [
              ],
              "attached_conditions_summary": [
                {
                  "table": "`msg`",
                  "attached": "(`msg`.`operator` = 0)"
                }
              ]
            }
          },
          {
            "refine_plan": [
              {
                "table": "`msg`"
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
1 row in set (0.01 sec)