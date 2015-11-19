title: 上传攻击框架
tags:
  - 安全
id: 999
categories:
  - 框架推荐
date: 2015-01-08 06:11:39
---

<span style="line-height: 1.5em;">作者是阿里巴巴安全工程师</span>[@卷成团变成个球的CasperKid君](http://weibo.com/n/%E5%8D%B7%E6%88%90%E5%9B%A2%E5%8F%98%E6%88%90%E4%B8%AA%E7%90%83%E7%9A%84CasperKid%E5%90%9B)<span style="line-height: 1.5em;"> 。文章是CK在2011年编写的，在当下仍具有非常重要参考价值。很多web 站点存在上传验证方式不严格的安全缺陷,是web 渗透中关键的突破口 ，站长小伙伴要注意哦！</span>

0x00 上传检测流程概述
0x01 客户端检测绕过(javascript 检测)
0x02 服务端检测绕过(MIME 类型检测)
0x03 服务端检测绕过(目录路径检测)
0x04 服务端检测绕过(文件扩展名检测)
- 黑名单检测
- 白名单检测
- .htaccess 文件攻击
0x05 服务端检测绕过(文件内容检测)
- 文件幻数检测
- 文件相关信息检测
- 文件加载检测
0x06 解析攻击
- 网络渗透的本质
- 直接解析
- 本地文件包含解析
- .htaccess 解析
- web 应用程序解析漏洞及其原理
0x07 上传攻击框架
- 轻量级检测绕过攻击
- 路径/扩展名检测绕过攻击
- 文件内容性检测绕过攻击
- 上传攻击框架
- 结语

下载: [Upload_Attack_Framework.pdf](http://www.owasp.org.cn/OWASP_Training/Upload_Attack_Framework.pdf)
