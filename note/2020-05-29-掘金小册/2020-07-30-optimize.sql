

root@mysqldb 12:01:  [audit_db]> desc SELECT * FROM person_info ORDER BY name asc, birthday asc, phone_number asc LIMIT 10;
+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
| id | select_type | table       | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
|  1 | SIMPLE      | person_info | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
1 row in set, 1 warning (0.00 sec)



root@mysqldb 12:01:  [audit_db]> desc SELECT name,birthday,phone_number FROM person_info ORDER BY name asc, birthday asc, phone_number asc LIMIT 10;
+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
| id | select_type | table       | partitions | type  | possible_keys | key                            | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | person_info | NULL       | index | NULL          | idx_name_birthday_phone_number | 449     | NULL |    9 |   100.00 | Using index |
+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)



root@mysqldb 12:02:  [audit_db]> show global variables like '%optimizer_switch%';
+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable_name    | Value                                                                                                                                                                                                                                                                                                                                                                                                            |
+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| optimizer_switch | index_merge=on,index_merge_union=on,index_merge_sort_union=on,index_merge_intersection=on,engine_condition_pushdown=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=on,block_nested_loop=on,batched_key_access=off,materialization=on,semijoin=on,loosescan=on,firstmatch=on,duplicateweedout=on,subquery_materialization_cost_based=on,use_index_extensions=on,condition_fanout_filter=on,derived_merge=on |
+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.01 sec)



SET optimizer_trace='enabled=on'; 
SELECT * FROM person_info ORDER BY name asc, birthday asc, phone_number asc LIMIT 10;
SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 

root@mysqldb 12:05:  [audit_db]> SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 
*************************** 1. row ***************************
                            QUERY: SELECT * FROM person_info ORDER BY name asc, birthday asc, phone_number asc LIMIT 10
                            TRACE: {
  "steps": [
    {
      "join_preparation": {
        "select#": 1,
        "steps": [
          {
            "expanded_query": "/* select#1 */ select `person_info`.`id` AS `id`,`person_info`.`name` AS `name`,`person_info`.`birthday` AS `birthday`,`person_info`.`phone_number` AS `phone_number`,`person_info`.`country` AS `country` from `person_info` order by `person_info`.`name`,`person_info`.`birthday`,`person_info`.`phone_number` limit 10"
          }
        ]
      }
    },
    {
      "join_optimization": {
        "select#": 1,
        "steps": [
          {
            "substitute_generated_columns": {
            }
          },
          {
            "table_dependencies": [
              {
                "table": "`person_info`",
                "row_may_be_null": false,
                "map_bit": 0,
                "depends_on_map_bits": [
                ]
              }
            ]
          },
          {
            "rows_estimation": [
              {
                "table": "`person_info`",
                "table_scan": {
                  "rows": 9,
                  "cost": 1
                }
              }
            ]
          },
          {
			# 分析各种可能的执行计划
            "considered_execution_plans": [
              {
                "plan_prefix": [
                ],
                "table": "`person_info`",   
                "best_access_path": {
                  "considered_access_paths": [
                    {
                      "rows_to_scan": 9,
                      "access_type": "scan",    -- 全表扫描
                      "resulting_rows": 9,
                      "cost": 2.8,
                      "chosen": true,
                      "use_tmp_table": true   -- 使用临时表
                    }
                  ]
                },
                "condition_filtering_pct": 100,
                "rows_for_plan": 9,
                "cost_for_plan": 2.8,
                "sort_cost": 9,
                "new_cost_for_plan": 11.8,
                "chosen": true
              }
            ]
          },
          {
            "attaching_conditions_to_tables": {
              "original_condition": null,
              "attached_conditions_computation": [
              ],
              "attached_conditions_summary": [
                {
                  "table": "`person_info`",
                  "attached": null
                }
              ]
            }
          },
          {
            "clause_processing": {
              "clause": "ORDER BY",
              "original_clause": "`person_info`.`name`,`person_info`.`birthday`,`person_info`.`phone_number`",
              "items": [
                {
                  "item": "`person_info`.`name`"
                },
                {
                  "item": "`person_info`.`birthday`"
                },
                {
                  "item": "`person_info`.`phone_number`"
                }
              ],
              "resulting_clause_is_simple": true,
              "resulting_clause": "`person_info`.`name`,`person_info`.`birthday`,`person_info`.`phone_number`"
            }
          },
          {
            "reconsidering_access_paths_for_index_ordering": {
              "clause": "ORDER BY",
              "index_order_summary": {
                "table": "`person_info`",
                "index_provides_order": false,
                "order_direction": "undefined",
                "index": "unknown",
                "plan_changed": false
              }
            }
          },
          {
            "refine_plan": [
              {
                "table": "`person_info`"
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
          {
            "filesort_information": [
              {
                "direction": "asc",
                "table": "`person_info`",
                "field": "name"
              },
              {
                "direction": "asc",
                "table": "`person_info`",
                "field": "birthday"
              },
              {
                "direction": "asc",
                "table": "`person_info`",
                "field": "phone_number"
              }
            ],
            "filesort_priority_queue_optimization": {
              "limit": 10,
              "rows_estimate": 1092,
              "row_size": 229,
              "memory_available": 4194304,
              "chosen": true
            },
            "filesort_execution": [
            ],
            "filesort_summary": {
              "rows": 9,
              "examined_rows": 9,
              "number_of_tmp_files": 0,
              "sort_buffer_size": 2608,
              "sort_mode": "<sort_key, rowid>"
            }
          }
        ]
      }
    }
  ]
}
MISSING_BYTES_BEYOND_MAX_MEM_SIZE: 0
          INSUFFICIENT_PRIVILEGES: 0
1 row in set (0.00 sec)


