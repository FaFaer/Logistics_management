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
    <form action="${pageContext.request.contextPath}/editvehicle1" method="post">
        <input type="text" id="vehicle_Id" name="vehicle_Id" style="display: none;"/>

        <div class="layui-form-item">
            <label for="vehicle_Code" class="layui-form-label">
                <span class="we-red">*</span>车牌号
            </label>
            <div class="layui-input-inline">
                <input type="text" id="vehicle_Code" name="vehicle_Code" required
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="vehicle_Keeper" class="layui-form-label">
                <span class="we-red">*</span>车辆负责人
            </label>
            <div class="layui-input-inline">
                <select required class="layui-select" id="vehicle_Keeper" name="vehicle_Keeper"></select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="vehicle_Warehouse" class="layui-form-label">
                <span class="we-red">*</span>所属仓库
            </label>
            <div class="layui-input-inline">
                <select required class="layui-select" id="vehicle_Warehouse" name="vehicle_Warehouse"></select>
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
<script type="text/javascript">
  
</script>
</body>

</html>