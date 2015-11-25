title: axis1与axis2的较量
id: 195
categories: java
date: 2011-03-22 02:12:17
tags:
---

</br>

<span> </span>这里我并不说是axis1和axis2的什么不同，只是最近接触到了axis1和axis2的应用而已。

</br>

<span> </span>情况是这样滴。

</br>

<span> </span>公司的系统架构是公司外部系统的接口交互都要走公司的接口层，再由接口层将信息透传给公司内部的各个系统。

</br>

<span> </span>接口层使用axis2来架构，我这块的接口部分是使用axis1架构的，这个框架用了好几年，相当的成熟，看代码中的注释，最早的有02年写的代码，听说是很早那一批海归写的。

</br>

<span> </span>按理来说，高版本一般都会是兼容低版本的，况且对于axis来说，只要是标准的wsdl就可以，可还是有些区别的。

</br>

<span> </span>我使用axis1可以正常调用和返回，接口层可以调用也可以返回，看日志，调用的输入和输出都是正常，可在接口层那边就是取不到数据。同事和我整整查了一中午问题，公司对接口很厉害的高手也没有个办法。

</br>

<span> </span>最后，还是用最底层的办法来查，webService的本质还是xml，查看输入和输出的xml，输入没有什么问题，输出还是发现了一些端倪。

</br>

<span> </span>作为一个返回对象，属性内容是包含在ns的标签中的，在我们输出的xml文件中，ns标签标签中出现的是mutilhref=&quot;#01&quot; ，在ns的标签外面，有个#01的标签，在#01中包含着输出的内容。接口层使用的是axis2取数据是从ns的标签中取的，当然是取不到标签外的值，axis1是可以取到的。

</br>

<span> </span>让接口层改用axis1，为了保持整个框架的统一，肯定不能改，我们改成axis2，时间不允许。有问题就google、baidu了，最近google搜索，都是搜索的繁体或者英文，简体的好些不是很方便，有时google还打不开，有些厌恶baidu的搜索了，现在用有道多一些。对于axis1和axis2的这个问题，整个网络上面，就只有一个09年的帖子提到，让关闭一些wsdd中globalConfiguration的sendMultiRefs设置为flase。

</br>

<span> </span>设置为false之后，再次调用，ns标签外的对象就被包含在ns中，不会采用引用的方式了。

</br>

<span> </span>在http://axis.apache.org/axis/java/reference.html有几个配置的解释，没看到有中文的解释，按照我自己的理解，意译下。

</br>

<span> </span>sendMultiRefs<span> </span>true/false flag to control whether multirefs are sent or not.

</br>

<span> </span>是否使用引用对象的方式

</br>

<span> </span>sendXMLDeclaration<span> </span>true/false flag to control whether the &lt;?xml?&gt; declaration is sent in messages

</br>

<span> </span>是否包含xml头文件的信息

</br>

<span> </span>sendXsiTypes<span> </span>true/false flag to enable/disable sending the type of every value sent over the wire. Defaults to true.

</br>

<span> </span>是否在每个值中都标注值的类型参数

</br>
