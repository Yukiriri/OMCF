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
- `FerriteCore`
- `Sodium`
- `Iris`
- `EntityCulling`
- `Caxton`

# 图形设置
- 全默认高品质
- 区块视距12
- 模拟视距6

# 负载方式
1. 随便新建一个创造存档
2. 确认完全加载12视距的区块
3. 静候原地

# 统计数据
- ## Fabric 1.21.1
  - Liberica LTS JDK 25
    |        | Allocated Size | 平均FPS | %1 Low FPS |
    | :----- | :------------- | :------ | :--------- |
    | G1GC-C |                |         |            |
    | ZGC-C  |                |         |            |
    | SGC-C  |                |         |            |

  - GraalVM JDK 25
    |        | Allocated Size | 平均FPS       | %1 Low FPS    |
    | :----- | :------------- | :------------ | :------------ |
    | G1GC-C |                |               |               |
    | ZGC-C  |                |               |               |
    | SGC-C  | GraalVM不支持  | GraalVM不支持 | GraalVM不支持 |

- ## Fabric 26.1
  - Liberica LTS JDK 25
    |        | Allocated Size | 平均FPS | %1 Low FPS |
    | :----- | :------------- | :------ | :--------- |
    | G1GC-C |                |         |            |
    | ZGC-C  |                |         |            |
    | SGC-C  |                |         |            |

  - GraalVM JDK 25
    |        | Allocated Size | 平均FPS       | %1 Low FPS    |
    | :----- | :------------- | :------------ | :------------ |
    | G1GC-C |                |               |               |
    | ZGC-C  |                |               |               |
    | SGC-C  | GraalVM不支持  | GraalVM不支持 | GraalVM不支持 |

> [!NOTE]  
> 取自F3信息  
