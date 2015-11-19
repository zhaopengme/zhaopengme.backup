title: spring定时器小结【2】-quartz的实现
id: 243
categories:
  - java
date: 2010-07-22 20:10:19
tags:
---

采用TimerTask的方式无法定时定点，quartz就更灵活一些了。
</br>TestBean.java
</br><pre>
package cn.joypen.spring.demo2.bean;
/**
 * 测试bean
 * @author JOYPEN
 * @email user.zhaopeng@qq.com
 * @webSite htt://joypen.cn
 * @time 2010-7-22 下午07:53:38
 */
public class TestBean {
	private String name = &quot;joypen&quot;;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
</pre>
</br>TestService.java
</br><pre>
package cn.joypen.spring.demo2.service;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import cn.joypen.spring.demo2.bean.TestBean;
import cn.joypen.spring.demo2.dao.iface.ITestDao;
/**
 * 测试类
 *
 * @author JOYPEN
 * @email user.zhaopeng@qq.com
 * @webSite htt://joypen.cn
 * @time 2010-7-22 下午07:52:37
 */
public class TestService extends QuartzJobBean {
	private TestBean testBean;
	//必须集成QuartzJobBean 的executeInternal的方式
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println(testBean.getName());
	}
	public TestBean getTestBean() {
		return testBean;
	}
	public void setTestBean(TestBean testBean) {
		this.testBean = testBean;
	}
}
</pre>
</br>applicationContext.xml
</br><pre>

			class=&quot;org.springframework.scheduling.quartz.JobDetailBean&quot;&gt;

			cn.joypen.spring.demo2.service.TestService

			class=&quot;org.springframework.scheduling.quartz.CronTriggerBean&quot;&gt;

			0/5 * * * * ?

			class=&quot;org.springframework.scheduling.quartz.SchedulerFactoryBean&quot;&gt;

</pre>
</br>quartz也可以采用org.springframework.scheduling.quartz.SimpleTriggerBean的方式，功能与TimerTask类似，好处在于不需要将注入的文件写出来，也就是因为这个原因，我搞了一天，才发现原因。要采用例子的方式，必须要加入。