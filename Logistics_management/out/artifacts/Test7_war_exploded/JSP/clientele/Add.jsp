<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加客户</title>
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
    <form action="" method="post">
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
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Province" class="layui-form-label">
                <span class="we-red">*</span>所在省
            </label>
            <div class="layui-input-inline">
                <select required class="layui-select" id="Province" name="Province">
                    <option value="">-------请选择省-------</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="City" class="layui-form-label">
                <span class="we-red">*</span>所在市
            </label>
            <div class="layui-input-inline">
                <select required class="layui-select" id="City" name="City">
                    <option>-------请选择市-------</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="District" class="layui-form-label">
                <span class="we-red">*</span>所在区
            </label>
            <div class="layui-input-inline">
                <select class="layui-select" id="District" name="District">
                    <option>-------请选择区-------</option>
                </select>
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
            <label for="Clientele_Warehouse" class="layui-form-label">
                <span class="we-red">*</span>所属仓库
            </label>
            <div class="layui-input-inline">
                <select class="layui-select" id="Clientele_Warehouse" name="Clientele_Warehouse">
                    <option>-------请选择所属仓库-------</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item" style="margin-left: 170px">
            <input type="submit" value="提交" class="layui-btn"/>
            <input type="reset" class="layui-btn layui-btn-danger" value="重置"/>
        </div>
    </form>
</div>
<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/admin.js" charset="utf-8"></script>
<script type="text/javascript">

    $('#sub').click(function () {
        $.ajax({
            data:{Clientele_Name:$('#Clientele_Name').val()
                ,Clientele_Principal:$('#Clientele_Principal').val()
                ,Clientele_Tel:$('#Clientele_Tel').val()
                ,Province:$('#Province').val()
                ,City:$('#City').val()
                ,District:$('#District').val()
                ,Clientele_Address:$('#Clientele_Address').val()
                ,Clientele_Warehouse:$('#Clientele_Warehouse').val()
            }
            ,type: "POST",
            url: "${pageContext.request.contextPath}/addclientele",
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

    $('#Clientele_Tel').blur(function () {
        var Tel = $('#Clientele_Tel').val();
        if (Tel.length != 11) {
            alert("请输入十一位联系方式！！");
        }
    });
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
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/searchW",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#Clientele_Warehouse').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");
                })
            }, error: function (data) {
            }
        })
    });
    $('#Province').change(function () {
        var Province = $('#Province').val();
        $('#City').empty();
        $('#City').append("<option>-------请选择市-------</option>");
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
        $('#District').append("<option>-------请选择区-------</option>");
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