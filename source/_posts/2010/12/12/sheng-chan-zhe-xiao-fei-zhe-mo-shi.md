title: 生产者消费者模式
id: 209
categories: java
date: 2010-12-12 17:38:52
tags:
---

用两种方式实现
</br>第一种，使用timertask实现，timertask，可以比较精确的实现定时任务。
</br>_在这里插一句，java的实时性是很差的，timertask也就是大概的可以实现_
</br>看代码：
</br>Producer.java
</br><pre>
package me.dapeng.timer;
import java.util.concurrent.LinkedBlockingQueue;
public class Producer extends Thread {
	private LinkedBlockingQueue queue;
	public Producer(LinkedBlockingQueue queue) {
		this.queue = queue;
	}
	@Override
	public void run() {
		int i = 0;
		while (true) {
			queue.offer(&quot;string&quot; + i);
			// System.err.println(&quot;[Producer]queue size:&quot; + queue.size());
			i++;
		}
	}
}
</pre>
</br>Consumer.java
</br><pre>
package me.dapeng.timer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimerTask;
import java.util.concurrent.LinkedBlockingQueue;
public class Consumer extends TimerTask {
	private LinkedBlockingQueue queue;
	public Consumer(LinkedBlockingQueue queue) {
		this.queue = queue;
	}
	@Override
	public void run() {
		SimpleDateFormat formatter = new SimpleDateFormat(&quot;yyyy-MM-dd HH:mm:ss&quot;);
		String date = formatter.format(new Date());
		int size = queue.size();
		try {
			if (size &gt; 0) {
				String str = (String) queue.poll();
				System.err.println(date + &quot;-&quot; + str);
			} else {
				Thread.sleep(1000);
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
</pre>
</br>TestPoll.java
</br><pre>
package me.dapeng.timer;
import java.util.Timer;
import java.util.concurrent.LinkedBlockingQueue;
public class TestPoll {
	private final static LinkedBlockingQueue queue = new LinkedBlockingQueue(1000);
	public static void main(String[] args) {
		Producer producer = new Producer(queue);
		producer.start();
		Consumer consumer = new Consumer(queue);
		Timer timer = new Timer();
		timer.schedule(consumer, 2000, 1000);
	}
}
</pre>
</br>第二种方式
</br>Producer.java
</br><pre>
package me.dapeng.poll;
import java.util.concurrent.LinkedBlockingQueue;
public class Producer extends Thread {
	private LinkedBlockingQueue queue;
	public Producer(LinkedBlockingQueue queue) {
		this.queue = queue;
	}
	@Override
	public void run() {
		int i = 0;
		while (true) {
			queue.offer(&quot;string&quot; + i);
			// System.err.println(&quot;[Producer]queue size:&quot; + queue.size());
			i++;
		}
	}
}
</pre>
</br>Consumer.java
</br><pre>
package me.dapeng.poll;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;
public class Consumer extends Thread {
	private LinkedBlockingQueue queue;
	public Consumer(LinkedBlockingQueue queue) {
		this.queue = queue;
	}
	@Override
	public void run() {
		SimpleDateFormat formatter = new SimpleDateFormat(&quot;yyyy-MM-dd HH:mm:ss&quot;);
		int i = 0;
		while (true) {
			String date = formatter.format(new Date());
			int size = queue.size();
			try {
				if (size &gt; 0) {
					String str = (String) queue.poll(1, TimeUnit.SECONDS);
					System.err.println(str);
				} else {
					Thread.sleep(1000);
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			i++;
		}
	}
}
</pre>
</br>TestPoll.java
</br><pre>
package me.dapeng.poll;
import java.util.concurrent.LinkedBlockingQueue;
public class TestPoll {
	private final static LinkedBlockingQueue queue = new LinkedBlockingQueue(1000);
	public static void main(String[] args) {
		Producer producer = new Producer(queue);
		producer.start();
		Consumer consumer = new Consumer(queue);
		consumer.start();
	}
}
</pre>
</br>_
</br>其实这两种方式，都是同样的代码，仅仅是换用了timertask和while(true)，重点还是用了queue，只是为了和我们老大证明queue.pool的使用方式而已。
</br>_
