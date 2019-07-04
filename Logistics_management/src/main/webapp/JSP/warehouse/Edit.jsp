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
    <form action="${pageContext.request.contextPath}/edit1warehouse" method="post">
        <input name="Warehouse_Code" id="warehouse_Code" style="display: none">
        <div class="layui-form-item">
            <label for="Warehouse_Name" class="layui-form-label">
                <span class="we-red">*</span>仓库名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Warehouse_Name" name="Warehouse_Name" required
                       autocomplete="off" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label for="Warehouse_Tel" class="layui-form-label">
                <span class="we-red">*</span>联系电话
            </label>
            <div class="layui-input-inline">
                <input type="tel" id="Warehouse_Tel" name="Warehouse_Tel" required autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Province" class="layui-form-label">
                <span class="we-red">*</span>所在省
            </label>
            <div class="layui-input-inline">
                <input type="text"  class="layui-input" id="Province" name="Province" readonly="readonly"/>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="City" class="layui-form-label">
                <span class="we-red">*</span>所在市
            </label>
            <div class="layui-input-inline">
                <input  type="text" class="layui-input"  id="City" name="City" readonly="readonly" />

            </div>
        </div>

        <div class="layui-form-item">
            <label for="District" class="layui-form-label">
                <span class="we-red">*</span>所在区
            </label>
            <div class="layui-input-inline">
                <input  type="text" class="layui-input" id="District" name="District" readonly="readonly"/>

            </div>
        </div>

        <div class="layui-form-item">
            <label for="Warehouse_Address" class="layui-form-label">
                <span class="we-red">*</span>详细地址
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Warehouse_Address" name="Warehouse_Address" required
                       autocomplete=""
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Warehouse_Keeper" class="layui-form-label">
                <span class="we-red">*</span>管理员
            </label>
            <div class="layui-input-inline">
                <select class="layui-select" id="Warehouse_Keeper" name="Warehouse_Keeper">
                </select>
            </div>
        </div>


        <div class="layui-form-item" style="margin-left: 170px">
            <input type="submit" id="Editsub" value="修改" class="layui-btn"/>
            <input type="reset" class="layui-btn layui-btn-danger" value="重置"/>
        </div>
    </form>
</div>
<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/admin.js" charset="utf-8"></script>
<script type="text/javascript">
    // 电话号码的长度验证
    $('#Clientele_Tel').blur(function () {
        var Tel = $('#Warehouse_Tel').val();
        if (Tel.length != 11) {
            alert("请输入十一位联系方式！！");
        }
    });


</script>
</body>

</html>