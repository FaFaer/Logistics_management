<%--
  Created by IntelliJ IDEA.
  User: TT
  Date: 2019/3/30
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>仓库列表</title>
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
        <a href="">仓库管理</a>
        <a>
          <cite>仓库列表</cite></a>
      </span>
</div>
<div id="testText">
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <div class="layui-inline">
            <input type="text" name="warehouseName" id="warehouseName" placeholder="请输入仓库名" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-inline">
            <input type="text" name="warehouseAddress" id="warehouseAddress" placeholder="请输入详细地址" autocomplete="off"
                   title="搜索" class="layui-input">
        </div>
        <div class="layui-inline">
            <select class="layui-select" id="Province">
                <option value="">-------请选择省-------</option>
            </select>
        </div>
        <div class="layui-inline">
            <select class="layui-select" id="City">
                <option value="">-------请选择市-------</option>
            </select>
        </div>
        <div class="layui-inline">
            <select class="layui-select" id="District">
                <option value="">-------请选择区-------</option>
            </select>
        </div>

        <button class="layui-btn" lay-filter="sreach" title="搜索" onclick="query(0)"><i class="layui-icon">&#xe615;</i>
        </button><!--精准查询-->
        <button class="layui-btn layui-btn-danger" title="重置" onclick="myreset()">重置</button>
    </div>
</div>
<form method="post" action="${pageContext.request.contextPath}/delAllwarehouse">
    <div class="weadmin-block">
        <input type="button" class="layui-btn" value="添加"
               onclick="WeAdminShow('添加仓库','${pageContext.request.contextPath}/JSP/warehouse/Add.jsp',600)">
        <span class="fr" style="line-height:40px" id="sum"></span>
        <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="start()"
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
        $('#warehouseAddress').val("");
        $('#warehouseName').val("");
        $('#Province').find("option").eq(0).prop("selected",true);
        $('#City').find("option").eq(0).prop("selected",true);
        $('#District').find("option").eq(0).prop("selected",true);
    }
    $(function () {
        Province = $('#Province').val();
        $.ajax({
            data: {"China_Pid": Province},
            type: "POST",
            url: "${pageContext.request.contextPath}/searchP",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#Province').append("<option value='" + element.china_Id + "'>" + element.china_Name + "</option>");
                })
            }, error: function (data) {
            }
        });
        start();
    });

    function start() {
        query(0);
        querynumber(1);
    }

    //分页查询
    function query(i) {
        $.ajax({
            data: {
                "Warehouse_Id": i
                , "warehouse_Name": $('#warehouseName').val()
                , "warehouse_Address": $('#warehouseAddress').val()
                , "Province": $('#Province').val()
                , "City": $('#City').val()
                , "District": $('#District').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listW",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                var j = 1;
                var p = i + 1;
                $('#memberList').empty();
                $('#memberList').append("<thead>" +
                    "        <tr>" +
                    "            <th>序号</th>" +
                    "            <th>仓库号</th>" +
                    "            <th>仓库名字</th>" +
                    "            <th>仓库地址</th>" +
                    "            <th>管理员</th>" +
                    "            <th>联系方式</th>" +
                    "            <th>创建时间</th>" +
                    "            <th>最后修改时间</th>" +
                    "            <th>操作</th>" +
                    "        </tr>" +
                    "        </thead>");
                result.forEach(function (element) {
                    var k = j;
                    var sat = element.warehouse_Status;
                    $('#memberList').append("<tr data-id=" + k++ + ">");
                    $('#memberList').append("<td>" + (j++) + "</td><td>" + element.warehouse_Code + "</td><td>" + element.warehouse_Name + "</td><td>" + element.province + element.city + element.district + element.warehouse_Address + "</td>" +
                        "<td>" + element.warehouse_Keeper + "</td><td>" + element.warehouse_Tel + "</td><td>" +
                        element.create_Time + "</td><td>" + element.update_Time + "</td>");

                    $('#memberList').append("<td class='td-manage'><a title='修改' onclick=\"WeAdminEdi('编辑','${pageContext.request.contextPath}/JSP/warehouse/Edit.jsp'," + element.warehouse_Code + ", 600)\" href=\"javascript:;\">"
                        + "<i class='layui-icon'>&#xe631;</i></a>" +
                        "&ensp;<a title='删除' onclick='dele_del(" + element.warehouse_Code + ")' href='javascript:;'><i class='layui-icon'>&#xe640;</i></a></td></tr>");
                });
                querynumber(p);
            }, error: function (data) {
            }
        })



    }

    /*修改弹出层+传递ID参数*/
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
                    data: {"warehouse_Code": id},
                    type: "POST",
                    url: "${pageContext.request.contextPath}/editwarehouse",
                    success: function (data) {
                        var warehouse = eval('(' + data + ')');
                        body.contents().find("#warehouse_Code").val(warehouse.warehouse.warehouse_Code);
                        body.contents().find("#Warehouse_Name").val(warehouse.warehouse.warehouse_Name);
                        body.contents().find("#Province").append("<option value=null>" + warehouse.warehouse.province + "</option>");
                        body.contents().find("#City").append("<option value=null>" + warehouse.warehouse.city + "</option>");
                        body.contents().find("#District").append("<option value=null>" + warehouse.warehouse.district + "</option>");
                        body.contents().find("#warehouse_Address").val(warehouse.warehouse.warehouse_Address);
                        body.contents().find("#Warehouse_Keeper").append("<option value=null>" + warehouse.warehouse.warehouse_Keeper + "</option>");
                        body.contents().find("#warehouse_Tel").val(warehouse.warehouse.warehouse_Tel);

                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/selectusers",
                            success: function (data) {
                                var result = jQuery.parseJSON(data);
                                result.forEach(function (element) {
                                    body.contents().find('#Warehouse_Keeper').append("<option value='" + element.user_Id + "'>" + element.user_Name + "</option>");
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

    //查询记录总数
    function querynumber(i) {
        $.ajax({
            data: {
                "Warehouse_Id": i
                , "warehouse_Name": $('#warehouseName').val()
                , "warehouse_Address": $('#warehouseAddress').val()
                , "Province": $('#Province').val()
                , "City": $('#City').val()
                , "District": $('#District').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listWnumber",
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

    $('#Province').change(function () {
        var Province = $('#Province').val();
        $('#City').empty();
        $('#City').append("<option value=\"\">-------请选择市-------</option>");
        $.ajax({
            data: {"China_Pid": Province},
            type: "POST",
            url: "${pageContext.request.contextPath}/searchP",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#City').append("<option value='" + element.china_Id + "'>" + element.china_Name + "</option>");
                })
            }, error: function (data) {
            }
        })
    });
    $('#City').change(function () {
        var City = $('#City').val();
        $('#District').empty();
        $('#District').append("<option value=\"\">-------请选择区-------</option>");
        $.ajax({
            data: {"China_Pid": City},
            type: "POST",
            url: "${pageContext.request.contextPath}/searchP",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#District').append("<option value='" + element.china_Id + "'>" + element.china_Name + "</option>");
                })
            }, error: function (data) {
            }
        })
    });

    //删除记录
    function dele_del(id) {
        layer.confirm('确认要删除吗？', function (index) {
            $.ajax({
                data: {"warehouse_Code": id},
                type: "POST",
                url: "${pageContext.request.contextPath}/deleteW",
                success: function (data) {
                    var i = jQuery.parseJSON(data).i;
                    if (i == "1") {
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
