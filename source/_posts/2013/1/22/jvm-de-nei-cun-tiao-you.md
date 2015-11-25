title: jvm的内存调优
id: 14
categories: java
date: 2013-01-22 22:15:03
tags:
---

<span>![](http://m1.img.libdd.com/farm5/2013/0122/22/F2432573DF61E709EAADC14DF9207EB4E3BDFC18DB1D6_500_254.jpg)</img>
</br></span>

<span>1) 堆
</br><span>
</br></span> &nbsp;&nbsp;&nbsp;运行时数据区域，所有类实例和数组的内存均从此处分配。Java 虚拟机启动时创建。对象的堆内存由称为垃圾回收器 的自动内存管理系统回收。
</br> 堆由两部分组成:</span>

<span> &nbsp;&nbsp;&nbsp;其中eden+fromspace+tospace也叫年轻代(young),old space叫旧生代.</span>

<span> &nbsp;&nbsp;&nbsp;其中还有S1,S0(在JDK的自带工具输出中会看到),分别指的是Survivor space,存放每次垃圾回收后存活的对象.</span>

<span> &nbsp;&nbsp;&nbsp;Old Generation , 主要存放应用程序中生命周期长的存活对象
</br>垃圾回收主要是对Young Generation块和Old Generation块内存进行回收，YG用来放新产生的对象，经过几次回收还没回收掉的对象往OG中移动，
</br>对YG进行垃圾回收又叫做MinorGC，对OG垃圾回收叫MajorGC，两块内存回收互不干涉</span>

<span>2) **<span>非堆内存</span>**</span>

 &nbsp;&nbsp;<span>JVM具有一个由所有线程共享的方法区。方法区属于非堆内存。它存储每个类结构，如运行时常数池、字段和方法数据，以及方法和构造方法的代码。它是在 Java 虚拟机启动时创建的。
</br> &nbsp;&nbsp;&nbsp;除了方法区外，Java 虚拟机实现可能需要用于内部处理或优化的内存，这种内存也是非堆内存。 例如，JIT 编译器需要内存来存储从 Java 虚拟机代码转换而来的本机代码，从而获得高性能。</span>
</br> &nbsp;&nbsp;Permanent Generation &nbsp;&nbsp;（图中的Permanent Space） 存放JVM自己的反射对象，比如类对象和方法对象
</br>3) 回收算法和过程
</br> &nbsp;&nbsp;

 JVM采用一种分代回收 (generational collection) 的策略，用较高的频率对年轻的对象(young generation)进行扫描和回收，这种叫做minor collection，而对老对象(old generation)的检查回收频率要低很多，称为major collection。这样就不需要每次GC都将内存中所有对象都检查一遍。

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当一个URL被访问时，内存申请过程 如下：
</br>A. JVM会试图为相关Java对象在Eden中初始化一块内存区域
</br>B. 当Eden空间足够时，内存申请结束。否则到下一步
</br>C. JVM试图释放在Eden中所有不活跃的对象（这属于1或更高级的垃圾回收）, 释放后若Eden空间仍然不足以放入新对象，则试图将部分Eden中活跃对象放入Survivor区
</br>D. Survivor区被用来作为Eden及OLD的中间交换区域，当OLD区空间足够时，Survivor区的对象会被移到Old区，否则会被保留在Survivor区
</br>E. 当OLD区空间不够时，JVM会在OLD区进行完全的垃圾收集（0级）
</br>F. 完全垃圾收集后，若Survivor及OLD区仍然无法存放从Eden复制过来的部分对象，导致JVM无法在Eden区为新对象创建内存区域，则出现”out of memory错误”

 &nbsp;&nbsp;&nbsp;对象衰老的过程
</br> &nbsp;&nbsp;&nbsp;young generation的内存，由一块Eden(伊甸园，有意思)和两块Survivor Space(1.4文档中称为semi-space)构成。新创建的对象的内存都分配自eden。两块Survivor Space总有会一块是空闲的，用作copying collection的目标空间。Minor collection的过程就是将eden和在用survivor space中的活对象copy到空闲survivor space中。所谓survivor，也就是大部分对象在伊甸园出生后，根本活不过一次GC。对象在young generation里经历了一定次数的minor collection后，年纪大了，就会被移到old generation中，称为tenuring。(是否仅当survivor space不足的时候才会将老对象tenuring? 目前资料中没有找到描述)
</br> &nbsp;&nbsp;&nbsp;&nbsp;剩余内存空间不足会触发GC，如eden空间不够了就要进行minor collection，old generation空间不够要进行major collection，permanent generation空间不足会引发full GC。

