<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加用户</title>
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
    <form class="layui-form" action="" method="post">
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="we-red">*</span>登录名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="username" name="User_Name" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="we-red">*</span>将会成为您唯一的登入名
            </div>
        </div>
        <div class="layui-form-item">
            <label for="phone" class="layui-form-label">
                <span class="we-red">*</span>手机
            </label>
            <div class="layui-input-inline">
                <input type="text" id="phone" name="User_Tel" required="" lay-verify="phone"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_email" class="layui-form-label">
                <span class="we-red">*</span>邮箱
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_email" name="User_Email" required="" lay-verify="email"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="we-red">*</span>角色</label>
            <div class="layui-input-inline">
                <select class="layui-select" id="User_Permission" name="User_Permission" style="width: 100px;">
                    <option value="">请选择角色</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_pass" class="layui-form-label">
                <span class="we-red">*</span>密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="L_pass" name="User_Password" required="" lay-verify="pass"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                6到16个字符
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
                <span class="we-red">*</span>确认密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="L_repass" name="repass" required="" lay-verify="repass"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" id="sub" class="layui-form-label"></label>
            <input type="submit"  class="layui-btn" lay-filter="add" lay-submit="" value="添加">
        </div>
    </form>
</div>
<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript">
    $('#sub').click(function () {
        $.ajax({
            data:{User_Name:$('#username').val()
                ,User_Tel:$('#phone').val()
                ,User_Email:$('#L_email').val()
                ,User_Permission:$('#User_Permission').val()
                ,User_Password:$('#L_pass').val()
            }
            ,type: "POST",
            url: "${pageContext.request.contextPath}/sveuser",
            success: function (data) {
                var result = eval('(' + data + ')').result;
                if(result == true){
                    alert("添加成功")
                }else{
                    alert("添加失败")
                }
            }, error: function (data) {
                alert("添加失败")
            }
        });
    });
    $(function () {
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
    });
$('#username').blur(function () {
    $.ajax({
        data:{"User_Name":$('#username').val()},
        type: "POST",
        url: "${pageContext.request.contextPath}/selectuser",
        success: function (data) {
            var result = eval('('+data+')');
            if(result.i == "1"){
                alert("该用户名已存在！")
            }
        }, error: function (data) {
        }
    })
});
    layui.extend({
        admin: '${pageContext.request.contextPath}/Pages/static/js/admin'
    });
    layui.use(['form','layer','admin'], function(){
        var form = layui.form,
            admin = layui.admin,
            layer = layui.layer;
        form.render();
        //自定义验证规则
        form.verify({
                nikename: function(value){
                    if(value.length < 5){
                        return '昵称至少得5个字符啊';
                    }
                }
                ,pass: [/(.+){6,16}$/, '密码必须6到16位']
                ,repass: function(value){
                    if($('#L_pass').val()!=$('#L_repass').val()){
                        return '两次密码不一致';
                    }
                }
        });

    });
</script>
</body>

</html>