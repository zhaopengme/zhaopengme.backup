title: Fix Bug的五个阶段
id: 192
categories:
  - 闲言碎语
date: 2011-03-24 08:58:01
tags:
---

</br>

写很很透彻，把码农解决bug的过程都包含进去了，至少我就是这样的。

</br>

下面的文章和《各种流行的编程方式》有异曲同工，请你不要理解错了。本文来源，翻译如下：

</br>

——————————————————

</br>

一个非常严重和困难的bug，能够成就一个饱经沧桑深受压力的有经验的专业程序员的职业生涯。经受这种考验的创伤程度，相当你受到了一次严重的身体伤害，离婚，或是家庭成为的离世。

</br>

研究人员在研究了计算机编程心理学后，得出了一个程序员们在解决一个困难的bug时的心路里程。这些不同的境界，很像为大众所知的K&uuml;bler-Ross Stages of Grief（这个模型描述了人对待哀伤与灾难过程中的5个独立阶段（否认，愤怒，耍赖，抑郁，接受）。绝症患者被认为会经历这些阶段），而且原因都很相似。就好像死亡所伴随的悲伤一样，fix一个bug是一个过程其初始化了一个事件，一开始是拒绝相信，其造就了你苦闷的情绪并开始逐步影响你的心智。这种苦闷的情结果会让你纠结要努力忍受，最终会你会找到一个满意的结果。

</br>

了解下面这几个bug-fixing的阶段，会让我们更好的生存下来，并持之以恒，最终带来……关闭我们所有的bug的结果。

</br>

第一阶段：抵触

</br>

本阶段的状态: 多疑 Skeptical. 生气 Offended. 易怒 Petulant.

</br>

1\. 不理睬

</br>

也许这个bug会安静地离开。

</br>

2\. 标记上“不是bug”

</br>

也许这是用户的错，或是本地配置有问题。是的，我确信就是那样，一会就会好的。

</br>

3\. 就是一次小故障

</br>

我想这就是一次小故障，很奇怪地发生了一次，它不会再发生的，虽然没有搞清楚是为什么发生了，不过这就好像我们的数据库，网格，浏览器或别的什么打了几个嗝一样。一会就会好的，我确信。

</br>

4\. 躲藏.

</br>

我要休几天病假，也许他们会把这个bug转给别人的。

</br>

5\. 标记为“修改需求中”

</br>

你看，我是按照需求实现的。如果你们想要改这个行为和UI，就一定要修改需求。也许他们会决定就这样了。

</br>

6\. 需要更多的信息

</br>

我不能确定这是一个bug，除非我能在错误日志中看到一条特定的报错信息。

</br>

7\. 转给其他人

</br>

我调查这个bug中看到了其它模块中我看不懂的数据，问题很大。我应该把这个bug转给开发那个模块的人。我可以在我的模块中检查一下那个边边角角的情况，但是正确的fix应该是在别人的模块中。反正那个在别的国家，我见不着他。

</br>

第二阶段：接受

</br>

本阶段的状态: 认命 Resigned. 被打击 Defeated. 被激怒 Annoyed.

</br>

1\. 接受现实

</br>

行了，行了，行了！这是我的bug，我会修正它的。

</br>

2\. 把这个bug放到最后

</br>

也许，我可以在我需要fix这个bug之前找到一个新的工作。

</br>

3\. 和你的经理讨价还价

</br>

好的，你看，我可以正确地fix这个问题，不过我需要一个月。也就是说，我可以给这个问题贴个创可贴，那不会真正的解决它，但是我们可以避免用户的抱怨，这可以为我们赢得几天的时间。

</br>

4\. 为这个bug标记一个无耻的时间

</br>

上帝啊，我希望这时间够了。

</br>

第三阶段： 投入和沮丧

</br>

本阶段的状态: 眼花 Giddy. 头晕 Light-headed. 紧张 Nauseous.

</br>

1\. 开始调查

</br>

