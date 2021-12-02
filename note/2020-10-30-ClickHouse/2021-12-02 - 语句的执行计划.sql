localhost.localdomain :) explain SELECT sum(LO_REVENUE),toYear(LO_ORDERDATE) AS year, P_BRAND FROM lineorder_flat WHERE P_CATEGORY = 'MFGR#12' AND S_REGION = 'AMERICA' GROUP BY year,P_BRAND ORDER BY year,P_BRAND;

EXPLAIN
SELECT
    sum(LO_REVENUE),
    toYear(LO_ORDERDATE) AS year,
    P_BRAND
FROM lineorder_flat
WHERE (P_CATEGORY = 'MFGR#12') AND (S_REGION = 'AMERICA')
GROUP BY
    year,
    P_BRAND
ORDER BY
    year ASC,
    P_BRAND ASC

Query id: 2ffe2129-9403-49d9-8322-c14af3b16f34

┌─explain─────────────────────────────────────────────────────────────────────────────┐
│ Expression (Projection)                                                             │
│   Sorting (Sorting for ORDER BY)                                                    │
│     Expression (Before ORDER BY)                                                    │
│       Aggregating                                                                   │
│         Expression (Before GROUP BY)                                                │
│           Filter (WHERE)                                                            │
│             SettingQuotaAndLimits (Set limits and quota after reading from storage) │
│               ReadFromMergeTree                                                     │
└─────────────────────────────────────────────────────────────────────────────────────┘

8 rows in set. Elapsed: 0.024 sec. 
