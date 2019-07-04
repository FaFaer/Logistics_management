<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>修改客户</title>
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
    <form action="${pageContext.request.contextPath}/editcliente1" method="post">
        <input type="text" id="Clientele_Code" name="Clientele_Code" style="display: none;">
        <div class="layui-form-item">
            <label for="Clientele_Name" class="layui-form-label">
                <span class="we-red">*</span>客户名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Clientele_Name" name="Clientele_Name" required
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Clientele_Principal" class="layui-form-label">
                <span class="we-red">*</span>负责人姓名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Clientele_Principal" name="Clientele_Principal" required autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Clientele_Tel" class="layui-form-label">
                <span class="we-red">*</span>联系电话
            </label>
            <div class="layui-input-inline">
                <input type="tel" id="Clientele_Tel" name="Clientele_Tel" required autocomplete="off"
                       maxlength="12" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Province1" class="layui-form-label">
                <span class="we-red">*</span>所在省
            </label>
            <div class="layui-input-inline">
                <select required class="layui-select" id="Province1" name="Province"></select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="City1" class="layui-form-label">
                <span class="we-red">*</span>所在市
            </label>
            <div class="layui-input-inline">
                <select required class="layui-select" id="City1" name="City"> </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="District1" class="layui-form-label">
                <span class="we-red">*</span>所在区
            </label>
            <div class="layui-input-inline">
                <select  class="layui-select" id="District1" name="District"></select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Clientele_Address" class="layui-form-label">
                <span class="we-red">*</span>详细地址
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Clientele_Address" name="Clientele_Address" required
                       autocomplete=""
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Clientele_Warehouse1" class="layui-form-label">
                <span class="we-red">*</span>所属仓库
            </label>
            <div class="layui-input-inline">
                <select  class="layui-select" id="Clientele_Warehouse1" name="Clientele_Warehouse"></select>
            </div>
        </div>


        <div class="layui-form-item" style="margin-left: 170px">
            <input type="submit" value="提交" class="layui-btn"/>
            <input type="reset" class="layui-btn layui-btn-danger" value="重置"/>
        </div></form>
</div>
<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/admin.js" charset="utf-8"></script>
    $('#Clientele_Tel').blur(function () {
        var Tel = $('#Clientele_Tel').val();
        if(Tel.length!=11){
            alert("请输入十一位联系方式！！");
        }
    });
    $('#Province1').change(function () {
        var Province1 = $('#Province1').val();
        $('#City1').empty();
        $('#City1').append("<option>-------请选择市-------</option>");
        $.ajax({
            data: {"China_Pid": Province1},
            type: "POST",
            url: "${pageContext.request.contextPath}/searchP",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#City1').append("<option value='" + element.china_Id + "'>" + element.china_Name + "</option>");
                })
            }, error: function (data) {
            }
        })
    });
    $('#City1').change(function () {
        var City = $('#City1').val();
        $('#District1').empty();
        $('#District1').append("<option>-------请选择区-------</option>");
        $.ajax({
            data: {"China_Pid": City},
            type: "POST",
            url: "${pageContext.request.contextPath}/searchP",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#District1').append("<option value='" + element.china_Id + "'>" + element.china_Name + "</option>");
                })
            }, error: function (data) {
            }
        })
    });
</script>
</body>

</html>