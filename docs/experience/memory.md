# 一般值得计算的JVM内存
- 堆内存（Xmx）
- 非堆内存（Metaspace，Code Cache，...）
- 外界API管理的内存

# 估算方式
- 给服务端-Xmx4G，运行期占用大概是（堆4G + 非堆1G = 5G占用）
- 给客户端-Xmx4G，运行期占用大概是（堆4G + 非堆1G + OpenGL 2G = 7G占用）
