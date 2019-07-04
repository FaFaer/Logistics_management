<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>深蓝物流管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/Pages/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/weadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js"
            charset="utf-8"></script>
    <style>
        a {
            cursor: pointer;
        }
    </style>
</head>

<body>
<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/Pages/index.html">深蓝物流管理系统</a>
    </div>
    <div class="left_open">
        <i title="展开左侧栏" class="iconfont">&#xe699;</i>
    </div>
    <ul class="layui-nav left fast-add" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">+新增</a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a onclick="WeAdminShow('资讯','http://www.huanqiu.com/?agt=15438/')"><i class="iconfont">&#xe6a2;</i>资讯</a>
                </dd>
                <dd>
                    <a onclick="WeAdminShow('角色','${pageContext.request.contextPath}/JSP/admin/role-add.jsp')"><i
                            class="iconfont">&#xe613;</i>角色</a>
                </dd>
                <dd>
                    <a onclick="WeAdminShow('用户','${pageContext.request.contextPath}/JSP/admin/Add.jsp')"><i
                            class="iconfont">&#xe6b8;</i>用户</a>
                </dd>
            </dl>
        </li>
    </ul>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item"><a href="javascript:;">${user.getUser_Name()}</a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->

                <dd>
                    <a onclick="WeAdminShow('切换帐号','login.jsp')">切换帐号</a>
                </dd>
                <dd>
                    <a class="loginout" href="" onclick="loginout()">退出</a>
                </dd>
            </dl>
        </li>
    </ul>

</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>订单管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/JSP/orderM/List.jsp">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>订单管理</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <c:if test="${user.getUser_Tel()/1000>=1}">
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe6b8;</i>
                        <cite>客户管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a _href="${pageContext.request.contextPath}/JSP/clientele/List.jsp">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>客户管理</cite>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>

            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe6ce;</i>
                    <cite>资源管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <c:if test="${(user.getUser_Tel()%100)/10>=1}">
                        <li>
                            <a _href=";;">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>商品管理</cite>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a _href="${pageContext.request.contextPath}/JSP/goods/ListType.jsp">
                                        <i class="iconfont">&#xe6a7;</i>
                                        <cite>商品类型管理</cite>
                                    </a>
                                </li>
                                <li>
                                    <a _href="${pageContext.request.contextPath}/JSP/goods/List.jsp">
                                        <i class="iconfont">&#xe6a7;</i>
                                        <cite>商品名管理</cite>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${(user.getUser_Tel()%1000)/100>=1}">
                        <li>
                            <a _href="${pageContext.request.contextPath}/JSP/vehicle/List.jsp">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>车辆管理</cite>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${user.getUser_Tel()%10>=1}">
                        <li>
                            <a _href=";;">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>库存管理</cite>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a _href="${pageContext.request.contextPath}/JSP/warehouse/List.jsp">
                                        <i class="iconfont">&#xe6a7;</i>
                                        <cite>仓库管理</cite>
                                    </a>
                                </li>
                                <li>
                                    <a _href="${pageContext.request.contextPath}/JSP/inventory/List.jsp">
                                        <i class="iconfont">&#xe6a7;</i>
                                        <cite>库存管理</cite>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:if>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe726;</i>
                    <cite>用户管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <c:if test="${(user.getUser_Permission()%1000)/100 >= 1}">
                        <li>
                            <a _href="${pageContext.request.contextPath}/JSP/admin/List.jsp">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>用户列表</cite>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${user.getUser_Permission()/1000 >= 1}">
                        <li>
                            <a _href="${pageContext.request.contextPath}/JSP/admin/role-list.jsp">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>角色管理</cite>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </li>
        </ul>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="wenav_tab" id="WeTabTip" lay-allowclose="true">
        <ul class="layui-tab-title" id="tabName">
            <li>我的桌面</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='${pageContext.request.contextPath}/JSP/welcome.jsp' frameborder="0" scrolling="yes"
                        class="weIframe"></iframe>
            </div>
        </div>
    </div>
</div>
<div class="page-content-bg"></div>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
<!-- 底部开始 -->
<div class="footer">
    <div class="copyright"> ©2019 唐存花 v1.0 All Rights Reserved</div>
</div>
<!-- 底部结束 -->
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript">
    //			layui扩展模块的两种加载方式-示例
    //		    layui.extend({
    //			  admin: '{/}../../static/js/admin' // {/}的意思即代表采用自有路径，即不跟随 base 路径
    //			});
    //			//使用拓展模块
    //			layui.use('admin', function(){
    //			  var admin = layui.admin;
    //			});
    layui.config({
        base: '${pageContext.request.contextPath}/Pages/static/js/'
        , version: '101100'
    }).use('admin');

    function loginout() {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/loginout",
            success: function (data) {
                layer.msg('注销成功!', {
                    icon: 1,
                    time: 1000
                });
            }, error: function (data) {
                layer.msg('注销失败!', {
                    icon: 1,
                    time: 1000
                });
            }
        });
    }
</script>
<!--Tab菜单右键弹出菜单-->
<ul class="rightMenu" id="rightMenu">
    <li data-type="fresh">刷新</li>
    <li data-type="current">关闭当前</li>
    <li data-type="other">关闭其它</li>
    <li data-type="all">关闭所有</li>
</ul>
</body>


</html>