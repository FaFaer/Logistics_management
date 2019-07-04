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
    <title>角色管理</title>
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

        /* Switch 1 Specific Styles Start */

        .box_1 {
            background: #eee;
        }

        input[type="checkbox"].switch_1 {
            font-size: 14px;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            width: 3.5em;
            height: 1.5em;
            background: #ddd;
            border-radius: 3em;
            position: relative;
            cursor: pointer;
            outline: none;
            -webkit-transition: all .2s ease-in-out;
            transition: all .2s ease-in-out;
        }

        input[type="checkbox"].switch_1:checked {
            background: #0ebeff;
        }

        input[type="checkbox"].switch_1:after {
            position: absolute;
            content: "";
            width: 1.5em;
            height: 1.5em;
            border-radius: 50%;
            background: #fff;
            -webkit-box-shadow: 0 0 .25em rgba(0, 0, 0, .3);
            box-shadow: 0 0 .25em rgba(0, 0, 0, .3);
            -webkit-transform: scale(.7);
            transform: scale(.7);
            left: 0;
            -webkit-transition: all .2s ease-in-out;
            transition: all .2s ease-in-out;
        }

        input[type="checkbox"].switch_1:checked:after {
            left: calc(100% - 1.5em);
        }

        /* Switch 1 Specific Style End */

    </style>
</head>
<body>
<div class="weadmin-nav">
			<span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">用户管理</a>
        <a>
          <cite>角色管理</cite></a>
      </span>
</div>
<div id="testText">
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <div class="layui-inline">
            <input type="text" name="Role_Name" id="Role_Name" placeholder="请输入角色名" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-inline">
            <select class="layui-select" id="Role_Status">
                <option value="N">请选择角色状态</option>
                <option value="A">启用</option>
                <option value="X">停用</option>
            </select>
        </div>
        <div class="layui-inline">
            <input type="text" class="layui-input" name="Create_Time" placeholder="请选择创建时间" id="test10">
        </div>
        <div class="layui-inline">
            <input type="text" class="layui-input" name="Update_Time" placeholder="请选择时间区间" id="test11">
        </div>
        <button class="layui-btn" lay-filter="sreach" title="搜索" onclick="query(0)"><i class="layui-icon">&#xe615;</i>
        </button><!--精准查询-->
        <button class="layui-btn layui-btn-danger" title="重置" onclick="myreset()">重置</button>
    </div>
</div>
<form method="post" action="${pageContext.request.contextPath}/delAllcliente1">
    <div class="weadmin-block">
        <input type="button" class="layui-btn" value="添加"
               onclick="WeAdminShow('添加角色','${pageContext.request.contextPath}/JSP/admin/role-add.jsp',900)">
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
<script src="${pageContext.request.contextPath}/Pages/static/laydate/laydate.js" charset="utf-8"></script>
<script type="text/javascript">
    function myreset() {
        $('#Role_Name').val("");
        $('#test10').val("");
        $('#test11').val("");
        $('#Role_Status').find("option").eq(0).prop("selected", true);
    }

    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#test10'
            , theme: 'molv'//指定元素
            , done: function (value, date) {
                laydate.render({
                    elem: '#test11'
                    , min: ' \'' + value + '\''
                    , theme: 'molv'//指定元素
                });
            }
        });
    });
    $(function () {
        query(0);
    });

    function query(i) {
        $.ajax({
            data: {
                "Role_Id": i, "Role_Name": $('#Role_Name').val()
                , "Role_Status": $('#Role_Status').val()
                , "Create_Time": $('#test10').val()
                , "Update_Time": $('#test11').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listR",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                var j = 1;
                var p = i + 1;
                $('#memberList').empty();
                $('#memberList').append("<thead>" +
                    "        <tr>" +
                    "            <th>序号</th>" +
                    "            <th>编号</th>" +
                    "            <th>角色名称</th>" +
                    "            <th>状态</th>" +
                    "            <th>描述</th>" +
                    "            <th>创建时间</th>" +
                    "            <th>最后修改时间</th>" +
                    "            <th>操作</th>" +
                    "        </tr>" +
                    "        </thead>");
                result.forEach(function (element) {
                    var k = j;
                    $('#memberList').append("<tr data-id=" + k++ + ">");
                    $('#memberList').append("<td>" + (j++) + "</td><td>" + element.role_Code + "</td><td>" + element.role_Name + "</td>");
                    if (element.role_Status == "A") {
                        $('#memberList').append("<td>启用中</td>");
                    } else $('#memberList').append("<td>停用中</td>");
                    $('#memberList').append("<td>" + element.role_Describe + "</td><td>" + element.create_Time + "</td><td>" + element.update_Time + "</td>");
                    if (element.role_Status == "A") {
                        $('#memberList').append("<td><input type=\"checkbox\" class=\"switch_1\" name=\"Role_User_Permission\" onchange=\"aaa('" + element.role_Code + "','X')\" checked value=\"0\"></td>");
                    } else {
                        $('#memberList').append("<td><input type=\"checkbox\" class=\"switch_1\" name=\"Role_User_Permission\" onchange=\"aaa('" + element.role_Code + "','A')\"  value=\"0\">" +
                            "&ensp;<a title='删除' onclick='dele_del(" + element.role_Code + ")' href='javascript:;'><i class='layui-icon'>&#xe640;</i></a></td>");
                    }
                    $('#memberList').append("</tr>");
                });
                querynumber(p);
            }, error: function (data) {
            }
        })
    }

    function aaa(id, status) {
        layer.confirm('确认要改变状态吗？', function (index) {
            $.ajax({
                data: {
                    "role_Code": id,
                    "role_Status": status,
                },
                type: "POST",
                url: "${pageContext.request.contextPath}/updateStatus",
                success: function (data) {
                    var result = eval('(' + data + ')');
                    if (result.i == "0") {
                        if (result.j != "0") {
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

                    } else {
                        layer.msg('修改失败，该角色下还有' + result.i + '名用户!', {
                            icon: 1,
                            time: 1000
                        });
                    }
                }, error: function (data) {
                    alert("修改失败")
                }
            })
        })
    }

    // 删除角色
    function dele_del(id) {
        layer.confirm('确认删除角色吗？', function (index) {
            $.ajax({
                data: {
                    "Role_Code": id,
                },
                type: "POST",
                url: "${pageContext.request.contextPath}/deleteRole",
                success: function (data) {
                    var result = eval('(' + data + ')');
                    if (result.j != "0") {
                        layer.msg('删除成功!', {
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
                    alert("修改失败")
                }
            })
        })
    }

    // 查询角色数量
    function querynumber(i) {
        $.ajax({
            data: {
                "Role_Id": i, "Role_Name": $('#Role_Name').val()
                , "Role_Status": $('#Role_Status').val()
                , "Create_Time": $('#test10').val()
                , "Update_Time": $('#test11').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listRnumber",
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
</script>
</body>
</html>
