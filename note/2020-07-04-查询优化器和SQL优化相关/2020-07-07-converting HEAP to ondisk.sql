


CREATE TABLE `words` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=0;
	start transaction;
  while i<100000 do
    insert into words(word) values(concat(char(97+(i div 1000)), char(97+(i % 1000 div 100)), char(97+(i % 100 div 10)), char(97+(i % 10))));
    set i=i+1;
  end while;
	commit;
end;;
delimiter ;

call idata();
		

set tmp_table_size=1024;
set sort_buffer_size=32768;
set max_length_for_sort_data=16;

SET optimizer_trace='enabled=on'; /* 打开 optimizer_trace，只对本线程有效 */
select word from words order by rand() limit 3; /* 执行语句 */
SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; /* 查看 OPTIMIZER_TRACE 输出 */
root@localhost [db1]>SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; /* 查看 OPTIMIZER_TRACE 输出 */
*************************** 1. row ***************************
                            QUERY: select word from words order by rand() limit 3
                            TRACE: {
  "steps": [
    {
      "join_preparation": {
        "select#": 1,
        "steps": [
          {
            "expanded_query": "/* select#1 */ select `words`.`word` AS `word` from `words` order by rand() limit 3"
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
                "table": "`words`",
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
                "table": "`words`",
                "table_scan": {
                  "rows": 9980,
                  "cost": 21
                }
              }
            ]
          },
          {
            "considered_execution_plans": [
              {
                "plan_prefix": [
                ],
                "table": "`words`",
                "best_access_path": {
                  "considered_access_paths": [
                    {
                      "rows_to_scan": 9980,
                      "access_type": "scan",
                      "resulting_rows": 9980,
                      "cost": 2017,
                      "chosen": true
                    }
                  ]
                },
                "condition_filtering_pct": 100,
                "rows_for_plan": 9980,
                "cost_for_plan": 2017,
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
                  "table": "`words`",
                  "attached": null
                }
              ]
            }
          },
          {
            "clause_processing": {
              "clause": "ORDER BY",
              "original_clause": "rand()",
              "items": [
                {
                  "item": "rand()"
                }
              ],
              "resulting_clause_is_simple": false,
              "resulting_clause": "rand()"
            }
          },
          {
            "refine_plan": [
              {
                "table": "`words`"
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
            "creating_tmp_table": {
              "tmp_table_info": {
                "table": "intermediate_tmp_table",
                "row_length": 268,
                "key_length": 0,
                "unique_constraint": false,
                "location": "memory (heap)",
                "row_limit_estimate": 3
              }
            }
          },
          {
            "converting_tmp_table_to_ondisk": {
              "cause": "memory_table_size_exceeded",
              "tmp_table_info": {
                "table": "intermediate_tmp_table",
                "row_length": 268,
                "key_length": 0,
                "unique_constraint": false,
                "location": "disk (InnoDB)",
                "record_format": "packed"
              }
            }
          },
          {
            "filesort_information": [
              {
                "direction": "asc",
                "table": "intermediate_tmp_table",
                "field": "tmp_field_0"
              }
            ],
            "filesort_priority_queue_optimization": {
              "limit": 3,
              "rows_estimate": 1170,
              "row_size": 14,
              "memory_available": 32768,
              "chosen": true
            },
            "filesort_execution": [
            ],
            "filesort_summary": {
              "rows": 4,
              "examined_rows": 10000,
              "number_of_tmp_files": 0,
              "sort_buffer_size": 88,
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

ERROR: 



set tmp_table_size=1024;
set sort_buffer_size=32768;
set max_length_for_sort_data=16;

set profiling = 1;
select word from words order by rand() limit 3;
show profiles;
root@localhost [db1]>show profile cpu,block io for query 1;
+---------------------------+----------+----------+------------+--------------+---------------+
| Status                    | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
+---------------------------+----------+----------+------------+--------------+---------------+
| starting                  | 0.000240 | 0.000236 |   0.000000 |            0 |             0 |
| checking permissions      | 0.000025 | 0.000022 |   0.000000 |            0 |             0 |
| checking permissions      | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| Opening tables            | 0.000030 | 0.000030 |   0.000000 |            0 |             0 |
| init                      | 0.000059 | 0.000059 |   0.000000 |            0 |             0 |
| System lock               | 0.000018 | 0.000018 |   0.000000 |            0 |             0 |
| optimizing                | 0.000016 | 0.000015 |   0.000000 |            0 |             0 |
| statistics                | 0.000127 | 0.000131 |   0.000000 |            0 |             0 |
| preparing                 | 0.000055 | 0.000051 |   0.000000 |            0 |             0 |
| Creating tmp table        | 0.000104 | 0.000108 |   0.000000 |            0 |             0 |
| Sorting result            | 0.000024 | 0.000020 |   0.000000 |            0 |             0 |
| executing                 | 0.000007 | 0.000007 |   0.000000 |            0 |             0 |
| Sending data              | 0.000121 | 0.000122 |   0.000000 |            0 |             0 |
| converting HEAP to ondisk | 0.000328 | 0.000327 |   0.000000 |            0 |             0 |    -- 该线程正在将内部临时表从 MEMORY 表转换为磁盘表, 考虑优化SQL或者增加tmp_table_size参数的大小
| Sending data              | 0.019617 | 0.019609 |   0.000000 |            0 |             0 |
| Creating sort index       | 0.005121 | 0.005121 |   0.000000 |            0 |             0 |
| end                       | 0.000053 | 0.000047 |   0.000000 |            0 |             0 |
| query end                 | 0.000020 | 0.000018 |   0.000000 |            0 |             0 |
| removing tmp table        | 0.000220 | 0.000222 |   0.000000 |            0 |             0 |
| query end                 | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
| closing tables            | 0.000015 | 0.000015 |   0.000000 |            0 |             0 |
| freeing items             | 0.000032 | 0.000032 |   0.000000 |            0 |             0 |
| cleaning up               | 0.000019 | 0.000019 |   0.000000 |            0 |             0 |
+---------------------------+----------+----------+------------+--------------+---------------+
23 rows in set, 1 warning (0.00 sec)
			