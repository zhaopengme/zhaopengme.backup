title: 人人网的开源框架paoding-rose(2)
id: 184
categories:

date: 2011-04-19 01:30:16
tags:
---

人人网的开源框架paoding-rose(2)
</br><span> </span>上次写过rose，说到文档不全，其实不是文档不全，而是我没有细细看，文档还是写的很详细的，而且源码注释很规范，加上源码注释和文档，rose框架还是很容易的掌握的。
</br><span> </span>在安全性设计上面打算采用spring security来实现的，把spring security集成到系统用了几天的时间，这样系统就是spring + spring security + rose的设计了。
</br><span> </span>其中的遇到的问题是spring security 需要配置自己的过滤器，而在rose的系统中只需要配置一个过滤器，配置两个过滤器就出抛出已经有过滤器的异常，我把spring security的过滤器去掉了，只配置了一个rose的过滤器，再按照配置spring security的方式配置好了。在配置过程中，就是一个不断尝试，试着配出来的。
</br><span> </span>配置好了，就是项目启动不再出现异常情况，运行也不报错了。可预期的结果并不是我要的结果。我过滤的方式是通过url来控制权限的，spring security对正常的url是可以进行控制的，对pathinfo格式的url就不能做控制。这个问题纠结了好久，我还询问过开发rose框架的作者，他给我的解释是rose本身就是一个独立的context，它的parent是root context，这样说来，rose就和spring security是属于两个context了，当然不能控制了。
</br><span> </span>根据日志记录，这样的解释说不过去，从日志记录中，spring security对url都是做过滤的，首先是rose对url进行过滤，接着是spring security进行过滤。在看rose源码的时候，有这样的一段注释。“如果一个请求在Rose中没有找到合适的类来为他服务，Rose将把该请求移交给web容器的其他组件来处理。” &nbsp;这样才能解释通道理，也可以和日志记录对应起来。rose先做了处理，无法处理的时候才交给其他容器做处理的。
</br><span> </span>我想尝试先让spring security先来处理，这样处理之后，spring security却不会请求交给rose来处理，这块尝试了好久，没有找到解决的办法，最终只跟踪到spring security中的一个异常对象，在rose处理了，就不会把异常抛出，这个也是spring security不能处理rose请求的原因的。结果是我解决不了，引入spring security就放弃了。
</br><span> </span>引入spring security我是想偷工的，没有偷成。反过来也想想，引入了新框架进来，就会增加系统的负担，我还是希望系统轻巧一点。
</br><span> </span>可安全性总是要做的，了解spring security的原理，同理写一个了。spring security是按照面向切面的思路，通过过滤器来实现的。rose的过滤器很好用，不仅可以设置过滤器，还可以设置局部和全局的过滤器，还可以设置过滤器的权重，满足什么时候，什么场景，采用什么过滤器。
</br><span> </span>我写的基本可以用起来，满足了我的基本要求了。现在也仅仅是满足需求，对一些漏洞还需要继续的修补。
</br>