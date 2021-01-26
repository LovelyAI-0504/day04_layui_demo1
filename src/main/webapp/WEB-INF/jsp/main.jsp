<%--
  Created by IntelliJ IDEA.
  User: Lovely_AI
  Date: 2021/1/23
  Time: 15:40:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台布局页面</title>
</head>
<link type="text/css" rel="stylesheet" href="/layui/css/layui.css"/>
<script type="text/javascript" src="/layui/layui.js"></script>
<script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

    layui.use("element",function (){

        var element = layui.element;

        //1.响应menu的click事件
        $(".menu").click(function (){
            //获取title id url的值  attr("XXX")为获取名为XXX标签的属性值
            var title = $(this).text();
            var id = $(this).attr("id");
            var url = $(this).attr("url");
            //打印
            //console.log(title+":"+id+":"+url);
            //这个选没有增加过，就先增加
            if ($("li[lay-id="+id+"]").length==0){
                element.tabAdd("docDemoTabBrief",{
                    //标签标题
                    title:title,
                    //标签内容                                                 //scrolling="no"为边框线
                    content:'<iframe width="100%" height="100%" frameborder="0" scrolling="no" src='+url+'></iframe>',
                    id:id
                });
            };
            element.tabChange('docDemoTabBrief', id);//根据id来切换tab
        });
    });

</script>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">AI の 后台布局</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="/img/touxiang.gif" class="layui-nav-img">
                    Lovely_AI
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">项目模块</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="menu" id="101" url="showList">查看商品</a></dd>
                        <dd><a href="javascript:;">超链接</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">解决方案</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">列表一</a></dd>
                        <dd><a href="javascript:;">列表二</a></dd>
                        <dd><a href="javascript:;">超链接</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">云市场</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">阿里云</a></dd>
                        <dd><a href="javascript:;">百度云</a></dd>
                        <dd><a href="javascript:;">腾讯云</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="">发布商品</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->                                         <!--lay-allowClose="true" 为是否在后面增加删除按钮-->
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" lay-allowClose="true">
            <ul class="layui-tab-title">
                <li class="layui-this">网站首页</li>

            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe width="100%" height="100%" frameborder="0" scrolling="no" src="index.jsp"></iframe>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © Aic.com - 底部固定区域
    </div>
</div>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>
</body>
</html>