4 接下来这部分讲解的是TOMCAT或者其他服务器出现如下错误时的分析:

 &nbsp;&nbsp;1、首先是：java.lang.OutOfMemoryError: Java heap space

解释：

Heap size 设置

JVM堆的设置是指java程序运行过程中JVM可以调配使用的内存空间的设置.JVM在启动的时候会自动设置Heap size的值，其初始空间(即-Xms)是物理内存的1/64，最大空间(-Xmx)是物理内存的1/4。可以利用JVM提供的-Xmn -Xms -Xmx等选项可进行设置。Heap size 的大小是Young Generation 和Tenured Generaion 之和。
</br>提示：在JVM中如果98％的时间是用于GC且可用的Heap size 不足2％的时候将抛出此异常信息。
</br>提示：Heap Size 最大不要超过可用物理内存的80％，一般的要将-Xms和-Xmx选项设置为相同，而-Xmn为1/4的-Xmx值。

解决方法：

手动设置Heap size
</br>修改TOMCAT_HOME/bin/catalina.bat，在“echo “Using CATALINA_BASE: $CATALINA_BASE””上面加入以下行：
</br>Java代码
</br>set JAVA_OPTS=%JAVA_OPTS% -server -Xms800m -Xmx800m -XX:MaxNewSize=256m &nbsp;

set JAVA_OPTS=%JAVA_OPTS% -server -Xms800m -Xmx800m -XX:MaxNewSize=256m

或修改catalina.sh
</br>在“echo “Using CATALINA_BASE: $CATALINA_BASE””上面加入以下行：
</br>JAVA_OPTS=”$JAVA_OPTS -server -Xms800m -Xmx800m -XX:MaxNewSize=256m”

2、其次是：java.lang.OutOfMemoryError: PermGen space

原因：

PermGen space的全称是Permanent Generation space,是指内存的永久保存区域，这块内存主要是被JVM存放Class和Meta信息的,Class在被Loader时就会被放到PermGen space中，它和存放类实例(Instance)的Heap区域不同,GC(Garbage Collection)不会在主程序运行期对PermGen space进行清理，所以如果你的应用中有很CLASS的话,就很可能出现PermGen space错误，这种错误常见在web服务器对JSP进行pre compile的时候。如果你的WEB APP下都用了大量的第三方jar, 其大小超过了jvm默认的大小(4M)那么就会产生此错误信息了。

解决方法：

1\. 手动设置MaxPermSize大小
</br>修改TOMCAT_HOME/bin/catalina.bat（Linux下为catalina.sh），在Java代码
</br>“echo “Using CATALINA_BASE: $CATALINA_BASE””上面加入以下行： &nbsp;&nbsp;
</br>set JAVA_OPTS=%JAVA_OPTS% -server -XX:PermSize=128M -XX:MaxPermSize=512m &nbsp;

“echo “Using CATALINA_BASE: $CATALINA_BASE””上面加入以下行：
</br>set JAVA_OPTS=%JAVA_OPTS% -server -XX:PermSize=128M -XX:MaxPermSize=512m

catalina.sh下为：
</br>Java代码
</br>JAVA_OPTS=”$JAVA_OPTS -server -XX:PermSize=128M -XX:MaxPermSize=512m”

JAVA_OPTS=”$JAVA_OPTS -server -XX:PermSize=128M -XX:MaxPermSize=512m”

**<span>JVM的默认设置</span>**

**<span>堆</span>**（heap）（News Generation 和Old Generaion 之和）的设置

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;初始分配的内存由-Xms指定，默认是物理内存的1/64但小于1G。

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最大分配的内存由-Xmx指定，默认是物理内存的1/4但小于1G。

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;默认空余堆内存小于40%时，JVM就会增大堆直到-Xmx的最大限制，可以由-XX:MinHeapFreeRatio=指定。
</br>默认空余堆内存大于70%时，JVM会减少堆直到-Xms的最小限制，可以由-XX:MaxHeapFreeRatio=指定。

服务器一般设置-Xms、-Xmx相等以避免在每次GC 后调整堆的大小，所以上面的两个参数没啥用。

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-Xmn 设置young generation的heap大小

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-XX:MinHeapFreeRatio与-XX:MaxHeapFreeRatio设定空闲内存占总内存的比例范围，这两个参数会影响GC的频率和单次GC的耗时。-XX:NewRatio决定young与old generation的比例。Young generation空间越大，minor collection频率越低，但是old generation空间小了，又可能导致major collection频率增加。-XX:NewSize和-XX:MaxNewSize直接指定了young generation的缺省大小和最大大小。

