<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加商品类型</title>
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
            <label for="Goods_Name" class="layui-form-label">
                <span class="we-red">*</span>商品类型名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="Goods_Name" name="Goods_Name" required
                       autocomplete="off" class="layui-input">
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
            data:{Goods_Name:$('#Goods_Name').val()
            }
            ,type: "POST",
            url: "${pageContext.request.contextPath}/addGoodsType",
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
</script>
</body>

</html>