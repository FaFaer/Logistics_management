<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>入库</title>
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
            <label for="Inventory_GoodsType_Id" class="layui-form-label">
                <span class="we-red">*</span>商品类型
            </label>
            <div class="layui-inline">
                <select class="layui-select" id="Inventory_GoodsType_Id" name="Inventory_GoodsType_Id">
                    <option value="">请选择商品类型</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Inventory_Goods_Id" class="layui-form-label">
                <span class="we-red">*</span>商品名
            </label>
            <div class="layui-inline">
                <select class="layui-select" id="Inventory_Goods_Id" name="Inventory_Goods_Id">
                    <option value="">请选择商品</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Inventory_Warehouse_Id" class="layui-form-label">
                <span class="we-red">*</span>仓库
            </label>
            <div class="layui-inline">
                <select class="layui-select" id="Inventory_Warehouse_Id" name="Inventory_Warehouse_Id">
                    <option value="">请选择仓库</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Inventory_Amount" class="layui-form-label">
                <span class="we-red">*</span>数量
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Inventory_Amount" name="Inventory_Amount" required autocomplete="off"
                       class="layui-input">
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
           data:{Inventory_GoodsType_Id:$('#Inventory_GoodsType_Id').val()
               ,Inventory_Goods_Code:$('#Inventory_Goods_Id').val()
               ,Inventory_Warehouse_Id:$('#Inventory_Warehouse_Id').val()
               ,Inventory_Amount:$('#Inventory_Amount').val()
           }
           ,type: "POST",
           url: "${pageContext.request.contextPath}/addInventory",
           success: function (data) {
               var result = eval('(' + data + ')').result;
               if(result == true){
                  alert("入库成功")
               }else{
                   alert("入库失败")
               }
           }, error: function (data) {
               alert("入库失败")
           }
       });
   });
    $(function () {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/listGTAll",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#Inventory_GoodsType_Id').append("<option value='" + element.goods_Id + "'>" + element.goods_Name + "</option>");
                })
            }, error: function (data) {
            }
        });
    });
    $('#Inventory_GoodsType_Id').change(function () {
        $.ajax({
            data: {"Goods_Type_Id": $('#Inventory_GoodsType_Id').val()},
            type: "POST",
            url: "${pageContext.request.contextPath}/listGforType",
            success: function (data) {
                $('#Inventory_Goods_Id').empty();
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#Inventory_Goods_Id').append("<option value='" + element.goods_Code + "'>" + element.goods_Name + "</option>");
                })
            }, error: function (data) {
            }
        });
    })
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/searchW",
        success: function (data) {
            var result = jQuery.parseJSON(data);
            result.forEach(function (element) {
                $('#Inventory_Warehouse_Id').append("<option value='" + element.warehouse_Id + "'>" + element.warehouse_Name + "</option>");
            })
        }, error: function (data) {
        }
    })
</script>
</body>

</html>