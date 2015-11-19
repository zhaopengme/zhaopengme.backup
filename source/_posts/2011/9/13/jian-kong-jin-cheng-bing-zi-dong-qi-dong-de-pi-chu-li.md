title: 监控进程并自动启动的批处理
id: 167
categories:
  - 闲言碎语
date: 2011-09-13 22:04:20
tags:
---

<pre></pre>
</br>最近用的ManicTime的版本，经常会自动退出，我系统从win7的32位换到64位同样有这样的问题，到ManicTime官网上查看问题，同样发现其他人也有这样的问题，官方只管是让发日志给他们分析，也不见到有什么解决的办法。我每次看到右下角的图标不见了，就要手动启动一次，写程序的，不能经常做一些机械重复性的工作嘛！就写了一个批处理，监控如果ManicTime退出了，就自动把他启动起来。
</br><pre></pre>
</br>代码如下：
</br><pre><span><span> </span></span></pre>
</br>[codesyntax lang=&quot;vb&quot;]
</br><pre>@echo off
:main
tasklist|findstr /i ManicTime.exe&gt;nul||&quot;E:Program FilesManicTimeManicTime.exe&quot;
ping 127.1 -n 11 &gt;nul 2&gt;nul
goto main</pre>
</br>[/codesyntax]
</br>&nbsp;