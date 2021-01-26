<%--
  Created by IntelliJ IDEA.
  User: Lovely_AI
  Date: 2021/1/22
  Time: 10:46:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图片上传页面</title>
</head>

<link type="text/css" rel="stylesheet" href="/layui/css/layui.css"/>
<script type="text/javascript" src="/layui/layui.js"></script>
<script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    layui.use(['upload','layer'],function (){
        var layer = layui.layer;
        var upload = layui.upload;

        upload.render({
            elem:"#upLoadImg",
            url:'upLoad',
            done:function (resp){
                layer.msg(resp.msg);
                var img1=$("<img/>").prop("src","upload/"+resp.path);
                $("#imgDiv").append(img1);
            },
            error:function (){
                layer.msg("上传图片出错啦!!!")
            }
        });
    })
</script>

<body>
    <button type="button" class="layui-btn" id="upLoadImg">
        <i class="layui-icon">&#xe67c;</i>上传图片
    </button>
    <div id="imgDiv">

    </div>
</body>
</html>
