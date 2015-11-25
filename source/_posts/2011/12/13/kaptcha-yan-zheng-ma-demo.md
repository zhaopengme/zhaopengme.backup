title: kaptcha验证码Demo
id: 138
categories: java
date: 2011-12-13 00:50:18
tags:
---

为了防止程序破解系统登录，一般都会采用登录+验证码的措施。

kaptcha是我用到的最好用的一个验证码工具，使用非常的简单。

瞧瞧我在项目中使用的效果吧！感觉还是很不错的。

[![http://lh4.ggpht.com/-Q-mV4xef8gY/TuYpItsXbxI/AAAAAAAAAEk/UGTbrhHZ-IY/s400/vercode.jpg](http://m2.img.libdd.com/farm3/118/48E585B6FE66C51CE8D30FB4525F2D76_200_80.PNG)</img>](http://lh4.ggpht.com/-Q-mV4xef8gY/TuYpItsXbxI/AAAAAAAAAEk/UGTbrhHZ-IY/s400/vercode.jpg)

**使用方法：**

1.当然是下载kaptcha的jar包了

kaptaca的地址：[http://code.google.com/p/kaptcha/](http://code.google.com/p/kaptcha/ "http://code.google.com/p/kaptcha/")

我在下面也提供一个我修改的版本，修改点下面说。

2.在web.xml中增加配置
<pre><span>   1:</span><span>&lt;</span><span>servlet</span><span>&gt;</span></pre>
</br>
</br><pre><span>   2:</span><span>&lt;</span><span>servlet-name</span><span>&gt;</span>Kaptcha<span>&lt;/</span><span>servlet-name</span><span>&gt;</span></pre>
</br>
</br><pre><span>   3:</span><span>&lt;</span><span>servlet-class</span><span>&gt;</span>com.google.code.kaptcha.servlet.KaptchaServlet<span>&lt;/</span><span>servlet-class</span><span>&gt;</span></pre>
</br>
</br><pre><span>   4:</span><span>&lt;/</span><span>servlet</span><span>&gt;</span></pre>
</br>
</br><pre><span>   5:</span><span>&lt;</span><span>servlet-mapping</span><span>&gt;</span></pre>
</br>
</br><pre><span>   6:</span><span>&lt;</span><span>servlet-name</span><span>&gt;</span>Kaptcha<span>&lt;/</span><span>servlet-name</span><span>&gt;</span></pre>
</br>
</br><pre><span>   7:</span><span>&lt;</span><span>url-pattern</span><span>&gt;</span>/kaptcha.jpg<span>&lt;/</span><span>url-pattern</span><span>&gt;</span></pre>
</br>
</br><pre><span>   8:</span><span>&lt;/</span><span>servlet-mapping</span><span>&gt;</span></pre>
</br>
</br>
</br>

3.在需要的页面进行调用

</br>
</br>
</br><pre><span>   1:</span><span>&lt;</span><span>img</span><span>src</span><span>=&quot;Kaptcha.jpg&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   2:</span><span>&lt;</span><span>form</span><span>method</span><span>=&quot;POST&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   3:</span><span>&lt;</span><span>br</span><span>&gt;</span>验证码:<span>&lt;</span><span>input</span><span>type</span><span>=&quot;text&quot;</span><span>name</span><span>=&quot;kaptchafield&quot;</span><span>&gt;&lt;</span><span>br</span><span>/&gt;</span></pre>
</br>
</br><pre><span>   4:</span><span>&lt;</span><span>input</span><span>type</span><span>=&quot;submit&quot;</span><span>name</span><span>=&quot;submit&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   5:</span><span>&lt;/</span><span>form</span><span>&gt;</span></pre>
</br>
</br>
</br>

4.验证

</br>
</br>
</br><pre><span>   1:</span> String key = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);</pre>
</br>
</br><pre><span>   2:</span> String parm = (String) request.getParameter(<span>&quot;kaptchafield&quot;</span>);</pre>
</br>
</br><pre><span>   3:</span>&nbsp; </pre>
</br>
</br><pre><span>   4:</span> out.println(<span>&quot;验证码的值: &quot;</span> + key+<span>&quot;&lt;br /&gt;&quot;</span>);</pre>
</br>
</br><pre><span>   5:</span> out.println(<span>&quot;您输入的值: &quot;</span> + parm);</pre>
</br>
</br><pre><span>   6:</span>&nbsp; </pre>
</br>
</br><pre><span>   7:</span><span>if</span> (key != null &amp;&amp; parm != null) {</pre>
</br>
</br><pre><span>   8:</span><span>if</span> (key.equals(parm)) {</pre>
</br>
</br><pre><span>   9:</span>         out.println(<span>&quot;&lt;b&gt;验证成功&lt;/b&gt;&quot;</span>);</pre>
</br>
</br><pre><span>  10:</span>     } <span>else</span> {</pre>
</br>
</br><pre><span>  11:</span>         out.println(<span>&quot;&lt;b&gt;验证失败&lt;/b&gt;&quot;</span>);</pre>
</br>
</br><pre><span>  12:</span>     }</pre>
</br>
</br><pre><span>  13:</span> }</pre>
</br>
</br>
</br>

看看效果来

</br>

[![http://lh5.ggpht.com/-Vfq77phVbNQ/TuYhXdChLpI/AAAAAAAAAEc/NL_fI-Tljgo/s144/kaptcha-example.jpg](http://m2.img.libdd.com/farm3/118/48E585B6FE66C51CE8D30FB4525F2D76_200_80.PNG)</img>](http://lh5.ggpht.com/-Vfq77phVbNQ/TuYhXdChLpI/AAAAAAAAAEc/NL_fI-Tljgo/s144/kaptcha-example.jpg)

</br>

效果还不错的，就是美化不怎么好，好在kaptcha的自定义功能很强，可以根据需要自定义自己的效果。

</br>

kaptcha的配置属性

</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>**Constant****Description****Default** kaptcha.border 是否有边框 默认为yes 我们可以自己设置yes，no<span>&nbsp;</span> yes kaptcha.border.color 边框颜色 默认为Color.BLACK<span>&nbsp;</span> black kaptcha.border.thickness 边框粗细度 默认为1<span>&nbsp;</span> 1 kaptcha.image.width 验证码图片宽度 默认为200<span>&nbsp;</span> 200 kaptcha.image.height 验证码图片高度 默认为50<span>&nbsp;</span> 50 kaptcha.producer.impl 验证码生成器 com.google.code.kaptcha.impl.DefaultKaptcha kaptcha.textproducer.impl 验证码文本生成器 com.google.code.kaptcha.text.impl.DefaultTextCreator kaptcha.textproducer.char.string 验证码文本字符内容范围 abcde2345678gfynmnpwx kaptcha.textproducer.char.length 验证码文本字符长度 5 kaptcha.textproducer.char.space 验证码文本字符间距 默认为2<span>&nbsp;</span> 2 kaptcha.textproducer.font.names 验证码文本字体样式 默认为new Font(&quot;Arial&quot;, 1, fontSize), new Font(&quot;Courier&quot;, 1, fontSize)<span>&nbsp;</span> Arial, Courier kaptcha.textproducer.font.size 验证码文本字符大小 40px. kaptcha.textproducer.font.color 验证码文本字符颜色 默认为Color.BLACK<span>&nbsp;</span> black kaptcha.noise.impl 验证码噪点生成对象 com.google.code.kaptcha.impl.DefaultNoise kaptcha.noise.color 验证码噪点颜色 默认为Color.BLACK<span>&nbsp;</span> black kaptcha.obscurificator.impl 验证码样式引擎 默认为WaterRipple<span>&nbsp;</span> com.google.code.kaptcha.impl.WaterRipple kaptcha.background.impl 验证码背景生成器 默认为DefaultBackground<span>&nbsp;</span> com.google.code.kaptcha.impl.DefaultBackground kaptcha.background.clear.from 验证码背景颜色渐进 默认为Color.LIGHT_GRAY<span>&nbsp;</span> light grey kaptcha.background.clear.to 验证码背景颜色渐进 默认为Color.WHITE<span>&nbsp;</span> white kaptcha.word.impl 验证码文本字符渲染 默认为DefaultWordRenderer<span>&nbsp;</span> com.google.code.kaptcha.text.impl.DefaultWordRenderer kaptcha.session.key 放入session的key名称 KAPTCHA_SESSION_KEY kaptcha.session.date session中key的存活时间 KAPTCHA_SESSION_DATE
</br>

kaptcha中验证码样式引擎有WaterRipple（水纹类似的）、ShadowGimpy(投影)、FishEyeGimpy（鱼眼）三种样式，在将图片缩小一些后，有这些样式，就很难辨认了。所以，我就增加了一种没有干扰效果的样式，NoGimpy，代码很简单。

</br>
</br>
</br><pre><span>   1:</span><span>package</span> com.google.code.kaptcha.impl;</pre>
</br>
</br><pre><span>   2:</span>&nbsp; </pre>
</br>
</br><pre><span>   3:</span><span>import</span> java.awt.Graphics2D;</pre>
</br>
</br><pre><span>   4:</span><span>import</span> java.awt.image.BufferedImage;</pre>
</br>
</br><pre><span>   5:</span>&nbsp; </pre>
</br>
</br><pre><span>   6:</span><span>import</span> com.google.code.kaptcha.GimpyEngine;</pre>
</br>
</br><pre><span>   7:</span><span>import</span> com.google.code.kaptcha.util.Configurable;</pre>
</br>
</br><pre><span>   8:</span>&nbsp; </pre>
</br>
</br><pre><span>   9:</span><span>public</span><span>class</span> NoGimpy <span>extends</span> Configurable <span>implements</span> GimpyEngine {</pre>
</br>
</br><pre><span>  10:</span>&nbsp; </pre>
</br>
</br><pre><span>  11:</span><span>public</span> BufferedImage getDistortedImage(BufferedImage baseImage) {</pre>
</br>
</br><pre><span>  12:</span>         BufferedImage distortedImage = <span>new</span> BufferedImage(baseImage.getWidth(),</pre>
</br>
</br><pre><span>  13:</span>                 baseImage.getHeight(), BufferedImage.TYPE_INT_ARGB);</pre>
</br>
</br><pre><span>  14:</span>&nbsp; </pre>
</br>
</br><pre><span>  15:</span>         Graphics2D graph = (Graphics2D) distortedImage.getGraphics();</pre>
</br>
</br><pre><span>  16:</span>         graph.drawImage(baseImage, 0, 0, null, null);</pre>
</br>
</br><pre><span>  17:</span>         graph.dispose();</pre>
</br>
</br><pre><span>  18:</span><span>return</span> distortedImage;</pre>
</br>
</br><pre><span>  19:</span>     }</pre>
</br>
</br><pre><span>  20:</span>&nbsp; </pre>
</br>
</br><pre><span>  21:</span> }</pre>
</br>
</br>
</br>

class文件已经打包到kaptcha-2.3.2.1.jar中了，这个其实可以自定义在自己的项目中的，只不过我是为了方便以后使用，省的每次都复制代码。

</br>
</br>

&nbsp;

</br>

kaptcha在spring中也是可以使用的，我采用的是servlet的方式。为了统一整体框架，推荐使用spring的方式，如果是简单好用，那就用servlet吧！

</br>

**注：如果在spring中是配置web.xml，session中是取不到key值的，因为spring本身就是个单独的applicationcontext，要不就采用servlet的方式，要不就用spring的方式。**

</br>

spring的方式

</br>

1.bean配置，初始化默认水属性

</br>
</br>
</br><pre><span>   1:</span><span>&lt;</span><span>bean</span><span>id</span><span>=&quot;captchaProducer&quot;</span><span>class</span><span>=&quot;com.google.code.kaptcha.impl.DefaultKaptcha&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   2:</span><span>&lt;</span><span>property</span><span>name</span><span>=&quot;config&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   3:</span><span>&lt;</span><span>bean</span><span>class</span><span>=&quot;com.google.code.kaptcha.util.Config&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   4:</span><span>&lt;</span><span>constructor-arg</span><span>&gt;</span></pre>
</br>
</br><pre><span>   5:</span><span>&lt;</span><span>props</span><span>&gt;</span></pre>
</br>
</br><pre><span>   6:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.border&quot;</span><span>&gt;</span>no<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>   7:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.border.color&quot;</span><span>&gt;</span>105,179,90<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>   8:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.textproducer.font.color&quot;</span><span>&gt;</span>red<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>   9:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.image.width&quot;</span><span>&gt;</span>250<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>  10:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.textproducer.font.size&quot;</span><span>&gt;</span>90<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>  11:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.image.height&quot;</span><span>&gt;</span>90<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>  12:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.session.key&quot;</span><span>&gt;</span>code<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>  13:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.textproducer.char.length&quot;</span><span>&gt;</span>4<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>  14:</span><span>&lt;</span><span>prop</span><span>key</span><span>=&quot;kaptcha.textproducer.font.names&quot;</span><span>&gt;</span>宋体,楷体,微软雅黑<span>&lt;/</span><span>prop</span><span>&gt;</span></pre>
</br>
</br><pre><span>  15:</span><span>&lt;/</span><span>props</span><span>&gt;</span></pre>
</br>
</br><pre><span>  16:</span><span>&lt;/</span><span>constructor-arg</span><span>&gt;</span></pre>
</br>
</br><pre><span>  17:</span><span>&lt;/</span><span>bean</span><span>&gt;</span></pre>
</br>
</br><pre><span>  18:</span><span>&lt;/</span><span>property</span><span>&gt;</span></pre>
</br>
</br><pre><span>  19:</span><span>&lt;/</span><span>bean</span><span>&gt;</span></pre>
</br>
</br>
</br>

2.后台action

</br>
</br>
</br><pre><span>   1:</span> @RequestMapping(<span>&quot;/captcha-image&quot;</span>)</pre>
</br>
</br><pre><span>   2:</span><span>public</span> ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response)</pre>
</br>
</br><pre><span>   3:</span><span>throws</span> Exception {</pre>
</br>
</br><pre><span>   4:</span>         response.setDateHeader(<span>&quot;Expires&quot;</span>, 0);</pre>
</br>
</br><pre><span>   5:</span><span>// Set standard HTTP/1.1 no-cache headers.</span></pre>
</br>
</br><pre><span>   6:</span>         response.setHeader(<span>&quot;Cache-Control&quot;</span>, <span>&quot;no-store, no-cache, must-revalidate&quot;</span>);</pre>
</br>
</br><pre><span>   7:</span><span>// Set IE extended HTTP/1.1 no-cache headers (use addHeader).</span></pre>
</br>
</br><pre><span>   8:</span>         response.addHeader(<span>&quot;Cache-Control&quot;</span>, <span>&quot;post-check=0, pre-check=0&quot;</span>);</pre>
</br>
</br><pre><span>   9:</span><span>// Set standard HTTP/1.0 no-cache header.</span></pre>
</br>
</br><pre><span>  10:</span>         response.setHeader(<span>&quot;Pragma&quot;</span>, <span>&quot;no-cache&quot;</span>);</pre>
</br>
</br><pre><span>  11:</span><span>// return a jpeg</span></pre>
</br>
</br><pre><span>  12:</span>         response.setContentType(<span>&quot;image/jpeg&quot;</span>);</pre>
</br>
</br><pre><span>  13:</span><span>// create the text for the image</span></pre>
</br>
</br><pre><span>  14:</span>         String capText = captchaProducer.createText();</pre>
</br>
</br><pre><span>  15:</span><span>// store the text in the session</span></pre>
</br>
</br><pre><span>  16:</span>         request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);</pre>
</br>
</br><pre><span>  17:</span><span>// create the image with the text</span></pre>
</br>
</br><pre><span>  18:</span>         BufferedImage bi = captchaProducer.createImage(capText);</pre>
</br>
</br><pre><span>  19:</span>         ServletOutputStream out = response.getOutputStream();</pre>
</br>
</br><pre><span>  20:</span><span>// write the data out</span></pre>
</br>
</br><pre><span>  21:</span>         ImageIO.write(bi, <span>&quot;jpg&quot;</span>, out);</pre>
</br>
</br><pre><span>  22:</span><span>try</span> {</pre>
</br>
</br><pre><span>  23:</span>             out.flush();</pre>
</br>
</br><pre><span>  24:</span>         } <span>finally</span> {</pre>
</br>
</br><pre><span>  25:</span>             out.close();</pre>
</br>
</br><pre><span>  26:</span>         }</pre>
</br>
</br><pre><span>  27:</span><span>return</span> null;</pre>
</br>
</br><pre><span>  28:</span>     }</pre>
</br>
</br>
</br>

3.页面调用

</br>
</br>
</br><pre><span>   1:</span><span>&lt;</span><span>input</span><span>name</span><span>=&quot;kaptcha&quot;</span><span>type</span><span>=&quot;text&quot;</span><span>id</span><span>=&quot;kaptcha&quot;</span><span>/&gt;</span></pre>
</br>
</br><pre><span>   2:</span><span>&lt;</span><span>img</span><span>src</span><span>=&quot;/captcha-image.do&quot;</span><span>width</span><span>=&quot;55&quot;</span><span>height</span><span>=&quot;20&quot;</span><span>id</span><span>=&quot;kaptchaImage&quot;</span><span>/&gt;</span></pre>
</br>
</br>
</br>

4.验证

</br>
</br>
</br><pre><span>   1:</span> String code = (String)request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);</pre>
</br>
</br>
</br>

下载：[kaptcha修改版](http://dl.dbank.com/c0pirfrcla) | [kaptcha演示demo](http://dl.dbank.com/c0m5upf3hx)
