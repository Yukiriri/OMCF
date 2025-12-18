# OMCF
吸收了各种MC调优后再进行重新定制的MC JVM参数，同时提供服务端和客户端的方案  
如果遇到问题或者有更好的调优，欢迎提出  
祝你能收获更多快乐  

## 用途一览
[G1GC.txt]: ../flags/G1GC.txt
[G1GCM.txt]: ../flags/G1GCM.txt
[ZGC.txt]: ../flags/ZGC.txt
[ZGCM.txt]: ../flags/ZGCM.txt
[SGC.txt]: ../flags/SGC.txt
[SGCM.txt]: ../flags/SGCM.txt

| JVM参数    | 调校目标            | JDK要求 | 适用范围                   |
| :--------- | :------------------ | :------ | :------------------------- |
| [G1GC.txt] | 轻度STW均衡GC       | JDK8+   | 服务端 & 客户端            |
| [ZGC.txt]  | 无感STW高内存利用GC | JDK17+  | 服务端 & 客户端 & Velocity |
| [SGCM.txt] | 无感STW中内存利用GC | JDK24+  | 服务端 & 客户端 & Velocity |

- ## 运行效果
  - [服务端运行统计](./statistical/server/server.md)

- ## 选择推荐
  |              | 客户端                 | 服务端                 |
  | :----------- | :--------------------- | :--------------------- |
  | 低主频少核心 | [G1GC.txt]             | [G1GC.txt]             |
  | 低主频多核心 | [SGCM.txt] / [ZGC.txt] | [G1GC.txt]             |
  | 高主频少核心 | [SGCM.txt] / [ZGC.txt] | [G1GC.txt]             |
  | 高主频多核心 | [SGCM.txt] / [ZGC.txt] | [SGCM.txt] / [ZGC.txt] |

> [!TIP]  
> G1GC和SGCM可以有节省内存的用途  
> 如果想节省内存占用，就把-Xms设置到比-Xmx更低  
> 但是G1GC的-Xms不要给太小，不然反复伸缩进程内存会导致STW大幅波动  

## 使用方式
- 服务端  
  - 添加到java启动命令行  
    (在-jar之前)  
  - 写入到txt文件并在启动命令行@引用  
    (在-jar之前)  
    (需要JDK9+)  
- 客户端  
  - 添加到启动器自定义JVM参数  
    (需要删除启动器已有的`-XX:+UseG1GC`)  
  - 写入到txt文件并在启动器自定义JVM参数@引用  
    (需要删除启动器已有的`-XX:+UseG1GC`)  
    (需要JDK9+)  

> [!IMPORTANT]  
> 写入到txt时，Windows需要注意行尾必须为LF  

> [!NOTE]  
> 你是说，怎么在启动命令行引用？  
> 比如在`user_jvm_args.txt`里写好了JVM参数  
> 然后启动命令就这样写  
> ```
> java @user_jvm_args.txt -jar server.jar
> ```
> @user_jvm_args.txt一定要在-jar之前  

## JDK推荐
- [Liberica](https://bell-sw.com/pages/downloads/)
- [Zulu](https://www.azul.com/downloads/?package=jdk#zulu)

> [!TIP]  
> 推荐使用LTS版本，可以有更广范围的旧版MC兼容性  

## 经验心得
- [内存估算](./experience/memory.md)

## 学习参考
- https://chriswhocodes.com/vm-options-explorer.html
- https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft
- https://github.com/openjdk/jdk/blob/jdk25/src/hotspot/share/gc/g1/g1ConcurrentMark.cpp
- https://github.com/openjdk/jdk/blob/jdk25/src/hotspot/share/gc/z/zDirector.cpp
- https://github.com/openjdk/jdk/blob/jdk25/src/hotspot/share/gc/shenandoah/heuristics/shenandoahHeuristics.cpp
- https://github.com/openjdk/jdk/blob/jdk25/src/hotspot/share/gc/shenandoah/heuristics/shenandoahStaticHeuristics.cpp

## Stargazers
![Stargazers](https://starchart.cc/Yukiriri/OMCF.svg?variant=adaptive)
