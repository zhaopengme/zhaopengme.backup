title: mysql建表设置两个默认CURRENT_TIMESTAMP的技巧
id: 97
categories: 闲言碎语
date: 2012-06-23 14:39:42
tags:
---

业务场景:

例如用户表,我们需要建一个字段是创建时间, 一个字段是更新时间.

解决办法可以是指定插入时间,也可以使用数据库的默认时间.

在mysql中如果设置两个默认CURRENT_TIMESTAMP,会出现这样的错误.
 ERROR 1293 (HY000): Incorrect table definition; there can be only one TIMESTAMP column with CURRENT_TIMESTAMP in DEFAULT or ON UPDATE clause.

错误的建表语句:
 CREATE TABLE `db1`.`sms_queue` (
</br> &nbsp; `Id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
</br> &nbsp; `Message` VARCHAR(160) NOT NULL DEFAULT 'Unknown Message Error',
</br> &nbsp; `CurrentState` VARCHAR(10) NOT NULL DEFAULT 'None',
</br> &nbsp; `Phone` VARCHAR(14) DEFAULT NULL,
</br> &nbsp; `Created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
</br> &nbsp; `LastUpdated` TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP,
</br> &nbsp; `TriesLeft` tinyint NOT NULL DEFAULT 3,
</br> &nbsp; PRIMARY KEY (`Id`)
</br> )
</br> ENGINE = InnoDB;

解决办法,可以使用触发器或者其他,在此还是使用数据库的方式.

建表语句:
 create table test_table(
</br> &nbsp; id integer not null auto_increment primary key,
</br> &nbsp; stamp_created timestamp default '0000-00-00 00:00:00',
</br> &nbsp; stamp_updated timestamp default now() on update now()
</br> );

测试:
<pre><span>mysql</span><span>&gt;</span><span> </span><span>insert</span><span> </span><span>into</span><span> test_table</span><span>(</span><span>stamp_created</span><span>,</span><span> stamp_updated</span><span>)</span><span> </span><span>values</span><span>(</span><span>null</span><span>,</span><span> </span><span>null</span><span>);</span><span>
Query OK</span><span>,</span><span> </span><span>1</span><span> row affected </span><span>(</span><span>0.06</span><span> sec</span><span>)</span><span>

mysql</span><span>&gt;</span><span> </span><span>select</span><span> </span><span>*</span><span> </span><span>from</span><span> t5</span><span>;</span><span>
</span><span>+</span><span>----+---------------------+---------------------+ </span><span>
</span><span>|</span><span> id </span><span>|</span><span> stamp_created       </span><span>|</span><span> stamp_updated       </span><span>|</span><span>
</span><span>+</span><span>----+---------------------+---------------------+</span><span>
</span><span>|</span><span>  </span><span>2</span><span> </span><span>|</span><span> </span><span>2009-04-30</span><span> </span><span>09</span><span>:</span><span>44</span><span>:</span><span>35</span><span> </span><span>|</span><span> </span><span>2009-04-30</span><span> </span><span>09</span><span>:</span><span>44</span><span>:</span><span>35</span><span> </span><span>|</span><span>
</span><span>+</span><span>----+---------------------+---------------------+</span><span>
</span><span>2</span><span> rows </span><span>in</span><span> </span><span>set</span><span> </span><span>(</span><span>0.00</span><span> sec</span><span>)</span><span>

mysql</span><span>&gt;</span><span> </span><span>update</span><span> test_table </span><span>set</span><span> id </span><span>=</span><span> </span><span>3</span><span> </span><span>where</span><span> id </span><span>=</span><span> </span><span>2</span><span>;</span><span>
Query OK</span><span>,</span><span> </span><span>1</span><span> row affected </span><span>(</span><span>0.05</span><span> sec</span><span>)</span><span> Rows matched</span><span>:</span><span> </span><span>1</span><span>  Changed</span><span>:</span><span> </span><span>1</span><span>  Warnings</span><span>:</span><span> </span><span>0</span><span>

mysql</span><span>&gt;</span><span> </span><span>select</span><span> </span><span>*</span><span> </span><span>from</span><span> test_table</span><span>;</span><span>
</span><span>+</span><span>----+---------------------+---------------------+</span><span>
</span><span>|</span><span> id </span><span>|</span><span> stamp_created       </span><span>|</span><span> stamp_updated       </span><span>|</span><span>
</span><span>+</span><span>----+---------------------+---------------------+ </span><span>
</span><span>|</span><span>  </span><span>3</span><span> </span><span>|</span><span> </span><span>2009-04-30</span><span> </span><span>09</span><span>:</span><span>44</span><span>:</span><span>35</span><span> </span><span>|</span><span> </span><span>2009-04-30</span><span> </span><span>09</span><span>:</span><span>46</span><span>:</span><span>59</span><span> </span><span>|</span><span>
</span><span>+</span><span>----+---------------------+---------------------+ </span><span>
</span><span>2</span><span> rows </span><span>in</span><span> </span><span>set</span><span> </span><span>(</span><span>0.00</span><span> sec</span><span>)</span><span> </span></pre> 解决办法是在stackoverflow看到的,原文网址:

[http://stackoverflow.com/questions/267658/having-both-a-created-and-last-updated-timestamp-columns-in-mysql-4-0](http://stackoverflow.com/questions/267658/having-both-a-created-and-last-updated-timestamp-columns-in-mysql-4-0)
