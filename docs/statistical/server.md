# 硬件 & OS
| OS   | Windows 11 26200.8037 |
| :--- | :-------------------- |
| CPU  | AMD 9950X 16C32T      |
| RAM  | 64G 6000C28           |
- PBO Enable
- PBO Scalar 1X
- PBO Curve Optimize
  - CCD0 Negative 30
  - CCD1 Negative 30
- PBO Curve Shaper
  - HighFreq Negative 10,9,8
  - MaxFreq  Negative 20,18,16
- PBO Per-core Boost Clock Limit
  - Core0-7  5550MHz
  - Core8-15 5450MHz

# MOD
- `chunky`
- `C2ME`(配置全核32线程)

# 负载方式
1. 删除存档中的`entities` `poi` `region`文件夹
2. 启动服务端
3. 运行/chunky radius 1024

# 统计数据
- ## Fabric 1.21.1
  - Liberica LTS JDK 25
    | 记录项        | G1GC 2G       | ZGC 2G        | SGC 2G        | G1GC 32G      | ZGC 32G        | SGC 32G       |
    | :------------ | :------------ | :------------ | :------------ | :------------ | :------------- | :------------ |
    | STW时间范围   | 0.4ms--15.0ms | 0.06ms--5.6ms | 0.02ms--8.6ms | 3.0ms--22.7ms | 0.04ms--0.18ms | 0.03ms--6.6ms |
    | chunky平均CPS | 638           | 490           | 420           | 648           | 570            | 560           |
    | chunky用时    | 26s           | 34s           | 40s           | 25s           | 29s            | 29s           |

    <!-- ```mermaid
    xychart
      title "2G"
      x-axis "chunky seconds" 0 --> 60
      y-axis "chunky CPS" 0 --> 1000
      line [0]
      line [0]
      line [0]
    ``` -->

  - GraalVM JDK 25
    | 记录项        | G1GC 2G       | ZGC 2G         | SGC 2G        | G1GC 32G      | ZGC 32G        | SGC 32G       |
    | :------------ | :------------ | :------------- | :------------ | :------------ | :------------- | :------------ |
    | STW时间范围   | 0.1ms--13.1ms | 0.06ms--0.18ms | GraalVM不支持 | 8.0ms--16.4ms | 0.05ms--0.24ms | GraalVM不支持 |
    | chunky平均CPS | 640           | 515            | GraalVM不支持 | 658           | 584            | GraalVM不支持 |
    | chunky用时    | 25s           | 33s            | GraalVM不支持 | 25s           | 28s            | GraalVM不支持 |

- ## Fabric 1.21.11
  - Liberica LTS JDK 25
    | 记录项        | G1GC 2G       | ZGC 2G        | SGC 2G         | G1GC 32G      | ZGC 32G        | SGC 32G       |
    | :------------ | :------------ | :------------ | :------------- | :------------ | :------------- | :------------ |
    | STW时间范围   | 2.8ms--12.5ms | 0.05ms--4.3ms | 0.02ms--15.0ms | 6.8ms--10.7ms | 0.04ms--0.20ms | 0.02ms--6.3ms |
    | chunky平均CPS | 799           | 655           | 582            | 804           | 756            | 695           |
    | chunky用时    | 21s           | 25s           | 29s            | 21s           | 23s            | 24s           |

  - GraalVM JDK 25
    | 记录项        | G1GC 2G       | ZGC 2G        | SGC 2G        | G1GC 32G      | ZGC 32G       | SGC 32G       |
    | :------------ | :------------ | :------------ | :------------ | :------------ | :------------ | :------------ |
    | STW时间范围   | 3.8ms--12.0ms | 0.05ms--5.8ms | GraalVM不支持 | 5.9ms--12.1ms | 0.04ms--5.7ms | GraalVM不支持 |
    | chunky平均CPS | 780           | 641           | GraalVM不支持 | 806           | 742           | GraalVM不支持 |
    | chunky用时    | 22s           | 26s           | GraalVM不支持 | 21s           | 23s           | GraalVM不支持 |

<!-- - ## Fabric 26.1
  - Liberica LTS JDK 25
  - GraalVM JDK 25 -->

> [!NOTE]  
> 分配内存均为-Xms同步-Xmx  

> [!NOTE]  
> STW时间取自所有Pause阶段的统计  

> [!NOTE]  
> --代表从最小值到最大值  
