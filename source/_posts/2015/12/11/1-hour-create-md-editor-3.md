title: 1小时编写一个支持七牛上传的 markdown 客户端3（打包发布篇）
date:  2015-12-11 19:00:25
categories:
- 技术
tags:
- node
- javascript
- wordpress
- 七牛
- markdown

---
![time.png](http://7xon03.com1.z0.glb.clouddn.com/2015/12/11/381e522ad97c71e2f6f120e2310c6434.png "time.png")

**摘要:** 一个小时如何编写一个支持七牛上传的 markdown 编辑器的客户端。本地主要是讲解下最后的打包发布，和里面的一些注意内容。

<!--more-->

本篇的内容不会太多，就是几个打包命令的执行。

![Gruntfile.js.png](http://7xon03.com1.z0.glb.clouddn.com/2015/12/11/9f7f6ea5d4c7f5f2148572d03b05d9bc.png "Gruntfile.js.png")

我们打开 `Gruntfile.js` 这个文件。会看到有很多 `grunt.registerTask` 这样的代码，用过 `grunt` 的应该知道，这就是注册的任务，`grunt.registerTask('dist-win'` 例如这个，执行`grunt dist-win`就会打包成 window 平台的文件，对应的也就有 mac 平台 、linux 平台的。

#### **注意**

1. 打包的时候，要注意是否下载了对应的平台包。在[第一篇](http://zhaopeng.me/2015/12/8/1-hour-create-md-editor/ "第一篇") 文章中，有说明下载平台的包，否则是无法打包成功的。
2. 注意打包的时候，把`'jshint',`给注释掉。这个是Javascript代码验证工具，用来检测你的代码规范性，合理性的。比如你在 js 中写`a==b`，用`jshint`的时候，就必须是`a===b`，采用恒等的方式。还有很多要求，用`jshint`，你的代码习惯会越来越好。如果对这些不是特别严格，也可用去掉。

#### 未来计划

目前已经足够我使用，但是还有很多缺点，比如打开文章，没有插入 hexo 的文章模板，有些弹出框显示不完整等等。在以后，会慢慢加进来的。


