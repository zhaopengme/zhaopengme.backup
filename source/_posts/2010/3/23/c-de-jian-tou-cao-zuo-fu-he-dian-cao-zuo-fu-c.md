title: 'C++的箭头操作符和点操作符[c++]'
id: 269
categories:
  - java
date: 2010-03-23 01:04:29
tags:
---

最近在回顾c++的东西，现在java搞的多，c++的东西忘得也差不多啦！看了一些基础性的东西，整理一下，也算做个笔记吧！
</br>c++的重点之一：C++的箭头操作符(-&gt;)和点操作符(.)
</br>都是用在结构这块的，c++的结构类似于java的对象，但是java毕竟是真正面向对象的，看到的一切都是对象，要有对象，就要用new来创建了。而c++仅仅是支持面向对象，比如c++中的一个例子。
</br>class A
</br>{
</br>&nbsp;&nbsp;&nbsp; private:
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int a;
</br>&nbsp;&nbsp;&nbsp; public:
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A()
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a = 10;
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;void play()
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%d&quot;,a);
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
</br>};
</br>int main()
</br>{
</br>&nbsp;&nbsp;&nbsp; //创建一个指针
</br>&nbsp;&nbsp;&nbsp; A *a = new A;
</br>&nbsp;&nbsp;&nbsp; a-&gt;play();
</br>&nbsp;&nbsp;&nbsp;//定义一个变量对象;
</br>&nbsp;&nbsp;&nbsp;A b;
</br>&nbsp;&nbsp;&nbsp;b.play();
</br>}
</br>&nbsp;&nbsp;&nbsp;用这个例子的结果都是显示数字10，我们需要得出的结果而是：
</br>如果使用指针，那就是用“-&gt;”箭头操作符，定义变量那就用“.”点操作符。
</br>而使用指针还是定义变量，我认为是是否需要对变量进行数据的改变，如果仅仅是做传值，那就定义变量，如果是做数据改变（比如说这个值需要存贮），那就用指针来做。
</br>okay！继续学习。。。