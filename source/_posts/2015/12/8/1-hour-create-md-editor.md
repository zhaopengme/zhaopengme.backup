title: 1小时编写一个支持七牛上传的 markdown 客户端1（技术实现篇）
date: 2015-12-08 12:54:13
categories:
- 技术

tags:
- node
- javascript
- wordpress
- 七牛
- markdown

---
![ndpeditor.png](http://7xon03.com1.z0.glb.clouddn.com/2015/12/08/bffe04a1380011469f7c74083750c44c.png "ndpeditor.png")

**摘要:** 一个小时如何编写一个支持七牛上传的 markdown 编辑器的客户端。如何能从零快速学习 nodejs，并付诸实践。

<!--more-->

# 介绍

说是一个小时，前前后后加上代码重构，优化代码，也用了一两天得时间，但在写第一版代码的时候，的确用了很短的时候。

[https://github.com/zhaopengme/ndpediter](https://github.com/zhaopengme/ndpediter "https://github.com/zhaopengme/ndpediter")

# 技术点

在做这个的时候，出发点是因为 hexo 编辑的时候，我需要使用七牛的图片外链，但是没有一个好用的支持七牛图片外链的工具。就有了自己动手做一个念头，在技术选择的时候，我最熟悉的是后台 java，前端 javascript 的搭配，因为要写一个客户端，首先想到的时候用纯 java 来实现，之前我也用 java 写过一个支持 markdown 的笔记软件 [jnote](http://www.oschina.net/p/jnote "jnote") ,或者做一个 web 网站，再加一个浏览器的壳，在几年之前，我写过这样的一个 demo [https://github.com/zhaopengme/jbrower-demo](https://github.com/zhaopengme/jbrower-demo "https://github.com/zhaopengme/jbrower-demo")，就是用 Mozilla 内核的浏览器框架，嵌入 web 网站的方式。可目前已经有了 node-webkit 这样的技术，就不需要的我之前的想法。用了node-webkit，搭配最好的就是 nodejs 了，我就放弃了用 java 来实现的方式，虽然我不会 nodejs，但这也给了我一个学习的 nodejs 的机会了。那就开始上手了。

## 在内嵌 web 系统和纯 nodejs 的选择

在开始设计的时候，依照我原来的想法，是采用内嵌一个 web 系统，通过 node-webkit 来打开内嵌的 web 系统来实现的，所有我开始学习 express 的文档。看了 [http://www.expressjs.com.cn/](http://www.expressjs.com.cn/ "http://www.expressjs.com.cn/") 文档后，我尝试着使用纯 nodejs 的方式来实现我的需要，读写文件，图片保存，图片上传，发现也是可以的，其实开头想想也是可以的，只是自己一个惯性思维导致的。

## 技术干货列表

1. nodejs
2. node-webkit
3. qiniu-nodejs-sdk
4. yeoman
5. generator-node-webkit
6. layer
7. editormd

### 1. nodejs

主要用来实现文件的读写，图片的上传。

### 2. node-webkit

基于node.js和chromium的应用程序实时运行环境，可运行通过HTML(5)、CSS(3)、Javascript来编写的本地应用程序。从网上扒的介绍，为了占位。

### 3. qiniu-nodejs-sdk

[https://github.com/qiniu/nodejs-sdk.v6](https://github.com/qiniu/nodejs-sdk.v6 "https://github.com/qiniu/nodejs-sdk.v6")

七牛的 nodejs 的 api。

### 4. yeoman

[http://yeoman.io/](http://yeoman.io/ "http://yeoman.io/")

Yeoman 是 Google 的团队和外部贡献者团队合作开发的，他的目标是通过Grunt（一个用于开发任务自动化的命令行工具）和Bower（一个HTML、CSS、Javascript和图片等前端资源的包管理器）的包装为开发者创建一个易用的工作流。

Yeoman 的目的不仅是要为新项目建立工作流，同时还是为了解决前端开发所面临的诸多严重问题，例如零散的依赖关系。

也是从网上扒的介绍，也是为了占位。Yeoman 可以说是对已经成为体系的流程工具的封装，更简单说是"一键开发，一键部署"等等。是 `generator-node-webkit` 使用的前提。

### 5. generator-node-webkit

[https://github.com/Dica-Developer/generator-node-webkit](https://github.com/Dica-Developer/generator-node-webkit "https://github.com/Dica-Developer/generator-node-webkit")

generator-node-webkit 是基于 Yeoman 的工具，可以"一键"创建 node-webkit 的开发环境，"一键"打包环境。

### 6. layer

[http://layer.layui.com/](http://layer.layui.com/ "http://layer.layui.com/")

一个 jquery 的弹出框插件，我觉得它好用，就单独拉出来了，好东西，值得推荐。比如我得图片上传 配置 关于 保存提醒等都是使用它的。

### 7. editormd

[https://github.com/pandao/editor.md](https://github.com/pandao/editor.md "https://github.com/pandao/editor.md")

编辑器实现的核心，实现编辑器最为主要的组成部分，在各种 markdown 实现的各种版本中，最优秀的编辑器之一，10分推荐。

> 在开始实现之前，最好先看一下以上的几种技术的说明，方便我们理解。

# 技术实现篇

## 环境准备

### nodejs 环境

作为 hexo 的使用者，nodejs 肯定会有的，即使没有，那自己安装吧，这个很容易。[https://nodejs.org/](https://nodejs.org/ "https://nodejs.org/")。我装得 mac 版，不会告诉你用 mac 装很多东西都是用 `brew` 可以一键安装的。

### yeoman 安装

`npm install -g yo` 这是官方的安装，有可能安装成功了，之后 node-webkit 安装会出现问题，最好用这个 `npm i -g yo generator-karma`。

### generator-node-webkit 安装

`npm install generator-node-webkit -g` 用 npm 都是一行命令搞定，很容易吧！用 mac 的童鞋，有没有装 brew 呢？装个 brew 吧！无论是装13还是为了自己开发方便。

## 生成开发环境

以上 yeoman 和 generator-node-webkit 我们采用的都是安装全局的办法。

### 1. 自动创建目录结构
`yo node-webkit` 就能生成好我们需要的环境目录了,好吧！这里录个 gif 给大家看看。

![generator-node-webkit.gif](http://7xon03.com1.z0.glb.clouddn.com/2015/12/08/c7038a7a132c6b0145b448c8091dec7c.gif "generator-node-webkit.gif")

**注意**
> 1. mac 现在基本都是64位的了，不要选择32位的。
> 2. 这个要下载 对应平台的资源，比较慢，我就停止录了。

当前创建完成后，就会有下面这样的界面了。

![yo node-webkit](http://7xon03.com1.z0.glb.clouddn.com/2015/12/08/7d460dbc713fe6d9a6655ce88977b4b1.png "yo node-webkit")

### 2. 下载依赖

`npm install & bower install` 按照提醒，就可以把相关的依赖全部安装了。如果提醒没有 bower，那就 `npm install bower -g`，bower 也是个常用工具，也作为全局安装吧。

### 3. 下载项目依赖

前几个步骤，可以叫做工程依赖，就是每一个这样的工程，都需要这样的步骤的，这个步骤是说，我们项目需要的依赖。比如 qiniu-nodejs-sdk 就是我们项目需要的，可以通过 `npm install qiniu`来安装，如果我们需要 bootstrap，那么就可以用 `bower install bootstrap`或者`npm install bootstrap` 来安装。我是手动安装我需要的 js 插件之类的。

`npm install qiniu --save`  下载七牛的 sdk。

`npm install path-extra --save` 一个获取系统目录，临时目录的。

`npm install fs-utils --save` 一个文件工具，可以很方便的同步、异步读取文件，还可以读写 json。

我们带上`--save`，这样就说明是我们项目中使用的，在`package.json`就添加了项目的依赖。

我们的项目结构就是这样的了。

![项目结构](http://7xon03.com1.z0.glb.clouddn.com/2015/12/08/1fa478dff286fad401d0ec625e9b49a2.png "项目结构")

本来是打算把代码说明也放到本篇的，写到这里，发现内容会很长，那就放到下一篇文章吧！下一篇文章包含代码讲解和代码优化，以及如何进行模块化分割。

github 上面有代码，结合本篇步骤，再加上源码，也是可以看懂的，源码真得很简单。

[https://github.com/zhaopengme/ndpediter](https://github.com/zhaopengme/ndpediter "https://github.com/zhaopengme/ndpediter")

这个文件是我第一版写的未经过优化的 demo 版本，下一篇会讲解如何将这个文件进行模块化分割。
[https://github.com/zhaopengme/ndpediter/blob/master/demo.js](https://github.com/zhaopengme/ndpediter/blob/master/demo.js "https://github.com/zhaopengme/ndpediter/blob/master/demo.js")


