title: linux停止某个进程的脚本
id: 27
categories: java
date: 2012-12-12 15:44:13
tags:
---

linux停止某个进程的脚本
</br>

记录两种写法

方式一
<pre config="brush:bash;toolbar:false;">kill -9 `ps -ef | grep 'java -Xms80m -Xmx180m' | grep Project1 | awk '{print $2}'`</pre>

方式二
<pre config="brush:bash;toolbar:false;">ps -ef |grep 'java -Xms80m -Xmx180m' | grep Project1 |awk '{print $2}' |xargs kill -9</pre>
