title: 干净的代码是改出来的
id: 106
categories: 闲言碎语
date: 2012-03-16 09:45:00
tags:
---

&nbsp;

对于程序员来说，最终的也是最基本的目标就是能写出一手好的代码。随着代码量的增长，自身对什么是好的代码的认识也渐渐有了不断的调整。

&nbsp;

1** 注释真的那么重要么？**

最好的注释就是代码。这句话确实是没有错误的。如果一个函数占用了一屏的版面，原因是由于各种各样的注释和解释性的 // ** 等说明文档，确实是比较恼人的。与其花过多的时间花精力在注释和说明的编写上面，不如花时间在变量名的编写上面。

&nbsp;

不能说没有注释的代码一定是天书。在程序员界来说，其实有许多是大家默认的约定，以php为例子

如果说function getMsgBySsn($msgid, $ssn)

function getMsgs($msgids);

这样的语句其实不用注释完全是可以的。

&nbsp;

这说明好的变量名和函数名是最好的注释！

在做一个完整的项目的时候，看代码的过程中其实就是接受作者潜意识规约的过程。

如果一个大的项目，所有的数据结构都使用一致的变量名，$msg, $chg， 那么这些变量名就已经赋予了完整的定义了。

比如在一个项目中,在所有表示“消息”这个概念的地方，不管是参数还是返回值，完全都只使用$msg这么一个array()

那么，虽然我没有在每个引用的地方加大篇幅说明$msg中的key和value是什么，只要读者追着看到这样的函数：
<pre>function getMsg()
{
    $msgid = self::getMsgid()
    return array(

    ‘msgid’ =&gt; $msgid,
    'ssn'      =&gt; self::getSsn($msgid),
    'title'      =&gt; self::getTitle($msgid),
   );

}</pre>
</br>

是不是/** Msg包含 msgid,ssn,title **/这样的注释更好呢？

</br>

当然，好代码在变量都一定会遵循的规则是：一个项目一个意思的东西，一定只有一个规定的变量名

</br>

好的代码会由于一个或两个变量名起的不对而不惜一次一次的svn commit，最后出现的代码一定不会让你失望的。

</br>

&nbsp;

</br>

**2 代码的简洁性**

</br>

你总是能感叹到为什么有的人写的代码是这么让人舒服。

</br>

让代码简单并不是一件容易的事情。这需要相当的代码能力才能有这样的能力。

</br>

比如这么一个函数,明明可以更简单的:

</br><pre>function example()
{
    $iMsgid = $this-&gt;getMsgid();
    $sTitle = $this-&gt;genTitle($iMsgid);
    $sContent = $this-&gt;genContent($iMsgid);
    $result = array(
        'msgid' =&gt; $iMsgid,
        'title'     =&gt; $sTitle,
        'content' =&gt; $sContent,
    );
    return $result;
}</pre>
</br>

我宁可选择写成这样:

</br><pre>function example()
{
    $msgid = $this-&gt;getMsgid();
    $title = $this-&gt;genTitle($msgid);
    $content = $this-&gt;genContent($msgid);
    return compact('msgid', 'title', 'content');
}</pre>
</br>

不妨能不能用更少的代码行数写出一样功能性的代码。

</br>

代码的量一旦减少，给的信息就是：犯错的概率也更少了

</br>

&nbsp;

</br>

最近在新项目组有几个感想：

</br>

1

</br>

以前经常觉得有很多函数必须要很详细的参数说明什么的，其实大都都是可以使用OO的方法来使代码更优美

</br>

比如function($msgid, $title, $content, $ssn)

</br>

为什么不是使用function($msg)呢？

</br>

开始我认为，$msg这样传入并不知道里面包含的key和value是什么，对代码的阅读性造成障碍

</br>

但是后来想想，其实这是因为我在阅读到这个函数的时候并没有$msg是一个对象的概念，也就是前面的代码并没有在人的潜意识里面栽种下这个对象的概念。那么前面的代码应该改了…………

</br>

2 好的代码不是一次性写出来的，一定是一次一次svn commit堆积出来的，你会看到某大牛为了一个空格，一个文件名是使用cron还是shell， 一个变量名（比如getMsg($Msgid) =&gt; getMsg($msgid)）而进行一次又一次的改动

</br>

最后得出的代码真的是“干净”的！

</br>

&nbsp;

</br>

原文网址：[http://www.cnblogs.com/yjf512/archive/2012/03/15/2399532.html](http://www.cnblogs.com/yjf512/archive/2012/03/15/2399532.html)
