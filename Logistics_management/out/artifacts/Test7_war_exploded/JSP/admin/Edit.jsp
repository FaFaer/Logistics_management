<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改用户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/weadmin.css">

    <style>
        .layui-form-item {
            margin-left: 40px;
        }
    </style>
</head>
<body>
<div class="weadmin-body">
    <form class="layui-form" action="${pageContext.request.contextPath}/updateuser" method="post">
        <input id="user_Code" name="user_Code" style="display: none">
        <div class="layui-form-item">
            <label for="User_Name" class="layui-form-label">
                <span class="we-red">*</span>登录名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="User_Name" name="User_Name" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="we-red">*</span>将会成为您唯一的登入名
            </div>
        </div>
        <div class="layui-form-item">
            <label for="User_Tel" class="layui-form-label">
                <span class="we-red">*</span>手机
            </label>
            <div class="layui-input-inline">
                <input type="text" id="User_Tel" name="User_Tel" required="" lay-verify="phone"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="User_Email" class="layui-form-label">
                <span class="we-red">*</span>邮箱
            </label>
            <div class="layui-input-inline">
                <input type="text" id="User_Email" name="User_Email" required="" lay-verify="email"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="we-red">*</span>角色</label>
            <div class="layui-input-inline">
                <select class="layui-select" id="User_Permission" name="User_Permission" style="width: 100px;">
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <input type="submit" class="layui-btn" lay-filter="add" lay-submit="" value="修改">
        </div>
    </form>
</div>
<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {

        // 判断用户名是否重复
        $('#User_Name').blur(function () {
            $.ajax({
                data: {
                    "User_Name": $('#User_Name').val()
                    , "User_Code": $('#user_Code').val()
                },
                type: "POST",
                url: "${pageContext.request.contextPath}/selectuser1",
                success: function (data) {
                    var result = eval('(' + data + ')');
                    if (result.i == "1") {
                        alert("该用户名已存在！")
                    }
                }, error: function (data) {
                }
            })
        });
        layui.extend({
            admin: '${pageContext.request.contextPath}/Pages/static/js/admin'
        });
        layui.use(['form', 'layer', 'admin'], function () {
            var form = layui.form,
                admin = layui.admin,
                layer = layui.layer;
            form.render();

            // 自定义验证规则
        });
    })
</script>
</body>

</html>