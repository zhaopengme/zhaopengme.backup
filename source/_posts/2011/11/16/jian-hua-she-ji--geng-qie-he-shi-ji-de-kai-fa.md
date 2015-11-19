title: 简化设计，更切合实际的开发
id: 152
categories:
  - java
date: 2011-11-16 19:47:57
tags:
---

千层饼的代码，就是过度的封装，当你要明白一句代码的使用的时候，才发现他已经关联好多的代码，你还需要明白这些代码的使用，你不疯才怪。

今天还和同事说起mvc的使用，在我们的项目中，mvc的使用，已经有些过度了，过度的强调了设计模式。

mvc，模型（model）、视图（view）、控制层（controller）。

view对应页面，即html、jsp、其他使用模版引擎的。

model对应bean，而bean是数据库表的承载者。

controller就是逻辑业务的处理。

在目前系统在实际使用中，划分出来Action层、Service层、Dao层。

按照定义简单的说Action控制页面跳转，Service控制业务逻辑、Dao控制数据访问存储，层次也是很清楚的。

除此之外，还有页面，在当前，页面也是讲究框架分层的，在Service、Dao中有自己接口，有接口的实现，很可能还会有父类的接口或者类的继承，层层相叠，在实际使用，一个很好的思想，可不一定会很好用。

我学习mvc分层的时候，很崇拜这些设计思想的，公司的项目中，也有着设计思想的架构，平时搞起没事来，就提这个思想、那个思想，使用久了，就越来越不觉得的，处处的设计思想，反而不好用了。今天在和同事讨论mvc的时候，说道Service层来处理业务的逻辑，我同意这种观点，可Service层就那么好用么？不见得吧！层次分的更多，需要更多的维护，结构更加的复杂。

我使用过php的thinkphp，国产的php框架，很推荐这个框架，在他的框架的就没有Service层，直接的Action到Dao。

也研究过人人的开源框架paoding，Action到Dao，Dao可以使用注解，简单好用，快速，上手容易。

在这里说的两个框架，都属于轻量级的框架，适用于系统快速开发。

最终系统的设计架构，都要以实际使用为主，只是提醒各位架构者，设计思想仅仅作为一种知道，过度的设计和使用反而会适得其反。

转载一篇关于过度的设计的文章。 
</br>千层饼代码

 任何一个跟计算机专业沾点儿边的人都知道“意大利面条代码(spaghetti code)”指的是什么。很遗憾，这种风格的代码如今还是不少。但现在我们又有了—找不到其它更好的词汇，还是沿用面食的比喻—“千层饼代码(lasagna code)”。

 千层饼代码是指代码被一层层的抽象，一层层的对象继承和引用，以及其它一些毫无意义的修饰，最终导致代码臃肿不堪，难于维护，完全跟“清晰”这个词不沾边。看着如今有些代码写成这个样子，我不由抓狂。而当你看到[Turbo Pascal v3 的体积是如此的微小](http://prog21.dadgum.com/116.html)，而且明白这是一个功能完整的Pascal语言编译器时，你不能不问，为什么如今的应用程序和编译器会全都如此的巨大。

 Turbo Pascal v3的体积小于40k，不错，4万个字节码。今天你还能找到体积这么小的有用的软件吗。大多数人甚至不能编译出一个小于1M的“Hello World”程序，这都是受我们追捧的面向对象编程的恩赐，人们似乎对“代码行数”的要求胜过代码清晰性，对“抽象和对象化”的要求胜过代码的简洁和优雅。

 回想起我初进入计算机行业时，我们写很少的代码能完成很多的事。而如今，我们写了成千上万行代码，能完成的事却变少了。如此的悲哀，让人想哭，或无奈的的甩甩手，走开。

 还有几点亮光。还有一些人在写短小漂亮的代码。但他们显得越来越稀有，尤其是在最近热衷于写优雅、短小、漂亮的代码的人过世的时候。Dennis Ritchie(C语言的创始人)会告诉你可以用小程序做大事。他强调说：算法是你要解决的问题的核心。创造漂亮和精心设计的东西，值得人们永远研究，就像[Thompson版的正则表达式算法](http://swtch.com/%7Ersc/regexp/regexp2.html)！

 也许只有像我这样的年龄和天生的坏脾气的人才会这样的抱怨，但这些年来很多系统都让我痛苦。它们写的如此的丑陋，设计的如此糟糕。也有亮点，但少之又少。无怪乎，现在的孩子都不愿意去研究计算机科学。以前我们对各种算法的固有的美丽的追求，现在变成了在键盘上的一痛乱敲，输入成百上千行代码，期望编译器能编译通过。Lisp，Smalltalk或APL等语言的优雅哪里去了？甚至Fortran也比现在的许多受人追捧的那些烂编程语言优雅的多。为什么没有人回去研究那些面向算法的语言、去改进它们?

 我曾经对我的孩子说，这么多好的语言如今只剩下C语言，这真是悲哀。不错，一些特定领域还有一些很漂亮很小的语言存在，但会成为主流吗？不会。这就是一场灾难。有些东西，比如Python，如果它不把一个面向对象的系统嵌入到体内，也许它会很不错。唉。

**译者注：**lasagna，字典的解释是，“烤奶酪肉馅面条：通过烘烤带有一层层的番茄汁和填有如奶酪和肉馅等调料的面团而制成的菜肴”，但这解释我听起来更像是月饼沾大酱。这里暂且用一个比较形象的东西：千层饼。

原文网址：[http://www.aqee.net/lasagna-code/](http://www.aqee.net/lasagna-code/ "http://www.aqee.net/lasagna-code/")