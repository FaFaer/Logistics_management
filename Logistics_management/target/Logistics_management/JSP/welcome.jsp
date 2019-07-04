<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>欢迎页面-欢迎使用深蓝物流管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/weadmin.css">


</head>

<body>
<div class="weadmin-body">
    <blockquote class="layui-elem-quote">欢迎使用深蓝物流管理系统</blockquote>

    <div class="layui-col-lg12 layui-collapse" style="border: none;">
        <div class="layui-col-lg6 layui-col-md12">


            <!--统计信息展示-->
            <fieldset class="layui-elem-field" style="padding: 5px;">
                <!--天气提醒-->
                <blockquote class="layui-elem-quote font16">温馨提示</blockquote>
                <div class="layui-card-body" id="wormid">温馨提示</div>
                <!--WeAdmin公告-->
                <div class="layui-card">
                    <div class="layui-card-header layui-elem-quote">深蓝物流公告</div>
                    <div class="layui-card-body">
                        <div class="layui-carousel weadmin-notice" lay-filter="notice" lay-indicator="inside"
                             lay-arrow="none" style="width: 100%; height: 280px;">
                            <div carousel-item="">
                                <div class="">
                                    <a target="_blank" class="layui-bg-red">2018年3月28日 深蓝物流小版本更新</a>
                                </div>
                                <div class="">
                                    <a target="_blank" class="layui-bg-blue">深蓝物流管理系统正式发布</a>
                                </div>
                                <div class="">
                                    <a target="_blank" class="layui-bg-green">深蓝 官方发布 物流管理系统 多标签页版本</a>
                                </div>

                            </div>
                            <div class="layui-carousel-ind">
                                <ul>
                                    <li class="layui-this"></li>
                                    <li></li>
                                </ul>
                            </div>
                            <!--<button class="layui-icon layui-carousel-arrow" lay-type="sub"></button>
                            <button class="layui-icon layui-carousel-arrow" lay-type="add"></button>-->
                        </div>

                    </div>
                </div>
                <!--<legend>数据统计</legend>-->
                <blockquote class="layui-elem-quote font16">数据统计</blockquote>
                <div id="myEchart" style="width: 700px;height:400px;">

                </div>
            </fieldset>
        </div>
        <div class="layui-col-lg6 layui-col-md12">
            <fieldset class="layui-elem-field we-changelog" style="padding: 5px;">
                <!--更新日志-->
                <blockquote class="layui-elem-quote font16">发展历程&公司活动</blockquote>
                <ul class="layui-timeline" style=" overflow-y: auto;">
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">
                                <h3>深蓝物流成立分公司</h3>
                                <span class="layui-badge-rim">2007-01</span>
                            </div>
                            <ul>
                                <li>2007年1月成立深蓝物流日本分公司</li>
                                <li>2011年7月成立深蓝物流埃及分公司</li>
                                <li>2013年9月成立深蓝物流巴西分公司</li>
                                <li>2013年9月成立深蓝物流印尼分公司</li>
                                <li>2015年9月成立深蓝物流印度分公司</li>
                            </ul>
                        </div>
                    </li>
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">
                                <h3>深蓝物流更新基础版本为V2.2.6</h3>
                                <span class="layui-badge-rim">2018-04-03</span>
                            </div>
                            <ul>
                                <li>更新后台管理基础版本为V2.2.6</li>
                            </ul>
                        </div>
                    </li>
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis" style="color: #FF5722;">&#xe756;</i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">
                                <h3>深蓝物流十二年周年庆</h3>
                                <span class="layui-badge-rim">2019-1-25</span>
                            </div>
                            <blockquote class="layui-elem-quote">于
                                <a href="http://www.layui.com/doc/base/modules.html#extend" target="_blank">**国际大酒店</a>五楼举行周年庆，希望每位员工都能到场
                            </blockquote>
                            <ul>
                                <li>五点开始入场</li>
                                <li>周年庆开始</li>
                                <li>舞会</li>
                                <li>创始人及有重大贡献者分享经验</li>
                                <li>抽奖活动 &nbsp;<i class="layui-icon"
                                                  style="font-size: 16px; color: #FF5722;">&#xe60c;</i></li>
                            </ul>
                        </div>
                    </li>
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">
                                <h3>深蓝物流初步规划</h3>
                                <span class="layui-badge-rim">2018-01-01</span>
                            </div>
                            <p>
                                layui发版以来，很多朋友贡献了layui案例,其中后台相关案例占了比较大的比例。
                                <br>恰逢最近接触使用后台开发较多，就查阅了大量后台开源框架，layui的案例layuicms/vip-admin/x-admin/jqadmin等等，甚至还有AdminLte/H-ui
                                admin的demo.
                                <br>自己在做项目的时候，有一些特定需求，需要拓展的内容。
                                <br>项目工作告一段落的缝隙，就缝缝补补地研究layui写一下东西。
                                <br>第一次尝试，代码有些粗糙，也结合自己的理解希望能尽可能简单明了，模块完善中分享出来，希望能给需要的朋友一些参考。
                            </p>
                        </div>
                    </li>
                </ul>
            </fieldset>
        </div>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/admin.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/js/jquery.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/incubator-echarts/dist/echarts.min.js"
        charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/Pages/static/incubator-echarts/theme/macarons.js"
        charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        // 查询需要尽快完成订单
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/searchorderforIndex",
            success: function (data) {
                var result = jQuery.parseJSON(data);
                $('#wormid').html("<i class=\"layui-icon layui-icon-face-surprised\" style=\"font-size: 30px; color: #ff1d0f;\"></i>  您还有"+result.i+"张订单未出货，请分配配送车辆！")
            }, error: function (data) {
            }
        });
        // 图标数据查询和显示
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/searchforIndex",
            success: function (data) {
                var date = new Date();
                var temp = new Date();
                var dates = [6];
                var j = 0;
                for (var i = 5; i >= 0; i--) {
                    date.setMonth(temp.getMonth() + 1 - j++);
                    if (date.getMonth() == 0) {
                        dates[i] = 12;
                    } else {
                        dates[i] = date.getMonth();
                    }
                    dates[i] += "月";
                }

                var result = jQuery.parseJSON(data);
                var USERSdata = [result.USERS0, result.USERS1, result.USERS2, result.USERS3, result.USERS4, result.USERS5];
                var CLIENTELEdata = [result.CLIENTELE0, result.CLIENTELE1, result.CLIENTELE2, result.CLIENTELE3, result.CLIENTELE4, result.CLIENTELE5];
                var VEHICLEdata = [result.VEHICLE0, result.VEHICLE1, result.VEHICLE2, result.VEHICLE3, result.VEHICLE4, result.VEHICLE5];
                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('myEchart'), 'macarons');
                // 指定图表的配置项和数据
                var option = {
                    title: {
                        text: '数据统计'
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data: ['用户', '客户', '车辆']
                    },
                    calculable: true,
                    xAxis: {
                        type: 'category',
                        data: dates
                    },
                    yAxis: [
                        {
                            type: 'value'
                        }
                    ],
                    series: [
                        {
                            name: '用户',
                            type: 'bar',
                            data: USERSdata,
                        },
                        {
                            name: '客户',
                            type: 'bar',
                            data: CLIENTELEdata,
                        },
                        {
                            name: '车辆',
                            type: 'bar',
                            data: VEHICLEdata,
                        }
                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);


            }, error: function (data) {
            }
        });
    });


    layui.extend({
        admin: '{/}../Pages/static/js/admin',
    });
    layui.use(['jquery', 'element', 'util', 'admin', 'carousel'], function () {
        var element = layui.element,
            $ = layui.jquery,
            carousel = layui.carousel,
            util = layui.util,
            admin = layui.admin;
        //建造实例
        carousel.render({
            elem: '.weadmin-shortcut'
            , width: '100%' //设置容器宽度
            , arrow: 'none' //始终显示箭头
            , trigger: 'hover'
            , autoplay: false
        });

        carousel.render({
            elem: '.weadmin-notice'
            , width: '100%' //设置容器宽度
            , arrow: 'none' //始终显示箭头
            , trigger: 'hover'
            , autoplay: true
        });

        $(function () {
            setTimeAgo(2018, 0, 1, 13, 14, 0, '#firstTime');
            setTimeAgo(2018, 2, 28, 16, 0, 0, '#lastTime');
        });

        function setTimeAgo(y, M, d, H, m, s, id) {
            var str = util.timeAgo(new Date(y, M || 0, d || 1, H || 0, m || 0, s || 0));
            $(id).html(str);
        };
    });
</script>

</html>