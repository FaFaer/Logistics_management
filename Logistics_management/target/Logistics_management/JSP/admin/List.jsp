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
    <title>用户列表</title>
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
          <cite>用户列表</cite></a>
      </span>
</div>
<div id="testText">
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <div class="layui-inline">
            <input type="text" name="User_Name" id="User_Name" placeholder="请输入客户名" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-inline">
            <select class="layui-select" id="User_Permission" name="User_Permission" style="width: 100px;">
                <option value="">请选择角色</option>
            </select>
        </div>
        <div class="layui-inline">
            <select class="layui-select" id="User_Status">
                <option value="">请选择状态</option>
                <option value="A">启用中</option>
                <option value="X">停用中</option>
            </select>
        </div>
        <button class="layui-btn" lay-filter="sreach" title="搜索" onclick="query(0)"><i class="layui-icon">&#xe615;</i>
        </button><!--精准查询-->
        <button class="layui-btn layui-btn-danger" title="重置" onclick="myreset()">重置</button>
    </div>
</div>
<form method="post" action="${pageContext.request.contextPath}/delAllcliente1">
    <div class="weadmin-block">
        <input type="button" class="layui-btn" value="添加"
               onclick="WeAdminShow('添加用户','${pageContext.request.contextPath}/JSP/admin/Add.jsp',650)">
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
        $('#User_Name').val("");
        $('#User_Permission').find("option").eq(0).prop("selected",true);
        $('#User_Status').find("option").eq(0).prop("selected",true);
    }
    $(function () {
        //查询搜索框需要的角色
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/selectRole",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#User_Permission').append("<option value='" + element.role_Code + "'>" + element.role_Name + "</option>");
                })
            }, error: function (data) {
            }
        })
        query(0);
    });


    function query(i) {
        $.ajax({
            data: {
                "User_Id": i
                , "User_Permission": $('#User_Permission').val()
                , "User_Name": $('#User_Name').val()
                , "User_Status": $('#User_Status').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listU",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                var j = 1;
                var p = i + 1;
                $('#memberList').empty();
                $('#memberList').append("<thead>" +
                    "        <tr>" +
                    "            <th>序号</th>" +
                    "            <th>编号</th>" +
                    "            <th>用户名称</th>" +
                    "            <th>用户联系方式</th>" +
                    "            <th>用户邮件地址</th>" +
                    "            <th>角色</th>" +
                    "            <th>创建人</th>" +
                    "            <th>状态</th>" +
                    "            <th>创建时间</th>" +
                    "            <th>最后修改时间</th>" +
                    "            <th>操作</th>" +
                    "        </tr>" +
                    "        </thead>");
                result.forEach(function (element) {
                    var k = j;
                    $('#memberList').append("<tr data-id=" + k++ + ">");
                    $('#memberList').append("<td>" + (j++) + "</td><td>" + element.user_Code + "</td><td>" + element.user_Name + "</td><td>" + element.user_Tel + "</td>" +
                        "<td>" + element.user_Email + "</td><td>" + element.user_Permission + "</td><td>" + element.create_User_Id + "</td>");
                    if (element.user_Status == "A") {
                        $('#memberList').append("<td>启用中</td>");
                    } else $('#memberList').append("<td>停用中</td>");
                    $('#memberList').append("<td>" + element.create_Time + "</td><td>" + element.update_Time + "</td>");
                    if (element.user_Status == "A") {
                        $('#memberList').append("<td><input type=\"checkbox\" title=\"停用\" class=\"switch_1\" name=\"Role_User_Permission\" onchange=\"aaa('" + element.user_Code + "','X')\" checked value=\"0\">&ensp;" +
                            "<a title='修改' onclick=\"WeAdminEdi('编辑','${pageContext.request.contextPath}/JSP/admin/Edit.jsp'," + element.user_Code + ", 600)\" href=\"javascript:;\">" +
                            "<i class='layui-icon'>&#xe631;</i></a></td>");
                    } else {
                        $('#memberList').append("<td><input type=\"checkbox\" title=\"启用\" class=\"switch_1\" name=\"Role_User_Permission\" onchange=\"aaa('" + element.user_Code + "','A')\"  value=\"0\">" +
                            "&ensp;<a title='删除' onclick='dele_del(" + element.user_Code + ")' href='javascript:;'><i class='layui-icon'>&#xe640;</i></a></td>");
                    }
                    $('#memberList').append("</tr>");
                });
                querynumber(p);
            }, error: function (data) {
            }
        })
    }

    // 删除用户
    function dele_del(id) {
        layer.confirm('确认删除用户吗？', function (index) {
            $.ajax({
                data: {
                    "user_Code": id,
                },
                type: "POST",
                url: "${pageContext.request.contextPath}/deleteUserStatus",
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

    // 修改状态
    function aaa(id, status) {
        layer.confirm('确认要改变状态吗？', function (index) {
            $.ajax({
                data: {
                    "user_Code": id,
                    "user_Status": status,
                },
                type: "POST",
                url: "${pageContext.request.contextPath}/updateUserStatus",
                success: function (data) {
                    var result = eval('(' + data + ')');
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
                }, error: function (data) {
                    alert("修改失败")
                }
            })
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
                    data: {"User_Code": id},
                    type: "POST",
                    url: "${pageContext.request.contextPath}/edituser",
                    success: function (data) {
                        var user = eval('(' + data + ')').user;
                        body.contents().find("#user_Code").val(user.user_Code);
                        body.contents().find("#User_Name").val(user.user_Name);
                        body.contents().find("#User_Tel").val(user.user_Tel);
                        body.contents().find("#User_Permission").append("<option value=null>" + user.user_Permission + "</option>");
                        body.contents().find("#User_Email").val(user.user_Email);
                        $(function () {
                            $.ajax({
                                type: "POST",
                                url: "${pageContext.request.contextPath}/selectRole",
                                success: function (data) {
                                    var result = jQuery.parseJSON(data);
                                    result.forEach(function (element) {
                                        body.contents().find('#User_Permission').append("<option value='" + element.role_Code + "'>" + element.role_Name + "</option>");
                                    })
                                }, error: function (data) {
                                }
                            })
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
                "User_Id": i
                , "User_Permission": $('#User_Permission').val()
                , "User_Name": $('#User_Name').val()
                , "User_Status": $('#User_Status').val()
            },
            type: "POST",
            url: "${pageContext.request.contextPath}/listUnumber",
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
</script>
</body>
</html>
