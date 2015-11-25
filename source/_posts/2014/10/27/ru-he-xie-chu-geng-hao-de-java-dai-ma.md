title: 如何写出更好的Java代码
tags:
  - java
  - 架构
  - 编程
  - 设计
categories: java
date: 2014-10-27 06:18:21
---

from: [http://it.deepinmind.com/java/2014/05/21/better-java.html](http://it.deepinmind.com/java/2014/05/21/better-java.html)

Java是最流行的编程语言之一，但似乎并没有人喜欢使用它。好吧，实际上Java是一门还不错的编程语言，由于最近Java 8发布了，我决定来编辑一个如何能更好地使用Java的列表，这里面包括一些库，实践技巧以及工具。

这篇文章在[GitHub](https://github.com/cxxr/better-java)上也有。你可以随时在上面贡献或者添加你自己的Java使用技巧或者最佳实践。

*   编码风格

    *   结构体

            *   builder模式

        *   依赖注入
    *   避免null值
    *   不可变
    *   避免过多的工具类
    *   格式

            *   文档
        *   Stream

*   部署

    *   框架
    *   Maven

            *   依赖收敛

        *   持续集成
    *   Maven仓储
    *   配置管理

*   库

    *   遗失的特性

            *   Apache Commons
        *   Guava
        *   Gson
        *   Java Tuples
        *   Joda-Time
        *   Lombok
        *   Play framework
        *   SLF4J
        *   jOOQ

        *   测试

            *   jUnit 4
        *   jMock
        *   AssertJ

*   工具

    *   IntelliJ IDEA

            *   Chronon

        *   JRebel
    *   校验框架
    *   Eclipse Memory Analyzer

*   资源

    *   书籍
    *   播客

### 编码风格

传统的Java编码方式是非常啰嗦的企业级JavaBean的风格。新的风格更简洁准确，对眼睛也更好。

#### 结构体

我们这些码农干的最简单的事情就是传递数据了。传统的方式就是定义一个JavaBean:
<div>
<pre>public class DataHolder {
    private String data;

    public DataHolder() {
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getData() {
        return this.data;
    }
}</pre>
</div>
这不仅拖沓而且浪费。尽管你的IDE可以自动地生成这个，但这还是浪费。因此，[不要这么写](http://www.javapractices.com/topic/TopicAction.do?Id=84)。

相反的，我更喜欢C的结构体的风格，写出来的类只是包装数据：
<div>
<pre>public class DataHolder {
    public final String data;

    public DataHolder(String data) {
        this.data = data;
    }
}</pre>
</div>
这样写减少了一半的代码。不仅如此，除非你继承它，不然这个类是不可变的，由于它是不可变的，因此推断它的值就简单多了。

如果你存储的是Map或者List这些可以容易被修改的数据，你可以使用ImmutableMap或者ImmutableList，这个在不可变性这节中会有讨论。

#### Builder模式

如果你有一个相对复杂的对象，可以考虑下Builder模式。

你在对象里边创建一个子类，用来构造你的这个对象。它使用的是可修改的状态，但一旦你调用了build方法，它会生成一个不可变对象。

想象一下我们有一个非常复杂的对象DataHolder。它的构造器看起来应该是这样的：
<div>
<pre>public class ComplicatedDataHolder {
    public final String data;
    public final int num;
    // lots more fields and a constructor

    public class Builder {
        private String data;
        private int num;

        public Builder data(String data) {
            this.data = data;
            return this;
        }

        public Builder num(int num) {
            this.num = num;
            return this;
        }

        public ComplicatedDataHolder build() {
            return new ComplicatedDataHolder(data, num); // etc
        }
    }
}</pre>
</div>
现在你可以使用它了：
<div>
<pre>final ComplicatedDataHolder cdh = new ComplicatedDataHolder.Builder()
    .data("set this")
    .num(523)
    .build();</pre>
</div>
关于Builder的使用[这里](http://en.deepinmind.com/blog/2014/05/21/the-builder-pattern-in-practice.html)还有些更好的例子，我这里举的例子只是想让你大概感受一下。当然这会产生许多我们希望避免的样板代码，不过好处就是你有了一个不可变对象以及一个连贯接口。

#### 依赖注入

这更像是一个软件工程的章节而不是Java的，写出可测的软件的一个最佳方式就是使用依赖注入（Dependency injection，DI）。由于Java强烈鼓励使用面向对象设计 ，因此想写出可测性强的软件，你需要使用DI。

在Java中，这个通常都是用Spring框架来完成的。它有一个基于XML配置的绑定方式，并且仍然相当流行。重要的一点是你不要因为它的基于XML的配置格式而过度使用它了。在XML中应该没有任何的逻辑和控制结构。它只应该是依赖注入。

还有一个不错的方式是使用[Dagger库](http://square.github.io/dagger/)以及Google的[Guice](https://code.google.com/p/google-guice/)。它们并没有使用Spring的XML配置文件的格式，而是将注入的逻辑放到了注解和代码里。

#### 避免null值

如果有可能的话尽量避免使用null值。你可以返回一个空的集合，但不要返回null集合。如果你准备使用null的话，考虑一下@Nullable注解。IntelliJ IDEA对于@Nullable注解有内建的支持。

如果你使用的是Java 8的话，可以考虑下新的Optional类型。如果一个值可能存在也可能不存在，把它封装到Optional类里面，就像这样：
<div>
<pre>public class FooWidget {
    private final String data;
    private final Optional&lt;Bar&gt; bar;

    public FooWidget(String data) {
        this(data, Optional.empty());
    }

    public FooWidget(String data, Optional&lt;Bar&gt; bar) {
        this.data = data;
        this.bar = bar;
    }

    public Optional&lt;Bar&gt; getBar() {
        return bar;
    }
}</pre>
</div>
现在问题就清楚了，data是不会为null的，而bar可能为空。Optional类有一些像isPresent这样的方法，这让它感觉跟检查null没什么区别。不过有了它你可以写出这样的语句：
<div>
<pre>final Optional&lt;FooWidget&gt; fooWidget = maybeGetFooWidget();
final Baz baz = fooWidget.flatMap(FooWidget::getBar)
                         .flatMap(BarWidget::getBaz)
                         .orElse(defaultBaz);</pre>
</div>
这比使用if来检查null好多了。唯一的缺点就是标准类库中对Optional的支持并不是很好，因此你还是需要对null进行检查的。

#### 不可变

变量，类，集合，这些都应该是不可变的，除非你有更好的理由它们的确需要进行修改。

变量可以通过final来设置成不可变的：
<div>
<pre>final FooWidget fooWidget;
if (condition()) {
    fooWidget = getWidget();
} else {
    try {
        fooWidget = cachedFooWidget.get();
    } catch (CachingException e) {
        log.error("Couldn't get cached value", e);
        throw e;
    }
}
// fooWidget is guaranteed to be set here</pre>
</div>
现在你可以确认fooWidget不会不小心被重新赋值了。final关键字可以和if/else块以及try/catch块配合使用。当然了，如果fooWidget对象不是不可变的，你也可以很容易地对它进行修改。

有可能的话，集合都应该尽量使用Guava的ImmutableMap, ImmutableList, or ImmutableSet类。这些类都有自己的构造器，你可以动态的创建它们，然后将它们设置成不可变的，。

要使一个类不可变，你可以将它的字段声明成不可变的（设置成final)。你也可以把类自身也设置成final的这样它就不能被扩展并且修改了，当然这是可选的。

#### 避免大量的工具类

如果你发现自己添加了许多方法到一个Util类里，你要注意了。
<div>
<pre>public class MiscUtil {
    public static String frobnicateString(String base, int times) {
        // ... etc
    }

    public static void throwIfCondition(boolean condition, String msg) {
        // ... etc
    }
}</pre>
</div>
这些类乍一看挺吸引人的，因为它们里面的这些方法不属于任何一个地方。因此你以代码重用之名将它们全都扔到这里了。

这么解决问题结果更糟。把它们放回它们原本属于的地方吧，如果你确实有一些类似的常用方法，考虑下Java 8里接口的默认方法。并且由于它们是接口，你可以实现多个方法。
<div>
<pre>public interface Thrower {
    public void throwIfCondition(boolean condition, String msg) {
        // ...
    }

    public void throwAorB(Throwable a, Throwable b, boolean throwA) {
        // ...
    }
}</pre>
</div>
这样需要使用它的类只需简单的实现下这个接口就可以了。

#### 格式

格式远比许多程序员相像的要重要的多。一致的格式说明你关注自己的代码或者对别人有所帮助？是的。不过你先不要着急为了让代码整齐点而浪费一整天的时间在那给if块加空格了。

如果你确实需要一份代码格式规范，我强烈推荐Google的[Java风格指南](http://google-styleguide.googlecode.com/svn/trunk/javaguide.html)。这份指南最精彩的部分就是[编程实践](http://google-styleguide.googlecode.com/svn/trunk/javaguide.html#s6-programming-practices)这节了。非常值得一读。

#### 文档

面向用户的代码编写下文档还是很重要的。这意味着你需要提供一些[使用的示例](http://docs.guava-libraries.googlecode.com/git-history/release/javadoc/com/google/common/collect/ImmutableMap.Builder.html)，同时你的变量方法和类名都应该有适当的描述信息。

结论就是不要给不需要文档的地方添加文档。如果对于某个参数你没什么可说的，或者它已经非常明显了，别写文档了。模板化的文档比没有文档更糟糕，因为它欺骗了你的用户，让他觉得这里有文档。

#### 流

Java 8有一个漂亮的流和lambda表达式的语法。你的代码可以这么写：
<div>
<pre>final List&lt;String&gt; filtered = list.stream()
    .filter(s -&gt; s.startsWith("s"))
    .map(s -&gt; s.toUpperCase());</pre>
</div>
而不是这样：
<div>
<pre>final List&lt;String&gt; filtered = Lists.newArrayList();
for (String str : list) {
    if (str.startsWith("s") {
        filtered.add(str.toUpperCase());
    }
}</pre>
</div>
这样你能写出更连贯的代码，可读性也更强。

### 部署

正确地部署Java程序还是需要点技巧的。现在部署Java代码的主流方式有两种 ：使用框架或者使用自家摸索出来的解决方案，当然那样更灵活。

#### 框架

由于部署Java程序并不容易，因此才有了各种框架来用于部署。最好的两个是[Dropwizard](https://dropwizard.github.io/dropwizard/)以及[Spring Boot](http://projects.spring.io/spring-boot/)。[Play Framework](http://www.playframework.com/)也可以算是一个部署框架。

这些框架都试图降低部署程序的门槛。如果你是一个Java的新手或者你需要快速把事情搞定的话，那么框架就派上用场了。单个jar的部署当然会比复杂的WAR或者EAR部署要更容易一些。

然而，这些框架的灵活性不够，并且相当顽固，因此如果这些框架的开发人员给出的方式不太适合你的项目的话，你只能自己进行配置了。

#### Maven

备选方案：[Gradle](http://www.gradle.org/)。

Maven仍然是编译，打包，运行测试的标准化工具。还有其它一些选择，比如Gradle，不过它们的采用程度远不Maven。如果你之前没用过Maven，你可以看下这个[Maven的使用示例](http://books.sonatype.com/mvnex-book/reference/index.html)。

我喜欢用一个根POM文件来包含所有的外部依赖。它看起来就像是[这样](https://gist.github.com/cxxr/10787344)。这个根POM文件只有一个外部依赖，不过如果你的产品很大的话，你可能会有很多依赖。你的根POM文件自己就应该是一个项目：它有版本控制，并且和其它的Java项目一样进行发布。

如果你觉得为每个外部依赖的修改都给POM文件打个标签（tag)有点太浪费了，那是你还没有经历过花了一个星期的时间来跟踪项目依赖错误的问题。

你的所有Maven工程都应该包含你的主POM文件以及所有的版本信息。这样的话，你能知道公司项目的每个外部依赖所选择的版本，以及所有正确的Maven插件。如果你需要引入一个外部依赖的话，大概是这样的：
<div>
<pre>&lt;dependencies&gt;
    &lt;dependency&gt;
        &lt;groupId&gt;org.third.party&lt;/groupId&gt;
        &lt;artifactId&gt;some-artifact&lt;/artifactId&gt;
    &lt;/dependency&gt;
&lt;/dependencies&gt;</pre>
</div>
如果你需要进行内部依赖的话，应该在项目的段中单独进行维护。不然的话，主POM文件的版本号就要疯涨了。

#### 依赖收敛

Java的一个最好的地方就是有大量的第三方库，它们无所不能。几乎每个API或者工具都有相应的Java SDK，并且可以很容易地引入到Maven中来。

所有的这些Java库自身可能又会依赖一些特定的版本的其它类库。如果你引入了大量的库，可能会出现版本冲突 ，比如说像这样：
<div>
<pre>Foo library depends on Bar library v1.0
Widget library depends on Bar library v0.9</pre>
</div>
你的工程应该引入哪个版本？

有了Maven的依赖收敛的插件后，如果你的依赖版本不一致的话，编译的时候就会报错。那么你有两种解决冲突的方案：

*   在dependencyManagement区中显式地选择某个版本的bar。
*   Foo或者Widget都不要依赖Bar。
到底选择哪种方案取决你的具体情况： 如果你想要跟踪某个工程的版本，不依赖它是最好的。另一方面，如果你想要明确一点，你可以自己选择一个版本，不过这样的话，如果更新了其它的依赖，也得同步地修改它。

### 持续集成

很明显你需要某种持续集成的服务器来不断地编译你的SNAPSHOT版本，或者对Git分支进行构建。

[Jenkins](http://jenkins-ci.org/)和[Travis-CI](https://travis-ci.org/)是你的不二选择。

代码覆盖率也很重要，[Cobertura](http://cobertura.github.io/cobertura/)有一个不错的Maven插件，并且对CI支持的也不错。当然还有其它的代码覆盖的工具，不过我用的是Cobertura。

### Maven库

你需要一个地方来存储你编译好的jar包，war包，以及EAR包，因此你需要一个代码仓库。

常见的选择是[Artifactory](http://www.jfrog.com/)或者[Nexus](http://www.sonatype.com/nexus)。两个都能用，并且各有利弊。

你应该自己进行Artifactory/Nexus的安装并且将你的依赖做一份镜像。这样不会由于下载Maven 库的时候出错了导到编译中断。

#### 配置管理

那现在你的代码可以编译了，仓库也搭建起来了，你需要把你的代码带出开发环境，走向最终的发布了。别马虎了，因为自动化执行从长远来看，好处是大大的。

[Chef](http://www.getchef.com/chef/)，[Puppet](http://puppetlabs.com/)，和[Ansible](http://www.ansible.com/home)都是常见的选择。我自己也写了一个可选方案，[Squadron](http://www.gosquadron.com/)。这个嘛，当然了，我自然是希望你们能下载下它的，因为它比其它那些要好用多了。

不管你用的是哪个工具，别忘了自动化部署就好。

### 库

可能Java最好的特性就是它拥有的这些库了。下面列出了一些库，应该绝大多数人都会用得上。

Java的标准库，曾经还是很不错的，但在现在看来它也遗漏掉了很多关键的特性。

#### Apache Commons

[Apache Commons项目](http://commons.apache.org/)有许多有用的功能。

*   Commons Codec有许多有用的Base64或者16进制字符串的编解码的方法。别浪费时间自己又写一遍了。
*   Commons Lang是一个字符串操作，创建，字符集，以及许多工具方法的类库。
*   Commons IO，你想要的文件相关的方法都在这里了。它有FileUtils.copyDirectory，FileUtils.writeStringToFile, IOUtils.readLines，等等。

#### Guava

Guava是一个非常棒的库，它就是Java标准库"所缺失的那部分"。它有很多我喜欢的地方，很难一一赘述，不过我还是想试一下。

*   Cache，这是一个最简单的获取内存缓存的方式了，你可以用它来缓存网络访问，磁盘访问，或者几乎所有东西。你只需实现一个CacheBuilder，告诉Guava如何创建缓存就好了。
*   不可变集合。这里有许多类：ImmutableMap, ImmutableList，甚至还有ImmutableSortedMultiSet，如果这就是你想要的话。
我还喜欢用Guava的方式来新建可变集合：
<div>
<pre>// Instead of
final Map&lt;String, Widget&gt; map = new HashMap&lt;String, Widget&gt;();

// You can use
final Map&lt;String, Widget&gt; map = Maps.newHashMap();</pre>
</div>
有许多像Lists, Maps, Sets的静态类，他们都更简洁易懂一些。

如果你还在坚持使用Java 6或者7的话，你可以用下[Collections2](http://docs.guava-libraries.googlecode.com/git-history/release/javadoc/com/google/common/collect/Collections2.html)，它有一些诸如filter和transform的方法。没有Jvaa 8的stream的支持，你也可以用它们来写出连贯的代码。

Guava也有一些很简单的东西，比如Joiner，你可以用它来拼接字符串，还有一个类可以用来[处理中断](http://docs.guava-libraries.googlecode.com/git-history/release/javadoc/com/google/common/util/concurrent/Uninterruptibles.html)。

#### Gson

Google的[Gson](https://code.google.com/p/google-gson/)是一个简单高效的JSON解析库。它是这样工作的：
<div>
<pre>final Gson gson = new Gson();
final String json = gson.toJson(fooWidget);

final FooWidget newFooWidget = gson.fromJson(json, FooWidget.class);</pre>
</div>
真的很简单，使用它会感觉非常愉快。Gson的[用户指南](https://sites.google.com/site/gson/gson-user-guide)中有更多的示例。

#### Java Tuples

我对Java一个不爽的地方就是它的标准库中居然没有元组。幸运的是， [Java tuples工程](http://www.javatuples.org/)解决了这一问题。

它也很容易使用，并且真的很赞：
<div>
<pre>Pair&lt;String, Integer&gt; func(String input) {
    // something...
    return Pair.with(stringResult, intResult);
}</pre>
</div>

#### Joda-Time

Joda-Time是我用过的最好的时间库了。简直，直接，容易测试。你还想要什么？

这个库里我最喜欢的一个类就是Duration，因为我用它来告诉说我要等待多长时间，或者过多久我才进行重试。

#### Lombok

[Lombok](http://projectlombok.org/)是一个非常有趣的库。它通过注释来减少了Java中的饱受诟病的样板代码（注：setter,getter之类的）。

想给你类中的变量增加setter， getter方法？太简单了：
<div>
<pre>public class Foo {
    @Getter @Setter private int var;
}</pre>
</div>
现在你可以这么写了：
<div>
<pre>final Foo foo = new Foo();
foo.setVar(5);</pre>
</div>
[这里](http://jnb.ociweb.com/jnb/jnbJan2010.html)还有更多的示例。我还没在生产代码中用过Lombok，不过我有点等不及了。

#### Play框架

备选方案：[Jersey](https://jersey.java.net/)或者[Spark](http://www.sparkjava.com/)

在Java中实现REST风格的WEB服务有两大阵营：[JAX-RS](http://en.wikipedia.org/wiki/Java_API_for_RESTful_Web_Services)和其它。

JAX-RS是传统的方式。你使用像Jersey这样的东西来将注解和接口，实现组合到一起来实现WEB服务。这样做的好处就是，你可以通过一个接口就能很容易创建出一个调用的客户端来。

Play框架是在JVM上实现WEB服务的截然不同的一种方式：你有一个routes文件，然后你去实现routes中那些规则所引用到的类。它其实就是个完整的MVC框架，不过你可以只用它来实现REST服务。

它同时支持Java和Scala。它优先使用Scala这点可能有点令人沮丧，但是用Java进行开发的话也非常不错。

如果你习惯了Python里的Flask这类的微框架，那么你应该会对Spark感到很熟悉。有了Java 8它简直如虎添翼。

#### SLF4J

Java打印日志有许多不错的解决方案。我个人最喜欢的是SLF4J，因为它是可挺插拔的，并且可以同时混合不同的日志框架中输出的日志。有个奇怪的工程同时使用了java.util.logging, JCL, 和log4j？没问题，SLF4J就是为它而生的。

想入门的话，看下它的这个[两页的手册](http://www.slf4j.org/manual.html)就足够的了。

#### jOOQ

我不喜欢很重的ORM框架，因为我喜欢SQL。因此我写了许多的JDBC模板，但它们很难维护。jOOQ是个更不错的解决方案。

你可以在Java中以一种类型安全的方式来书写SQL语句：
<div>
<pre>// Typesafely execute the SQL statement directly with jOOQ
Result&lt;Record3&lt;String, String, String&gt;&gt; result =
create.select(BOOK.TITLE, AUTHOR.FIRST_NAME, AUTHOR.LAST_NAME)
    .from(BOOK)
    .join(AUTHOR)
    .on(BOOK.AUTHOR_ID.equal(AUTHOR.ID))
    .where(BOOK.PUBLISHED_IN.equal(1948))
    .fetch();</pre>
</div>
将它以及[DAO模式](http://www.javapractices.com/topic/TopicAction.do?Id=66)结合起来，你可以让数据库访问变得更简单。

### 测试

测试对软件来说至关重要。下面这些库能让测试变得更加容易。

#### jUnit 4

jUnit就不用介绍了。它是Java中单元测试的标准工具。

不过可能你还没有完全发挥jUnit的威力。jUnit还支持参数化测试，以及能让你少写很多样板代码的[测试规则](https://github.com/junit-team/junit/wiki/Rules)，还有能随机测试代码的[Theory](https://github.com/junit-team/junit/wiki/Theories),以及[Assumptions](https://github.com/junit-team/junit/wiki/Assumptions-with-assume)。

#### jMock

如果你已经完成了依赖注入，那么它回报你的时候来了：你可以mock出带副作用的代码（就像和REST服务器通信那样），并且仍然能对调用它的代码执行断言操作。

jMock是Java中标准的mock工具。它的使用方式是这样的：
<div>
<pre>public class FooWidgetTest {
    private Mockery context = new Mockery();

    @Test
    public void basicTest() {
        final FooWidgetDependency dep = context.mock(FooWidgetDependency.class);

        context.checking(new Expectations() {
            oneOf(dep).call(with(any(String.class)));
            atLeast(0).of(dep).optionalCall();
        });

        final FooWidget foo = new FooWidget(dep);

        Assert.assertTrue(foo.doThing());
        context.assertIsSatisfied();
    }
}</pre>
</div>
这段代码通过jMock设置了一个FooWidgetDependency ，然后添加了一些期望的操作。我们希望dep的call方法被调用一次而dep的optionalCall 方法会被调用0或更多次。

如果你反复的构造同样的FooWidgetDependency，你应该把它放到一个[测试设备（Test Fixture）](https://github.com/junit-team/junit/wiki/Test-fixtures)里，然后把assertIsSatisfied放到一个@After方法中。

#### AssertJ

你是不是用jUnit写过这些？
<div>
<pre>final List&lt;String&gt; result = some.testMethod();
assertEquals(4, result.size());
assertTrue(result.contains("some result"));
assertTrue(result.contains("some other result"));
assertFalse(result.contains("shouldn't be here"));</pre>
</div>
这些样板代码有点太聒噪了。AssertJ解决了这个问题。同样的代码可以变成这样：
<div>
<pre>assertThat(some.testMethod()).hasSize(4)
                             .contains("some result", "some other result")
                             .doesNotContain("shouldn't be here");</pre>
</div>
连贯接口让你的测试代码可读性更强了。代码如此，夫复何求？

### 工具

#### IntelliJ IDEA

备选方案： Eclipse and Netbeans

最好的Java IDE当然是 IntelliJ IDEA。它有许多很棒的特性，我们之所以还能忍受Java这些冗长的代码，它起了很大的作用。自动补全很棒，&lt; a href="http://i.imgur.com/92ztcCd.png" target="_blank"&gt;代码检查也超赞，重构工具也非常实用。

免费的社区版对我来说已经足够了，不过在旗舰版中有许多不错的特性比如数据库工具，Srping框架的支持以及Chronon等。

#### Chronon

GDB 7中我最喜欢的特性就是调试的时候可以按时间进行遍历了。有了IntelliJ IDEA的[Chronon插件](http://blog.jetbrains.com/idea/2014/03/try-chronon-debugger-with-intellij-idea-13-1-eap/)后，这个也成为现实了。当然你得是旗舰版的。

你可以获取到变量的历史值，跳回前面执行的地方，获取方法的调用历史等等。第一次使用的话会感觉有点怪，但它能帮忙你调试一些很棘手的BUG。

#### JRebel

持续集成通常都是SaaS产品的一个目标。你想想如果你甚至都不需要等到编译完成就可以看到代码的更新？

这就是[JRebel](http://zeroturnaround.com/software/jrebel/)在做的事情。只要你把你的服务器挂到某个JRebel客户端上，代码一旦有改动你马上就能看到效果。当你想快速体验一个功能的话，这个的确能节省不少时间。

#### 验证框架

Java的类型系统是相当弱的。它不能区分出普通字符串以及实际上是正则的字符串，也不能进行
