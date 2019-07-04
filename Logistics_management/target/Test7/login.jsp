<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>用户登录-深蓝物流管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/Pages/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/weadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js"
            charset="utf-8"></script>

</head>
<body class="login-bg">

<div class="login">
    <div class="message">用户登录-深蓝物流管理系统</div>
    <div id="darkbannerwrap"></div>

    <form method="post" class="layui-form">
        <input id="name" placeholder="账号" type="text" class="layui-input"/>
        <hr class="hr15"/>
        <input id="password" placeholder="密码" type="password" class="layui-input"/>
        <hr class="hr15"/>
        <input class="loginin" id="sub" value="登录" style="width:100%;" type="submit" onclick="loginuser()"/>
        <hr class="hr20"/>
    </form>
</div>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/admin.js" charset="utf-8"></script>
<script type="text/javascript">
    function loginuser() {
        $.ajax({
            data: {"user_Name": $('#name').val(),
                   "user_Password": $('#password').val()},
            type: "POST",
            url: "${pageContext.request.contextPath}/login",
            success: function (data) {
                var result = eval('(' + data + ')');
                if (result.result != "1") {
                    alert("账号或密码错误，请重新输入！")
                } else {
                    alert("登陆成功！")
                }
            }, error: function (data) {
                alert("登陆失败，请重新登陆！")
            }
        })
    }
</script>
<!-- 底部结束 -->
</body>
</html>