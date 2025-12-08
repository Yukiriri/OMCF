# OMCF
吸收了各种MC调优后再进行重新定制的MC JVM参数，将同时研究服务端和客户端的方案。  
如果遇到问题或者有更好的调优，欢迎提出。  

## 运行效果
[statistical.md](./statistical/statistical.md)

## 用途一览
[G1GC]: ../flags/G1GC.txt
[G1GCC]: ../flags/G1GCC.txt
[ZGC]: ../flags/ZGC.txt
[ZGCC]: ../flags/ZGCC.txt

| JVM参数 | 用途       | JDK要求 | 适用范围                   |
| :------ | :--------- | :------ | :------------------------- |
| [G1GC]  | 低GC负载   | JDK8+   | 服务端 & 客户端 & Velocity |
| [G1GCC] | 低内存占用 | JDK12+  | 服务端 & 客户端 & Velocity |
| [ZGC]   | 低GC停顿   | JDK21+  | 服务端 & 客户端 & Velocity |
| [ZGCC]  | 低内存占用 | JDK21+  | 服务端 & 客户端 & Velocity |

## 选择推荐
|              | 客户端 | 服务端 |
| :----------- | :----- | :----- |
| 低主频少核心 | [G1GC] | [G1GC] |
| 低主频多核心 | [ZGC]  | [G1GC] |
| 高主频少核心 | [ZGC]  | [G1GC] |
| 高主频多核心 | [ZGC]  | [ZGC]  |

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
  - [Zulu](https://www.azul.com/downloads/?package=jdk#zulu)
  - [Liberica](https://bell-sw.com/pages/downloads/)
  - [Temurin](https://adoptium.net/temurin/releases/)

## 一点MC内存经验
MC一般值得计算的Java内存有
  - 堆内存（Xmx）
  - 非堆内存（Metaspace，Code Cache，...）
  - 外界API管理的内存

估算方式例如：
  - 给服务端-Xmx4G，运行期占用大概是（堆4G + 非堆1G = 5G占用）
  - 给客户端-Xmx4G，运行期占用大概是（堆4G + 非堆1G + OpenGL 2G = 7G占用）

## 学习参考
- https://chriswhocodes.com/vm-options-explorer.html
- https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft
- https://pdai.tech/md/java/jvm/java-jvm-gc-g1.html

## Stargazers
[![Stargazers](https://starchart.cc/Yukiriri/OMCF.svg?variant=adaptive)]()