**<span>非堆内存</span>**的设置

 &nbsp;&nbsp;&nbsp;&nbsp;默认分配为64M

 &nbsp;&nbsp;&nbsp;&nbsp;-XX:PermSize设置最小分配空间，-XX:MaxPermSize设置最大分配空间。一般把这两个数值设为相同，以减少申请内存空间的时间。

再讲解和笔记下,JDK下的一些相关看内存管理工具的使用:

查看jvm内存状态：
</br>jstat -gcutil pid 1000 20

异常情况的例子

jstat -gcutil pid 1000 20

 S0 &nbsp;&nbsp;&nbsp;&nbsp;S1 &nbsp;&nbsp;&nbsp;&nbsp;E &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P &nbsp;&nbsp;&nbsp;&nbsp;YGC &nbsp;&nbsp;&nbsp;&nbsp;YGCT &nbsp;&nbsp;&nbsp;FGC &nbsp;&nbsp;&nbsp;FGCT &nbsp;&nbsp;&nbsp;&nbsp;GCT
</br> &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;99.99 &nbsp;82.51 &nbsp;53.11 &nbsp;&nbsp;2409 &nbsp;&nbsp;&nbsp;1.205 10117 7250.393 7251.598
</br> &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;83.42 &nbsp;82.55 &nbsp;53.10 &nbsp;&nbsp;2409 &nbsp;&nbsp;&nbsp;1.205 10118 7252.650 7253.855
</br> &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;56.06 &nbsp;82.46 &nbsp;53.10 &nbsp;&nbsp;2410 &nbsp;&nbsp;&nbsp;1.205 10120 7254.467 7255.672
</br> &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;32.11 &nbsp;82.55 &nbsp;53.10 &nbsp;&nbsp;2411 &nbsp;&nbsp;&nbsp;1.205 10121 7256.673 7257.877
</br> &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;99.99 &nbsp;82.55 &nbsp;53.10 &nbsp;&nbsp;2412 &nbsp;&nbsp;&nbsp;1.205 10123 7257.026 7258.231
</br> &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;76.00 &nbsp;82.50 &nbsp;53.10 &nbsp;&nbsp;2412 &nbsp;&nbsp;&nbsp;1.205 10124 7259.241 7260.446
</br>
</br>这个数据显示Full GC频繁发生。
</br> 正常情况的例子

 &nbsp;S0 &nbsp;&nbsp;&nbsp;&nbsp;S1 &nbsp;&nbsp;&nbsp;&nbsp;E &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P &nbsp;&nbsp;&nbsp;&nbsp;YGC &nbsp;&nbsp;&nbsp;&nbsp;YGCT &nbsp;&nbsp;&nbsp;FGC &nbsp;&nbsp;&nbsp;FGCT &nbsp;&nbsp;&nbsp;&nbsp;GCT

 &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;&nbsp;0.24 &nbsp;55.39 &nbsp;99.60 &nbsp;&nbsp;&nbsp;171 &nbsp;&nbsp;&nbsp;0.667 &nbsp;1339 &nbsp;393.364 &nbsp;394.031

 &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;&nbsp;0.24 &nbsp;55.39 &nbsp;99.60 &nbsp;&nbsp;&nbsp;171 &nbsp;&nbsp;&nbsp;0.667 &nbsp;1339 &nbsp;393.364 &nbsp;394.031

 &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;&nbsp;0.24 &nbsp;55.39 &nbsp;99.60 &nbsp;&nbsp;&nbsp;171 &nbsp;&nbsp;&nbsp;0.667 &nbsp;1339 &nbsp;393.364 &nbsp;394.031

 &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;&nbsp;0.24 &nbsp;55.39 &nbsp;99.60 &nbsp;&nbsp;&nbsp;171 &nbsp;&nbsp;&nbsp;0.667 &nbsp;1339 &nbsp;393.364 &nbsp;394.031

 &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;&nbsp;0.24 &nbsp;55.39 &nbsp;99.60 &nbsp;&nbsp;&nbsp;171 &nbsp;&nbsp;&nbsp;0.667 &nbsp;1339 &nbsp;393.364 &nbsp;394.031

 &nbsp;0.00 &nbsp;&nbsp;0.00 &nbsp;&nbsp;0.24 &nbsp;55.39 &nbsp;99.60 &nbsp;&nbsp;&nbsp;171 &nbsp;&nbsp;&nbsp;0.667 &nbsp;1339 &nbsp;393.364 &nbsp;394.031
