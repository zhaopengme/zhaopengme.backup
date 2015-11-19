title: 利用set去除list中的重复值
id: 236
categories:
  - java
date: 2010-09-27 22:39:20
tags:
---

<pre>
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
public class TestSet {
	public static void main(String[] args) {
		List list = new ArrayList();
		list.add(&quot;zhaopeng&quot;);
		list.add(&quot;zhaopeng&quot;);
		list.add(&quot;zhaopeng&quot;);
		list.add(&quot;momo&quot;);
		list.add(&quot;momo&quot;);
		list.add(&quot;momo&quot;);
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			String object = (String) iterator.next();
			System.err.println(object);
		}
		System.err.println(&quot;----------------------&quot;);
		List newList = TestSet.removeList(list);
		for (Iterator iterator = newList.iterator(); iterator.hasNext();) {
			String object = (String) iterator.next();
			System.err.println(object);
		}
	}
	public static List removeList(List list) {
		Set someList = new HashSet(list);
		List newList = new ArrayList();
		for (Iterator iterator = someList.iterator(); iterator.hasNext();) {
			Object object = (Object) iterator.next();
			newList.add(object);
		}
		return newList;
	}
}
</pre>