title: 代码优化实例-Java用JDBC批处理插入
id: 102
categories:
  - java
date: 2012-03-23 13:53:59
tags:
---

[![](http://m3.img.libdd.com/farm4/2012/0821/18/69F5D0CAE9A40222867C8CFC642CC4CE865DE15EF698_447_270.JPEG)</img>](http://dapeng.me/wp-content/uploads/2012/03/2012032301.jpg)

代码的使用性很强的啊！

&nbsp;

让我们看看如何使用JDBC API在Java中执行批量插入。虽然你可能已经知道，但我会尽力解释基础到复杂的场景。

在此笔记里，我们将看到我们如何可以使用像Statement和PreparedStatement JDBC API来批量在任何数据库中插入数据。此外，我们将努力探索一些场景，如在内存不足时正常运行，以及如何优化批量操作。

首先，使用Java JDBC基本的API批量插入数据到数据库中。

#### Simple Batch - 简单批处理

我把它叫做简单批处理。要求很简单，执行批量插入列表，而不是为每个INSERT语句每次提交数据库，我们将使用JDBC批处理操作和优化性能。

想想一下下面的代码：

##### Bad Code
<pre>[java]	String [] queries = {
		    insert into employee (name, city, phone) values ('A', 'X', '123'),
		    insert into employee (name, city, phone) values ('B', 'Y', '234'),
		    insert into employee (name, city, phone) values ('C', 'Z', '345'),
		};
		Connection connection = new getConnection();
		Statement statemenet = connection.createStatement();
		for (String query : queries) {
		    statemenet.execute(query);
		}
		statemenet.close();
		connection.close(); [/java]</pre>
</br>

这是糟糕的代码。它单独执行每个查询，每个INSERT语句的都提交一次数据库。考虑一下，如果你要插入1000条记录呢？这是不是一个好主意。

</br>

&nbsp;

</br>

下面是执行批量插入的基本代码。来看看：

</br>

##### Good Code

</br><pre>[java]
 	 Connection connection = new getConnection();
	 Statement statemenet = connection.createStatement();
	 for (String query : queries) {
	     statemenet.addBatch(query);
	 }
	 statemenet.executeBatch();
	 statemenet.close();
	 connection.close();
[/java]</pre>
</br>

请注意我们如何使用addBatch（）方法，而不是直接执行查询。然后，加入所有的查询，我们使用statement.executeBatch（）方法一次执行他们。没有什么花哨，只是一个简单的批量插入。

</br>

&nbsp;

</br>

请注意，我们已经从一个String数组构建了查询。现在，你可能会想，使其动态化。例如：

</br><pre>[java]
	import java.sql.Connection;
	import java.sql.Statement;
	//...
	Connection connection = new getConnection();
	Statement statemenet = connection.createStatement();
	for (Employee employee: employees) {
	    String query = &amp;quot;insert into employee (name, city) values('
	            + employee.getName() + ',' + employee.getCity + ');
	    statemenet.addBatch(query);
	}
	statemenet.executeBatch();
	statemenet.close();
	connection.close();
[/java]</pre>
</br>

请注意我们是如何从Employee对象中的数据动态创建查询并在批处理中添加，插入一气呵成。完美！是不是？

</br>

等等......你必须思考什么关于SQL注入？这样动态创建的查询SQL注入是很容易的。并且每个插入查询每次都被编译。

</br>

&nbsp;

</br>

为什么不使用PreparedStatement而不是简单的声明。是的，这是个解决方案。下面是SQL注入安全批处理。

</br>

#### SQL Injection Safe Batch - SQL注入安全批处理

</br>

思考一下下面代码:

</br><pre>[java] import java.sql.Connection;
import java.sql.PreparedStatement;
//...
String sql = &amp;quot;insert into employee (name, city, phone) values (?, ?, ?);;
Connection connection = new getConnection();
PreparedStatement ps = connection.prepareStatement(sql);
for (Employee employee: employees) {
    ps.setString(1, employee.getName());
    ps.setString(2, employee.getCity());
    ps.setString(3, employee.getPhone());
    ps.addBatch();
}
ps.executeBatch();
ps.close();
connection.close();[/java]</pre>
</br>

&nbsp;

</br>

看看上面的代码。漂亮。我们使用的java.sql.PreparedStatement和在批处理中添加INSERT查询。这是你必须实现批量插入逻辑的解决方案，而不是上述Statement那个。

</br>

这一解决方案仍然存在一个问题。考虑这样一个场景，在您想要插入到数据库使用批处理半万条记录。嗯，可能产生的OutOfMemoryError：

</br><pre>[java] java.lang.OutOfMemoryError: Java heap space
    com.mysql.jdbc.ServerPreparedStatement$BatchedBindValues.&lt;init&gt;(ServerPreparedStatement.java:72)
    com.mysql.jdbc.ServerPreparedStatement.addBatch(ServerPreparedStatement.java:330)
    org.apache.commons.dbcp.DelegatingPreparedStatement.addBatch(DelegatingPreparedStatement.java:171)[/java]</pre>
</br>

&nbsp;

</br>

这是因为你试图在一个批次添加所有语句，并一次插入。最好的办法是将执行分批次。看看下面的解决方案

</br>

#### Smart Insert: Batch within Batch - 智能插入：将整批分批

</br>

这是一个简单的解决方案。考虑批量大小为1000，每1000个查询语句为一批插入提交。

</br><pre>[java] String sql = &amp;quot;insert into employee (name, city, phone) values (?, ?, ?);
Connection connection = new getConnection();
PreparedStatement ps = connection.prepareStatement(sql);

final int batchSize = 1000;
int count = 0;

for (Employee employee: employees) {

    ps.setString(1, employee.getName());
    ps.setString(2, employee.getCity());
    ps.setString(3, employee.getPhone());
    ps.addBatch();

    if(++count % batchSize == 0) {
        ps.executeBatch();
    }
}
ps.executeBatch(); // insert remaining records
ps.close();
connection.close();[/java]</pre>
</br>

这才是理想的解决方案，它避免了SQL注入和内存不足的问题。看看我们如何递增计数器计数，一旦BATCHSIZE 达到 1000，我们调用executeBatch（）提交。

</br>

希望对你有帮助。

</br>

来源：[英文原文](http://viralpatel.net/blogs/2012/03/batch-insert-in-java-jdbc.html)&nbsp; 中文编译：[IT瘾](http://itindex.net/)[原文链接](http://itindex.net/blog/2012/03/07/1331084887812.html)