<%--
  Created by IntelliJ IDEA.
  User: Lovely_AI
  Date: 2021/1/21
  Time: 8:49:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品数据添加页面</title>
</head>
<link type="text/css" rel="stylesheet" href="/layui/css/layui.css"/>
<script type="text/javascript" src="/layui/layui.js"></script>
<script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

    layui.use(['layer','form'],function () {
        var layer = layui.layer;
        var form = layui.form;

        //监听增加用户表单中的submitbutton
        form.on('submit(addCloFilter)',function (data) {
            // console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
            // console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
            // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}

            //1.这个表单元素中的值  data.field.name
            $.ajax({
                //type:请求的方法  //post  //get  //可以直接在ajax处换成post,这里就不用写
                type:"post",
                //url:向服务器发送的请求
                url:"/Clo/save",
                //向服务器发送的数据 //数据类型格式为:data: "typename="+data.field.typename+"&discription="+data.field.discription
                data:$("#addCloForm").serialize(),
                //回调方法,服务器成功返回数据，这个方法就执行
                success:function (resp){
                    layer.msg(resp.msg);
                },
                //服务器未返回数据，这个方法就执行
                error:function (){
                    layer.msg("出错啦!!!");
                }
            });

            //return true就是进行http请求,这里我们要进行ajax请求,所有要return false
            return false;
        });

    });

</script>
<body>
<div style="margin: 0 auto;width: 800px;border: 1px solid black">
    <form class="layui-form" id="addCloForm"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
        <div>
            <h2 style="text-align: center;margin: 10px 0;">商品添加页面</h2>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">品牌名称</label>
            <div class="layui-input-block">
                <input type="text" name="typename" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">商品介绍</label>
            <div class="layui-input-block">
                <input type="text" name="discription" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">上架时间</label>
            <div class="layui-input-block">
                <input type="date" name="ontime" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">商品价格</label>
            <div class="layui-input-block">
                <input type="text" name="price" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">图片位置</label>
            <div class="layui-input-block">
                <input type="text" name="picpath" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="addCloFilter">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>

        <!-- 更多表单结构排版请移步文档左侧【页面元素-表单】一项阅览 -->
    </form>
</div>
</body>
</html>
