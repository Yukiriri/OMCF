重新定制新版本MC通用JVM优化参数，同时覆盖服务端和客户端  
如果遇到问题或者有更好的调优，欢迎提出  
也欢迎贡献更多的统计数据  
祝你能收获更多快乐  

## 用途一览
[G1GC.txt   ]: ../flags/G1GC.txt
[G1GCM.txt  ]: ../flags/G1GCM.txt
[G1GC-C.txt ]: ../flags/G1GC-C.txt
[G1GCM-C.txt]: ../flags/G1GCM-C.txt
[ZGC.txt    ]: ../flags/ZGC.txt
[ZGC-C.txt  ]: ../flags/ZGC-C.txt
[SGC.txt    ]: ../flags/SGC.txt
[SGC-C.txt  ]: ../flags/SGC-C.txt

| JVM GC参数    | STW程度         | 运行表现     | JDK要求 | 适用场景                   |
| :------------ | :-------------- | :----------- | :------ | :------------------------- |
| [G1GC.txt]    | 轻度 & 偶尔尖峰 | 均衡         | JDK8+   | 服务端 & 客户端            |
| [G1GCM.txt]   | 间歇持续轻度    | 内存紧凑     | JDK8+   | 服务端 & 客户端            |
| [G1GC-C.txt]  | 轻度 & 少量尖峰 | 积极返还内存 | JDK8+   | 客户端                     |
| [G1GCM-C.txt] | 轻度 & 少量尖峰 | 积极返还内存 | JDK8+   | 客户端                     |
| [ZGC.txt]     | 无感 & 偶尔微感 | 积极消费内存 | JDK21+  | 服务端 & 客户端 & Velocity |
| [ZGC-C.txt]   | 无感 & 偶尔微感 | 积极返还内存 | JDK21+  | 客户端                     |
| [SGC.txt]     | 无感 & 偶尔轻度 | 积极消费内存 | JDK25+  | 服务端 & 客户端 & Velocity |
| [SGC-C.txt]   | 无感 & 偶尔轻度 | 积极返还内存 | JDK25+  | 客户端                     |

- ## 已有的统计数据
  [/docs/statistical/](./statistical/)

> [!NOTE]  
> 稍等后续补充  

- ## 选择参考
  - ## 低主频
    |               | 服务端                       | 客户端                         |
    | :------------ | :--------------------------- | :----------------------------- |
    | 少核心 小内存 | [G1GC.txt]                   | [G1GC.txt]                     |
    | 少核心 大内存 | [G1GC.txt]                   | [G1GC.txt]                     |
    | 多核心 小内存 | 优选[ZGC.txt] 备选[G1GC.txt] | 优选[ZGC-C.txt] 备选[G1GC.txt] |
    | 多核心 大内存 | [ZGC.txt]                    | [ZGC-C.txt]                    |

  - ## 高主频
    |               | 服务端                       | 客户端                         |
    | :------------ | :--------------------------- | :----------------------------- |
    | 少核心 小内存 | [G1GC.txt]                   | [G1GC.txt]                     |
    | 少核心 大内存 | 优选[ZGC.txt] 备选[G1GC.txt] | 优选[ZGC-C.txt] 备选[G1GC.txt] |
    | 多核心 小内存 | 优选[ZGC.txt] 备选[G1GC.txt] | 优选[ZGC-C.txt] 备选[G1GC.txt] |
    | 多核心 大内存 | [ZGC.txt]                    | [ZGC-C.txt]                    |

> [!TIP]  
> `G1GC-C` `G1GCM-C` `ZGC-C` `SGC-C`可以有节省内存的用途  
> 如果想节省内存占用，就把-Xms设置到比-Xmx更低  
> 但是`G1GC-C` `G1GCM-C`的-Xms不要给太小，不然反复伸缩进程内存会导致STW大幅波动  

## 使用方式
- ## 服务端  
  - 添加到java启动命令行  
    (在-jar之前)  
  - 写入到txt文件并在启动命令行@引用  
    (在-jar之前)  
    (需要JDK9+)  
  - 也可以添加到`user_jvm_args.txt`  
    (这个因服务端偏好而异)  
- ## 客户端  
  - 添加到启动器自定义JVM参数  
    (需要删除启动器已有的`-XX:+UseG1GC`)  
  - 写入到txt文件并在启动器自定义JVM参数@引用  
    (需要删除启动器已有的`-XX:+UseG1GC`)  
    (需要JDK9+)  

> [!IMPORTANT]  
> 在使用Windows写入到txt时，需要注意行尾必须为LF  

## JDK推荐
- [Liberica](https://bell-sw.com/pages/downloads/)
- [Zulu](https://www.azul.com/downloads/?package=jdk#zulu)
- [Graalvm](https://www.graalvm.org/downloads/)

> [!TIP]  
> 推荐使用LTS版本，可以有更广范围的旧版MC兼容性  

## 经验心得
- [内存估算](./experience/memory.md)

## Credits
- https://chriswhocodes.com/vm-options-explorer.html
- https://chat.qwen.ai/s/8aa3e2f3-bfde-4f3a-af69-238603d982d4?fev=0.2.38
- https://chat.qwen.ai/s/7944d7ec-c9c8-465e-bfb8-dc2dc404af64?fev=0.2.38
- https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft

## Stargazers
![Stargazers](https://starchart.cc/Yukiriri/OMCF.svg?variant=adaptive)
