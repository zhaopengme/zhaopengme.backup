title: 'c#时间戳转换'
id: 77
categories:
  - 软件工具
date: 2012-09-17 17:28:22
tags:
---

今天遇到个比较搞的事情，我们接口层的时间格式采用时间戳的格式来进行定义的。在各个语言上面应该是比较通用的吧！
</br> 我们讨论的焦点是c#不好处理，要把格式改成yyyy-mm-dd hh:mm:ss的格式，就这样产生了分歧。
</br> 我不做C#开发，也承认C#作为MS的产品，可能C#对于时间戳会没做很好的处理，可总有处理的办法吧！呀！这个问题纠结的啊！
</br> 为了测试有办法处理，给电脑装了VS2010，测试之后，才发现，这么容易处理！ 发代码给大家瞧瞧，没学过代码的也能明白，啥叫个简单。
</br>
<pre config="brush:c#;toolbar:false;">
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(&quot;时间戳转换为本地时间&quot;);
            Console.WriteLine(&quot;1347872069&quot;+&quot;转换为本地时间：&quot;);
            long l = 1347872069; // 本地时间为：2012/9/17 8:54:29
            Console.WriteLine(FROM_UNIXTIME(l));

            Console.WriteLine(&quot;=================&quot;);

            Console.WriteLine(&quot;本地时间转换为时间戳&quot;);
            DateTime dt = DateTime.Now;//取系统当前时间
            Console.WriteLine(&quot;系统当前时间：&quot; + dt.ToLocalTime());
            Console.WriteLine(UNIX_TIMESTAMP(dt));

            Console.Read();
        }
        //时间戳转换为本地时间
        public static DateTime FROM_UNIXTIME(long timeStamp)
        {
            return DateTime.Parse(&quot;1970-01-01 00:00:00&quot;).AddSeconds(timeStamp);
        }
        //本地时间转换为时间戳
        public static long UNIX_TIMESTAMP(DateTime dateTime)
        {
            return (dateTime.Ticks - DateTime.Parse(&quot;1970-01-01 00:00:00&quot;).Ticks) / 10000000;
        }
    }
}
</pre>

![](http://m2.img.libdd.com/farm4/2012/0917/17/41496F711F1EE2C0AB9F1590596E03DF8B655C8D7D8E_500_197.jpg)</img>
</br> 提供一个时间戳转换工具的网址，不相信，可以试试。
</br>[http://shiningray.cn/toys/unix-timestamp](http://shiningray.cn/toys/unix-timestamp "http://shiningray.cn/toys/unix-timestamp")