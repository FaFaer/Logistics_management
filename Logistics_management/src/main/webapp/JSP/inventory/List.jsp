<%--
  Created by IntelliJ IDEA.
  User: TT
  Date: 2019/3/30
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>库存列表</title>
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
        <a href="">库存管理</a>
        <a>
          <cite>库存列表</cite></a>
      </span>
</div>
<div id="testText">
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <div class="layui-inline">
            <input type="text" name="Inventory_Goods_Name" id="Inventory_Goods_Name" placeholder="请输入商品名" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-inline">
            <select class="layui-select" id="Inventory_Warehouse_Id">
                <option value="">请选择仓库</option>
            </select>
        </div>
        <button class="layui-btn" lay-filter="sreach" title="搜索" onclick="query(0)"><i class="layui-icon">&#xe615;</i>
        </button><!--精准查询-->
        <button class="layui-btn layui-btn-danger" title="重置" onclick="myreset()">重置</button>
    </div>
</div>
<form method="post" action="${pageContext.request.contextPath}/delAllcliente1">
    <div class="weadmin-block">
        <input type="button" class="layui-btn" value="入库" onclick="WeAdminShow('入库','${pageContext.request.contextPath}/JSP/inventory/Add.jsp',500)">
        <span class="fr" style="line-height:40px" id="sum"></span>
        <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="query(0)"
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
        $('#Inventory_Goods_Name').val("");
        $('#Inventory_Warehouse_Id').find("option").eq(0).prop("selected",true);
    }
    $(function () {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/searchW",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#Inventory_Warehouse_Id').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");
                })
            }, error: function (data) {
            }
        });
        query(0);
    });


    function query(i) {
        $.ajax({
            data: {
                "Inventory_Id": i,
                "Inventory_Warehouse_Id": $('#Inventory_Warehouse_Id').val(),
                "Inventory_Goods_Name": $('#Inventory_Goods_Name').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listI",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                var j = 1;
                var p = i + 1;
                $('#memberList').empty();
                $('#memberList').append("<thead>" +
                    "        <tr>" +
                    "            <th>序号</th>" +
                    "            <th>编号</th>" +
                    "            <th>商品名称</th>" +
                    "            <th>仓库名称</th>" +
                    "            <th>数量</th>" +
                    "        </tr>" +
                    "        </thead>");
                result.forEach(function (element) {
                    var k = j;
                    $('#memberList').append("<tr><td>" + (j++) + "</td><td>" + element.inventory_Code + "</td><td>" + element.inventory_Goods_Name +
                        "</td><td>" + element.inventory_Warehouse_Id+"</td><td>" + element.inventory_Amount + "</td></tr>");
                });
                querynumber(p);
            }, error: function (data) {
            }
        })
    }
    /*弹出层+传递ID参数*/
    function WeAdminEdi(title, url, id, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        if (url == null || url == '') {
            url = "404.html";
        }
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        layer.open({
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false, //不固定
            maxmin: true,
            shadeClose: true,
            shade: 0.4,
            title: title,
            content: url,
            success: function (layero, index) {
                //向iframe页的id=house的元素传值  // 参考 https://yq.aliyun.com/ziliao/133150
                var body = layer.getChildFrame('body', index);
                $.ajax({
                    data: {"Clientele_Code": id},
                    type: "POST",
                    url: "${pageContext.request.contextPath}/editcliente",
                    success: function (data) {
                        var clientele = eval('(' + data + ')');
                        body.contents().find("#Clientele_Code").val(clientele.clientele_Code);
                        body.contents().find("#Clientele_Name").val(clientele.clientele_Name);
                        body.contents().find("#Province1").append("<option value=null>" + clientele.province + "</option>");
                        body.contents().find("#City1").append("<option value=null>" + clientele.city + "</option>");
                        body.contents().find("#District1").append("<option value=null>" + clientele.district + "</option>");
                        body.contents().find("#Clientele_Warehouse1").append("<option value=null>" + clientele.clientele_Warehouse + "</option>");
                        body.contents().find("#Clientele_Address").val(clientele.clientele_Address);
                        body.contents().find("#Clientele_Warehouse").val(clientele.Clientele_Warehouse);
                        body.contents().find("#Clientele_Principal").val(clientele.clientele_Principal);
                        body.contents().find("#Clientele_Tel").val(clientele.clientele_Tel);
                        $.ajax({
                            data: {"China_Pid": ""},
                            type: "POST",
                            url: "${pageContext.request.contextPath}/searchP",
                            success: function (data) {
                                var result = jQuery.parseJSON(data);
                                result.forEach(function (element) {
                                    body.contents().find("#Province1").append("<option value='" + element.china_Id + "'>" + element.china_Name + "</option>");
                                })
                            }, error: function (data) {
                            }
                        });
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/searchW",
                            success: function (data) {
                                var result = jQuery.parseJSON(data);
                                body.contents().find('#Clientele_Warehouse1').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");

                                result.forEach(function (element) {
                                    body.contents().find('#Clientele_Warehouse1').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");
                                })
                            }, error: function (data) {
                            }
                        });
                    }, error: function () {

                    }
                });
            },
            error: function (layero, index) {
            }
        });
    }

    function querynumber(i) {
        $.ajax({
            data: {
                "Inventory_Id": i,
                "Inventory_Warehouse_Id": $('#Inventory_Warehouse_Id').val(),
                "Inventory_Goods_Name": $('#Inventory_Goods_Name').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listINumber",
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
</script>
</body>
</html>
