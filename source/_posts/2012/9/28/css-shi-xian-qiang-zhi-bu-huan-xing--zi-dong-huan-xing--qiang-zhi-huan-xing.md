title: css实现强制不换行/自动换行/强制换行
id: 72
categories:

date: 2012-09-28 13:00:02
tags:
---

css换行的一点小技巧
</br> 强制不换行
</br>
<pre config="brush:css;toolbar:false;">
div{
white-space:nowrap;
}
</pre>

自动换行
</br>
<pre config="brush:css;toolbar:false;">
div{
word-wrap: break-word;
word-break: normal;
}
</pre>

强制英文单词断行
</br>
<pre config="brush:css;toolbar:false;">
div{
word-break:break-all;
}
</pre>