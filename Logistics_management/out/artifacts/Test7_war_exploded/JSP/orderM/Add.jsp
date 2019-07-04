<%--
  Created by IntelliJ IDEA.
  User: TT
  Date: 2019/3/30
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>库存列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/weadmin.css">
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]
   <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>>
    <![endif]-->
    <style>
        #page .current{
            display: inline-block;
            background: #009688 0 0 no-repeat;
            color: #fff;
            padding: 10px;
            min-width: 15px;
            border: 1px solid #009688;
        }
        a:hover {
            cursor: pointer;
            color: rebeccapurple;
        }

        input[type="checkbox"] {
            width: 20px;
            height: 20px;
            display: inline-block;
            text-align: center;
            vertical-align: middle;
            line-height: 18px;
            position: relative;
        }

        input[type="checkbox"]::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            background: #fff;
            width: 100%;
            height: 100%;
            border: 1px solid #d9d9d9
        }

        input[type="checkbox"]:checked::before {
            content: "\2713";
            background-color: #fff;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            border: 1px solid #e50232;
            color: #e50232;
            font-size: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div id="testText">
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <input id="Order_Code" style="display: none">
        <div class="layui-inline" >
            <select class="layui-select" id="Vehicle_Id">
                <option value="">请选择车辆</option>
            </select></div><input type="submit" id="sub" value="出货" class="layui-btn"/>

    </div>
</div>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/admin.js" charset="utf-8"></script>
<script type="text/javascript">
    $('#sub').click(function () {
        $.ajax({
            data:{Order_Code:$('#Order_Code').val()
                ,Vehicle_Id:$('#Vehicle_Id').val()
            }
            ,type: "POST",
            url: "${pageContext.request.contextPath}/addvehicleforOrder",
            success: function (data) {
                var result = eval('(' + data + ')').result;
                if(result == true){
                    alert("出货成功")
                }else{
                    alert("出货失败")
                }
            }, error: function (data) {
                alert("出货失败")
            }
        });
    });

    $(function () {
        var timer = setTimeout(function () {
            $.ajax({
                data:{"Order_Code":$('#Order_Code').val()},
                type: "POST",
                url: "${pageContext.request.contextPath}/searchVForOrder",
                success: function (data) {
                    var result = jQuery.parseJSON(data);
                    result.forEach(function (element) {
                        $('#Vehicle_Id').append("<option value='" + element.vehicle_Id + "'>" + element.vehicle_Code + "</option>");
                    })
                }, error: function (data) {
                }
            });
        },100)
    });


</script>
</body>
</html>
