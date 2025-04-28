# OMCF
吸收了各种MC调优后再进行重新定制的MC JVM参数，将同时研究服务端和客户端的方案。  
如果遇到问题或者有更好的调优，欢迎提出。  

# G1GC
- 方便写入文件使用
```
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-Dfile.encoding=UTF-8

-XX:+AlwaysPreTouch
-XX:+DisableExplicitGC
-XX:-UseCompressedClassPointers

-XX:+UseG1GC
-XX:MaxGCPauseMillis=100
-XX:G1HeapRegionSize=4M
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
-XX:+IgnoreUnrecognizedVMOptions -XX:+UnlockExperimentalVMOptions -Dfile.encoding=UTF-8  -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:-UseCompressedClassPointers  -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:G1HeapRegionSize=4M -XX:G1NewSizePercent=100 -XX:G1MaxNewSizePercent=100 -XX:+AlwaysTenure -XX:-G1UseAdaptiveIHOP -XX:InitiatingHeapOccupancyPercent=80 -XX:G1MixedGCLiveThresholdPercent=95 -XX:+ParallelRefProcEnabled 
```
- [运行效果](./md/test-summary-g1gc.md)
- [参数讲解](./md/explain-g1gc.md)

> [!NOTE]
> 服务端客户端通用

> [!TIP]
> 如果使用Java17+  
> 还可以再添加`--add-modules=jdk.incubator.vector`  

# ZGC
- 方便写入文件使用
```
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-Dfile.encoding=UTF-8

-XX:+AlwaysPreTouch
-XX:+DisableExplicitGC
-XX:-UseCompressedClassPointers

-XX:-UseG1GC
-XX:+UseZGC
-XX:+ZGenerational
-XX:-ZProactive

--add-modules=jdk.incubator.vector

```
- 方便命令行使用
```
-XX:+IgnoreUnrecognizedVMOptions -XX:+UnlockExperimentalVMOptions -Dfile.encoding=UTF-8  -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:-UseCompressedClassPointers  -XX:-UseG1GC -XX:+UseZGC -XX:+ZGenerational -XX:-ZProactive  --add-modules=jdk.incubator.vector 
```

> [!NOTE]
> 服务端客户端通用

> [!IMPORTANT]
> 需要Java21+

# G1GC-内存紧凑模式
先天不合适，做不了

# ZGC-内存紧凑模式
- 方便写入文件使用
```
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-Dfile.encoding=UTF-8

-XX:+AlwaysPreTouch
-XX:+DisableExplicitGC
-XX:-UseCompressedClassPointers

-XX:-UseG1GC
-XX:+UseZGC
-XX:+ZGenerational
-XX:-ZProactive
-XX:ZCollectionIntervalMinor=0.95
-XX:ZUncommitDelay=5

--add-modules=jdk.incubator.vector

```
- 方便命令行使用
```
-XX:+IgnoreUnrecognizedVMOptions -XX:+UnlockExperimentalVMOptions -Dfile.encoding=UTF-8  -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:-UseCompressedClassPointers  -XX:-UseG1GC -XX:+UseZGC -XX:+ZGenerational -XX:-ZProactive -XX:ZCollectionIntervalMinor=0.95 -XX:ZUncommitDelay=5  --add-modules=jdk.incubator.vector 
```

> [!NOTE]
> 服务端客户端通用

> [!IMPORTANT]
> 需要Java21+

# 使用方式
- ### 如果使用Java8，则只有一种方式
  - 将JVM参数添加到启动命令行
- ### 如果使用Java9+，则多一种方式
  - 写入到文件里并在启动命令行引用
    - 使用jar启动的核心适合写入自定义文件
    - 高版本纯Mod Loader适合写入到`user_jvm_args.txt`
> [!NOTE]
> 你是说，怎么在启动命令行引用？  
> 比如在`my_args.txt`里填写好了上面的参数  
> 然后启动命令就这样写  
> ```
> java @my_args.txt -jar server.jar
> ```

# bin目录脚本
- [使用文档](./md/omcsl.md)

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
  - 给服务端-Xmx4G，运行时候的占用大概是（堆4G + 非堆1G = 5G占用）
  - 给客户端-Xmx4G，运行时候的占用大概是（堆4G + 非堆1G + OpenGL 2G = 7G占用）

## TPS排查
> [!NOTE]
> 可以使用[spark](https://spark.lucko.me/download)采集并导出插件/模组占用耗时堆栈图  
> 找出堆栈顺序里最先出现的tick占用高的插件/模组  

> [!TIP]
> 如果想安装`C2ME`模组  
> 分配的内存不能太小，必须和CPU核心数成正比  

## 学习参考
- [Aikar's Flags](https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft)
- [VM Options Explorer](https://chriswhocodes.com/vm-options-explorer.html)
- [ZGC OpenJDK Wiki](https://wiki.openjdk.org/display/zgc)
- [https://pdai.tech/md/java/jvm/java-jvm-gc-g1.html](https://pdai.tech/md/java/jvm/java-jvm-gc-g1.html)

## GC经验总结
- 关于2大GC  
  - G1GC  
    G1GC的设计理念是清大垃圾留小垃圾  
    所以G1GC对垃圾的回收并不彻底，会有一些甚至明显的内存浪费  
  - ZGC  
    ZGC则是全新设计了内存分配和回收方式  
    对象的分配不再无脑向后开辟，所以内存开销可以尽可能最小化  

## Stargazers
[![Stargazers](https://starchart.cc/Yukiriri/OMCF.svg?variant=adaptive)]()

## 无用的吐槽
我现在已经不那么觉得JVM不行了，就是觉得MC需要一场真正的脱胎换骨
