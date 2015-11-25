title: 960CSS框架基本原理
id: 191
categories:

date: 2011-03-26 17:10:21
tags:
---

</br>

本来是打算找一个模板直接使用的，没有找到到合适的，自己写好麻烦的啊！很早就知道960css的这个框架了，趁这个机会学学，找到一篇比较容易入门的基础，推荐阅读。

</br>

&nbsp;

</br>

CSS框架已经出现很长时间了，关于这些框架的用处也被我们讨论了很多遍了。有人说，CSS框架不够先进，还有人说这些框架大大的节省了他们的开发时间。在此，我们将不再讨论这个问题。

</br>

&nbsp;

</br>

前段时间，我了解到了CSS框架。经过对Malo、BluePrint和960做了实验对比后，我得出一个结论：我最喜欢960CSS框架。

</br>

&nbsp;

</br>

本教程将解释这个框架的基本原理，这样你就可以用960来快速进入开发。

</br>

&nbsp;

</br>

基本原理

</br>

&nbsp;

</br>

你必须知道一些基本原理来“学习这个框架是如何工作的”。你可以通过实验（或者是用firebug）来学习它，不过我也将会在这里为你介绍它。让我们开始吧。

</br>

&nbsp;

</br>

不要编辑960.css文件

</br>

&nbsp;

</br>

首先是一个小提示：不要编辑960.css文件，否则，将来你将不能更新这个框架。因为尽管我们需要布局我们的HTML，我们将创建一个独立的CSS文件。

</br>

&nbsp;

</br>

加载网格

</br>

&nbsp;

</br>

因为我们可以使用一个外部文件的CSS代码，我们必须在我们的HTML网站中加载它们，我们可以通过以下代码来实现：

</br>

&nbsp;

</br>

&lt;link rel=”stylesheet” type=”text/css” media=”all” href=”path/to/960/reset.css” /&gt;

</br>

&nbsp;

</br>

&lt;link rel=”stylesheet” type=”text/css” media=”all” href=”path/to/960/960.css” /&gt;

</br>

&nbsp;

</br>

&lt;link rel=”stylesheet” type=”text/css” media=”all” href=”path/to/960/text.css” /&gt;

</br>

&nbsp;

</br>

这些做好了之后，我们必须添加我们自己的CSS文件。例如，你可以叫这个文件为style.css或site.css或者其它任何名字。用下面代码引用这个文件：

</br>

&nbsp;

</br>

&lt;link rel=”stylesheet” type=”text/css” media=”all” href=”path/to/style.css” /&gt;

</br>

&nbsp;

</br>

容器

</br>

&nbsp;

</br>

在960框架中，你可以选择名为.container_12和.container_16的两个容器class。他们都是960px的宽度（这就是为什么叫960），它们的不同是分的列数不同。.container_12被分割为12列，.container_16被分割为16列。这些960px宽的容器是水平居中的。

</br>

&nbsp;

</br>

网格/列

</br>

&nbsp;

</br>

有很多列宽可供选择，而且在这两个容器里，这些宽度也不相同。你可以通过打开960.css文件来查看这些宽度。但是这对于设计一个网站来说是不必要的。有一个小技巧可以让这个框架更加易用。

</br>

&nbsp;

</br>

比如，你想要在你的容器里建两列（叫sidebar/content）。你可以这样做：

</br>

&nbsp;

</br>

&lt;div class=”container_12″&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_4″&gt;sidebar&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_8″&gt;main content&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;/div&gt;

</br>

&nbsp;

</br>

可以看到，你的第一列（grid_4）的数字加上第二列（grid_8）的数字正好是12。也就是说，你不必知道每一列的宽度，你可以选择列宽通过一些简单的数学计算。

</br>

&nbsp;

</br>

如果我们要建一个4列的布局，代码可以是这样的：

</br>

&nbsp;

</br>

