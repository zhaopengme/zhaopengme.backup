title: 谷歌 Chrome Dev Tools 浅析 – 成为更高效的 Developer
id: 96
categories: java
date: 2012-06-23 14:40:42
tags:
---

web的调试一直采用的是火狐firebug的调试,现在火狐越来越臃肿.现在在领导的启发下,平常都用chrome dev tools调试的,也是挺方便,转载下chrome的调试技巧做下记录.

Google Chrome在招来了FireFox，FireBug的项目组领导人John J. Barton后，Chrome Dev Tools也变的越来越好用，越来越方便了。本文根据Google I/O上对Chrome Dev Tools的介绍([http://www.youtube.com/watch?v=N8SS-rUEZPg](http://www.youtube.com/watch?v=N8SS-rUEZPg)),和相关PPT：[http://chrome-devtools-io2011.appspot.com/template/index.html](http://chrome-devtools-io2011.appspot.com/template/index.html)<span>&nbsp;</span>整理而来。(参照的Chrome版本为: 19.0.1084.52)

**实时****CSS Style编辑**

选择一个Dom,可以对Dom进行编辑和操作,实时修改Css Style, 同时CssStyle可以保存变更历史版本。

[![](http://m2.img.libdd.com/farm4/2012/0822/05/B60EA9887688D6D1E490FA25CBF53F0EFD85598D7D8E_500_240.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641216466.jpg)

保存变更历史版本:

[![](http://m3.img.libdd.com/farm4/2012/0822/05/9453099C07F5E19E7681429ED89D01CE4D0E968D7D8E_500_240.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/20120615164122120.jpg)

同时支持可以在Chrome 载入的Css文件正文中自由的修改。

&nbsp;

**网络交互**

[![](http://m3.img.libdd.com/farm5/2012/0822/05/6F9A26927141F254D4F92740E76DFD057060BB8D7D8E_500_269.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641233010.jpg)

当一个页面载入时，所有发出的请求可以在“Network”里监听到，同时下面有”All”, “Documents”, ”Stylesheets”, “Images”, “Scripts”, “XHR”(XMLHttpRequst), WebSockets, Other, 这几个分类，可以清晰的把网络请求进行分类，同时可以看到每个请求的详细情况。

&nbsp;

**控制台**

在控制台里可以方便的使用命令来查看Dom，执行JavaScript, 等等操作， Console API:<span>&nbsp;</span>[http://getfirebug.com/wiki/index.php/Command_Line_API](http://getfirebug.com/wiki/index.php/Command_Line_API)<span>&nbsp;</span>copy(), dir(), inspect(), $0,

[![](http://m2.img.libdd.com/farm4/2012/0822/05/8C20A2EA94BDCCE991EA4EEFCC956BAEFA90BB8D7D8E_500_270.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641233076.jpg)

&nbsp;

**Script Debugging**

Script Debugging 脚本调试功能，这个功能可以说是Chrome Dev Tools里最实用最强大的工具了:

1\. JavaScript Breakpoints, Break on exception, JavaScript Pretty Print.

[![](http://m1.img.libdd.com/farm4/2012/0822/05/F16F42AAACD592CD76BE2B2910194B8F323C678D7D8E_500_278.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/20120615164124634.jpg)

Break Points:断点在需要设置的地方点一下即可,Break on exception:当此功能开启时，有Script异常出现时,自动会在Exception处断住,方便差错。JavaScript Pretty Print: 当JavaScript被压缩后，非常难阅读，Pretty Print使JavaScript按照语法和关键字重新换行并重排，使得压缩后的JavaScript仍然可以进行阅读。

&nbsp;

2\. DOM Breakpoints

Dom元素断点，经常有多处JavaScript操作同一个Dom元素，如果要在JavaScript上下断点，要下好几个地方，不好断到想要的地方，在Dom元素上下断点就方便多了：

[![](http://m3.img.libdd.com/farm5/2012/0822/05/ED31095AA3B05BAE0DB562165926C2B22B68DE8D7D8E_500_309.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641248192.jpg)

Break on subtree modifications, Break on attributes modifications, Break on node removal, 可以方便的断到操作Dom的JavaScript。

&nbsp;

3\. XHR Breakpoints, Event listener breakpoints:

[![](http://m1.img.libdd.com/farm4/2012/0822/05/ED1A59C9BF6D4F2E42D722FFA1B7CF771AD0818D7D8E_500_298.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641259338.jpg)

XHR Breakpoints,可以方便的断到XMLHttpRequest Ajax请求。Event Listener Breakpoints, 可以方便的断到各种Event。

&nbsp;

4\. 查找JavaScript

使用Ctrl+Shift+F, 打开查找窗口, 查找支持正则表达式：

[![](http://m3.img.libdd.com/farm4/2012/0822/05/4F9C36E77F4CEBB2541103A059A7B71CBDF2358D7D8E_500_298.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641252435.jpg)

查找函数定义：Ctrl + Shift + o

[![](http://m3.img.libdd.com/farm5/2012/0822/05/10DACC0FABB1E3D0F2F4F279F2DA77AD2E22A88D7D8E_500_298.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641269993.jpg)

查找文件： Ctrl + o

[![](http://m3.img.libdd.com/farm5/2012/0822/05/21DEF0A77D9B160CE7208FBD5377A63F2623488D7D8E_500_298.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641275457.jpg)

&nbsp;

5\. 实时修改 JavaScript代码

页面外链JavaScript文件在 Script Panel中可以直接修改，改完后Ctrl + s<span>&nbsp;</span>保存， 会立即生效，但是不支持 Html 页面中 JavaScript 修改，经过 Pretty print 格式化的JavaScript也不支持实时修改。

&nbsp;

6\. 自建Script文件

在Console(控制台) 中输入代码的最后一行加上 //@ sourceURL=filename.js, 会在Script Panel中加入一个新的外链Script文件: filename.js, 这个新文件和其它外链JavaScript 文件一样，可以实时进行修改。

&nbsp;

**Timeline**

Timeline功能把浏览器处理Dom的时间轴画了出来，方便进行优化:

[![](http://m3.img.libdd.com/farm5/2012/0822/05/32EC2403A4101EF6B848A64E069651F67BA2A68D7D8E_500_298.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641281063.jpg)

&nbsp;

**Remote Debugging**

Remote Debugging 使得Chrome成为一个WebServer,执行命令--remote-debugging-port=1337, 同时再开一个Chrome 访问localhost:1337, 就可以用一个Chrome当Host,一个Chrome当Client,在调试一些移动Web的时候非常实用。

[![](http://m3.img.libdd.com/farm4/2012/0822/05/EFCFBA2470154B1F92677FD52D93BB113ED9D6189977_500_367.jpg)</img>](http://images.cnblogs.com/cnblogs_com/powertoolsteam/201206/201206151641287749.jpg)
