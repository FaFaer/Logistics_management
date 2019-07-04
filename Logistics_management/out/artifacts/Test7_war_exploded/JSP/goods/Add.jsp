<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加商品</title>
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
            <label for="Goods_Code" class="layui-form-label">
                <span class="we-red">*</span>商品条形码
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Goods_Code" name="Goods_Code" required
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Goods_Name" class="layui-form-label">
                <span class="we-red">*</span>商品名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Goods_Name" name="Goods_Name" required
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Goods_Price" class="layui-form-label">
                <span class="we-red">*</span>商品类型
            </label>
            <div class="layui-inline">
                <select class="layui-select" id="Goods_Type_Id" name="Goods_Type_Id">
                    <option value="">请选择商品类型</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="Goods_Price" class="layui-form-label">
                <span class="we-red">*</span>商品价格
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Goods_Price" name="Goods_Price" required autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="margin-left: 170px">
            <input type="submit" value="提交" id="sub" class="layui-btn"/>
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
            data:{
                Goods_Code:$('#Goods_Code').val()
                ,Goods_Name:$('#Goods_Name').val()
                ,Goods_Type_Id:$('#Goods_Type_Id').val()
                ,Goods_Price:$('#Goods_Price').val()
            }
            ,type: "POST",
            url: "${pageContext.request.contextPath}/addGoods",
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

    $('#Goods_Price').change(function () {
        var Goods_Price = $('#Goods_Price').val();
        var reg = /(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
        if (!reg.test(Goods_Price)) {
            alert("价格只能由数字组成")
        }
    });
    $(function () {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/listGTAll",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                result.forEach(function (element) {
                    $('#Goods_Type_Id').append("<option value='" + element.goods_Id + "'>" + element.goods_Name + "</option>");
                })
            }, error: function (data) {
            }
        });
    });
</script>
</body>

</html>