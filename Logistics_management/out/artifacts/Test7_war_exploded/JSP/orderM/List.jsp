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
    <title>订单列表</title>
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
        #page .current {
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
        <a href="">订单管理</a>
        <a>
          <cite>订单列表</cite></a>
      </span>
</div>
<div id="testText">
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <div class="layui-inline">
            <input type="text" name="Order_Code" id="Order_Code" placeholder="请输入订单号" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-inline">
            <select class="layui-select Clientele_Id" id="forsearch">
                <option value="">请选择客户</option>
            </select>
        </div>
        <div class="layui-inline">
            <select class="layui-select" id="Order_Status">
                <option value="">请选择状态</option>
                <option value="0">未出货</option>
                <option value="1">已出货</option>
                <option value="2">运输中</option>
                <option value="3">完成</option>
            </select>
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
<form method="post" action="${pageContext.request.contextPath}/delAllwarehouse">
    <div class="weadmin-block">
        <button type="button" class="layui-btn" onclick="exportExcel()">下载订货单导入模板</button>
        <button type="button" class="layui-btn" id="test3"><i class="layui-icon"></i>上传订货单</button>
        <span class="fr" style="line-height:40px" id="sum"></span>
        <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="start()" title="刷新">
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
        function exportExcel(){
            location.href="${pageContext.request.contextPath}/createExcel";
            <!--这里不能用ajax请求，ajax请求无法弹出下载保存对话框-->
        }

    function myreset(){
        $('#Order_Code').val("");
        $('#forsearch').find("option").eq(0).prop("selected",true);
        $('#Inventory_Warehouse_Id').find("option").eq(0).prop("selected",true);
        $('#Order_Status').find("option").eq(0).prop("selected",true);
    }
    <%--上传订货单--%>
    layui.use('upload', function () {
        var $ = layui.jquery
            , upload = layui.upload;
        //指定允许上传的文件类型
        upload.render({
            elem: '#test3'
            , url: '${pageContext.request.contextPath}/import'
            , accept: 'file' //普通文件
            , exts: 'xls|xlsx' //限制后缀名
            , done: function (res) {
                if (res.result == "0") {
                    if (res.msg == "0") {
                        alert("该客户不存在！")
                    }
                } else if (res.result == "2") {
                    alert("导入失败！请确认库存！")
                } else if (res.result == "1") {
                    /*查看详情弹出层+传递ID参数*/
                    layer.open({
                        type: 2,
                        fix: false, //不固定
                        shadeClose: true,
                        shade: 0.4,
                        title: '订货单',
                        content: '${pageContext.request.contextPath}/JSP/orderM/GoodsList.jsp',
                        success: function (layero, index) {
                            //向iframe页的id=house的元素传值  // 参考 https://yq.aliyun.com/ziliao/133150
                            var body = layer.getChildFrame('body', index);
                            // var result = jQuery.parseJSON(res.order_goodsList);
                            res.order_goodsList.forEach(function (element) {
                                body.contents().find('#memberList').append("<thead>" +
                                    "        <tr>" +
                                    "            <th>商品编号</th>" +
                                    "            <th>商品名称</th>" +
                                    "            <th>数量</th>" +
                                    "        </tr>" +
                                    "        </thead>");
                                body.contents().find('#memberList').append("<tr>");
                                body.contents().find('#memberList').append("<td>" + element.order_Goods_Code + "</td>");
                                body.contents().find('#memberList').append("<td>" + element.order_Code + "</td>");
                                body.contents().find('#memberList').append("<td>" + element.oder_Goods_Amount + "</td>");
                                body.contents().find('#memberList').append("</tr>");
                            })
                        },
                        btn: ['确定'],
                        yes: function (index, layero) {
                            //do something
                            layer.closeAll(); //如果设定了yes回调，需进行手工关闭
                        }
                    });
                }
            }
        })
    });

    $(function () {
        // 查询搜索框的客户
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/searchCForOrder",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('.Clientele_Id').append("<option value='" + element.clientele_Id + "'>" + element.clientele_Name + "</option>");
                })
            }, error: function (data) {
            }
        });
        // 查询搜索框的仓库
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
                "Order_Id": i
                , "Order_Code": $('#Order_Code').val()
                , "Clientele_Id": $('#forsearch').val()
                , "Warehouse_Id": $('#Inventory_Warehouse_Id').val()
                , "Order_Status": $('#Order_Status').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listL",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                var j = 1;
                var p = i + 1;
                $('#memberList').empty();
                $('#memberList').append("<thead>" +
                    "        <tr>" +
                    "            <th>序号</th>" +
                    "            <th>订单号</th>" +
                    "            <th>客户名</th>" +
                    "            <th>配送仓库</th>" +
                    "            <th>配送卡车</th>" +
                    "            <th>状态</th>" +
                    "            <th>创建人</th>" +
                    "            <th>创建时间</th>" +
                    "            <th>最后修改时间</th>" +
                    "            <th>操作</th>" +
                    "        </tr>" +
                    "        </thead>");
                result.forEach(function (element) {
                    var k = j;
                    $('#memberList').append("<tr data-id=" + k++ + ">");
                    $('#memberList').append("<td>" + (j++) + "</td><td>" + element.order_Code + "</td>" +
                        "<td><a title='订货单' onclick=\"orderclienteleList(" + element.clientele_Id + ")\" href=\"javascript:;\">"+ element.clientele_Id + "</a></td>" +
                        "<td>" + element.warehouse_Id + "</td>" + "<td>" + element.vehicle_Id + "</td>");
                    if (element.order_Status == "0") {
                        $('#memberList').append("<td>未出货</td>");
                    }
                    if (element.order_Status == "1") {
                        $('#memberList').append("<td>已出货</td>");
                    }
                    if (element.order_Status == "2") {
                        $('#memberList').append("<td>运输中</td>");
                    }
                    if (element.order_Status == "3") {
                        $('#memberList').append("<td>完成</td>");
                    }

                    $('#memberList').append("<td>" + element.user_Id + "</td><td>" + element.create_Time + "</td><td>" + element.update_Time + "</td>");
                    // 操作

                    if (element.order_Status == "0") {
                        $('#memberList').append("<td class='td-manage'><a title='订货单' onclick=\"orderGoodList(" + element.order_Code + ")\" href=\"javascript:;\"><i class='layui-icon'>&#xe60a;</i></a>" +
                            "&ensp;&ensp;<a title='出货' onclick=\"addOrder('出货','${pageContext.request.contextPath}/JSP/orderM/Add.jsp','" + element.order_Code + "',400,200)\" href='javascript:;'><i class='layui-icon'>&#xe67b;</i></a>" +
                            "&ensp;&ensp;<a title='取消' onclick='dele_del(" + element.order_Code + ")' href='javascript:;'><i class='layui-icon'>&#xe640;</i></a></td></tr>");
                    }
                    if (element.order_Status == "1") {
                        $('#memberList').append("<td class='td-manage'><a title='订货单' onclick=\"orderGoodList(" + element.order_Code + ")\" href=\"javascript:;\"><i class='layui-icon'>&#xe60a;</i></a>" +
                            "&ensp;&ensp;<a title='配送' onclick=\"updateorderStatus('" + element.order_Code + "','1','2')\" href='javascript:;'><i class='layui-icon'>&#xe6c9;</i></a>" +
                            "&ensp;&ensp;<a title='操作轨迹' onclick=\"orderOperation(" + element.order_Code + ")\" href=\"javascript:;\"><i class='layui-icon'>&#xe674;</i></a></td></tr>");
                    }
                    if (element.order_Status == "2") {
                        $('#memberList').append("<td class='td-manage'><a title='订货单' onclick=\"orderGoodList(" + element.order_Code + ")\" href=\"javascript:;\"><i class='layui-icon'>&#xe60a;</i></a>" +
                            "&ensp;&ensp;<a title='到达' onclick=\"updateorderStatus('" + element.order_Code + "','2','3')\" href='javascript:;'><i class='layui-icon'>&#xe67a;</i></a>" +
                            "&ensp;&ensp;<a title='操作轨迹' onclick=\"orderOperation(" + element.order_Code + ")\" href=\"javascript:;\"><i class='layui-icon'>&#xe674;</i></a></td></tr>");
                    }
                    if (element.order_Status == "3") {
                        $('#memberList').append("<td class='td-manage'><a title='订货单' onclick=\"orderGoodList(" + element.order_Code + ")\" href=\"javascript:;\"><i class='layui-icon'>&#xe60a;</i></a>" +
                            "&ensp;&ensp;<a title='操作轨迹' onclick=\"orderOperation(" + element.order_Code + ")\" href=\"javascript:;\"><i class='layui-icon'>&#xe674;</i></a>" +
                            "</td></tr>");
                    }

                });
                querynumber(p);
            }, error: function (data) {
            }
        })
    }

    // 看客户详细信息
    function orderclienteleList(id) {
            layer.open({
                type: 2,
                fix: false, //不固定
                shadeClose: true,
                shade: 0.4,
                title: '订货单',
                content: '${pageContext.request.contextPath}/JSP/orderM/GoodsList.jsp',
                success: function (layero, index) {
                    $.ajax({
                        data: {"Clientele_Code": id},
                        type: "POST",
                        url: "${pageContext.request.contextPath}/orderClientele",
                        success: function (data) {
                            //向iframe页的id=house的元素传值  // 参考 https://yq.aliyun.com/ziliao/133150
                            var body = layer.getChildFrame('body', index);
                            var result = jQuery.parseJSON(data).clientele;
                            body.contents().find('#memberList').append("<thead>" +
                                "        <tr>" +
                                "            <th>客户姓名</th>" +
                                "            <th>地址</th>" +
                                "            <th>负责人姓名</th>" +
                                "            <th>联系电话</th>" +
                                "            <th>创建时间</th>" +
                                "            <th>最后修改时间</th>" +
                                "        </tr>" +
                                "        </thead>");
                          var q = "<tr><td>"+result.clientele_Name+"</td><td>"+result.province+result.city+result.district+result.clientele_Address+
                              "</td><td>"+result.clientele_Principal+"</td><td>"+result.clientele_Tel+"</td><td>"+result.create_Time+"</td><td>"+result.update_Time+"</td></tr>"
                            body.contents().find('#memberList').append(q);
                        }
                    });
                },
                btn: ['确定'],
                yes: function (index, layero) {
                    layer.closeAll(); //如果设定了yes回调，需进行手工关闭
                }
            });
    }

    // 修改状态
    function updateorderStatus(id, prestatus, status) {
        layer.confirm('确认要修改状态吗？', function (index) {
            $.ajax({
                data: {
                    "Order_Code": id
                    , "Order_Status": status
                    , "Clientele_Id": prestatus
                },
                type: "POST",
                url: "${pageContext.request.contextPath}/updateorderStatus",
                success: function (data) {
                    var i = jQuery.parseJSON(data).i;
                    if (i == "1") {
                        layer.msg('已修改!', {
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
        })
    }

    // 出货
    function addOrder(title, url, id, w, h) {
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
                body.contents().find("#Order_Code").val(id);
            },
            error: function (layero, index) {
            }
        });
    }

    // 查看订单操作轨迹
    function orderOperation(Code) {
        layer.open({
            type: 2,
            fix: false, //不固定
            shadeClose: true,
            shade: 0.4,
            title: '订货单',
            content: '${pageContext.request.contextPath}/JSP/orderM/GoodsList.jsp',
            success: function (layero, index) {
                $.ajax({
                    data: {"Order_Code": Code},
                    type: "POST",
                    url: "${pageContext.request.contextPath}/orderTrackList",
                    success: function (data) {
                        //向iframe页的id=house的元素传值  // 参考 https://yq.aliyun.com/ziliao/133150
                        var body = layer.getChildFrame('body', index);
                        var result = jQuery.parseJSON(data);
                        // var result = jQuery.parseJSON(res.order_goodsList);
                        body.contents().find('#memberList').append("<thead>" +
                            "        <tr>" +
                            "            <th>操作人</th>" +
                            "            <th>操作前</th>" +
                            "            <th>操作后</th>" +
                            "            <th>操作时间</th>" +
                            "        </tr>" +
                            "        </thead>");
                        var q = "";
                        result.forEach(function (element) {
                            q += "<tr><td>" + element.user_Id + "</td>";
                            switch (element.pre_Status) {
                                case "-1":
                                    q += "<td>新建订单</td>";
                                    break;
                                case "0":
                                    q += "<td>未出货</td>";
                                    break;
                                case "1":
                                    q += "<td>已出货</td>";
                                    break;
                                case "2":
                                    q += "<td>配送中</td>";
                                    break;
                            }
                            switch (element.aft_Status) {
                                case "0":
                                    q += "<td>未出货</td>";
                                    break;
                                case "1":
                                    q += "<td>已出货</td>";
                                    break;
                                case "2":
                                    q += "<td>配送中</td>";
                                    break;
                                case "3":
                                    q += "<td>完成订单</td>";
                                    break;
                            }
                            q += "<td>" + element.operation_Time + "</td></tr>";
                        })
                        body.contents().find('#memberList').append(q);
                    }
                });
            },
            btn: ['确定'],
            yes: function (index, layero) {
                //do something
                layer.closeAll(); //如果设定了yes回调，需进行手工关闭
            }
        });
    }


    // 查看订货单
    function orderGoodList(Code) {
        layer.open({
            type: 2,
            fix: false, //不固定
            shadeClose: true,
            shade: 0.4,
            title: '订货单',
            content: '${pageContext.request.contextPath}/JSP/orderM/GoodsList.jsp',
            success: function (layero, index) {
                $.ajax({
                    data: {"Order_Code": Code},
                    type: "POST",
                    url: "${pageContext.request.contextPath}/orderGoodList",
                    success: function (data) {
                        //向iframe页的id=house的元素传值  // 参考 https://yq.aliyun.com/ziliao/133150
                        var body = layer.getChildFrame('body', index);
                        var result = jQuery.parseJSON(data);
                        body.contents().find('#memberList').append("<thead>" +
                            "        <tr>" +
                            "            <th>商品编号</th>" +
                            "            <th>商品名称</th>" +
                            "            <th>数量</th>" +
                            "        </tr>" +
                            "        </thead>");
                        var q = "";
                        result.forEach(function (element) {
                            q += "<tr><td>" + element.order_Goods_Code + "</td>";
                            q += "<td>" + element.order_Code + "</td>";
                            q += "<td>" + element.oder_Goods_Amount + "</td></tr>";
                        })
                        body.contents().find('#memberList').append(q);
                    }
                });
            },
            btn: ['确定'],
            yes: function (index, layero) {
                //do something
                layer.closeAll(); //如果设定了yes回调，需进行手工关闭
            }
        });
    }

    // 查询记录总数
    function querynumber(i) {
        $.ajax({
            data: {
                "Order_Id": i
                , "Order_Code": $('#Order_Code').val()
                , "Clientele_Id": $('#forsearch').val()
                , "Warehouse_Id": $('#Inventory_Warehouse_Id').val()
                , "Order_Status": $('#Order_Status').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listLnumber",
            success: function (data) {
                var j = jQuery.parseJSON(data).sum;
                $('#sum').html("共有数据：" + j + "条");
                var q = "";
                var m = 1;
                for (var f = 1; f <= j; f += 10) {
                    q += "<a class='prev' onclick=(query(" + (m - 1) + "))>" + m++ + "</a>";
                }
                $('#page').html(q);
                var t = i - 1;
                $('#page a').removeClass("prev");
                var l = "#page a:eq(" + t + ")";
                $(l).addClass("current");

            }, error: function (data) {
            }
        })
    }

    //删除订单
    function dele_del(id) {
        layer.confirm('确认要删除吗？', function (index) {
            $.ajax({
                data: {"Order_Code": id},
                type: "POST",
                url: "${pageContext.request.contextPath}/deleteL",
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
