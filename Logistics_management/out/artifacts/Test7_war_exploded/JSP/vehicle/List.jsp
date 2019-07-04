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
    <title>车辆列表</title>
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
        <a href="">车辆管理</a>
        <a>
          <cite>车辆列表</cite></a>
      </span>
</div>
<div id="testText">
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <div class="layui-inline">
            <input type="text" name="Vehicle_Code" id="Vehicle_Code" placeholder="请输入车牌号" autocomplete="off"
                   class="layui-input">
        </div>

        <div class="layui-inline">
            <select class="layui-select" id="Vehicle_Warehouse">
                <option value=" ">请选择所属仓库</option>
            </select>
        </div>

        <div class="layui-inline">
            <select class="layui-select" id="Vehicle_Status">
                <option value=" ">--请选择车辆状态--</option>
                <option value="0">-----待分配-----</option>
                <option value="1">-----送货中-----</option>
                <option value="2">-----维修中-----</option>
            </select>
        </div>

        <button class="layui-btn" lay-filter="sreach" title="搜索" onclick="query(0)"><i class="layui-icon">&#xe615;</i>
        </button><!--精准查询-->
        <button class="layui-btn layui-btn-danger" title="重置" onclick="myreset()">重置</button>
    </div>
</div>
<form method="post" action="${pageContext.request.contextPath}/delAllvehicle">
    <div class="weadmin-block">
        <input type="button" class="layui-btn" value="添加"
               onclick="WeAdminShow('添加车辆','${pageContext.request.contextPath}/JSP/vehicle/Add.jsp',500)">
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
        $('#Vehicle_Code').val("");
        $('#Vehicle_Warehouse').find("option").eq(0).prop("selected",true);
        $('#Vehicle_Status').find("option").eq(0).prop("selected",true);
    }
    $(function () {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/searchW",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#Vehicle_Warehouse').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");
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
                "vehicle_Id": i, "Vehicle_Code": $('#Vehicle_Code').val(),
                "Vehicle_Warehouse": $('#Vehicle_Warehouse').val(),
                "Vehicle_Status": $('#Vehicle_Status').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listV",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                var j = 1;
                var p = i + 1;
                $('#memberList').empty();
                $('#memberList').append("<thead>" +
                    "        <tr>" +
                    "            <th>序号</th>" +
                    "            <th>车牌号</th>" +
                    "            <th>车辆所属配货仓库</th>" +
                    "            <th>车辆负责人</th>" +
                    "            <th>创建时间</th>" +
                    "            <th>最后修改时间</th>" +
                    "            <th>车辆状态</th>" +
                    "            <th>操作</th>" +
                    "        </tr>" +
                    "        </thead>");
                result.forEach(function (element) {
                    var k = j;
                    var sat =element.vehicle_Status;
                    $('#memberList').append("<tr>");
                    $('#memberList').append("<td>" + (j++) + "</td><td>" + element.vehicle_Code + "</td><td>" + element.vehicle_Warehouse + "</td><td>" + element.vehicle_Keeper + "</td><td>" +
                        element.create_Time + "</td><td>" + element.update_Time + "</td>");
                    if(sat == "0"){$('#memberList').append("<td>待分配</td><td class='td-manage'><a title='修改' onclick=\"WeAdminEdivehicle('编辑','${pageContext.request.contextPath}/JSP/vehicle/Edit.jsp','" + element.vehicle_Id + "', 500)\" href=\"javascript:;\">" +
                        "<i class='layui-icon'>&#xe631;</i>&ensp;<a title='维修' onclick=\"updateVehicleStatus('${pageContext.request.contextPath}/updateVehicleStatus','"+element.vehicle_Id+"','2')\"><i class='layui-icon'>&#xe628;</i></a></td>")}
                    if(sat == "1"){$('#memberList').append("<td>送货中</td><td class='td-manage'></td>")}
                    // 送货中只能查看详情，详情就是订单里的信息
                    if(sat == "2"){$('#memberList').append("<td>维修中</td><td><a title='已维修好' onclick=\"updateVehicleStatus('${pageContext.request.contextPath}/updateVehicleStatus','"+element.vehicle_Id+"','0')\"><i class='layui-icon'>&#xe665;</i></a>&ensp;<a title='删除' onclick='dele_del(" + element.vehicle_Id + ")' href='javascript:;'><i class='layui-icon'>&#xe640;</i></a></td>")}
                    $('#memberList').append("</tr>");
                     });
                querynumber(p);
            }, error: function (data) {
            }
        })
    }

    function updateVehicleStatus(url,id,code) {
        layer.confirm('确认修改状态？', function (index) {
            $.ajax({
                data: {"vehicle_Id":id,
                    "vehicle_Code":code
                },
                type: "POST",
                url: url,
                success: function (data) {
                    var i = jQuery.parseJSON(data)[0];
                    if (i == "1") {
                        layer.msg('修改成功!', {
                            icon: 1,
                            time: 1000
                        });
                    } else {
                        layer.msg('修改失败!', {
                            icon: 1,
                            time: 1000
                        });
                    }
                }, error: function (data) {
                    layer.msg('修改失败!', {
                        icon: 1,
                        time: 1000
                    });
                }
            })

        });
    }


    /*查看详情弹出层+传递ID参数*/
    function WeAdminEdivehicle(title, url, id, w, h) {
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
                    data: {"vehicle_Id": id},
                    type: "POST",
                    url: "${pageContext.request.contextPath}/editvehicle",
                    success: function (data) {
                        var vehicle = eval('(' + data + ')');
                        body.contents().find("#vehicle_Id").val(id);
                        body.contents().find("#vehicle_Code").val(vehicle.vehicle_Code);
                        body.contents().find("#vehicle_Warehouse").append("<option value=null>" + vehicle.vehicle_Warehouse + "</option>");
                        body.contents().find("#vehicle_Keeper").append("<option value=null>" + vehicle.vehicle_Keeper + "</option>");
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/searchW",
                            success: function (data) {
                                var result = jQuery.parseJSON(data);
                                result.forEach(function (element) {
                                    body.contents().find("#Vehicle_Warehouse").append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");
                                })
                            }, error: function (data) {
                            }
                        });
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/selectusers",
                            success: function (data) {
                                var result = jQuery.parseJSON(data);
                                result.forEach(function (element) {
                                    if (element.user_Permission == "1") {
                                        body.contents().find("#vehicle_Keeper").append("<option value='" + element.user_Id + "'>" + element.user_Name + "</option>");
                                    }
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
                    data: {"vehicle_Code": id},
                    type: "POST",
                    url: "${pageContext.request.contextPath}/editvehicle",
                    success: function (data) {
                        var vehicle = eval('(' + data + ')');
                        body.contents().find("#vehicle_Code").val(vehicle.vehicle_Code);
                        body.contents().find("#vehicle_Name").val(vehicle.vehicle_Name);
                        body.contents().find("#Province1").append("<option value=null>" + vehicle.province + "</option>");
                        body.contents().find("#City1").append("<option value=null>" + vehicle.city + "</option>");
                        body.contents().find("#District1").append("<option value=null>" + vehicle.district + "</option>");
                        body.contents().find("#vehicle_Warehouse1").append("<option value=null>" + vehicle.vehicle_Warehouse + "</option>");
                        body.contents().find("#vehicle_Address").val(vehicle.vehicle_Address);
                        body.contents().find("#vehicle_Warehouse").val(vehicle.vehicle_Warehouse);
                        body.contents().find("#vehicle_Principal").val(vehicle.vehicle_Principal);
                        body.contents().find("#vehicle_Tel").val(vehicle.vehicle_Tel);
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
                                body.contents().find('#vehicle_Warehouse1').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");

                                result.forEach(function (element) {
                                    body.contents().find('#vehicle_Warehouse1').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");
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
                "vehicle_Id": i, "Vehicle_Code": $('#Vehicle_Code').val(),
                "Vehicle_Warehouse": $('#Vehicle_Warehouse').val(),
                "Vehicle_Status": $('#Vehicle_Status').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listvnumber",
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
    //删除记录
    function dele_del(id) {
        layer.confirm('确认要删除吗？', function (index) {
            $.ajax({
                data: {"vehicle_Id": id},
                type: "POST",
                url: "${pageContext.request.contextPath}/deleteV",
                success: function (data) {
                    var i = jQuery.parseJSON(data)[0];
                    if (i == "1" || i == '1' || i == 1) {
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