</br>
</br>参数含义：
</br>S0：Heap上的 Survivor space 0 段已使用空间的百分比
</br>S1：Heap上的 Survivor space 1 段已使用空间的百分比
</br>E： Heap上的 Eden space 段已使用空间的百分比
</br>O： Heap上的 Old space 段已使用空间的百分比
</br>P： Perm space 已使用空间的百分比
</br>YGC：从程序启动到采样时发生Young GC的次数
</br>YGCT：Young GC所用的时间(单位秒)
</br>FGC：从程序启动到采样时发生Full GC的次数
</br>FGCT：Full GC所用的时间(单位秒)
</br>GCT：用于垃圾回收的总时间(单位秒)
</br> 2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dump出内存
</br>2.1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;找出要dump的线程pid

</br>在Linux下，使用ps –aux
</br>
</br>2.2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dump出内存使用详情
</br>可以通过命令：

jmap -dump:file=a.hprof pid

例如:jmap -heap 2343,可以看到

Attaching to process ID 2343, please wait…
</br>Debugger attached successfully.
</br>Server compiler detected.
</br>JVM version is 11.0-b16

using thread-local object allocation.
</br>Parallel GC with 8 thread(s)

Heap Configuration:
</br> &nbsp;&nbsp;MinHeapFreeRatio = 40
</br> &nbsp;&nbsp;MaxHeapFreeRatio = 70
</br> &nbsp;&nbsp;MaxHeapSize &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 4294967296 (4096.0MB)
</br> &nbsp;&nbsp;NewSize &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 2686976 (2.5625MB)
</br> &nbsp;&nbsp;MaxNewSize &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= -65536 (-0.0625MB)
</br> &nbsp;&nbsp;OldSize &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 5439488 (5.1875MB)
</br> &nbsp;&nbsp;NewRatio &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（YG，OG 大小比为1：2）
</br> &nbsp;&nbsp;SurvivorRatio &nbsp;&nbsp;&nbsp;= 8
</br> &nbsp;&nbsp;PermSize &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 21757952 (20.75MB)
</br> &nbsp;&nbsp;MaxPermSize &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 268435456 (256.0MB)

Heap Usage:
</br>PS Young Generation
</br>Eden Space:
</br> &nbsp;&nbsp;capacity = 1260060672 (1201.6875MB)
</br> &nbsp;&nbsp;used &nbsp;&nbsp;&nbsp;&nbsp;= 64868288 (61.86322021484375MB)
</br> &nbsp;&nbsp;free &nbsp;&nbsp;&nbsp;&nbsp;= 1195192384 (1139.8242797851562MB)
</br> &nbsp;&nbsp;5.148028935546367% used
</br>From Space:
</br> &nbsp;&nbsp;capacity = 85524480 (81.5625MB)
</br> &nbsp;&nbsp;used &nbsp;&nbsp;&nbsp;&nbsp;= 59457648 (56.70323181152344MB)
</br> &nbsp;&nbsp;free &nbsp;&nbsp;&nbsp;&nbsp;= 26066832 (24.859268188476562MB)
</br> &nbsp;&nbsp;69.52120375359195% used
</br>To Space:
</br> &nbsp;&nbsp;capacity = 85852160 (81.875MB)
</br> &nbsp;&nbsp;used &nbsp;&nbsp;&nbsp;&nbsp;= 0 (0.0MB)
</br> &nbsp;&nbsp;free &nbsp;&nbsp;&nbsp;&nbsp;= 85852160 (81.875MB)
</br> &nbsp;&nbsp;0.0% used
</br>~~~~~~~~~~~~~~~~~~~~~~~~~~这三块为上面所说的YG大小和使用情况
</br>PS Old Generation
</br> &nbsp;&nbsp;capacity = 2291138560 (2185.0MB)
</br> &nbsp;&nbsp;used &nbsp;&nbsp;&nbsp;&nbsp;= 1747845928 (1666.8757705688477MB)
</br> &nbsp;&nbsp;free &nbsp;&nbsp;&nbsp;&nbsp;= 543292632 (518.1242294311523MB)
</br> &nbsp;&nbsp;76.28722062099989% used
</br>~~~~~~~~~~~~~~~~~~~~~~~~~~OG大小和使用情况
</br>PS Perm Generation
</br> &nbsp;&nbsp;capacity = 108265472 (103.25MB)
</br> &nbsp;&nbsp;used &nbsp;&nbsp;&nbsp;&nbsp;= 107650712 (102.6637191772461MB)
</br> &nbsp;&nbsp;free &nbsp;&nbsp;&nbsp;&nbsp;= 614760 (0.5862808227539062MB)
</br> &nbsp;&nbsp;99.43217353728436% used

