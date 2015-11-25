title: Web安全之SQL注入攻击技巧与防范
tags:
  - 安全
categories: 资料文档
date: 2014-12-28 15:18:41
---

from: [http://www.plhwin.com/2014/06/13/web-security-sql/](http://www.plhwin.com/2014/06/13/web-security-sql/)

# Web安全简史

在Web1.0时代，人们更多是关注服务器端动态脚本语言的安全问题，比如将一个可执行脚本（俗称Webshell）通过脚本语言的漏洞上传到服务器上，从而获得服务器权限。在Web发展初期，随着动态脚本语言的发展和普及，以及早期工程师对安全问题认知不足导致很多”安全血案”的发生，至今仍然遗留下许多历史问题，比如PHP语言至今仍然无法从语言本身杜绝「文件包含漏洞」（[参见这里](http://developer.51cto.com/art/201104/255224.htm)），只能依靠工程师良好的代码规范和安全意识。

伴随着Web2.0、社交网络、微博等一系列新型互联网产品的兴起，基于Web环境的互联网应用越来越广泛，Web攻击的手段也越来越多样，Web安全史上的一个重要里程碑是大约1999年发现的SQL注入攻击，之后的XSS，CSRF等攻击手段愈发强大，Web攻击的思路也从服务端转向了客户端，转向了浏览器和用户。

在安全领域，一般用帽子的颜色来比喻黑客的善与恶，白帽子是指那些工作在反黑客领域的技术专家，这个群体是”善”的的象征；而黑帽子则是指那些利用黑客技术造成破坏甚至谋取私利造成犯罪的群体，他们是”恶”的代表。

“白帽子”和”黑帽子”是两个完全对立的群体。对于黑帽子而言，他们只要找到系统的一个切入点就可以达到入侵破坏的目的，而白帽子必须将自己系统所有可能被突破的地方都设防，以保证系统的安全运行。

这看起来好像是不公平的，但是安全世界里的规则就是这样，可能我们的网站1000处都布防的很好，考虑的很周到，但是只要有一个地方疏忽了，攻击者就会利用这个点进行突破，让我们另外的1000处努力白费。

# 常见攻击方式

一般说来，在Web安全领域，常见的攻击方式大概有以下几种：
1、SQL注入攻击
2、跨站脚本攻击 - XSS
3、跨站伪造请求攻击 - CSRF
4、文件上传漏洞攻击
5、分布式拒绝服务攻击 - DDOS

说个题外话，本来这篇文章一开始的标题叫做 「Web安全之常见攻击方法与防范」，我原本想把上面的这5种方法都全部写在一篇文章里，可是刚写完第一个SQL注入攻击的时候，就发现文章篇幅已经不短了，又很难再进行大幅度的精简，所以索性把Web安全分成一个系列，分多篇文章来呈现给大家，下面你看到的就是第一篇「Web安全之SQL注入攻击的技巧与防范」。

# SQL注入常见攻击技巧

SQL注入攻击是Web安全史上的一个重要里程碑，它从1999年首次进入人们的视线，至今已经有十几年的历史了，虽然我们现在已经有了很全面的防范对策，但是它的威力仍然不容小觑，SQL注入攻击至今仍然是Web安全领域中的一个重要组成部分。

以PHP+MySQL为例，让我们以一个Web网站中最基本的用户系统来做实例演示，看看SQL注入究竟是怎么发生的。

1、创建一个名为demo的数据库：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>CREATE DATABASE  `demo` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;</pre>
</td>
</tr>
</tbody>
</table>
</figure>2、创建一个名为user的数据表，并插入1条演示数据：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>CREATE TABLE  `demo`.`user` (
`uid` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT  '用户uid',
`username` VARCHAR( 20 ) NOT NULL COMMENT  '用户名',
`password` VARCHAR( 32 ) NOT NULL COMMENT  '用户密码'
) ENGINE = INNODB;
INSERT INTO `demo`.`user` (`uid`, `username`, `password`) VALUES ('1', 'plhwin', MD5('123456'));</pre>
</td>
</tr>
</tbody>
</table>
</figure>

## 实例一

通过传入`username`参数，在页面打印出这个会员的详细信息，编写 `userinfo.php` 程序代码：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>&lt;?php
header('Content-type:text/html; charset=UTF-8');
$username = isset($_GET['username']) ? $_GET['username'] : '';
$userinfo = array();
if($username){
	//使用mysqli驱动连接demo数据库
	$mysqli = new mysqli("localhost", "root", "root", 'demo');
	$sql = "SELECT uid,username FROM user WHERE username='{$username}'";
	//mysqli multi_query 支持执行多条MySQL语句
	$query = $mysqli-&gt;multi_query($sql);
	if($query){
		do {
			$result = $mysqli-&gt;store_result();
			while($row = $result-&gt;fetch_assoc()){
				$userinfo[] = $row;
			}
			if(!$mysqli-&gt;more_results()){
				break;
			}
		} while ($mysqli-&gt;next_result());
	}
}
echo '&lt;pre&gt;',print_r($userinfo, 1),'&lt;/pre&gt;';</pre>
</td>
</tr>
</tbody>
</table>
</figure>上面这个程序要实现的功能是根据浏览器传入的用户名参数，在页面上打印出这个用户的详细信息，程序写的这么复杂是因为我采用了mysqli的驱动，以便能使用到 `multi_query` 方法来支持同时执行多条SQL语句，这样能更好的说明SQL注入攻击的危害性。

假设我们可以通过 `http://localhost/test/userinfo.php?username=plhwin` 这个URL来访问到具体某个会员的详情，正常情况下，如果浏览器里传入的username是合法的，那么SQL语句会执行：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>SELECT uid,username FROM user WHERE username='plhwin'</pre>
</td>
</tr>
</tbody>
</table>
</figure>但是，如果用户在浏览器里把传入的username参数变为 `plhwin';SHOW TABLES-- hack`，也就是当URL变为 `http://localhost/test/userinfo.php?username=plhwin';SHOW TABLES-- hack` 的时候，此时我们程序实际执行的SQL语句变成了：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>SELECT uid,username FROM user WHERE username='plhwin';SHOW TABLES-- hack'</pre>
</td>
</tr>
</tbody>
</table>
</figure>_注意：在MySQL中，最后连续的两个减号表示忽略此SQL减号后面的语句，我本机的MySQL版本号为5.6.12，目前几乎所有SQL注入实例都是直接采用两个减号结尾，但是实际测试，这个版本号的MySQL要求两个减号后面必须要有空格才能正常注入，而浏览器是会自动删除掉URL尾部空格的，所以我们的注入会在两个减号后面统一添加任意一个字符或单词，本篇文章的SQL注入实例统一以 `-- hack` 结尾。_

经过上面的SQL注入后，原本想要执行查询会员详情的SQL语句，此时还额外执行了 `SHOW TABLES;` 语句，这显然不是开发者的本意，此时可以在浏览器里看到页面的输出：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>Array
(
    [0] =&gt; Array
        (
            [uid] =&gt; 1
            [username] =&gt; plhwin
        )

    [1] =&gt; Array
        (
            [Tables_in_demo] =&gt; user
        )

)</pre>
</td>
</tr>
</tbody>
</table>
</figure>你能清晰的看到，除了会员的信息，数据库表的名字`user`也被打印在了页面上，如果作恶的黑客此时将参数换成 `plhwin';DROP TABLE user-- hack`，那将产生灾难性的严重结果，当你在浏览器中执行`http://localhost/test/userinfo.php?username=plhwin';DROP TABLE user-- hack` 这个URL后，你会发现整个 `user` 数据表都消失不见了。

通过上面的例子，大家已经认识到SQL注入攻击的危害性，但是仍然会有人心存疑问，MySQL默认驱动的`mysql_query`方法现在已经不支持多条语句同时执行了，大部分开发者怎么可能像上面的演示程序那样又麻烦又不安全。

是的，在PHP程序中，MySQL是不允许在一个`mysql_query`中使用分号执行多SQL语句的，这使得很多开发者都认为MySQL本身就不允许多语句执行了，但实际上[MySQL早在4.1版本就允许多语句执行](http://dev.mysql.com/doc/refman/4.1/en/c-api-multiple-queries.html)，通过PHP的源代码，我们发现其实只是PHP语言自身限制了这种用法，具体情况大家可以看看这篇文章「[PHP+MySQL多语句执行](http://zone.wooyun.org/content/50)」。

## 实例二

如果系统不允许同时执行多条SQL语句，那么SQL注入攻击是不是就不再这么可怕呢？答案是否定的，我们仍然以上面的user数据表，用Web网站中常用的会员登录系统来做另外一个场景实例，编写程序`login.php`，代码如下：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>&lt;?php
if($_POST){
	$link = mysql_connect("localhost", "root", "root");
	mysql_select_db('demo', $link);
	$username = empty($_POST['username']) ? '' : $_POST['username'];
	$password = empty($_POST['password']) ? '' : $_POST['password'];
	$md5password = md5($password);
	$sql = "SELECT uid,username FROM user WHERE username='{$username}' AND password='{$md5password}'";
	$query = mysql_query($sql, $link);
	$userinfo = mysql_fetch_array($query, MYSQL_ASSOC);
	if(!empty($userinfo)){
		//登录成功，打印出会员信息
		echo '&lt;pre&gt;',print_r($userinfo, 1),'&lt;/pre&gt;';
	} else {
		echo "用户名不存在或密码错误！";
	}
}
?&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
	&lt;meta charset="utf-8"&gt;
	&lt;title&gt;Web登录系统SQL注入实例&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
	&lt;form name="LOGIN_FORM" method="post" action=""&gt;
	登录帐号: &lt;input type="text" name="username" value="" size=30 /&gt;&lt;br /&gt;&lt;br /&gt;
	登录密码: &lt;input type="text" name="password" value="" size=30 /&gt;&lt;br /&gt;&lt;br /&gt;
	&lt;input type="submit" value="登录" /&gt;
	&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;</pre>
</td>
</tr>
</tbody>
</table>
</figure>此时如果输入正确的用户名 `plhwin` 和密码 `123456`，执行的SQL语句为：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>SELECT uid,username FROM user WHERE username='plhwin' AND password='e10adc3949ba59abbe56e057f20f883e'</pre>
</td>
</tr>
</tbody>
</table>
</figure>上面语句没有任何问题，可以看到页面打印出了登录成功后的会员信息，但如果有捣蛋鬼输入的用户名为`plhwin' AND 1=1-- hack`，密码随意输入，比如`aaaaaa`，那么拼接之后的SQL查询语句就变成了如下内容：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>SELECT uid,username FROM user WHERE username='plhwin' AND 1=1-- hack' AND password='0b4e7a0e5fe84ad35fb5f95b9ceeac79'</pre>
</td>
</tr>
</tbody>
</table>
</figure>执行上面的SQL语句，因为`1=1`是永远成立的条件，这意味着黑客只需要知道别人的会员名，无需知道密码就能顺利登录到系统。

# 如何确定SQL注入漏洞

通过以上的实例，我们仍然还会有疑问：黑客并不知道我们程序代码的逻辑和SQL语句的写法，他是如何确定一个网站是否存在SQL注入漏洞呢？一般说来有以下2种途径：

## 1、错误提示

如果目标Web网站开启了错误显示，攻击者就可以通过反复调整发送的参数、查看页面打印的错误信息，推测出Web网站使用的数据库和开发语言等重要信息。

## 2、盲注

除非运维人员疏忽，否则大部分的Web运营网站应该都关闭了错误提示信息，此时攻击者一般会采用盲注的技巧来进行反复的尝试判断。 仍然以上面的数据表user为例，我们之前的查看会员详情页面的url地址为`userinfo.php?username=plhwin`，此时黑客分别访问`userinfo.php?username=plhwin' AND 1=1-- hack`和`userinfo.php?username=plhwin' AND 1=2-- hack`，如果前者访问能返回正常的信息而后者不能，就基本可以判断此网站存在SQL注入漏洞，因为后者的`1=2`这个表达式永远不成立，所以即使username传入了正确的参数也无法通过，由此可以推断这个页面存在SQL注入漏洞，并且可以通过`username`参数进行注入。

# 如何防御SQL注入

对于服务器配置层面的防范，应该保证生产环境的Webserver是关闭错误信息的，比如PHP在生产环境的配置文件php.ini中的display_errors应该设置为Off，这样就关闭了错误提示，下面我们更多的从编码的角度来看看如何防范SQL注入。

上面用两个实例分析了SQL注入攻击的技巧，可以看到，但凡有SQL注入漏洞的程序，都是因为程序要接受来自客户端用户输入的变量或URL传递的参数，并且这个变量或参数是组成SQL语句的一部分，对于用户输入的内容或传递的参数，我们应该要时刻保持警惕，这是安全领域里的「外部数据不可信任」的原则，纵观Web安全领域的各种攻击方式，大多数都是因为开发者违反了这个原则而导致的，所以自然能想到的，就是从变量的检测、过滤、验证下手，确保变量是开发者所预想的。

## 1、检查变量数据类型和格式

如果你的SQL语句是类似`where id={$id}`这种形式，数据库里所有的id都是数字，那么就应该在SQL被执行前，检查确保变量id是int类型；如果是接受邮箱，那就应该检查并严格确保变量一定是邮箱的格式，其他的类型比如日期、时间等也是一个道理。总结起来：**只要是有固定格式的变量，在SQL语句执行前，应该严格按照固定格式去检查，确保变量是我们预想的格式**，这样很大程度上可以避免SQL注入攻击。

比如，我们前面接受`username`参数例子中，我们的产品设计应该是在用户注册的一开始，就有一个用户名的规则，比如`5-20个字符，只能由大小写字母、数字以及一些安全的符号组成，不包含特殊字符`。此时我们应该有一个`check_username`的函数来进行统一的检查。不过，仍然有很多例外情况并不能应用到这一准则，比如文章发布系统，评论系统等必须要允许用户提交任意字符串的场景，这就需要采用过滤等其他方案了。

## 2、过滤特殊符号

对于无法确定固定格式的变量，一定要进行特殊符号过滤或转义处理。以PHP为例，通常是采用`addslashes`函数，它会在指定的预定义字符前添加反斜杠转义，这些预定义的字符是：`单引号 (') 双引号 (") 反斜杠 (\) NULL`。

来看2条SQL语句：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>$uid = isset($_GET['uid']) ? $_GET['uid'] : 0;
$uid = addslashes(uid);
$sql = "SELECT uid,username FROM user WHERE uid='{$uid}'";</pre>
</td>
</tr>
</tbody>
</table>
</figure>以及

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>$uid = isset($_GET['uid']) ? $_GET['uid'] : 0;
$uid = addslashes(uid);
$sql = "SELECT uid,username FROM user WHERE uid={$uid}";</pre>
</td>
</tr>
</tbody>
</table>
</figure>上面两个查询语句都经过了php的addslashes函数过滤转义，但在安全性上却大不相同，在MySQL中，对于int类型字段的条件查询，上面个语句的查询效果完全一样，由于第一句SQL的变量被单引号包含起来，SQL注入的时候，黑客面临的首要问题是必须要先闭合前面的单引号，这样才能使后面的语句作为SQL执行，并且还要注释掉原SQL语句中的后面的单引号，这样才可以成功注入，由于代码里使用了addslashes函数，黑客的攻击会无从下手，但第二句没有用引号包含变量，那黑客也不用考虑去闭合、注释，所以即便同样采用addslashes转义，也还是存在SQL攻击漏洞。

对于PHP程序+MySQL构架的程序，在动态的SQL语句中，使用单引号把变量包含起来配合`addslashes`函数是应对SQL注入攻击的有效手段，但这做的还不够，像上面的2条SQL语句，根据「检查数据类型」的原则，uid都应该经过`intval`函数格式为int型，这样不仅能有效避免第二条语句的SQL注入漏洞，还能使得程序看起来更自然，尤其是在NoSQL(如MongoDB)中，变量类型一定要与字段类型相匹配才可以。

从上面可以看出，第二个SQL语句是有漏洞的，不过由于使用了addslashes函数，你会发现黑客的攻击语句也存在不能使用特殊符号的条件限制，类似`where username='plhwin'`这样的攻击语句是没法执行的，但是黑客可以将字符串转为16进制编码数据或使用`char`函数进行转化，同样能达到相同的目的，如果对这部分内容感兴趣，可以[点击这里查看](http://cbb.sjtu.edu.cn/course/database/lab8.htm)。而且由于SQL保留关键字，如「HAVING」、「ORDER BY」的存在，即使是基于黑白名单的过滤方法仍然会有或多或少问题，那么是否还有其他方法来防御SQL注入呢？

## 3、绑定变量，使用预编译语句

MySQL的`mysqli`驱动提供了预编译语句的支持，不同的程序语言，都分别有使用预编译语句的方法，我们这里仍然以PHP为例，编写`userinfo2.php`代码：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>&lt;?php
header('Content-type:text/html; charset=UTF-8');
$username = isset($_GET['username']) ? $_GET['username'] : '';
$userinfo = array();
if($username){
	//使用mysqli驱动连接demo数据库
	$mysqli = new mysqli("localhost", "root", "root", 'demo');
	//使用问号替代变量位置
	$sql = "SELECT uid,username FROM user WHERE username=?";
	$stmt = $mysqli-&gt;prepare($sql);
	//绑定变量
	$stmt-&gt;bind_param("s", $username);
	$stmt-&gt;execute();
	$stmt-&gt;bind_result($uid, $username);
	while ($stmt-&gt;fetch()) {
	    $row = array();
	    $row['uid'] = $uid;
	    $row['username'] = $username;
	    $userinfo[] = $row;
	}
}
echo '&lt;pre&gt;',print_r($userinfo, 1),'&lt;/pre&gt;';</pre>
</td>
</tr>
</tbody>
</table>
</figure>从上面的代码可以看到，我们程序里并没有使用`addslashes`函数，但是浏览器里运行`http://localhost/test/userinfo2.php?username=plhwin' AND 1=1-- hack`里得不到任何结果，说明SQL漏洞在这个程序里并不存在。

实际上，绑定变量使用预编译语句是预防SQL注入的最佳方式，使用预编译的SQL语句语义不会发生改变，在SQL语句中，变量用问号`?`表示，黑客即使本事再大，也无法改变SQL语句的结构，像上面例子中，username变量传递的`plhwin' AND 1=1-- hack`参数，也只会当作username字符串来解释查询，从根本上杜绝了SQL注入攻击的发生。

# 数据库信息加密安全

相信大家都还对2011年爆出的CSDN拖库事件记忆犹新，这件事情导致CSDN处在风口浪尖被大家痛骂的原因就在于他们竟然明文存储用户的密码，这引发了科技界对用户信息安全尤其是密码安全的强烈关注，我们在防范SQL注入的发生的同时，也应该未雨绸缪，说不定下一个被拖库的就是你，谁知道呢。

在Web开发中，传统的加解密大致可以分为三种:

1、对称加密：即加密方和解密方都使用相同的加密算法和密钥，这种方案的密钥的保存非常关键，因为算法是公开的，而密钥是保密的，一旦密匙泄露，黑客仍然可以轻易解密。常见的对称加密算法有：`AES`、`DES`等。

2、非对称加密：即使用不同的密钥来进行加解密，密钥被分为公钥和私钥，用私钥加密的数据必须使用公钥来解密，同样用公钥加密的数据必须用对应的私钥来解密，常见的非对称加密算法有：`RSA`等。

3、不可逆加密：利用哈希算法使数据加密之后无法解密回原数据，这样的哈希算法常用的有：`md5`、`SHA-1`等。

在我们上面登录系统的示例代码中，`$md5password = md5($password);`从这句代码可以看到采用了md5的不可逆加密算法来存储密码，这也是多年来业界常用的密码加密算法，但是这仍然不安全。为什么呢？

这是因为md5加密有一个特点：同样的字符串经过md5哈希计算之后生成的加密字符串也是相同的，由于业界采用这种加密的方式由来已久，黑客们也准备了自己强大的md5彩虹表来逆向匹配加密前的字符串，这种用于逆向反推MD5加密的彩虹表在互联网上随处可见，在Google里使用`md5 解密`作为关键词搜索，一下就能找到[md5在线破解网站](http://www.cmd5.com/)，把我们插入用户数据时候的MD5加密字符串`e10adc3949ba59abbe56e057f20f883e`填入进去，瞬间就能得到加密前的密码：`123456`。当然也并不是每一个都能成功，但可以肯定的是，这个彩虹表会越来越完善。

所以，我们有迫切的需求采用更好的方法对密码数据进行不可逆加密，通常的做法是为每个用户确定不同的密码加盐（salt）后，再混合用户的真实密码进行md5加密，如以下代码：

<figure>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre>&lt;?php
//用户注册时候设置的password
$password = $_POST['password'];
//md5加密，传统做法直接将加密后的字符串存入数据库，但这不够，我们继续改良
$passwordmd5 = md5($password);
//为用户生成不同的密码盐，算法可以根据自己业务的需要而不同
$salt = substr(uniqid(rand()), -6);
//新的加密字符串包含了密码盐
$passwordmd5 = md5($passwordmd5.$salt);</pre>
</td>
</tr>
</tbody>
</table>
</figure>

# 小结

1、不要随意开启生产环境中Webserver的错误显示。
2、永远不要信任来自用户端的变量输入，有固定格式的变量一定要严格检查对应的格式，没有固定格式的变量需要对引号等特殊字符进行必要的过滤转义。
3、使用预编译绑定变量的SQL语句。
4、做好数据库帐号权限管理。
5、严格加密处理用户的机密信息。
