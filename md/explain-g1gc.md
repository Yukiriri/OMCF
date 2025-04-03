# 我的G1GC参数讲解
- ## -XX:MaxGCPauseMillis=100
  每一轮GC里尽可能把暂停时间不超过100ms  

- ## -XX:G1HeapRegionSize=2M
  降低Region大小可以略微降低连续空间不足的风险，但会稀释G1MixedGCLiveThresholdPercent的效果，反之亦然

- ## -XX:G1NewSizePercent=99 -XX:G1MaxNewSizePercent=99
  使年轻代大小用满全堆，除老年代区以外皆为年轻代

- ## -XX:+AlwaysTenure
  完全取消幸存区，年轻代回收后存活对象直接归为老年代  
  幸存区大小也是影响暂停时间的一大因素，过高就会导致暂停变长  

- ## -XX:-G1UseAdaptiveIHOP
  让GC不要插手暗改InitiatingHeapOccupancyPercent，尽可能减少不必要的Mixed GC

- ## -XX:InitiatingHeapOccupancyPercent=80
  最大化减少Mixed GC的开销，当老年代占用达到全堆80%时，开始启动Mixed GC

- ## -XX:+ParallelRefProcEnabled
  Java8没有对这个选项默认启用，所以才加上这个选项  
