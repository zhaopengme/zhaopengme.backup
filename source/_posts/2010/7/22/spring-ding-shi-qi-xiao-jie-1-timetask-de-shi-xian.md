title: spring定时器小结【1】-TimeTask的实现
id: 244
categories: java
date: 2010-07-22 19:48:38
tags:
---

TestTimerTask.java
</br><pre>
package cn.joypen.spring.demo3;
import java.util.TimerTask;
/**
 * TimerTask测试
 *
 * @author JOYPEN
 * @email user.zhaopeng@qq.com
 * @webSite htt://joypen.cn
 * @time 2010-7-22 下午07:26:21
 */
public class TestTimerTask extends TimerTask {
	@Override
	public void run() {
		System.out.println(&quot;enter TimerTask !&quot;);
	}
}
</pre>
</br>applicationContext.xml
</br><pre>
&lt; ?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt; !DOCTYPE beans PUBLIC &quot;-//SPRING//DTD BEAN//EN&quot; &quot;spring-beans.dtd&quot; &gt;

			class=&quot;cn.joypen.spring.demo3.TestTimerTask&quot;&gt;

			class=&quot;org.springframework.scheduling.timer.ScheduledTimerTask&quot;&gt;

			5000

			5000

			class=&quot;org.springframework.scheduling.timer.TimerFactoryBean&quot;&gt;

</pre>
</br>TestMain1.java
</br><pre>
	public static void main(String[] args) {
		// ApplicationContext ctx = new
		// FileSystemXmlApplicationContext(&quot;applicationContext.xml&quot;);
		ApplicationContext ctx = new FileSystemXmlApplicationContext(&quot;/src/applicationContext.xml&quot;);
	}
</pre>
