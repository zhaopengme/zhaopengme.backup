title: iconfont.cn 阿里出品的矢量图标库
tags:
  - icon
  - 图标
  - 工具
  - 推荐
categories: 资料文档
date: 2014-10-22 06:15:50
---

[Iconfont.cn](http://www.iconfont.cn/)是阿里巴巴推出的矢量图标库，其中涵盖了1000多个常用图标，并在持续更新中。（目前已有7000+图标，部分图标为用户上传，因此默认不公开，但是可以搜索到。）

[![iconfont](http://coderzhaopeng-wordpress.stor.sinaapp.com/uploads/2014/09/iconfont.png)](http://coderzhaopeng-wordpress.stor.sinaapp.com/uploads/2014/09/iconfont.png)

&nbsp;

## Iconfont提供以下功能：

*   在线图标搜索
*   图标分捡下载
*   在线储存
*   矢量格式转换
*   图标库管理

## iconfont的优势

*   自由变化大小（高清屏无压力）
*   自由修改颜色（纯色）
*   可以添加一些视觉效果如：阴影、旋转、透明度

## iconfont使用

1.  声明字体

    <span class="at_rule">@<span class="keyword">font-face</span></span> <span class="rules">{<span class="rule"><span class="attribute">font-family</span>:<span class="value"> <span class="string">'iconfont'</span>;</span></span>
        <span class="rule"><span class="attribute">src</span>:<span class="value"> <span class="function">url(<span class="string">'iconfont.eot'</span>)</span>;</span></span> <span class="comment">/* IE9*/</span>
        <span class="rule"><span class="attribute">src</span>:<span class="value"> <span class="function">url(<span class="string">'iconfont.eot?#iefix'</span>)</span> <span class="function">format(<span class="string">'embedded-opentype'</span>)</span>, <span class="comment">/* IE6-IE8 */</span>
        <span class="function">url(<span class="string">'iconfont.woff'</span>)</span> <span class="function">format(<span class="string">'woff'</span>)</span>, <span class="comment">/* chrome、firefox */</span>
        <span class="function">url(<span class="string">'iconfont.ttf'</span>)</span> <span class="function">format(<span class="string">'truetype'</span>)</span>, <span class="comment">/* chrome、firefox、opera、Safari, Android, iOS 4.2+*/</span>
        <span class="function">url(<span class="string">'iconfont.svg#iconfont'</span>)</span> <span class="function">format(<span class="string">'svg'</span>)</span>;</span></span> <span class="comment">/* iOS 4.1- */</span>
    <span class="rule">}</span></span>
    `</pre>
2.  定义样式
    <pre>`<span class="class">.iconfont</span><span class="rules">{<span class="rule"><span class="attribute">font-family</span>:<span class="value"><span class="string">"iconfont"</span>;</span></span>
    <span class="rule"><span class="attribute">font-size</span>:<span class="value"><span class="number">16</span>px;</span></span><span class="rule"><span class="attribute">font-style</span>:<span class="value">normal;</span></span><span class="rule">}</span></span>
    `</pre>
3.  选择图标、获取字体编码，应用于页面
    <pre>`<span class="tag">&lt;<span class="title">i</span> <span class="attribute">class</span>=<span class="value">"iconfont"</span>&gt;</span>&amp;#33<span class="tag">&lt;/<span class="title">i</span>&gt;</span>
