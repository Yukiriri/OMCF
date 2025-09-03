# 命令格式
omcsl \<jar\> \<Xmx\> \[GC\]
- jar  
  `xxx.jar`或者`@/libraries/.../xxx.txt`
- Xmx  
  分配多大的内存
- GC  
  使用什么GC
  - G1GC
  - G1GCC  
    内存紧凑模式G1GC，以更高CPU消耗控制更低的内存水位
  - ZGC
  - ZGCC  
    内存紧凑模式ZGC，以更高CPU消耗控制更低的内存水位

# 命令样例
```
omcsl purpur.jar 4G
```

```
omcsl purpur.jar 4G ZGC
```

```
omcsl @libraries/net/neoforged/neoforge/21.1.160/win_args.txt 4G
```
