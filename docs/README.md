# OMCF
吸收了各种MC调优后再进行重新定制的MC JVM参数，将同时研究服务端和客户端的方案。  
如果遇到问题或者有更好的调优，欢迎提出。  

# G1GC
- 方便写入文件使用
```
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-Dfile.encoding=UTF-8
-Djava.awt.headless=true

-XX:+AlwaysPreTouch
-XX:+DisableExplicitGC
-XX:MaxDirectMemorySize=1024G

-XX:+UseG1GC
-XX:MaxGCPauseMillis=100
-XX:G1ConcMarkStepDurationMillis=2.0
-XX:G1HeapRegionSize=8M
-XX:G1NewSizePercent=100
-XX:G1MaxNewSizePercent=100
-XX:+AlwaysTenure
-XX:-G1UseAdaptiveIHOP
-XX:InitiatingHeapOccupancyPercent=80
-XX:G1MixedGCLiveThresholdPercent=95
-XX:+ParallelRefProcEnabled

```
- 方便命令行使用
```
-XX:+IgnoreUnrecognizedVMOptions -XX:+UnlockExperimentalVMOptions -Dfile.encoding=UTF-8 -Djava.awt.headless=true  -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:MaxDirectMemorySize=1024G  -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:G1ConcMarkStepDurationMillis=2.0 -XX:G1HeapRegionSize=8M -XX:G1NewSizePercent=100 -XX:G1MaxNewSizePercent=100 -XX:+AlwaysTenure -XX:-G1UseAdaptiveIHOP -XX:InitiatingHeapOccupancyPercent=80 -XX:G1MixedGCLiveThresholdPercent=95 -XX:+ParallelRefProcEnabled 
```
- [运行效果](./test-summary-g1gc.md)
- [参数讲解](./explain-g1gc.md)

> [!NOTE]
> 服务端、客户端、Velocity通用  

> [!TIP]
> 如果使用Java17+  
> 还可以再添加`--add-modules jdk.incubator.vector`  

# ZGC
- 方便写入文件使用
```
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-Dfile.encoding=UTF-8
-Djava.awt.headless=true

-XX:+AlwaysPreTouch
-XX:+DisableExplicitGC
-XX:MaxDirectMemorySize=1024G

-XX:-UseG1GC
-XX:+UseZGC
-XX:+ZGenerational
-XX:-ZProactive

--add-modules jdk.incubator.vector

```
- 方便命令行使用
```
-XX:+IgnoreUnrecognizedVMOptions -XX:+UnlockExperimentalVMOptions -Dfile.encoding=UTF-8 -Djava.awt.headless=true  -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:MaxDirectMemorySize=1024G  -XX:-UseG1GC -XX:+UseZGC -XX:+ZGenerational -XX:-ZProactive  --add-modules jdk.incubator.vector 
```

> [!IMPORTANT]
> 需要Java21+  

> [!NOTE]
> 服务端、客户端、Velocity通用  

# G1GC-内存紧凑模式
先天不合适，目前还没能实现

# ZGC-内存紧凑模式
- 方便写入文件使用
```
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-Dfile.encoding=UTF-8
-Djava.awt.headless=true

-XX:+AlwaysPreTouch
-XX:+DisableExplicitGC
-XX:MaxDirectMemorySize=1024G

-XX:-UseG1GC
-XX:+UseZGC
-XX:+ZGenerational
-XX:-ZProactive
-XX:ZCollectionIntervalMinor=1.1
-XX:ZUncommitDelay=2

--add-modules jdk.incubator.vector

```
- 方便命令行使用
```
-XX:+IgnoreUnrecognizedVMOptions -XX:+UnlockExperimentalVMOptions -Dfile.encoding=UTF-8 -Djava.awt.headless=true  -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:MaxDirectMemorySize=1024G  -XX:-UseG1GC -XX:+UseZGC -XX:+ZGenerational -XX:-ZProactive -XX:ZCollectionIntervalMinor=1.1 -XX:ZUncommitDelay=2  --add-modules jdk.incubator.vector 
```

> [!IMPORTANT]
> 需要Java21+  

> [!IMPORTANT]
> 不需要设置-Xms  
> 或者-Xms设置到比-Xmx更小  

> [!NOTE]
> 服务端、客户端、Velocity通用，但最适合客户端  

# 选择推荐
按机器配置场景来选择是：
|              | 客户端          | 服务端          |
| :----------- | :-------------- | :-------------- |
| 低主频少核心 | G1GC            | G1GC            |
| 低主频多核心 | 首选ZGC下策G1GC | 首选G1GC上策ZGC |
| 高主频少核心 | ZGC             | 首选ZGC下策G1GC |
| 高主频多核心 | ZGC             | ZGC             |

按MC运行的侧重来选择是：
- 追求低卡顿：[`ZGC`](#ZGC)
- 追求低卡顿低内存占用：[`内存紧凑ZGC`](#ZGC-内存紧凑模式)
- 追求低负载：[`G1GC`](#G1GC)

# 使用方式
- 服务端
  - Java <= 8
    - 将JVM参数添加到启动命令行
  - Java >= 9
    - 方式1：将JVM参数添加到启动命令行
    - 方式2：写入到文件里并在启动命令行引用
      - 高版本纯ModLoader可以写入到`user_jvm_args.txt`
      - 使用jar启动的核心就写入一个自定义名字的txt文件
- 客户端  
  添加到启动器自定义JVM参数  
  需要注意删除启动器已有的`-XX:+UseG1GC`  

> [!IMPORTANT]
> 写入到txt时，Windows需要注意行尾必须为LF  

> [!NOTE]
> 你是说，怎么在启动命令行引用？  
> 比如在`my_args.txt`里填写好了上面的参数  
> 然后启动命令就这样写  
> ```
> java @my_args.txt -jar server.jar
> ```
> @my_args.txt一定要在-jar之前  

# bin目录脚本
- [使用文档](./omcsl.md)

## 推荐JDK
  - [Liberica](https://bell-sw.com/pages/downloads/)
  - [Temurin](https://adoptium.net/zh-CN/temurin/releases/)
  - [Zulu](https://www.azul.com/downloads/?package=jdk#zulu)

## 一点MC内存经验
MC一般值得计算的Java内存有
  - 堆内存（Xmx）
  - 非堆内存（Metaspace，Code Cache，...）
  - 外界API管理的内存

估算方式例如：
  - 给服务端-Xmx4G，运行期占用大概是（堆4G + 非堆1G = 5G占用）
  - 给客户端-Xmx4G，运行期占用大概是（堆4G + 非堆1G + OpenGL 2G = 7G占用）

## 学习参考
- [Aikar's Flags](https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft)
- [VM Options Explorer](https://chriswhocodes.com/vm-options-explorer.html)
- [ZGC OpenJDK Wiki](https://wiki.openjdk.org/display/zgc)
- [https://pdai.tech/md/java/jvm/java-jvm-gc-g1.html](https://pdai.tech/md/java/jvm/java-jvm-gc-g1.html)

## Stargazers
[![Stargazers](https://starchart.cc/Yukiriri/OMCF.svg?variant=adaptive)]()