&lt;div class=”container_12″&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2″&gt;sidebar&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_6″&gt;main content&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2″&gt;photo’s&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2″&gt;advertisement&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;/div&gt;

</br>

&nbsp;

</br>

正如你所看到的那样，这个系统依然很完美。但是如果你想使用嵌套的列的话，你会发现它是有问题的。比如，如果后面三列都属于content列：

</br>

&nbsp;

</br>

&lt;div class=”container_12″&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2″&gt;sidebar&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_10″&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_6″&gt;main content&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2″&gt;photo’s&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2″&gt;advertisement&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;/div&gt;

</br>

&nbsp;

</br>

你会发现这错位了，不过不用着急，这正是我们下一节要说的。

</br>

&nbsp;

</br>

间距

</br>

&nbsp;

</br>

默认情况下，每列之间都有间距。每一个grid_（这里代表数字）class左右都有10个像素的间距。也就是说，两列之间，总共有20px的间距。

</br>

&nbsp;

</br>

20px间距对创建一个有足够宽的空白间距的布局来说是很棒的，它可以让一切看起来很自然。这也是我喜欢使用960的原因之一。

</br>

&nbsp;

</br>

在上面的例子中，我们遇到了个问题，现在我们就来解决它。

</br>

&nbsp;

</br>

问题是，每一列都有左右边距。而嵌套的三列中，第一列和最后一列是不需要边距的，解决方法是：

</br>

&nbsp;

</br>

&lt;div class=”container_12″&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2″&gt;sidebar&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_10″&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_6 alpha”&gt;main content&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2″&gt;photo’s&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div class=”grid_2 omega”&gt;advertisement&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;/div&gt;

</br>

&nbsp;

</br>

我们可以简单的添加”alpha“样式来去掉左边的间距，添加“omega”样式来去除右边的间距。这样我们刚刚创建的这个例子在任何浏览器里面就很完美了（当然包括IE6）。

</br>

&nbsp;

</br>

样式

</br>

&nbsp;

</br>

好了，你现在已经完全了解如果用960框架来创建一个网格布局的基本原理了。当然，我们也可以添加一些样式到我们的布局中。

</br>

&nbsp;

</br>

&lt;div class=”container_12″&gt;

</br>

&nbsp;

</br>

&lt;div id=”sidebar” class=”grid_2″&gt;sidebar&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div id=”content” class=”grid_10″&gt;

</br>

&nbsp;

</br>

&lt;div id=”main_content” class=”grid_6 alpha”&gt;main content&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div id=”photo” class=”grid_2″&gt;photo’s&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;div id=”advertise” class=”grid_2 omega”&gt;advertisement&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;/div&gt;

</br>

&nbsp;

</br>

&lt;/div&gt;

</br>

&nbsp;

</br>

因为CSS使用特性来确定哪一个样式声明具有高于其它样式的优先级。”id“比class更重要。

</br>

&nbsp;

</br>

用这种方法，我们可以在自己的文件中重写那些被class设定的规则（比如宽度，padding，边框等）。

</br>

&nbsp;

</br>

我也添加一些样式，它们整整花费了我5分钟来整理整个例子。查看示例的源代码和样式声明。.

</br>

&nbsp;

</br>

搞定

</br>

&nbsp;

</br>

就这样。你已经学习了如果使用960框架来建立跨浏览器兼容性和整洁的布局了。当你完全掌握了960框架后，你将大大地减少编写CSS的时间。

</br>

&nbsp;

</br>

如果你还不理解，研究一下示例吧。

</br>

&nbsp;

</br>

我留给你的问题：

</br>

&nbsp;

</br>

你使用960CSS框架吗？或者你使用其它框架？你认为框架可以帮你提升你的代码吗？

</br>

&nbsp;

</br>

Translate From: divitodesign

</br>

&nbsp;

</br>

来源：http://www.qianduan.net/960css-the-framework-of-the-basic-principles-of.html

</br>