title: underscorejs 源码走读笔记
tags:
  - javascript
  - js
  - js工具包
  - underscorejs
id: 963
categories:
  - web
  - 框架推荐
  - 网文收藏
date: 2015-03-23 08:53:32
---

from: [http://www.html-js.com/article/2134](http://www.html-js.com/article/2134)

Underscore 简介

Underscore 是一个JavaScript实用库,提供了类似Prototype.js的一些功能,但是没有继承任何JavaScript内置对象。它弥补了部分jQuery没有实现的功能,同时又是Backbone.js必不可少的部分。

Underscore提供了80多个函数,包括常用的: map, select, invoke — 当然还有更多专业的辅助函数,如:函数绑定, JavaScript模板功能, 强类型相等测试, 等等. 在新的浏览器中, 有许多函数如果浏览器本身直接支持,将会采用原生的,如 forEach, map, reduce, filter, every, some 和 indexOf.

个人感受

Underscore 是一个我坚持看完的js源代码，他简单、易懂、实用，细心观察就会发现，每个函数都很简短，作为开源阅读源码，我相信Underscore是不错的选择

<!--more-->

**笔记**

1：大量的这种方法，应该是 防止原始方法被篡改，同时加快运行速度，而且在严格模式，也不让通过arguments.callee 调用相关方法的原因吧
<pre>var ArrayProto = Array.prototype,
    ObjProto = Object.prototype,
    FuncProto = Function.prototype;

// Create quick reference variables for speed access to core prototypes.
var
push = ArrayProto.push,
    slice = ArrayProto.slice,
    concat = ArrayProto.concat,
    toString = ObjProto.toString,
    hasOwnProperty = ObjProto.hasOwnProperty;</pre>
2：void 0，开始还好奇为啥用void 0，是undefined 的缩写？后来一打听才知道，原来undefined在旧版本的浏览器中是不可以被赋值的，而新版本的浏览器是可以被赋值的，为了准确的判断，所以就有了void 0
<pre>_.first = _.head = _.take = function(array, n, guard) {
    if (array == null) return void 0;
    if ((n == null) || guard) return array[0];
    if (n &lt; 0) return [];
    return slice.call(array, 0, n);
};</pre>
3：代码短小精干

Underscore 代码短小精干没的说，真是精品

除了 eq 这个方法长点外 其他方法都很短

4：遗憾 这次走读 没记录笔记没调试

本菜鸟第一次走读源码 同时欢迎大家把源码走读 放到这个专栏下 O(∩_∩)O~