我能搞定它，我能搞定它！只需要小小的调整一下，小小的关注一下，多一点咖啡因，再加上一点时间，我能搞定它。

</br>

2\. Befuddlement.

</br>

Shit. 这太扯了。我居然没有一点进展。这代码真是乱。这样的代码居然能编译和运行，真TMD的神奇，我有机会能搞清楚它什么不正常吗？

</br>

3\. 再次躲藏

</br>

你看，很对不起。我不得不要去切除我的阑尾。再一次，是的，既然你提到了它，我的确有两个阑尾。现在我一个也没有了，你高兴了吧？。

</br>

4\. 犯贱

</br>

好吧，总之，你到底期望什么？想让我在一个没有高级调试器的环境下改这个BUG。我是什么？千里眼吗？我在我的Commodore 64上一个更好的调试器！

</br>

5\. 瞎搞

</br>

看看我试试这么改？Kao，这样不行。要不然这样搞？也不行。那么那样搞呢？Shit，虽然再糟糕。

</br>

6\. 绝望

</br>

我不可能fix这个bug了。我是个糟糕的程序员。我太笨了。我在这个满是聪明人的地方干什么？迟早他们会知道我的能力太差，那时我就玩完了，在这也混不下去了。

</br>

7.耻辱

</br>

我的经理问我为什么我用了一个月的时候来fix这个只需要两天就可以解决的bug？老实说，我不知道怎么去读日志信息，我搞坏了我们的编译脚本。现在，我不敢去让别人来帮我，因为这样只会让我显得更愚蠢。

</br>

8\. 恐慌！

</br>

这事变得比我相像的要复杂！而我开始觉得复杂的事变得简单……而我觉得简单的事变成需要重定半打的类。为什么我以前在我的经理前拍着胸说我可以搞定这个事？

</br>

9\. 通宵工作，远离朋友和家人

</br>

(语无论次的喃喃自语，一阵一阵地大声咒骂)

</br>

第四个阶段：愚蠢的快感

</br>

本阶段的状态: 感恩 Grateful. 安心 Relieved. 极端地自我欣赏 Awfully Impressed with Yourself.

</br>

1\. 醒悟

</br>

哦！我终于明白怎么搞定它了……

</br>

2\. 写正确的代码

</br>

我真NB，我是编码机器！

</br>

3\. 测试

</br>

牛！通过一个测试。真牛！又通过一个测试了。靠！有测试失败了。这是为什么……

</br>

4\. 隐藏测试失败

</br>

反正这完全是一个不重要的测试案例。没有人会检查它，这个测试真是毫无意义。

</br>

5\. 提交代码

</br>

我太牛了，厨房里有个馅饼可以庆祝一下吗？

</br>

6\. 关闭 bug.

</br>

我听说那里有个馅饼可以庆祝一下

</br>

第五个阶段： 与“完成”肉搏

</br>

本阶段的状态: 焦燥不安 Twitchy. 神经过敏 Nervous. 迷信 Superstitious.

</br>

1\. 有人reopen了这个 Bug

</br>

真的？他们发现了你引入了另一个bug？ Shit – 那只是一个不重要的案例永远不会发生的。

</br>

2\. 修正以前的修正

</br>

是的，我甚至检查了员工的年龄是一个虚数的情况，就是为了防止出错。

</br>

3\. 关闭 bug

</br>

是的，贱货，你被关闭了。全部都关了，再也不用心烦了。

</br>

4\. 发誓以后再也不干这种事了

</br>

5\. 大家都意识到你现在是那个模块的专家了

</br>

哦，不！现在他们又给了我三个那个模块的新bug

</br>

没关系，现在你只需要GOTO 第一个阶段。

</br>

此外，作为一个工作中的程序员，你会永远经历这些烂事，直到你——死亡，退休，或是被升到管理层。

</br>

（全文完）

</br>

原文网址：

</br>

http://coolshell.cn/articles/4045.html

</br>