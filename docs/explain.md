# 我的G1GC参数讲解
- ## -XX:+ParallelRefProcEnabled
  Java8没有对这个选项默认启用，所以才加上这个选项  

- ## -XX:G1NewSizePercent=100 -XX:G1MaxNewSizePercent=100
  将全堆中所有空闲空间给年轻代使用，也就是年老代以外皆为年轻代  
  反正闲着也是闲着，为什么不物尽其用呢  

- ## -XX:+AlwaysTenure
  完全取消幸存区，年轻代回收后存活对象直接归为年老代  
  幸存区大小也是影响暂停时间的一大因素，过高就会导致暂停变长  

- ## -XX:-G1UseAdaptiveIHOP
  让GC不要插手暗改InitiatingHeapOccupancyPercent，尽可能减少不必要的Mixed GC  

- ## -XX:InitiatingHeapOccupancyPercent
  当年老代占用达到全堆多少百分比时，开始启动Mixed GC  
  越高越能最大化减少Mixed GC的开销，但不能太高，太高了就Evacuation Failed触发Full GC了  

- ## -XX:G1MixedGCLiveThresholdPercent=95
  年老代Region中需要超过5%垃圾才会回收  
  按宏观来算，代表每1G年老代空间里最大容许50M垃圾  
  和G1HeapWastePercent保持互补差距可以达到微妙效果  
