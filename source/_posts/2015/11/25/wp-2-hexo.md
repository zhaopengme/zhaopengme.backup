title: 从 wordpress 转移到 hexo
date: 2015-11-25 19:51:25
categories: 
- 闲言碎语
tags:  
- node
- javascript
- wordpress
---
![wordpress2hexo.png](http://7xon03.com1.z0.glb.clouddn.com/2015/11/25/92580c9bf4dda86d70335640ae5eb81e.png "wordpress2hexo.png")
**摘要:** 记录一下建博的历程,再记录一下从wordpress转移到hexo的步骤.

<!--more-->

从08年开始博客后,用过不少的博客程序,pjblog zblog typecho wordpress gae,还用过一些博客服务,35blog Google博客 点点博客 sae等.各有各的优势,反正是掏钱的稳定放心,免费的不稳定.最近用过的sae,用sae原因是当时有微博认证,用sae基本可以免费使用.自从sae修改了策略之后,送得1万豆也在前几天用完了.现在的我懒得折腾这些,就开始寻找了屌丝使用.一个免费,能绑定域名,还能少折腾的方式.

# 选择 github 的好处

1. github 免费提供了一个 github Pages 服务,300M 的空间,足够屌丝们使用.
2. 可以绑定域名.
3. 现在流行使用这个,程序员用这个感觉有点 B 格.
4. 可以使用 markdown 来编写.

# 选择哪种 github pages 的博客程序

可以选择有 jekyll octopress hexo 等一些, 我调查了一些, jekyll octopress 使用比较复杂, hexo 生成静态文件速度快,但我700多篇文章,也用了1分多钟.

# 从 wordpress 转移到 hexo

1. 进入 wordpress 后台设置,选择导出,会打出一个`wordpress.xml` 文件.
2. 安装 [hexo-migrator-wordpress](https://github.com/hexojs/hexo-migrator-wordpress "hexo-migrator-wordpress") 插件,执行`hexo migrate wordpress wordpress.xml`, 就会转化成 `.md` 格式化的文件.这个过程中,可能会有些错误,无法转换的问题,一般都是 wordpress 文章有一些特殊字符的问题,根据错误修改吧!
3. 如果成功,那么你只需要执行 `hexo g` 和 `hexo d` 就可以发布了.

# 注意

**重要的事情要说三次,从 wordpress 转成 hexo 会丢失留言数据.** **重要的事情要说三次,从 wordpress 转成 hexo 会丢失留言数据.** **重要的事情要说三次,从 wordpress 转成 hexo 会丢失留言数据.**