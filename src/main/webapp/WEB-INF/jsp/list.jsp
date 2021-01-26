<%--
  Created by IntelliJ IDEA.
  User: Lovely_AI
  Date: 2021/1/20
  Time: 8:32:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>分页查询</title>
</head>
<link type="text/css" rel="stylesheet" href="/layui/css/layui.css"/>
<script type="text/javascript" src="/layui/layui.js"></script>
<script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    layui.use(['layer','table','util','form','laydate','upload'],function (){
        var layer = layui.layer;
        var table = layui.table;
        var util = layui.util;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        //1.显示表格内容
        var tabins = table.render({
            elem:"#table",
            height:300,
            url:"/show/list",
            page:true,
            limit:3,
            limits:[3,6],
            cols:[[
                //第5步添加
                // {checkbox:true},
                {field:"id",align:"center",title:"编号"},
                {field:"title",align:"center",title:"标题"},
                {field:"posttime",align:"center",title:"发帖时间",templet: function(d) {return util.toDateString(d.posttime);},edit: true},
                {field:"clicknum",align:"center",title:"点击数"},
                {field:"topic",align:"center",title:"板块名称",templet: function(d) {return d.topic.topicname},edit: true},

                //第4步添加
                {title:"编辑",align:"center",toolbar:'#toolbar1'},
                {title:"详情",align:"center",toolbar:'#toolbar3'},
                {title:"删除",align:"center",toolbar:'#toolbar2'}
            ]]
        });


        //2.增加用户btn  click事件
        //1.打开一个对框
        $("#addPostBtn").click(function (){
            //1.打开一个对框
            layer.open({
                type:1,
                title:'宏鹏论坛发帖',
                area:['800px','600px'],
                content:$("#addPostDiv")
            });

            //往下拉框设置
            $.ajax({
                type: 'post',
                url: '/show/Top',
                success:function (data) {
                    $("#selectId")[0].options.length=0;
                    $.each(data,function (index,item) {
                        $('#selectId').append(new Option(item.topicname,item.topicid));
                    })
                    //刷新表单
                    form.render();
                }
            })

            //上传图片
            upload.render({
                elem:"#upLoadImg",
                url:'upLoad',
                done:function (resp){
                    layer.msg(resp.msg);
                    var img1=$("<img style='height: 100px;width: 100px'/>").prop("src","upload/"+resp.path);
                    $("#imgDiv").append(img1);
                    //给隐藏域 图片地址 赋值
                    var a=$("#imgPic").attr("value",resp.path);
                },
                error:function (){
                    layer.msg("上传图片出错啦!!!")
                }
            });
        });

        //3.完成表单的提交
        //监听增加用户表单中的submitbutton
        form.on('submit(addPostFilter)',function (data) {
            $.ajax({
                //type:请求的方法  //post  //get  //可以直接在ajax处换成post,这里就不用写
                type:"post",
                //url:向服务器发送的请求
                url:"/Post/save",
                //向服务器发送的数据 //数据类型格式为:data: "typename="+data.field.typename+"&discription="+data.field.discription
                data:$("#addPostForm").serialize(),
                //回调方法,服务器成功返回数据，这个方法就执行
                success:function (resp){
                    //将jquery对象转换成dom对象,完成重置功能
                    $("#addPostForm")[0].reset();
                    //关闭所有打开的对话框
                    layer.closeAll();
                    //刷新table  重载这个表格中的数据
                    tabins.reload();
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


        //4.表格的工具栏编辑事件
        table.on('tool(postTableFilter)',function (data) {
            //当点击的按钮是edit编辑时
            console.log(data.event)
            if (data.event == "edit"){
                //先清空DIV 下面在装入自己的图片
                $("#imgDiv1").empty();
                var postId = data.data.id;
                //将数据查找出来
                $.ajax({
                    type:'post',
                    url:'/post/toupd',
                    data:'id='+ postId,
                    //发送一个请求回显两个数据 一个根据id搜索的数据  一个下拉列表的数据
                    success:function (data) {
                        //将要修改的数据回显在窗口中
                        form.val("updatePostFormFilter",{
                            "id":data.post.id,
                            "title":data.post.title,
                            "content":data.post.content,
                                        //调用修改日期方法
                            "posttime":sdf(data.post.posttime)
                        });
                        var imgupd=$("<img style='height: 100px;width: 100px'/>").prop("src","upload/"+data.post.pic);
                        //循环下拉列表数据
                        $("#selectId1")[0].options.length=0;
                        $.each(data.top,function (index,item) {
                            //添加数据
                            $('#selectId1').append(new Option(item.topicname,item.topicid));
                            //根据上面的id来默认选中一个下拉列表数据
                            $("#selectId1").find("option[value="+data.post.topicid+"]").prop("selected",true);
                        })
                        //刷新表单
                        form.render();
                        $("#imgDiv1").append(imgupd);

                    }
                });
                layer.open({
                    type:1,
                    title:'修改用户',
                    area:['800px','600px'],
                    content:$("#updPostDiv")
                });

            }


            //6.表格的工具栏删除事件
            else if (data.event == "del"){
                var postId = data.data.id;
                layer.confirm('确认要删除?', {icon: 3, title:'提示'}, function(index){
                    layer.msg(postId);
                    $.ajax({
                        type:"get",
                        url:"/post/del",
                        data:'id='+postId,
                        success:function (resp) {
                            //如果删除成功，删除表格这一行[将这个表格reload()]
                            //data.tr.remove();
                            //如果删除成功,重载这个表格中的数据
                            tabins.reload();
                            layer.msg(resp.msg);
                        },
                        error:function (){
                            layer.msg("删除失败!!!");
                        }
                    });
                });

            //点击详细案件
            }else {
                var postId = data.data.id;
                //将数据查找出来
                $.ajax({
                    type:'post',
                    url:'/post/showImg',
                    data:'id='+ postId,
                    //发送一个请求回显两个数据 一个根据id搜索的数据  一个下拉列表的数据
                    success:function (data) {
                        $("#showImg").empty();
                        var img1=$("<img style='height: 100%;width: 100%'/>").prop("src","upload/"+data.path);
                        $("#showImg").append(img1);
                        tabins.reload();
                    },
                    error:function (){
                        layer.msg("图片出错啦!!!");
                    }
                });
                layer.open({
                    type:1,
                    title:'图片',
                    area:['800px','600px'],
                    content:$("#showImgDiv")
                });
            }
        });

        //上传图片
        upload.render({
            elem:"#upLoadImg1",
            url:'upLoad',
            done:function (resp){
                $("#imgDiv1").empty();
                layer.msg(resp.msg);
                var img1=$("<img style='height: 100px;width: 100px'/>").prop("src","upload/"+resp.path);
                $("#imgDiv1").append(img1);
                //给隐藏域 图片地址 赋值
                $("#imgPic1").attr("value",resp.path);
            },
            error:function (){
                layer.msg("上传图片出错啦!!!")
            }
        });

        //修改日期方法
        function sdf(time){
            return util.toDateString(time.ontime,"yyyy-MM-dd")
        }

        //5.修改数据
        //监听增加用户表单中的submitbutton
        form.on('submit(updPostFilter)',function (data) {
            $.ajax({
                //type:请求的方法  //post  //get  //可以直接在ajax处换成post,这里就不用写
                type:"post",
                //url:向服务器发送的请求
                url:"/Post/upd",
                //向服务器发送的数据 //数据类型格式为:data: "typename="+data.field.typename+"&discription="+data.field.discription
                data:$("#updPostForm").serialize(),
                //回调方法,服务器成功返回数据，这个方法就执行
                success:function (resp){
                    //将jquery对象转换成dom对象,完成重置功能
                    $("#updPostForm")[0].reset();
                    //关闭所有打开的对话框
                    layer.closeAll();
                    //刷新table  重载这个表格中的数据
                    tabins.reload();
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


        //7.响应查询按键
        //往下拉框设置
        $.ajax({
            type: 'post',
            url: '/show/Top',
            success:function (data) {
                $('#selectIdTop').append(new Option("未选择",""));
                $.each(data,function (index,item) {
                    $('#selectIdTop').append(new Option(item.topicname,item.topicid));
                })
                //刷新表单
                form.render();
            }
        })
        form.on('submit(queryPostFilter)',function (data){
            console.log(data.field.title+":"+data.field.topicid);
            tabins.reload({
                where :{
                    //name请求参数名称  请求参数的值
                    title:data.field.title,
                    topicid:data.field.topicid,
                    clicknum:data.field.clicknum,
                    clicknum1:data.field.clicknum1
                },
                method:'post',
                page:{
                    curr:1
                }
            });
            return false;
        })




    });

</script>
<body>

    <!-- table上的按钮 增加与删除用户 开始 -->
    <div align="left" style="width: 1300px;margin: 0 auto;">
        <div>
            <button class="layui-btn layui-btn-radius  layui-btn-warm" id="addPostBtn">增加用户</button>
            <button class="layui-btn layui-btn-radius  layui-btn-warm" id="delClorBtn">删除用户</button>
        </div>

        <form class="layui-form" id="queryPostFilter">
            <div class="layui-form-item" style="margin: 10px 0 0 -65px">
                <label class="layui-form-label">标题</label>
                <div class="layui-input-inline">
                    <input type="text" name="title" placeholder="请输入标题" autocomplete="off" class="layui-input">
                </div>

                <label class="layui-form-label" style="padding-left: 0;width: 50px">板块</label>
                <div class="layui-input-inline" style="width: 90px;">
                    <select id="selectIdTop" name="topicid"></select>
                </div>
                <label class="layui-form-label" style="padding-left: 0;width: 50px">点击数</label>
                <div class="layui-input-inline" style="width: 80px;">
                    <input type="text" name="clicknum" placeholder="小" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 10px;padding-left: 0">到</label>
                <div class="layui-input-inline" style="width: 80px;">
                    <input type="text" name="clicknum1" placeholder="大" autocomplete="off" class="layui-input">
                </div>

                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="queryPostFilter">立即查询</button>

                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>

        <table id="table" lay-filter="postTableFilter"></table>
    </div>

    <!-- style="display: none"-->
<%--    <div align="center" >--%>
<%--        <a href="toAdd">添加页面</a><br>--%>
<%--        <a href="toUpload">文件上传</a><br>--%>
<%--        <a href="toTree">tree</a><br>--%>
<%--    </div>--%>

    <!--增加用户表单  开始 -->
    <div id="addPostDiv" style="display: none">
        <div style="margin: 0 auto;width: 600px;">
            <form class="layui-form" id="addPostForm"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
                <div>
                    <h2 style="text-align: center;margin: 10px 0;">宏鹏论坛发帖</h2>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">标题</label>
                    <div class="layui-input-block">
                        <input type="text" name="title" placeholder="请输入标题" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">帖子类型</label>
                    <div class="layui-input-block">
                        <select id="selectId" name="topicid"></select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">帖子内容</label>
                    <div class="layui-input-block">
                        <textarea name="content" placeholder="请输入内容" class="layui-textarea"></textarea>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">发布时间</label>
                    <div class="layui-input-block"><!--id="onTime"-->
                        <input type="date" name="posttime" placeholder="请输入" autocomplete="off" class="layui-input onTime" autocomplete="off">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">上传图片</label>
                    <button type="button" class="layui-btn" id="upLoadImg">
                        <i class="layui-icon">&#xe67c;</i>上传图片
                    </button>
                    <div id="imgDiv" style="height: 100px;width: 100px;float: right;margin-right: 200px"></div>
                </div>

                <input type="hidden" name="pic" id="imgPic">

                <div class="layui-form-item">
                    <div class="layui-input-block" style="float: right;">
                        <button class="layui-btn" lay-submit lay-filter="addPostFilter">发帖</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>

                <!-- 更多表单结构排版请移步文档左侧【页面元素-表单】一项阅览 -->
            </form>
        </div>
    </div>
    <!--增加用户表单 结束 -->

    <!-- table中的工具条  修改与删除  开始-->
    <script type="text/html" id="toolbar1">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    </script>
    <script type="text/html" id="toolbar2">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <script type="text/html" id="toolbar3">
        <a class="layui-btn layui-btn-norma layui-btn-xs" lay-event="detail">详情</a>
    </script>
    <!-- table中的工具条  修改与删除  结束-->

    <!--修改用户表单  开始 -->
    <div id="updPostDiv" style="display: none">
        <div style="margin: 0 auto;width: 600px;">
            <form class="layui-form" id="updPostForm"  lay-filter="updatePostFormFilter"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
                <div>
                    <h2 style="text-align: center;margin: 10px 0;">宏鹏论坛贴子修改</h2>
                </div>
                <input type="hidden" name="id">

                <div class="layui-form-item">
                    <label class="layui-form-label">标题</label>
                    <div class="layui-input-block">
                        <input type="text" name="title" placeholder="请输入标题" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">帖子类型</label>
                    <div class="layui-input-block">
                        <select id="selectId1" name="topicid"></select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">帖子内容</label>
                    <div class="layui-input-block">
                        <textarea name="content" placeholder="请输入内容" class="layui-textarea"></textarea>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">发布时间</label>
                    <div class="layui-input-block"><!--id="onTime"-->
                        <input type="date" name="posttime" placeholder="请输入" autocomplete="off" class="layui-input onTime" autocomplete="off">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">修改图片</label>
                    <button type="button" class="layui-btn" id="upLoadImg1">
                        <i class="layui-icon">&#xe67c;</i>修改图片
                    </button>
                    <div id="imgDiv1" style="height: 100px;width: 100px;float: right;margin-right: 200px">
                    </div>
                </div>

                <input type="hidden" name="pic" id="imgPic1">

                <div class="layui-form-item">
                    <div class="layui-input-block" style="float: right;">
                        <button class="layui-btn" lay-submit lay-filter="updPostFilter">修改</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>

                <!-- 更多表单结构排版请移步文档左侧【页面元素-表单】一项阅览 -->
            </form>
        </div>
    </div>
    <!--修改用户表单 结束 -->

    <!--详细 查看图片 开始-->
    <div id="showImgDiv" style="display: none">
        <div id="showImg"></div>
    </div>

</body>
</html>
