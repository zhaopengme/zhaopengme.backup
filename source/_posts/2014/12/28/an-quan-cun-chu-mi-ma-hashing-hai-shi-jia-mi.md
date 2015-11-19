title: 安全存储密码：Hashing 还是加密？
id: 1024
categories:
  - 网文收藏
  - 资料文档
date: 2014-12-28 15:15:59
tags:
---

一篇很不错的进行加密的文章!

from: [http://www.oschina.net/news/52976/hashing-or-encrypt](http://www.oschina.net/news/52976/hashing-or-encrypt)

对于网站来说， 再没有什么比用户信息泄露更让人尴尬的了。 尤其是当存有用户密码的文件如果被黑客获取， 对网站的安全和用户的信心来说都是巨大的打击。 如最近的[Ebay泄密事件](http://www.aqniu.com/threat-alert/2986.html)和[小米的用户数据泄露事件](http://www.aqniu.com/threat-alert/2858.html)。 保证用户信息安全首先需要正确理解对于用户密码的安全控制和保护。 这里OWASP的主席Michael Coates最近的一篇关于一些基本概念的介绍能够帮助开发人员更好的理解现代Hashing算法和加密对于用户密码保护的作用。 安全牛编译如下：

在过去几个月， 我们看到了一些严重的数据泄露事件， Ebay和Adobe的数据泄露事件影响了几百万用户。 Snapchat也遭受到了数据泄露事件的影响。 每一次密码泄露事件后， 人们都会问同一个问题， 这些密码的存储是不是安全？ 不幸的是， 这个看上去简单的问题其实并不好回答。

尽管在很多情况下， Hashing和加密都能够满足安全存储的需要， 对于在线应用而言， 很多情况下， 对于用户密码的安全存储往往只有一种正确的方案。 Hashing.是通过一个不可逆的杂凑函数计算出一个Hash值， 而通过这个值无法逆向计算出输入值（比如用户密码）。 对称加密则是采用密钥进行加密计算， 这是一种可逆的运算。  任何人如果有了密钥， 就能够解密出原始明文。

下表是Hashing和对称加密的对比
<table id="tablepress-1">
<thead>
<tr role="row">
<th role="columnheader" rowspan="1" colspan="1"></th>
<th role="columnheader" rowspan="1" colspan="1">Hashing</th>
<th role="columnheader" rowspan="1" colspan="1">对称加密</th>
</tr>
</thead>
<tbody role="alert">
<tr>
<td></td>
<td>不可逆函数</td>
<td>可逆运算</td>
</tr>
<tr>
<td>能够逆向算出初始值</td>
<td>不能</td>
<td>可以</td>
</tr>
<tr>
<td></td>
<td>对于现代杂凑算法而言， 从Hash值逆向算出输入值非常困难。 参见下面关于彩虹表，盐化等的讨论</td>
<td>对称加密就是设计来是的任何拥有密钥的人能够解密出原始明文</td>
</tr>
<tr>
<td>其他需要考虑的方面</td>
<td>杂凑算法的选择</td>
<td>加密算法的选择</td>
</tr>
<tr>
<td></td>
<td>对每个用户进行盐化</td>
<td>保护密钥</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>
显示第 1 至 6 项结果，共 6 项

当在线应用收到一个用户名和一个密码后， 就以密码为输入到杂凑函数中去得出一个Hash值， 然后用这个Hash值与数据库中存储的该用户的密码Hash值做比较， 如果两个Hash值相同， 就可以认为用户提供了有效的用户名和密码。 采用Hashing的好处是， 应用不需要存储用户的明文密码， 只需要存储Hash值。

**在线应用如何利用密码的Hash值来认证用户**

下图就是关于采用Hashing方式的简单描述:

那么， 所有杂凑算法都能用吗？ 不是的， 事实上， 杂凑算法中不同的算法的差别很大， 并不是所有的杂凑算法都适合存储密码。

说起来可能有点出人预料， 早期的杂凑算法速度过快， 黑客们尽管不能通过Hash值逆向计算出原输入值， 但是黑客们可以通过暴力破解的方式遍历所有可能的密码组合来尝试能够能够“碰撞”到用户密码的Hash值。 为了避免这种威胁， 现代的杂凑算法能够通过多重迭代， 使得在每次Hash计算时产生一些延时， 对单次Hash计算， 这样的延时基本没有任何影响， 而对于黑客的暴力破解来说， 几百万次计算的延时能够被放大几百年， 这样到使得暴力破解基本不现实的地步。

在Hashing中， 最好采用针对每个用户的盐化方式， 通过对用户密码添加一个随机字符串（随机字符串可以是显式存储）， 这样可以相同的密码产生相同的Hash值， 这样， 攻击者可以下载一个巨大的存有事先计算好Hash值的查找表， 也叫做彩虹表。 通过Hash值， 反向查找对应的输入值。

而通过下面两个表格可以看出， 通过对不同用户进行不同的盐化， 同样的密码就会出现不同的Hash值， 这样使得攻击者利用彩虹表进行攻击变得困难。

**没有盐化**
<table id="tablepress-2">
<thead>
<tr>
<th>用户名</th>
<th>密码</th>
<th>Hash值</th>
</tr>
</thead>
<tbody>
<tr>
<td>Joe</td>
<td>password123</td>
<td>xyfkdl323...</td>
</tr>
<tr>
<td>Sue</td>
<td>password123</td>
<td>xyfkdl323...</td>
</tr>
</tbody>
</table>
**盐化后**
<table id="tablepress-3">
<thead>
<tr>
<th>用户名</th>
<th>密码</th>
<th>盐化字符串</th>
<th>Hash值</th>
</tr>
</thead>
<tbody>
<tr>
<td>Joe</td>
<td>password123</td>
<td>48a023jl2…</td>
<td>ied390fl2...</td>
</tr>
<tr>
<td>Sue</td>
<td>password123</td>
<td>9fh3ls321…</td>
<td>40akdl23…</td>
</tr>
</tbody>
</table>
**类似于账户锁定的机制对于密码存储的模式有什么影响吗？**

简单的回答， 就是， 没有影响。 对密码的安全存储是为了提供在密码文件被盗取后的防护。 黑客对于密码Hash的攻击是一种离线攻击。 也就是说， 密码文件已经被盗取， 黑客可以利用自己的计算机通过尝试不同的密码来找出密码。 由于是离线攻击， 账号锁定或者验证码之类的安全机制已经没有作用了。 这些机制只有在针对网站服务器的在线登录页面攻击时才会起作用。

**对于密码存储， 采用对称加密而不是Hashing的风险在哪里？**

对称加密的设计就是一个可逆的运算， 这意味着在线应用必须能够访问到密钥， 并且在每次密码验证时都要使用。 如果加密后的密码被窃取的话， 黑客需要获取对称加密的密钥， 而一旦密钥被破解出来， 不管是通过某种方式泄露出来， 或者一些弱的密钥被暴力方式破解出来， 所有的密码都会被黑客获得。

**总结**

对于密码的安全存储来说， 理解对称加密与Hashing的区别非常重要。 一些如PBKDF2， bcrypt以及scrypt等算法都采用的每用户盐化以及多重迭代的Hashing方式以安全存储密码。

互联网已经日益成为重要的用户信息存储的场所。 网站开发人员及网站老板们需要尽其所能地保证用户信息的安全。 了解如何利用现代的Hashing算法对用户密码进行基本的安全控制保护非常重要。