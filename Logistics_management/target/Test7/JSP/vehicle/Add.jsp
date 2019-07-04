<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加车辆</title>
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
    <br><br><br><br>
    <form action="" method="post">
        <div class="layui-form-item">
            <label for="Vehicle_Code" class="layui-form-label">
                <span class="we-red">*</span>车牌号
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Vehicle_Code" name="Vehicle_Code" required
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <br><br>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="we-red">*</span>角色</label>
            <div class="layui-input-inline">
                <select class="layui-select" id="User_Permission" name="User_Permission" style="width: 100px;">
                    <option value="">请选择角色</option>
                </select>
            </div>
        </div>
        <br><br>
        <div class="layui-form-item">
            <label for="Vehicle_Keeper" class="layui-form-label">
                <span class="we-red">*</span>车辆负责人
            </label>

            <div class="layui-input-inline">
                <select required class="layui-select" id="Vehicle_Keeper" name="Vehicle_Keeper">
                    <option value="">-------请选择车辆负责人-------</option>
                </select>
            </div>
        </div><br><br>
        <div class="layui-form-item">
            <label for="Vehicle_Warehouse" class="layui-form-label">
                <span class="we-red">*</span>所属仓库
            </label>
            <div class="layui-input-inline">
                <select required class="layui-select" id="Vehicle_Warehouse" name="Vehicle_Warehouse">
                    <option value="">-------请选择所属仓库-------</option>
                </select>
            </div>
        </div>
        <br><br>
        <div class="layui-form-item" style="margin-left: 170px">
            <input type="submit" id="sub" value="提交" class="layui-btn"/>
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
            data:{Vehicle_Code:$('#Vehicle_Code').val()
                ,User_Permission:$('#User_Permission').val()
                ,Vehicle_Keeper:$('#Vehicle_Keeper').val()
                ,Vehicle_Warehouse:$('#Vehicle_Warehouse').val()
            }
            ,type: "POST",
            url: "${pageContext.request.contextPath}/addvehicle",
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
    });
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/searchW",
        success: function (data) {
            var result = jQuery.parseJSON(data);
            result.forEach(function (element) {
                $('#Vehicle_Warehouse').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");
            })
        }, error: function (data) {
        }
    });
    $('#User_Permission').change(function () {
        $.ajax({
            data:{"User_Permission":$('#User_Permission').val()},
            type: "POST",
            url: "${pageContext.request.contextPath}/selectusers",
            success: function (data) {
                $('#Vehicle_Keeper').empty();
                $('#Vehicle_Keeper').append("<option value=\"\">-------请选择车辆负责人-------</option>");
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#Vehicle_Keeper').append("<option value='" + element.user_Id + "'>" + element.user_Name + "</option>");

                })
            }, error: function (data) {
            }
        });
    })


</script>
</body>

</html>