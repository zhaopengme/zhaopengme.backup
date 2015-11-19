title: 谷歌、搜狗浏览器复制标签插件
id: 136
categories:
  - web
date: 2011-12-18 21:37:54
tags:
---

从用电脑开始一直用的是世界之窗的浏览器，从1.0的版本用到了3.5，自从世界之窗进入360后，也一直保留着世界之窗的使用，无论是360还是世界之窗，在win7上面都存在这样那样的bug，一直没有修复，而且世界之窗和360的软件版本都比不上世界之窗2的好用，只是现在在速度、网络、服务上面，世界之窗2的版本也只能怀念的软件了。

目前我使用的搜狗浏览器，使用的皮肤是世界之窗3的皮肤，看起来亲切，用起来还不错，自动填表的功能很强大，在两种模式下面基本都可以使用，比起其他多核浏览器好多了。我常常打开多个同一网址，做测试用的多，搜狗浏览器里面没有这个功能，很麻烦，要复制网址，打开新标签，粘贴，回车，才完成，在世界之窗浏览器中一直有这个功能，很方便，相当好用，搜狗浏览器少了这个功能很不爽啊！

提给官方，谁还不知道鸟不鸟你啊！搜狗浏览器采用的是webkit内核，和谷歌浏览器一样，研究了下他们的API，搞了个复制标签的插件出来，我需要的功能也有了，代码也就几行。因为搜狗浏览器和谷歌浏览器的内核一样，API也基本一样，也顺便做了个谷歌浏览器的插件，测试都可以使用的。

看看源码

搜狗浏览器的
<pre><span>   1:</span> sogouExplorer.browserAction.onClicked.addListener(<span>function</span>(tab){</pre>
</br>
</br><pre><span>   2:</span> sogouExplorer.tabs.create({</pre>
</br>
</br><pre><span>   3:</span>                     url: <span>&quot;http://baidu.com/&quot;</span>,</pre>
</br>
</br><pre><span>   4:</span>                     selected: <span>true</span></pre>
</br>
</br><pre><span>   5:</span>                 });</pre>
</br>
</br><pre><span>   6:</span> }); </pre>
</br>
</br>
</br>

谷歌浏览器的

</br>
</br>
</br><pre><span>   1:</span> chrome.browserAction.onClicked.addListener(<span>function</span>(tab){</pre>
</br>
</br><pre><span>   2:</span> chrome.tabs.create({</pre>
</br>
</br><pre><span>   3:</span>                     url: tab.url,</pre>
</br>
</br><pre><span>   4:</span>                     selected: <span>true</span></pre>
</br>
</br><pre><span>   5:</span>                 });</pre>
</br>
</br><pre><span>   6:</span> }); </pre>
</br>
</br>
</br>

基本一样吧！

</br>

附件包含谷歌浏览器、搜狗浏览器的插件和源码

</br>

下载：[http://dl.dbank.com/c0eaktfiau](http://dl.dbank.com/c0eaktfiau "http://dl.dbank.com/c0eaktfiau")