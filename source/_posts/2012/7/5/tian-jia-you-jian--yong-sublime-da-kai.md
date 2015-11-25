title: 添加右键“用Sublime打开”
id: 92
categories: 闲言碎语
date: 2012-07-05 00:28:32
tags:
---

最近迷上了Sublime text2编辑器，用的是绿色版的，没有右键打开，模仿UE的右键注册表文件，改了下，支持Sublime text2右键打开文件。
</br>Sublime text2 相当的神器，推荐每一位程序猿们使用.
</br>Windows Registry Editor Version 5.00
</br>[HKEY_CLASSES_ROOT*shellSublime]
</br>@=&quot;用Sublime打开&quot;
</br>[HKEY_CLASSES_ROOT*shellSublimeCommand]
</br>@=&quot;&quot;D:\360云盘\Tools\Sublime Text 2.0 x64\sublime_text.exe&quot; %1&quot;
</br>
