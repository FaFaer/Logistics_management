<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加仓库</title>
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
            <label class="layui-form-label"><span class="we-red">*</span>角色</label>
            <div class="layui-input-inline">
                <select class="layui-select" id="User_Permission" name="User_Permission" style="width: 100px;">
                    <option value="">请选择角色</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Warehouse_Keeper" class="layui-form-label">
                <span class="we-red">*</span>管理员
            </label>
            <div class="layui-input-inline">
                <select class="layui-select" id="Warehouse_Keeper" name="Warehouse_Keeper">
                    <option>-请选择仓库管理员-</option>
                </select>
            </div>
        </div>


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
            data:{Warehouse_Name:$('#Warehouse_Name').val()
                ,Warehouse_Tel:$('#Warehouse_Tel').val()
                ,Province:$('#Province').val()
                ,City:$('#City').val()
                ,District:$('#District').val()
                ,Warehouse_Address:$('#Warehouse_Address').val()
                ,User_Permission:$('#User_Permission').val()
                ,Warehouse_Keeper:$('#Warehouse_Keeper').val()
            }
            ,type: "POST",
            url: "${pageContext.request.contextPath}/addwarehouse",
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
        var Tel = $('#Warehouse_Tel').val();
        if (Tel.length != 11) {
            alert("请输入十一位联系方式！！");
        }
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
        });
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
        })
    });
        $('#User_Permission').change(function () {
        $.ajax({
            data:{"User_Permission":$('#User_Permission').val()},
            type: "POST",
            url: "${pageContext.request.contextPath}/selectusers",
            success: function (data) {
                $('#Warehouse_Keeper').empty();
                $('#Warehouse_Keeper').append("<option>-请选择仓库管理员-</option>");
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                        $('#Warehouse_Keeper').append("<option value='" + element.user_Id + "'>" + element.user_Name + "</option>");
                })
            }, error: function (data) {
            }
        });
    })
</script>
</body>

</html>