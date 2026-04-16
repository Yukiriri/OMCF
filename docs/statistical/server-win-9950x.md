# 硬件 & OS
| OS   | Windows 11 26200.8246 |
| :--- | :-------------------- |
| CPU  | AMD 9950X(16C32T)     |
| RAM  | 64G 6400(32-38-38-36) |
- PBO Enable
- PBO Scalar 1X
- PBO Curve Optimize
  - CCD0 Negative 40
  - CCD1 Negative 40
- PBO Curve Shaper
  - MaxFreq Negative 10,7,5
- PBO Per-core Boost Clock Limit
  - Core0-7  5550MHz
  - Core8-15 5450MHz

# MOD
- `chunky`
- `C2ME`
  - defaultGlobalExecutorParallelismExpression = "cpus"

# 负载方式
1. 删除存档中的`entities` `poi` `region`文件夹
2. 启动服务端
3. 运行/chunky radius 1024

# 统计数据
- ## Fabric 1.21.1
  - Liberica LTS JDK 25
    |           | STW时间范围 | chunky平均CPS | chunky总用时 |
    | :-------- | :---------- | :------------ | :----------- |
    | G1GC 2G   |             |               |              |
    | G1GC 32G  |             |               |              |
    | G1GCM 2G  |             |               |              |
    | G1GCM 32G |             |               |              |
    | ZGC 2G    |             |               |              |
    | ZGC 32G   |             |               |              |
    | SGC 2G    |             |               |              |
    | SGC 32G   |             |               |              |

  - GraalVM JDK 25
    |           | STW时间范围   | chunky平均CPS | chunky总用时  |
    | :-------- | :------------ | :------------ | :------------ |
    | G1GC 2G   |               |               |               |
    | G1GC 32G  |               |               |               |
    | G1GCM 2G  |               |               |               |
    | G1GCM 32G |               |               |               |
    | ZGC 2G    |               |               |               |
    | ZGC 32G   |               |               |               |
    | SGC 2G    | GraalVM不支持 | GraalVM不支持 | GraalVM不支持 |
    | SGC 32G   | GraalVM不支持 | GraalVM不支持 | GraalVM不支持 |

- ## Fabric 26.1
  - Liberica LTS JDK 25
    |           | STW时间范围 | chunky平均CPS | chunky总用时 |
    | :-------- | :---------- | :------------ | :----------- |
    | G1GC 2G   |             |               |              |
    | G1GC 32G  |             |               |              |
    | G1GCM 2G  |             |               |              |
    | G1GCM 32G |             |               |              |
    | ZGC 2G    |             |               |              |
    | ZGC 32G   |             |               |              |
    | SGC 2G    |             |               |              |
    | SGC 32G   |             |               |              |

  - GraalVM JDK 25
    |           | STW时间范围   | chunky平均CPS | chunky总用时  |
    | :-------- | :------------ | :------------ | :------------ |
    | G1GC 2G   |               |               |               |
    | G1GC 32G  |               |               |               |
    | G1GCM 2G  |               |               |               |
    | G1GCM 32G |               |               |               |
    | ZGC 2G    |               |               |               |
    | ZGC 32G   |               |               |               |
    | SGC 2G    | GraalVM不支持 | GraalVM不支持 | GraalVM不支持 |
    | SGC 32G   | GraalVM不支持 | GraalVM不支持 | GraalVM不支持 |

> [!NOTE]  
> 分配内存均为-Xms同步-Xmx  

> [!NOTE]  
> STW时间取自所有Pause阶段的统计  

> [!NOTE]  
> --代表从最小值到最大值  
