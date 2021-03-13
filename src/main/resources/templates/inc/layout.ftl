<#--宏：1.macro定义脚本，名为layout，参数为title-->
<#macro layout title>
 <!DOCTYPE html>
 <html>
 <head>
  <meta charset="utf-8">
  <title>${title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="fly,layui,前端社区">
  <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
  <link rel="stylesheet" href="/res/layui/css/layui.css">
  <link rel="stylesheet" href="/res/css/global.css">

     <#--导入script-->
  <script src="/res/layui/layui.js"></script>
  <script src="/res/js/jquery.min.js"></script>
 </head>
 <body>

 <#--宏common.ftl：分页、一条数据posting、个人账户-左侧链接（我的主页、用户中心、基本设置、我的消息）-->
 <#include "/inc/common.ftl" /><#--经过测试，发现common公共包，必须在header.ftl等之前进行“include导入”-->

 <#--【一、导航栏】-->
 <#include "/inc/header.ftl"/>

 <#--【三、所有引用该“带有宏的标签layout.ftl”都会执行该操作：<@layout "首页"></@layout>中的数据 -> 填充到<#nested/>标签中】-->
 <#nested>

 <#--【四、页脚】-->
 <#include "/inc/footer.ftl"/>

 <script>
   <#-----------------方式一：利用shiro来实现【登录状态】---------------------->
   <#--未登录的状态-->
   <#--【shiro.guest】：验证当前用户是否为 “访客”，即未认证（包含未记住）的用户
   <@shiro.guest>
       // layui.cache.page = '';
       layui.cache.user = {
           username: '游客'
           , uid: -1
           , avatar: '/res/images/avatar/00.jpg'
           , experience: 83
           , sex: '男'
       };
       layui.config({
           version: "3.0.0"
           ,base: '/res/mods/' //这里实际使用时，建议改成绝对路径
       }).extend({
           fly: 'index'
       }).use('fly');
   </@shiro.guest>
   -->

   <#--登录后的状态-->
   <#--【shiro.user】：认证通过或已记住的用户
   <@shiro.user>
       // layui.cache.page = '';
       layui.cache.user = {
           username: <@shiro.principal property="username"/>
           , uid: <@shiro.principal property="id"/>
           , avatar: <@shiro.principal property="avatar"/>
           , experience: 83
           , sex: <@shiro.principal property="gender"/>
       };
       layui.config({
           version: "3.0.0"
           , base: '/res/mods/' //这里实际使用时，建议改成绝对路径
       }).extend({
           fly: 'index'
       }).use('fly');
   </@shiro.user>
   -->

   <#-----------------方式二：利用session来实现【登录状态】---------------------->
   // layui.cache.page = '';
   layui.cache.user = {
     username: '${profile.username!"游客"}'
     , uid: ${profile.id!"-1"}
     , avatar: '${profile.avatar!"/res/images/avatar/00.jpg"}'
     , experience: 83
     , sex: '${profile.gender!"男"}'
   };

   layui.config({
     version: "3.0.0"
     , base: '/res/mods/' //这里实际使用时，建议改成绝对路径
   }).extend({
     fly: 'index'
   }).use('fly');
 </script>

 </body>
 </html>
</#macro>