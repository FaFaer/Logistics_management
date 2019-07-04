<%--
  Created by IntelliJ IDEA.
  User: TT
  Date: 2019/3/30
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品种类列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/weadmin.css">
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]
   <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>>
    <![endif]-->
    <style>
        #page .current{
            display: inline-block;
            background: #009688 0 0 no-repeat;
            color: #fff;
            padding: 10px;
            min-width: 15px;
            border: 1px solid #009688;
        }
        a:hover {
            cursor: pointer;
            color: rebeccapurple;
        }

        input[type="checkbox"] {
            width: 20px;
            height: 20px;
            display: inline-block;
            text-align: center;
            vertical-align: middle;
            line-height: 18px;
            position: relative;
        }

        input[type="checkbox"]::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            background: #fff;
            width: 100%;
            height: 100%;
            border: 1px solid #d9d9d9
        }

        input[type="checkbox"]:checked::before {
            content: "\2713";
            background-color: #fff;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            border: 1px solid #e50232;
            color: #e50232;
            font-size: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="weadmin-nav">
			<span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">商品种类管理</a>
        <a>
          <cite>商品种类列表</cite></a>
      </span>
</div>
<div id="testText">
</div>

<div class="weadmin-body">
    <div class="layui-row">
        <div class="layui-inline">
            <input type="text" name="Goods_Name" id="Goods_Name" placeholder="请输入商品种类名" autocomplete="off"
                   class="layui-input">
        </div>

        <button class="layui-btn" lay-filter="sreach" title="搜索" onclick="query(0)"><i class="layui-icon">&#xe615;</i>
        </button><!--精准查询-->
        <button class="layui-btn layui-btn-danger" title="重置" onclick="myreset()">重置</button>
    </div>
</div>
<form method="post" action="${pageContext.request.contextPath}/delAllwarehouse">
    <div class="weadmin-block">
        <input type="button" class="layui-btn" value="添加"
               onclick="WeAdminShow('添加商品种类','${pageContext.request.contextPath}/JSP/goods/AddType.jsp',500,300)">
        <span class="fr" style="line-height:40px" id="sum"></span>
        <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="query(0);"
           title="刷新">
            <i class="layui-icon" style="line-height:1.5em">&#x1002;</i></a>
    </div>

    <table class="layui-table" id="memberList">
        <tbody>
        </tbody>
    </table>
</form>
<div class="page">
    <div id="page">
    </div>
</div>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/admin.js" charset="utf-8"></script>
<script type="text/javascript">
    function myreset(){
        $('#Goods_Name').val("");
    }
    $(function () {
        query(0);
    });
    //分页查询
    function query(i) {
        $.ajax({
            data: {
                "Goods_Id": i
                , "Goods_Name": $('#Goods_Name').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listGT",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                var j = 1;
                var p = i + 1;
                $('#memberList').empty();
                $('#memberList').append("<thead>" +
                    "        <tr>" +
                    "            <th>序号</th>" +
                    "            <th>商品种类编号</th>" +
                    "            <th>商品种类名字</th>" +
                    "            <th>操作</th>" +
                    "        </tr>" +
                    "        </thead>");
                result.forEach(function (element) {
                    var k = j;
                    var sat = element.warehouse_Status;
                    $('#memberList').append("<tr data-id=" + k++ + ">");
                    $('#memberList').append("<td>" + (j++) + "</td><td>" + element.goods_Code + "</td><td>" + element.goods_Name + "</td>");
                    $('#memberList').append("<td class='td-manage'><a title='删除' onclick='dele_del(" + element.goods_Id + ")' href='javascript:;'><i class='layui-icon'>&#xe640;</i></a></td></tr>");
                });
                querynumber(p);
            }, error: function (data) {
            }
        })
    }

    //查询记录总数
    function querynumber(i) {
        $.ajax({
            data: {
                "Goods_Id": i
                , "Goods_Name": $('#Goods_Name').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listGTNumber",
            success: function (data) {
                var j = jQuery.parseJSON(data).sum;
                $('#sum').html("共有数据：" + j + "条");
                var q = "";
                var m = 1;
                for (var f = 1; f <= j; f+=10) {
                    q += "<a class='prev' onclick=(query(" + (m - 1) + "))>" + m++ + "</a>";
                }
                $('#page').html(q);
                var t = i-1;
                $('#page a').removeClass("prev");
                var l = "#page a:eq("+t+")";
                $(l).addClass("current");

            }, error: function (data) {
            }
        })
    }

    //删除商品类型
    function dele_del(id) {
        layer.confirm('确认要删除吗？', function (index) {
            $.ajax({
                data: {"Goods_Id": id},
                type: "POST",
                url: "${pageContext.request.contextPath}/deleteGT",
                success: function (data) {
                    var result = jQuery.parseJSON(data);
                    if(result.j == 0){
                        if (result.i == "1") {
                            layer.msg('已删除!', {
                                icon: 1,
                                time: 1000
                            });
                        } else {
                            layer.msg('删除失败!', {
                                icon: 1,
                                time: 1000
                            });
                        }
                    }else {
                        layer.msg("商品信息中有"+result.j+"条相关信息，不能删除该商品类型", {
                            icon: 1,
                            time: 1000
                        });
                    }
                }, error: function (data) {
                    layer.msg('删除失败!', {
                        icon: 1,
                        time: 1000
                    });
                }
            })

        });
    }
</script>
</body>
</html>
