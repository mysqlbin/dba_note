

shell> top -Hp 27255
top - 10:20:57 up 431 days, 20:59,  7 users,  load average: 0.24, 0.46, 0.57
Threads: 158 total,   0 running, 158 sleeping,   0 stopped,   0 zombie
%Cpu0  :  4.4 us,  7.4 sy,  0.0 ni, 87.5 id,  0.3 wa,  0.0 hi,  0.3 si,  0.0 st
%Cpu1  :  5.1 us,  5.7 sy,  0.0 ni, 88.9 id,  0.3 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu2  :  4.1 us,  7.2 sy,  0.0 ni, 88.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  :  4.7 us,  6.1 sy,  0.0 ni, 89.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem : 16267956 total,   166948 free, 11177948 used,  4923060 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  4678516 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                                                                                                                                                      
27273 mongodb   20   0 6676508 4.791g   5032 D  1.3 30.9   0:37.56 WTCheck.tThread                                                                                                                                              
27279 mongodb   20   0 6676508 4.791g   5032 S  0.3 30.9   2:58.41 ftdc                                                                                                                                                         
27255 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:01.15 mongod                                                                                                                                                       
27256 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 signalP.gThread                                                                                                                                              
27257 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:14.28 Backgro.kSource                                                                                                                                              
27258 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:03.39 FlowCon.fresher                                                                                                                                              
27263 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:11.71 mongod                                                                                                                                                       
27264 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:02.62 mongod                                                                                                                                                       
27265 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:10.96 mongod                                                                                                                                                       
27266 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:02.27 mongod                                                                                                                                                       
27267 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:02.29 mongod                                                                                                                                                       
27268 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:02.31 mongod                                                                                                                                                       
27269 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:02.31 mongod                                                                                                                                                       
27270 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.73 mongod                                                                                                                                                       
27271 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.22 WTIdleS.Sweeper                                                                                                                                              
27272 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:42.72 WTJourn.Flusher                                                                                                                                              
27274 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:05.92 Timesta.Monitor                                                                                                                                              
27275 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:01.56 DeadlineMonitor                                                                                                                                              
27277 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 Collect.xecutor                                                                                                                                              
27278 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 waitForMajority                                                                                                                                              
27280 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 FreeMonNet                                                                                                                                                   
27281 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 FreeMonHTTP-0                                                                                                                                                
27282 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.18 FreeMon.ocessor                                                                                                                                              
27283 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.41 TTLMonitor                                                                                                                                                   
27284 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:01.04 clientcursormon                                                                                                                                              
27285 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.21 Periodi.kRunner                                                                                                                                              
27286 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 mongod                                                                                                                                                       
27287 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.19 abortEx.actions                                                                                                                                              
27288 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:02.16 startPe.ressure                                                                                                                                              
27289 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.08 Logical.Refresh                                                                                                                                              
27290 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.12 Logical.cheReap                                                                                                                                              
27291 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.04 listener                                                                                                                                                     
27327 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:02.75 conn1                                                                                                                                                        
23567 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.01 conn42                                                                                                                                                       
23636 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 conn43                                                                                                                                                       
23662 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 conn44                                                                                                                                                       
23668 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 conn45                                                                                                                                                       
23683 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 conn46                                                                                                                                                       
23686 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 conn47                                                                                                                                                       
23687 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 conn48                                                                                                                                                       
23704 mongodb   20   0 6676508 4.791g   5032 S  0.0 30.9   0:00.00 conn49       
