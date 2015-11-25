title: db2 substr语法
id: 61
categories: 闲言碎语
date: 2012-10-13 14:42:50
tags:
---

做代码迁移,要把oracle迁移到db2上面,遇到了substr的使用,老是报错.原因是oralce的substr的postion从0开始,而db2的substr的postion从1开始,这个设计有些不合常规了啊!程序猿数数的时候都是从0开始的啊!
