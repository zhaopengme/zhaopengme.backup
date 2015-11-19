title: 一道有意思的机试题
id: 489
categories:
  - java
date: 2009-03-12 13:13:00
tags:
---

一道有意思的机试题
</br>
</br>　　有四个学生、六门课程，要求使用三个页面，第一个页面出现四个学生的选择，选择了学生后，到第二个页面出现选择了学生的列表，每个学生后面都有六门课程供学生选择，选好课程后，到第三个页面出现选择了的学生和对应的课程列表。
</br>
</br>　　乍一看很简单的一道题，不过我也用了一个小时左右的时间，最快的一个！题不难，要求也简单，无论什么使用技术，出现效果就行，可就是不会啊！现在不是接触的mvc就是servlet，所有的数据来源基本就是数据库，想问题想复杂了，我使用的办法是最古老的jsp页面脚本，在jsp页面定义数组来做的。
</br>
</br>　　第一个页面脚本代码：
</br>
</br>　　&lt;%
</br>
</br>　&nbsp;　String[] stu = new String[] { &quot;张三&quot;, &quot;李四&quot;, &quot;王五&quot;, &quot;赵六&quot; };
</br>
</br>　　%&gt;
</br>
</br>　　
</br>
</br>　　&lt;%
</br>
</br>　　&nbsp;for (int i = 0; i &lt; stu.length; i++) {
</br>
</br>　　%&gt;
</br>
</br>　　&quot; name=&quot;stu&quot; /&gt;
</br>
</br>　　&lt;%
</br>
</br>　&nbsp;　out.print(stu[i] + &quot;
</br>&quot;);
</br>
</br>　　}
</br>
</br>　　%&gt;
</br>
</br>　　
</br>
</br>　　
</br>
</br>　　说明：a、就定义了四名学生，把学生输出
</br>
</br>　　第二个页面的脚本代码：
</br>
</br>　　&lt;%
</br>
</br>　&nbsp;　String[] course = new String[] { &quot;数学&quot;, &quot;英语&quot;, &quot;物理&quot;, &quot;地理&quot;, &quot;哲学&quot;, &quot;美术&quot; };
</br>　　%&gt;
</br>
</br>　　&lt;%
</br>
</br>　&nbsp;　request.setCharacterEncoding(&quot;gbk&quot;);
</br>
</br>　&nbsp;　String[] stus = request.getParameterValues(&quot;stu&quot;);
</br>
</br>　　%&gt;
</br>
</br>　　
</br>
</br>　　&lt;%
</br>
</br>　&nbsp;　for (int i = 0; i &lt; stus.length; i++) {
</br>
</br>　　%&gt;
</br>
</br>　　&quot; name=&quot;stu&quot; /&gt;
</br>
</br>　　&lt;%
</br>
</br>　&nbsp;　out.print(stus[i] + &quot;&quot;);
</br>
</br>　&nbsp;&nbsp;　for (int m = 0; m &lt; course.length; m++) {
</br>
</br>　　%&gt;
</br>
</br>　　&quot; name=&quot;course&quot; /&gt;
</br>
</br>　　&lt;%
</br>
</br>　&nbsp;&nbsp;　out.print(course[m] + &quot; &quot;);
</br>
</br>　&nbsp;　}
</br>
</br>　&nbsp;&nbsp;　out.print(&quot;
</br>&quot;);
</br>
</br>　　}
</br>
</br>　　%&gt;
</br>
</br>　　
</br>
</br>　　
</br>
</br>　　说明：a、接受第一个页面已选择了的学生参数，输出，并使用隐藏域，为第三个页面学生的输出做铺垫
</br>
</br>　　b、定义六门课程，输出
</br>
</br>　　第三个页面脚本代码
</br>
</br>　　&lt;%
</br>
</br>　&nbsp;　request.setCharacterEncoding(&quot;gbk&quot;);
</br>
</br>　&nbsp;　String[] stu = request.getParameterValues(&quot;stu&quot;);
</br>
</br>　&nbsp;　for (int m = 0; m &lt; stu.length; m++) {
</br>
</br>　&nbsp;&nbsp;　String[] course = request.getParameterValues(&quot;course&quot; + m);
</br>
</br>　&nbsp;&nbsp;　out.print(stu[m] + &quot; &quot;);
</br>
</br>　&nbsp;　&nbsp;&nbsp;for (int n = 0; n &lt; course.length; n++) {
</br>
</br>　&nbsp;&nbsp;&nbsp;　out.print(course[n] + &quot; &quot;);
</br>
</br>　&nbsp;　&nbsp;&nbsp;}
</br>
</br>　&nbsp;　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out.print(&quot;
</br>&quot;);
</br>
</br>　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 　}
</br>
</br>　　%&gt;
</br>
</br>　　说明：a、接受学生参数和对应的选课参数，输出
</br>
</br>　　思路很简单，使用数组，定义一个数组，专门用于保存需要选课的学生，与之对应，再定义数组用来保存选课数据。与之对应的意思是，比如我们有一个学生需要选课，那么就定义一个选课数组，有两个学生，那就定义两个，依此类推。
</br>
</br>　　其实这个满足二维数组，可以使用二维数组来处理，不过当时我只想着作出结果，二维有点负责，就用一维数组了！
</br>
</br>　　面对问题，用某种适合办法解决就行！