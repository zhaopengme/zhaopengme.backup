title: double cookie验证
tags:
  - 安全
id: 1019
categories:
  - 资料文档
date: 2014-12-28 19:53:26
---

from: [http://www.75team.com/archives/729](http://www.75team.com/archives/729)

什么是double cookie验证
double cookie验证是利用cookie来验证请求合法性的一种方法。

一个double cookie验证的url形如

`http://a.com?c=cookie`

向服务器请求的url带上cookie，服务器收到请求后，解析出url中的cookie和http请求带过来的cookie进行对比。如果一样就说明请求合法，不一样就可以判定请求非法。

因为是用url中的cookie和http请求中的cookie进行验证，所以叫double cookie验证。

验证原理

url是客户端javascript生成的，javascript可以读取cookie。

url可以从任意客户端访问，但是只有一个客户端的http请求带给服务器的cookie和url中的cookie是一致的。

注意事项

*   用来验证的cookie在每个客户端必须唯一
*   用来验证的cookie不能是敏感信息。比如登录用户的token不能作为验证的cookie
应用场景

double cookie验证不能判断用户修改本地cookie然后再进行的访问。但是没有关系。举个应用场景。

比如一个网站的 评分功能的请求是这样的

`http://a.com?score=100&amp;id=10000`

如果有人把这个url发到网上，引诱其它用户来点击，那么就会生成大量的评分请求。这时就可以用double cookie验证了。因为很难让点击这个链接的人先修改本地cookie然后再点击链接

使用建议

有的同学喜欢把cookie做个变换，防止别人一眼看出来是用哪个cookie做的验证。没必要这样做，也不应该这样做。

1.  变换的方法一定会暴露在客户端
2.  验证的目的不是为了防止有意伪造
3.  对cooie做变换的方法如果不得当，可能会对cookie的结构造成依赖。如果哪天cookie的结构改变了，就会使验证代码失效，甚至报错。