jstat
</br>jstat是vm的状态监控工具，监控的内容有类加载、运行时编译及GC。

使用时，需加上查看进程的进程id，和所选参数。以下详细介绍各个参数的意义。
</br> &nbsp;&nbsp;&nbsp;jstat -class pid:显示加载class的数量，及所占空间等信息。
</br> &nbsp;&nbsp;&nbsp;jstat -compiler pid:显示VM实时编译的数量等信息。
</br> &nbsp;&nbsp;&nbsp;jstat -gc pid:可以显示gc的信息，查看gc的次数，及时间。其中最后五项，分别是young gc的次数，young gc的时间，full gc的次数，full gc的时间，gc的总时间。
</br> &nbsp;&nbsp;&nbsp;jstat -gccapacity:可以显示，VM内存中三代（young,old,perm）对象的使用和占用大小，如：PGCMN显示的是最小perm的内存使用量，PGCMX显示的是perm的内存最大使用量，PGC是当前新生成的perm内存占用量，PC是但前perm内存占用量。其他的可以根据这个类推， OC是old内纯的占用量。
</br> &nbsp;&nbsp;&nbsp;jstat -gcnew pid:new对象的信息。
</br> &nbsp;&nbsp;&nbsp;jstat -gcnewcapacity pid:new对象的信息及其占用量。
</br> &nbsp;&nbsp;&nbsp;jstat -gcold pid:old对象的信息。
</br> &nbsp;&nbsp;&nbsp;jstat -gcoldcapacity pid:old对象的信息及其占用量。
</br> &nbsp;&nbsp;&nbsp;jstat -gcpermcapacity pid: perm对象的信息及其占用量。
</br> &nbsp;&nbsp;&nbsp;jstat -util pid:统计gc信息统计。
</br> &nbsp;&nbsp;&nbsp;jstat -printcompilation pid:当前VM执行的信息。
</br> &nbsp;&nbsp;&nbsp;除了以上一个参数外，还可以同时加上 两个数字，如：jstat -printcompilation 3024 250 6是每250毫秒打印一次，一共打印6次，还可以加上-h3每三行显示一下标题。
</br>例子：

jstat -gcutil pid 1000 20

 S0 &nbsp;&nbsp;&nbsp;&nbsp;S1 &nbsp;&nbsp;&nbsp;&nbsp;E &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P &nbsp;&nbsp;&nbsp;&nbsp;YGC &nbsp;&nbsp;&nbsp;&nbsp;YGCT &nbsp;&nbsp;&nbsp;FGC &nbsp;&nbsp;&nbsp;FGCT &nbsp;&nbsp;&nbsp;&nbsp;GCT &nbsp;
</br> 47.49 &nbsp;&nbsp;0.00 &nbsp;64.82 &nbsp;46.08 &nbsp;47.69 &nbsp;20822 2058.631 &nbsp;&nbsp;&nbsp;68 &nbsp;&nbsp;22.734 2081.365
</br> &nbsp;0.00 &nbsp;37.91 &nbsp;38.57 &nbsp;46.13 &nbsp;47.69 &nbsp;20823 2058.691 &nbsp;&nbsp;&nbsp;68 &nbsp;&nbsp;22.734 2081.425 &nbsp;这里发生了一次YG GC，也就是MinorGC，耗时0.06s
</br> 46.69 &nbsp;&nbsp;0.00 &nbsp;15.19 &nbsp;46.18 &nbsp;47.69 &nbsp;20824 2058.776 &nbsp;&nbsp;&nbsp;68 &nbsp;&nbsp;22.734 2081.510
</br> 46.69 &nbsp;&nbsp;0.00 &nbsp;74.59 &nbsp;46.18 &nbsp;47.69 &nbsp;20824 2058.776 &nbsp;&nbsp;&nbsp;68 &nbsp;&nbsp;22.734 2081.510
</br> &nbsp;0.00 &nbsp;40.29 &nbsp;19.95 &nbsp;46.24 &nbsp;47.69 &nbsp;20825 2058.848 &nbsp;&nbsp;&nbsp;68 &nbsp;&nbsp;22.734 2081.582

MajorGC平均时间：22.734/68=0.334秒

MinorGC平均时间：2058.691/20823=0.099秒

<span>原文地址：</span>[http://www.javagg.com/?p=784](http://www.javagg.com/?p=784)
</br>
