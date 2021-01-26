<%--
  Created by IntelliJ IDEA.
  User: Lovely_AI
  Date: 2021/1/22
  Time: 11:40:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>tree</title>
</head>
<link type="text/css" rel="stylesheet" href="/layui/css/layui.css"/>
<script type="text/javascript" src="/layui/layui.js"></script>
<script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    layui.use(['layer','tree'],function () {
        var layer = layui.layer;
        var tree = layui.tree;

        var resultObj = [];

        var t1=tree.render({
            elem:'#tree',
            edit: ['add', 'update', 'del'],
            operate:function (obj){
                //获取操作单元的ID
                //console.log(obj.data.id)
                //获取操作单元的类型
                //console.log(obj.type)
                var id = obj.data.id;
                if (obj.type=='del'){
                    $.get("/type/del",{id},function (resp){
                        layer.msg(resp.msg);
                    });
                } else if (obj.type=='update'){
                    $.get("/type/update",{id,"name":obj.data.title},function (resp){
                        layer.msg("update");
                    });
                } else {
                    $.get("/type/add",{"pid":obj.data.id},function (resp){
                        layer.msg(resp.msg);
                        //刷新父对象
                        //parent.location.reload();
                        window.location.reload()
                    });
                }
            },
            //树  一个空的 //有下面给这个t1data赋值
            data:[]
        });

        //1.向服务发一个请求
        $.ajax({
            type:"get",
            url:"show/tree",
            success:function (resp){
                //fn接受一个TreeResult类型数组对象
                fn(resp);
                t1.reload({
                    data: resultObj
                })
            },
            //修改错误的话执行
            error:function (){
                layer.msg("请求数据失败!!!");
            }
        })
        function fn(jsonData) {
            //取得顶级的数据
            for(var i=0;i<jsonData.length;i++){
                if(jsonData[i].pid==0){
                    resultObj.push(jsonData[i]);
                }
            }
            getChildren(resultObj, jsonData)
        }

        function getChildren(nodeList, jsonData) {
            nodeList.forEach(function(elemet, index) {
                elemet.children = jsonData.filter(function(item, indexI) {
                    return item.pid === elemet.id
                })
                if(elemet.children.length > 0) {
                    getChildren(elemet.children, jsonData)
                }
            })
        }


    });
</script>
<body>
    <div id="tree"></div>

</body>
</html>
