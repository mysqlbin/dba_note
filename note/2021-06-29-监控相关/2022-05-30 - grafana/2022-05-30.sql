Time series:
- return column named time or time_sec (in UTC), as a unix time stamp or any sql native date data type. You can use the macros below.
- return column(s) with numeric datatype as values
Optional:
  - return column named metric to represent the series name.
  - If multiple value columns are returned the metric column is used as prefix.
  - If no column named metric is found the column name of the value column is used as series name

Resultsets of time series queries need to be sorted by time.

Table:
- return any set of columns

Macros:
- $__time(column) -> UNIX_TIMESTAMP(column) as time_sec
- $__timeEpoch(column) -> UNIX_TIMESTAMP(column) as time_sec
- $__timeFilter(column) -> column BETWEEN FROM_UNIXTIME(1492750877) AND FROM_UNIXTIME(1492750877)
- $__unixEpochFilter(column) ->  time_unix_epoch > 1492750877 AND time_unix_epoch < 1492750877
- $__unixEpochNanoFilter(column) ->  column >= 1494410783152415214 AND column <= 1494497183142514872
- $__timeGroup(column,'5m'[, fillvalue]) -> cast(cast(UNIX_TIMESTAMP(column)/(300) as signed)*300 as signed)
     by setting fillvalue grafana will fill in missing values according to the interval
     fillvalue can be either a literal value, NULL or previous; previous will fill in the previous seen value or NULL if none has been seen yet
- $__timeGroupAlias(column,'5m') -> cast(cast(UNIX_TIMESTAMP(column)/(300) as signed)*300 as signed) AS "time"
- $__unixEpochGroup(column,'5m') -> column DIV 300 * 300
- $__unixEpochGroupAlias(column,'5m') -> column DIV 300 * 300 AS "time"

Example of group by and order by with $__timeGroup:
SELECT
  $__timeGroupAlias(timestamp_col, '1h'),
  sum(value_double) as value
FROM yourtable
GROUP BY 1
ORDER BY 1

Or build your own conditionals using these macros which just return the values:
- $__timeFrom() -> FROM_UNIXTIME(1492750877)
- $__timeTo() ->  FROM_UNIXTIME(1492750877)
- $__unixEpochFrom() ->  1492750877
- $__unixEpochTo() ->  1492750877
- $__unixEpochNanoFrom() ->  1494410783152415214
- $__unixEpochNanoTo() ->  1494497183142514872