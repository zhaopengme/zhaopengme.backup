title: 代码设计的几个基本原则【转载】
id: 73
categories: java
date: 2012-09-27 23:53:00
tags:
---

原文网址：[http://www.cnblogs.com/mailingfeng/archive/2012/09/13/2683246.html](http://www.cnblogs.com/mailingfeng/archive/2012/09/13/2683246.html "http://www.cnblogs.com/mailingfeng/archive/2012/09/13/2683246.html")
</br>

1.  **OCP(Open-Close Principle)开闭原则**
</br> Software entities should be open for extension,but closed for modification,(在设计一个模块的时候，应当使这个模块可以在不被修改的前提下扩展)。
</br> 对扩展开放open，对修改关闭close。
</br> 如何实现？
</br> 1.抽象化是关键
</br> 2.对可变性的封装原则(Principle of Encapsulation of Variation EVP)。
</br> 3.对可能的拓展预留接口
</br> 备注:
</br> 1) 对于抽象化, 我的理解是, 接口是相对稳定的, 实现是根据需求多变的. 对于大多数可能预料的变化点, 我们可以抽取出共性或者常态点, 进行接口的封装, 而选择不同的实现类嵌入模块, 从而达到可扩展的作用.
</br> 2) 对于某个业务点, 可能以后有多种介入处理的情况, 那么这时候可以将业务抽象成事件(event)接口和监听器(listener)接口, 不同的处理需求生成不同的listener, 接入模块的listener收集器, 从而得到业务点的介入机会. 最后达到功能的扩展.
</br> 典型容易理解的例子，工厂模式。当需要新增加一个类的时候，直接继承product接口就可以了 , 由工厂类来组装产生需要的product, 而不用大范围修改原有代码。OCP～

2.  **Liskov Subsitution Principle(LSP)里氏代换原则**
</br> 就是子类可以代替父类出现的任何地方，在抽象的时候，重要的要理解的一个地方两个类之间是什么关系，是“has-A”？还是“Is-a”的关系。在 “has-a”的关系中，两个类存在的是依赖的关系(在类A里面存在类B的的变量)；在“Is-a”的关系中，可以提取这两个类的“共同代码”放在抽象类 C中，然后A，B继承与C，这也是一种重构。

3.  **Dependency Inversion Principle(DIP)依赖倒转原则**
</br> 就是在我们编程的时候方法的参数类型，变量，对于其他具体类的依赖，我们尽量的使用抽象类 。 就是说尽量依赖于抽象，而不是依赖于实现。
</br> 在书中两种表述:
</br> (1)，Abstraction should not depend on details.details should depend on abstraction. (抽象不应当依赖于细节，细节应当依赖于抽象)。Abstraction就像是建筑物的基础，而其实现类就是在基础上面一层一层的往上面走。你拆掉最上面 那层，和拿走最下面的基础，有什么不同了，这就是差异了。所以Abstraction是要相当的稳定，是维护的重点。也正是因为稳定，所以我们尽量的依赖 于Abstraction，既是稳定系统，也是灵活系统。
</br> (2),Program to an Interface,not an implementation(要针对接口编程，不要针对实现编程) 应当使用java接口和抽象java类进行变量的类型声明，参数的类型声明，方法返回值的类型和数据类型的转换。
</br> 备注:
</br> 依赖倒转原则的作用在于多模块或者类间有统一的&quot;知识&quot;, 都知道有这个接口, 都知道这个接口是这样用,会返回什么数据.
</br> 至于最初的实现类是什么, 只有提供该接口功能的实现类自己关心, 其他模块或者类只管用就行了. 即使以后需求更改, 实现会换成别的一个, 其他模块和类也无需修改代码.
</br> 例如A模块提供了一个接口是: List getProducts()
</br> 而B和C会使用该模块, 他们只知道这个方法就会返回List , 他们知道List和Product代表什么.
</br> 但他们不会管你的接口内部是使用List list = new ArrayList() , 还是List lis = new LinkedList() 或者具体的Product是什么(可能是衣服,鞋子等)

4.  **Interface Segregation Principle(ISP)接口隔离原则**
</br> 限制一个实体对另一个实体通信时候的宽度。 就是一个类对另外一个类依赖的时候，应当是建立在最小的接口上面。对于接口隔离原则来说，有两种接口，一种是真正意义上面的“java 接口”Interface；另外一种是指一个类的方法的集合。对于这来两种有，两个接口隔离的原则，对于一个类里面的方法的集合的接口隔离，我们称作是 “角色隔离原则”；另外一种叫做“定制服务”。 定制服务，就是一个类，我给你这个客户端一些方法，我放在一个java接口(Interface)里面。给另外一个客户端另外一些方法，放在另外一个接口(Interface). 角色隔离原则，是指客户端要多个不同的类的方法，我们就搞几个不同类别的接口(Interface)，在书中，这么比喻的，就相当于电影剧本里面的人物，我们找人来演，这个人就是具体的类。这就叫做角色隔离原则。

5.  **Composition/Aggregation Reuse Principle(CARP)组合/聚合复用原则**
</br> 就是说要尽量的使用合成和聚合，而不是继承关系达到复用的目的。 其实这里最终要的地方就是区分“has-a”和“is-a”的区别。相对于合成和聚合，继承的缺点在于：父类的方法全部暴露给子类。父类如果发生变化，子类也得发生变化。聚合的复用的时候就对另外的类依赖的比较的少。

6.  **Least Knowledge Principle(LKP)最少知识原则，又称为“Law of Demeter”迪米特原则。**
</br> 和ISP接口隔离原则一样，限制类与类之间的通信。ISP限制的是宽度，而LoD迪米特原则限制的是通信的广度和深度。
</br> LoD在广度上面，尽量减少远距离类的关联，而使用与自己有关的类，并且也与远距离类有关的类。
</br> 可是这种做法有一点麻烦。多个远距离类产生关联的时候，不怎么容易处理，所以增加一个远距离类的抽象类。所有的远距离类都是通过抽象类的形式来访问。
</br> 在深度上面，控制权限是最重要的，对于类，一个是default 和public，尽量最小权限；对于成员，private，default，protected，public。往上面走，权限越小，依赖的耦合就越小。
</br> 有几种描述：
</br> (a)Only talk to your immediate friends.
</br> (b)Don't talk to strangers.
</br> 设计模式“facade”,&quot;调停者模式&quot;。在这里是IoD的典型表现。
</br> 备注:
</br> 当一个系统比较大的时候, 如果所有的模块都自己去寻找与自己相关的类的时候, 那么引用关系就会变得极度复杂, 耦合度高.
</br> 这个时候最好就设定一个为各个模块所熟悉的对象, 例如Context容器.
</br> 另外,各个模块可以应用facade模式, 提供一个简单的对外接口, 并将其嵌入Context容器.
</br> 这样, 模块间通过熟人Context来获取其他模块的Facade接口, 即符合依赖倒转原则, 接口隔离原则和迪米特原则.
