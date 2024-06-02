<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>


    <title>听课评价可视化页面</title>

    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <link rel="stylesheet" href="/static/css/management.css">
</head>
<body>
<!-- 顶部 -->
<div>
    <jsp:include page="../../jsp/Top.jsp"/>

</div>

<div class="container-fluid">

    <div class="row">
        <!-- 左边 -->
        <jsp:include page="../../jsp/Menu.jsp"/>
        <%--内容--%>
        <div class="col-10   " style="  background-color: #f7f7fc98;">
            <div class="container-xl my-3 ">
                <div class="row row-deck row-cards mx-2">
                    <div class="col-lg-3 my-3">
                        <div class="row row-cards">
                            <div class="col-12">
                                <div class="card">
                                    <!-- 盒子内容 -->
                                    <div class="card-body" style="height: 10rem"></div>
                                </div>
                            </div>
                            <div class="col-12 my-2">
                                <div class="card">
                                    <div class="card-body" style="height: 25rem"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9 my-3">
                        <div class="card">
                            <!-- 盒子内容 -->
                            <div class="card-body" id="chart" style="height: 36rem ">
                            </div>
                        </div>
                    </div>
                    <a type="button" class="btn btn-primary"
                       href="/supervision/findAllCourse?visualization=zlisten">返回</a>
                </div>
            </div>


        </div>

    </div>
</div>

<!-- jquery.js -->
<script src="/static/lib/jquery/jquery.js"></script>
<!-- popper.js -->
<script src="/static/js/popper.min.js"></script>
<!-- bootstrap.js -->
<script src="/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="/static/lib/echarts/echarts.min.js"></script>


<script>

    var chart = echarts.init(document.getElementById('chart'));


    var option = {
        title: {
            text: '听课评价占比情况'
        },
        legend: {
            data: ['优秀', '良好', '中等', '差',]
        },
        radar: {

            indicator: [
                {name: '资料齐全规范，讲课精神饱满', max: 10},
                {name: '尊重学生,治学严谨', max: 10},
                {name: '教学目标明确进度适宜', max: 10},
                {name: '观点正确，表述清楚，逻辑性强', max: 10},
                {name: '内容充实，结构合理，重点突出', max: 10},
                {name: '注意介绍本学科研究和发展动态', max: 10},
                {name: '理论联系实际善于启发思维', max: 10},
                {name: '实现师生互动课堂气氛活跃', max: 10},
                {name: '有效利用各种教学媒体', max: 10},
                {name: '学习气氛浓厚', max: 10},
                {name: '学生学有所获', max: 10},


            ]
        },
        series: [
            {
                name: '听课情况占比',
                type: 'radar',
                data: [
                    {
                        value: ${youxiuValues},
                        name: '优秀'
                    },
                    {
                        value: ${GoodValues},
                        name: '良好'
                    },
                    {
                        value: ${SecondaryValues},
                        name: '中等'
                    },
                    {
                        value: ${DifferenceValues},
                        name: '差'
                    },

                ]
            }
        ],
        tooltip: {
            trigger: 'item'
        }
    };


    chart.setOption(option);


</script>

</body>
</html>