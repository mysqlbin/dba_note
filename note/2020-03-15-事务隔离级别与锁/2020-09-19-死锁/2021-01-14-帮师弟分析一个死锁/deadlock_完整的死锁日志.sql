LATEST DETECTED DEADLOCK
------------------------
2021-01-14 06:06:16 0x7f94ab1f7700
*** (1) TRANSACTION:
TRANSACTION 51049366, ACTIVE 1 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 93 lock struct(s), heap size 24784, 6646 row lock(s), undo log entries 3620
MySQL thread id 31826036, OS thread handle 140282680674048, query id 163814547 10.10.137.140 tangdou update
INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(201, 3808, 229203, 162),(201, 3808, 730182, 1145),(201, 3808, 16499868, 6239),(201, 3809, 258205, 9610),(201, 3809, 22622101, 7204),(201, 3810, 5661716, 187),(201, 3810, 8082534, 6081),(201, 3810, 10951920, 7061),(201, 3810, 20067284, 3217),(201, 3810, 22819889, 73),(201, 3811, 371252, 6998),(201, 3811, 12443344, 6598),(201, 3811, 22994324, 0),(201, 3812, 3585698, 0),(201, 3812, 10952417, 652),(201, 3813, 10952417, 3967),(201, 3813, 16125535, 0),(201, 3813, 22622101, 5820),(201, 3813, 23381263, 40),(202, 5200, 7440650, 0),(203, 3815, 537441, 0),(203, 3815, 7961496, 1861),(203, 3815, 10683760, 6098),(203, 3815, 23262363, 213),(203, 3816, 4067262, 1596),(203, 3817, 837815, 6137),(203, 3818, 2623576, 4227),(203, 3818, 9539162, 5940),(203, 3818, 22682514, 6199),(203, 3818, 23433009, 6307),(203, 3819, 2426256, 0),(203, 3819, 1
*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 89 page no 249 n bits 704 index sid of table `live_data_report`.`course_watch_time_s` trx id 51049366 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 538 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001451; asc    Q;;
 1: len 8; hex 800000000000cbc2; asc         ;;
 2: len 8; hex 0000000000013fca; asc       ? ;;

*** (2) TRANSACTION:
TRANSACTION 51049367, ACTIVE 0 sec inserting, thread declared inside InnoDB 4926
mysql tables in use 1, locked 1
206 lock struct(s), heap size 41168, 17608 row lock(s), undo log entries 9775
MySQL thread id 31825989, OS thread handle 140276502853376, query id 163814630 10.10.137.140 tangdou update
INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(374, 5307, 26183040, 15592),(374, 5307, 26184310, 6484),(374, 5308, 67720, 17806),(374, 5308, 171977, 872),(374, 5308, 186721, 0),(374, 5308, 245289, 9798),(374, 5308, 279907, 0),(374, 5308, 280485, 774),(374, 5308, 314590, 0),(374, 5308, 333029, 364),(374, 5308, 333852, 0),(374, 5308, 338082, 0),(374, 5308, 383339, 0),(374, 5308, 491028, 17850),(374, 5308, 823942, 0),(374, 5308, 881404, 1498),(374, 5308, 1390448, 4950),(374, 5308, 1791062, 10518),(374, 5308, 2065138, 1500),(374, 5308, 2592171, 0),(374, 5308, 2604266, 15284),(374, 5308, 2649824, 1330),(374, 5308, 2697197, 9932),(374, 5308, 2920209, 0),(374, 5308, 3083205, 12238),(374, 5308, 3160607, 0),(374, 5308, 3443550, 18878),(374, 5308, 3918867, 16746),(374, 5308, 4603109, 21846),(374, 5308, 4742337, 0),(374, 5308, 5049293, 6102),(374, 5308, 5060774, 58),(374, 5308, 
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 89 page no 249 n bits 704 index sid of table `live_data_report`.`course_watch_time_s` trx id 51049367 lock_mode X locks gap before rec
Record lock, heap no 16 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000e9a0de; asc         ;;
 2: len 8; hex 0000000000003df5; asc       = ;;

Record lock, heap no 23 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000013da05e; asc      = ^;;
 2: len 8; hex 0000000000003dfc; asc       = ;;

Record lock, heap no 24 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000141b2a4; asc      A  ;;
 2: len 8; hex 0000000000003dfd; asc       = ;;

Record lock, heap no 26 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000015e767a; asc      ^vz;;
 2: len 8; hex 0000000000003dff; asc       = ;;

Record lock, heap no 30 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000017172fe; asc      qr ;;
 2: len 8; hex 0000000000003e03; asc       > ;;

Record lock, heap no 39 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000001c7686; asc       v ;;
 2: len 8; hex 0000000000003e0c; asc       > ;;

Record lock, heap no 40 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000002d94ba; asc      -  ;;
 2: len 8; hex 0000000000003e0d; asc       > ;;

Record lock, heap no 47 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000003fe8ae; asc      ?  ;;
 2: len 8; hex 0000000000003e14; asc       > ;;

Record lock, heap no 60 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000012c5575; asc      ,Uu;;
 2: len 8; hex 0000000000003e21; asc       >!;;

Record lock, heap no 67 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000016685f3; asc      f  ;;
 2: len 8; hex 0000000000003e28; asc       >(;;

Record lock, heap no 74 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001451; asc    Q;;
 1: len 8; hex 8000000000718910; asc      q  ;;
 2: len 8; hex 0000000000002457; asc       $W;;

Record lock, heap no 77 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000004f7c3; asc         ;;
 2: len 8; hex 0000000000003e30; asc       >0;;

Record lock, heap no 82 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000001f26b0; asc       & ;;
 2: len 8; hex 0000000000003e35; asc       >5;;

Record lock, heap no 89 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000005c5b18; asc      \[ ;;
 2: len 8; hex 0000000000003e3c; asc       ><;;

Record lock, heap no 92 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000ab5d77; asc       ]w;;
 2: len 8; hex 0000000000003e3f; asc       >?;;

Record lock, heap no 101 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000163af3d; asc      c =;;
 2: len 8; hex 0000000000003e48; asc       >H;;

Record lock, heap no 103 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000001770554; asc      w T;;
 2: len 8; hex 0000000000003e4a; asc       >J;;

Record lock, heap no 104 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000180b86d; asc        m;;
 2: len 8; hex 0000000000003e4b; asc       >K;;

Record lock, heap no 110 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000001475dc; asc       u ;;
 2: len 8; hex 0000000000003e51; asc       >Q;;

Record lock, heap no 111 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000001ed2b3; asc         ;;
 2: len 8; hex 0000000000003e52; asc       >R;;

Record lock, heap no 120 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000c129e1; asc       ) ;;
 2: len 8; hex 0000000000011060; asc        `;;

Record lock, heap no 126 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000014f7b75; asc      O{u;;
 2: len 8; hex 000000000001106e; asc        n;;

Record lock, heap no 133 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000070ad5f; asc      p _;;
 2: len 8; hex 0000000000011088; asc         ;;

Record lock, heap no 136 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000ce52c4; asc       R ;;
 2: len 8; hex 0000000000011090; asc         ;;

Record lock, heap no 137 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000f206dc; asc         ;;
 2: len 8; hex 0000000000011091; asc         ;;

Record lock, heap no 139 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000101be06; asc         ;;
 2: len 8; hex 0000000000011093; asc         ;;

Record lock, heap no 143 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000001601291; asc      `  ;;
 2: len 8; hex 000000000001109b; asc         ;;

Record lock, heap no 151 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000001129848; asc        H;;
 2: len 8; hex 00000000000110ae; asc         ;;

Record lock, heap no 165 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 8000000000f0f45b; asc        [;;
 2: len 8; hex 00000000000110c5; asc         ;;

Record lock, heap no 166 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000047776b; asc      Gwk;;
 2: len 8; hex 00000000000164ec; asc       d ;;

Record lock, heap no 167 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000523ce6; asc      R< ;;
 2: len 8; hex 00000000000164ed; asc       d ;;

Record lock, heap no 168 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000078e353; asc      x S;;
 2: len 8; hex 00000000000164ef; asc       d ;;

Record lock, heap no 169 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000009e30b7; asc       0 ;;
 2: len 8; hex 00000000000164f0; asc       d ;;

Record lock, heap no 170 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000b2c4e6; asc         ;;
 2: len 8; hex 00000000000164f1; asc       d ;;

Record lock, heap no 171 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000bb0e0d; asc         ;;
 2: len 8; hex 00000000000164f3; asc       d ;;

Record lock, heap no 172 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000be7aad; asc       z ;;
 2: len 8; hex 00000000000164f4; asc       d ;;

Record lock, heap no 173 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000014bfcd2; asc      K  ;;
 2: len 8; hex 00000000000164fd; asc       d ;;

Record lock, heap no 174 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000015cfea8; asc      \  ;;
 2: len 8; hex 00000000000164ff; asc       d ;;

Record lock, heap no 175 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000017ce025; asc      | %;;
 2: len 8; hex 0000000000016503; asc       e ;;

Record lock, heap no 176 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000017e276c; asc      ~'l;;
 2: len 8; hex 0000000000016504; asc       e ;;

Record lock, heap no 177 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000180fd68; asc        h;;
 2: len 8; hex 0000000000016505; asc       e ;;

Record lock, heap no 178 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000001899d0a; asc         ;;
 2: len 8; hex 0000000000016506; asc       e ;;

Record lock, heap no 179 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000002483e; asc       H>;;
 2: len 8; hex 0000000000016507; asc       e ;;

Record lock, heap no 180 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000002ca61; asc        a;;
 2: len 8; hex 0000000000016508; asc       e ;;

Record lock, heap no 181 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000000b03d7; asc         ;;
 2: len 8; hex 0000000000016509; asc       e ;;

Record lock, heap no 182 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000001c0972; asc        r;;
 2: len 8; hex 000000000001650c; asc       e ;;

Record lock, heap no 183 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000001d9959; asc        Y;;
 2: len 8; hex 000000000001650d; asc       e ;;

Record lock, heap no 184 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000002c8f11; asc      ,  ;;
 2: len 8; hex 0000000000016510; asc       e ;;

Record lock, heap no 185 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000034891f; asc      4  ;;
 2: len 8; hex 0000000000016512; asc       e ;;

Record lock, heap no 186 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000035e2e8; asc      5  ;;
 2: len 8; hex 0000000000016513; asc       e ;;

Record lock, heap no 187 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000003fdb36; asc      ? 6;;
 2: len 8; hex 0000000000016514; asc       e ;;

Record lock, heap no 188 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000043e136; asc      C 6;;
 2: len 8; hex 0000000000016515; asc       e ;;

Record lock, heap no 189 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000006f7740; asc      ow@;;
 2: len 8; hex 0000000000016517; asc       e ;;

Record lock, heap no 190 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000ce4000; asc       @ ;;
 2: len 8; hex 000000000001651c; asc       e ;;

Record lock, heap no 191 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000d718b9; asc         ;;
 2: len 8; hex 000000000001651d; asc       e ;;

Record lock, heap no 192 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000e0614e; asc       aN;;
 2: len 8; hex 000000000001651f; asc       e ;;

Record lock, heap no 193 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000faf84e; asc        N;;
 2: len 8; hex 0000000000016521; asc       e!;;

Record lock, heap no 194 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000fb4fef; asc       O ;;
 2: len 8; hex 0000000000016522; asc       e";;

Record lock, heap no 195 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000001247106; asc      $q ;;
 2: len 8; hex 0000000000016523; asc       e#;;

Record lock, heap no 196 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000012c2e95; asc      ,. ;;
 2: len 8; hex 0000000000016524; asc       e$;;

Record lock, heap no 197 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000001600476; asc      ` v;;
 2: len 8; hex 0000000000016527; asc       e';;

Record lock, heap no 198 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000043137; asc       17;;
 2: len 8; hex 000000000001652c; asc       e,;;

Record lock, heap no 199 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000200bf3; asc         ;;
 2: len 8; hex 000000000001652e; asc       e.;;

Record lock, heap no 200 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000035e3be; asc      5  ;;
 2: len 8; hex 0000000000016530; asc       e0;;

Record lock, heap no 201 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000598eb7; asc      Y  ;;
 2: len 8; hex 0000000000016531; asc       e1;;

Record lock, heap no 202 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000062927e; asc      b ~;;
 2: len 8; hex 0000000000016532; asc       e2;;

Record lock, heap no 203 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000a19024; asc        $;;
 2: len 8; hex 0000000000016535; asc       e5;;

Record lock, heap no 204 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000a3df8f; asc         ;;
 2: len 8; hex 0000000000016536; asc       e6;;

Record lock, heap no 205 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000a9dd67; asc        g;;
 2: len 8; hex 0000000000016537; asc       e7;;

Record lock, heap no 206 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000001510b43; asc      Q C;;
 2: len 8; hex 0000000000016539; asc       e9;;

Record lock, heap no 207 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000001731272; asc      s r;;
 2: len 8; hex 000000000001653b; asc       e;;;

Record lock, heap no 208 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000178666e; asc      xfn;;
 2: len 8; hex 000000000001653c; asc       e<;;

Record lock, heap no 209 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000017d8138; asc      } 8;;
 2: len 8; hex 000000000001653d; asc       e=;;

Record lock, heap no 210 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 8000000000036601; asc       f ;;
 2: len 8; hex 000000000001653e; asc       e>;;

Record lock, heap no 211 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 800000000012dbda; asc         ;;
 2: len 8; hex 0000000000016540; asc       e@;;

Record lock, heap no 212 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000001c4e53; asc       NS;;
 2: len 8; hex 0000000000016542; asc       eB;;

Record lock, heap no 213 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 800000000028900b; asc      (  ;;
 2: len 8; hex 0000000000016544; asc       eD;;

Record lock, heap no 214 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000002ec1d4; asc      .  ;;
 2: len 8; hex 0000000000016545; asc       eE;;

Record lock, heap no 215 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000003b2f9a; asc      ;/ ;;
 2: len 8; hex 0000000000016546; asc       eF;;

Record lock, heap no 216 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 8000000000ee8277; asc        w;;
 2: len 8; hex 000000000001654a; asc       eJ;;

Record lock, heap no 267 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000006876e5; asc      hv ;;
 2: len 8; hex 000000000000ca4a; asc        J;;

Record lock, heap no 283 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000015f2ca1; asc      _, ;;
 2: len 8; hex 000000000000ca5a; asc        Z;;

Record lock, heap no 301 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000034966e; asc      4 n;;
 2: len 8; hex 000000000000ca6c; asc        l;;

Record lock, heap no 308 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000081b48d; asc         ;;
 2: len 8; hex 000000000000ca73; asc        s;;

Record lock, heap no 319 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000e1c445; asc        E;;
 2: len 8; hex 000000000000ca7e; asc        ~;;

Record lock, heap no 324 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000001546c59; asc      TlY;;
 2: len 8; hex 000000000000ca83; asc         ;;

Record lock, heap no 331 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000180fd68; asc        h;;
 2: len 8; hex 000000000000ca8a; asc         ;;

Record lock, heap no 332 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000000a252; asc        R;;
 2: len 8; hex 000000000000ca8b; asc         ;;

Record lock, heap no 336 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000036e4a3; asc      6  ;;
 2: len 8; hex 000000000000ca8f; asc         ;;

Record lock, heap no 342 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000008e5425; asc       T%;;
 2: len 8; hex 000000000000ca95; asc         ;;

Record lock, heap no 343 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000a40213; asc         ;;
 2: len 8; hex 000000000000ca96; asc         ;;

Record lock, heap no 349 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 800000000006e5ab; asc         ;;
 2: len 8; hex 000000000000ca9c; asc         ;;

Record lock, heap no 352 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 800000000022cf37; asc      " 7;;
 2: len 8; hex 000000000000ca9f; asc         ;;

Record lock, heap no 356 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 800000000083561f; asc       V ;;
 2: len 8; hex 000000000000caa3; asc         ;;

Record lock, heap no 358 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000009f0e7c; asc        |;;
 2: len 8; hex 000000000000caa5; asc         ;;

Record lock, heap no 364 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000009fc9e5; asc         ;;
 2: len 8; hex 000000000001105c; asc        \;;

Record lock, heap no 366 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000ece137; asc        7;;
 2: len 8; hex 0000000000011064; asc        d;;

Record lock, heap no 368 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000101be06; asc         ;;
 2: len 8; hex 0000000000011068; asc        h;;

Record lock, heap no 372 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000017cba14; asc      |  ;;
 2: len 8; hex 0000000000011071; asc        q;;

Record lock, heap no 377 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000448b41; asc      D A;;
 2: len 8; hex 0000000000011082; asc         ;;

Record lock, heap no 400 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000004ce856; asc      L V;;
 2: len 8; hex 000000000000843f; asc        ?;;

Record lock, heap no 401 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000005511e9; asc      U  ;;
 2: len 8; hex 0000000000008440; asc        @;;

Record lock, heap no 403 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000007b183e; asc      { >;;
 2: len 8; hex 0000000000008442; asc        B;;

Record lock, heap no 406 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000b49bfa; asc         ;;
 2: len 8; hex 0000000000008445; asc        E;;

Record lock, heap no 410 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000001096422; asc       d";;
 2: len 8; hex 0000000000008449; asc        I;;

Record lock, heap no 413 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000001807572; asc       ur;;
 2: len 8; hex 000000000000844c; asc        L;;

Record lock, heap no 414 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000182f0b2; asc         ;;
 2: len 8; hex 000000000000844d; asc        M;;

Record lock, heap no 415 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000189c975; asc        u;;
 2: len 8; hex 000000000000844e; asc        N;;

Record lock, heap no 417 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000003c6ed; asc         ;;
 2: len 8; hex 0000000000008450; asc        P;;

Record lock, heap no 421 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000000c769e; asc       v ;;
 2: len 8; hex 0000000000008454; asc        T;;

Record lock, heap no 422 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000103324; asc       3$;;
 2: len 8; hex 0000000000008455; asc        U;;

Record lock, heap no 426 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000035e3be; asc      5  ;;
 2: len 8; hex 0000000000008459; asc        Y;;

Record lock, heap no 437 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000ca1045; asc        E;;
 2: len 8; hex 0000000000008464; asc        d;;

Record lock, heap no 445 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000126d545; asc      & E;;
 2: len 8; hex 000000000000846c; asc        l;;

Record lock, heap no 456 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000001898764; asc        d;;
 2: len 8; hex 0000000000008477; asc        w;;

Record lock, heap no 458 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000003e996; asc         ;;
 2: len 8; hex 000000000000847a; asc        z;;

Record lock, heap no 463 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000002a4cb5; asc      *L ;;
 2: len 8; hex 000000000000847f; asc         ;;

Record lock, heap no 467 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000006fec18; asc      o  ;;
 2: len 8; hex 0000000000008483; asc         ;;

Record lock, heap no 468 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000007fd4da; asc         ;;
 2: len 8; hex 0000000000008484; asc         ;;

Record lock, heap no 477 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000151cac6; asc      Q  ;;
 2: len 8; hex 000000000000848d; asc         ;;

Record lock, heap no 480 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000001796b4a; asc      ykJ;;
 2: len 8; hex 0000000000008490; asc         ;;

Record lock, heap no 484 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 800000000029476c; asc      )Gl;;
 2: len 8; hex 0000000000008494; asc         ;;

Record lock, heap no 488 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000003b7896; asc      ;x ;;
 2: len 8; hex 0000000000008498; asc         ;;

Record lock, heap no 493 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 8000000000c8b138; asc        8;;
 2: len 8; hex 000000000000849d; asc         ;;

Record lock, heap no 497 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000ccd91d; asc         ;;
 2: len 8; hex 0000000000011061; asc        a;;

Record lock, heap no 502 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000002b24a; asc        J;;
 2: len 8; hex 0000000000011077; asc        w;;

Record lock, heap no 504 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000022b54d; asc      " M;;
 2: len 8; hex 000000000001107c; asc        |;;

Record lock, heap no 506 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000348761; asc      4 a;;
 2: len 8; hex 0000000000011080; asc         ;;

Record lock, heap no 509 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000063eb9f; asc      c  ;;
 2: len 8; hex 0000000000011087; asc         ;;

Record lock, heap no 510 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000a1c2e8; asc         ;;
 2: len 8; hex 000000000001108a; asc         ;;

Record lock, heap no 512 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000c5fa21; asc        !;;
 2: len 8; hex 000000000001108f; asc         ;;

Record lock, heap no 516 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000015be266; asc      [ f;;
 2: len 8; hex 0000000000011098; asc         ;;

Record lock, heap no 531 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000002f5850; asc      /XP;;
 2: len 8; hex 00000000000110b7; asc         ;;

Record lock, heap no 538 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001451; asc    Q;;
 1: len 8; hex 800000000000cbc2; asc         ;;
 2: len 8; hex 0000000000013fca; asc       ? ;;

Record lock, heap no 539 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001451; asc    Q;;
 1: len 8; hex 8000000000063187; asc       1 ;;
 2: len 8; hex 0000000000013fcb; asc       ? ;;

Record lock, heap no 540 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001451; asc    Q;;
 1: len 8; hex 8000000000c4423d; asc       B=;;
 2: len 8; hex 0000000000013fcc; asc       ? ;;

Record lock, heap no 541 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000064906b; asc      d k;;
 2: len 8; hex 00000000000164ee; asc       d ;;

Record lock, heap no 542 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000b32000; asc         ;;
 2: len 8; hex 00000000000164f2; asc       d ;;

Record lock, heap no 543 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000ca1045; asc        E;;
 2: len 8; hex 00000000000164f5; asc       d ;;

Record lock, heap no 544 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000cc12cb; asc         ;;
 2: len 8; hex 00000000000164f6; asc       d ;;

Record lock, heap no 545 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000e75ad9; asc       Z ;;
 2: len 8; hex 00000000000164f7; asc       d ;;

Record lock, heap no 546 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000eb3f21; asc       ?!;;
 2: len 8; hex 00000000000164f8; asc       d ;;

Record lock, heap no 547 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000101a6c5; asc         ;;
 2: len 8; hex 00000000000164f9; asc       d ;;

Record lock, heap no 548 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000105926b; asc        k;;
 2: len 8; hex 00000000000164fa; asc       d ;;

Record lock, heap no 549 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000135517f; asc      5Q ;;
 2: len 8; hex 00000000000164fb; asc       d ;;

Record lock, heap no 550 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000013f1a9a; asc      ?  ;;
 2: len 8; hex 00000000000164fc; asc       d ;;

Record lock, heap no 551 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000014de5ac; asc      M  ;;
 2: len 8; hex 00000000000164fe; asc       d ;;

Record lock, heap no 552 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000015f17ba; asc      _  ;;
 2: len 8; hex 0000000000016500; asc       e ;;

Record lock, heap no 553 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000016f86c7; asc      o  ;;
 2: len 8; hex 0000000000016501; asc       e ;;

Record lock, heap no 554 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000017a3099; asc      z0 ;;
 2: len 8; hex 0000000000016502; asc       e ;;

Record lock, heap no 555 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000000b7835; asc       x5;;
 2: len 8; hex 000000000001650a; asc       e ;;

Record lock, heap no 556 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000000f9f5d; asc        ];;
 2: len 8; hex 000000000001650b; asc       e ;;

Record lock, heap no 557 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000294606; asc      )F ;;
 2: len 8; hex 000000000001650e; asc       e ;;

Record lock, heap no 558 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000002ab46a; asc      * j;;
 2: len 8; hex 000000000001650f; asc       e ;;

Record lock, heap no 559 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000003155f0; asc      1U ;;
 2: len 8; hex 0000000000016511; asc       e ;;

Record lock, heap no 560 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000005f3b31; asc      _;1;;
 2: len 8; hex 0000000000016516; asc       e ;;

Record lock, heap no 561 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 800000000074be20; asc      t  ;;
 2: len 8; hex 0000000000016518; asc       e ;;

Record lock, heap no 562 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000a00a5c; asc        \;;
 2: len 8; hex 0000000000016519; asc       e ;;

Record lock, heap no 563 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000c2101d; asc         ;;
 2: len 8; hex 000000000001651a; asc       e ;;

Record lock, heap no 564 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000c7a689; asc         ;;
 2: len 8; hex 000000000001651b; asc       e ;;

Record lock, heap no 565 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000d98598; asc         ;;
 2: len 8; hex 000000000001651e; asc       e ;;

Record lock, heap no 566 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000000eee53a; asc        :;;
 2: len 8; hex 0000000000016520; asc       e ;;

Record lock, heap no 567 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000014f7b75; asc      O{u;;
 2: len 8; hex 0000000000016525; asc       e%;;

Record lock, heap no 568 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000001594f98; asc      YO ;;
 2: len 8; hex 0000000000016526; asc       e&;;

Record lock, heap no 569 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000016608c0; asc      f  ;;
 2: len 8; hex 0000000000016528; asc       e(;;

Record lock, heap no 570 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000001807ce7; asc       | ;;
 2: len 8; hex 0000000000016529; asc       e);;

Record lock, heap no 571 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 8000000001896e9c; asc       n ;;
 2: len 8; hex 000000000001652a; asc       e*;;

Record lock, heap no 572 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000014c6e; asc       Ln;;
 2: len 8; hex 000000000001652b; asc       e+;;

Record lock, heap no 573 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000001ed257; asc        W;;
 2: len 8; hex 000000000001652d; asc       e-;;

Record lock, heap no 574 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000027e20c; asc      '  ;;
 2: len 8; hex 000000000001652f; asc       e/;;

Record lock, heap no 575 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 80000000007cf1ee; asc      |  ;;
 2: len 8; hex 0000000000016533; asc       e3;;

Record lock, heap no 576 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 8000000000846391; asc       c ;;
 2: len 8; hex 0000000000016534; asc       e4;;

Record lock, heap no 577 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000111a31f; asc         ;;
 2: len 8; hex 0000000000016538; asc       e8;;

Record lock, heap no 578 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001456; asc    V;;
 1: len 8; hex 800000000162ac64; asc      b d;;
 2: len 8; hex 000000000001653a; asc       e:;;

Record lock, heap no 579 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000000601a3; asc         ;;
 2: len 8; hex 000000000001653f; asc       e?;;

Record lock, heap no 580 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000001af697; asc         ;;
 2: len 8; hex 0000000000016541; asc       eA;;

Record lock, heap no 581 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 8000000000226d14; asc      "m ;;
 2: len 8; hex 0000000000016543; asc       eC;;

Record lock, heap no 582 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 800000000082361d; asc       6 ;;
 2: len 8; hex 0000000000016547; asc       eG;;

Record lock, heap no 583 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 80000000008c4ab9; asc       J ;;
 2: len 8; hex 0000000000016548; asc       eH;;

Record lock, heap no 584 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 8000000000c19f25; asc        %;;
 2: len 8; hex 0000000000016549; asc       eI;;

Record lock, heap no 585 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001457; asc    W;;
 1: len 8; hex 8000000000f83801; asc       8 ;;
 2: len 8; hex 000000000001654b; asc       eK;;

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 89 page no 444 n bits 408 index sid of table `live_data_report`.`course_watch_time_s` trx id 51049367 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 108 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80000942; asc    B;;
 1: len 8; hex 800000000013fb1b; asc         ;;
 2: len 8; hex 0000000000011ad1; asc         ;;

*** WE ROLL BACK TRANSACTION (1)