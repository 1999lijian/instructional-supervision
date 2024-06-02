<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>主页页面</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <link rel="stylesheet" href="/static/css/management.css">
    <link rel="stylesheet" type="text/css" href="/static/lib/tooltipster/tooltipster.bundle.min.css"/>


</head>
<style>
    .table-container {
        max-height: 9rem; /* 根据需要调整高度 */
        overflow-y: auto;
        overflow-x: auto; /* 添加水平滚动条 */
        position: relative;
    }

    th, td {
        white-space: nowrap;
    }

    thead th {
        position: sticky;
        top: 0;
        background-color: #f8f9fa;
        z-index: 100;
    }

    .table-container thead th {
        position: sticky;
        top: 0;
        background-color: #f8f9fa;
        z-index: 100;
    }


</style>

<body>
<!-- 顶部 -->
<div>
    <jsp:include page="Top.jsp"/>
</div>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="Menu.jsp"/>
        <%--内容--%>
        <div class="col-10   " style="  background-color: #f7f7fc98;">
            <%--            隐藏引用面包屑导航   --%>
            <div style="display: none">
                <jsp:include page="breadcrumb.jsp"/>
            </div>

            <div class="container-xl my-3 ">
                <div class="row row-deck row-cards mx-2">
                    <%--               管理显示  --%>
                    <c:choose>
                        <c:when test="${userRole eq 1 }">
                            <div class="col-sm-6 col-lg-4 my-3 ">
                                <div class="card">
                                    <!-- 盒子内容 -->
                                    <div class="card-body" id="main" style="height: 15rem">
                                            <%--用户数量分配情况--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-4 my-3">
                                <div class="card">
                                    <div class="card-body" style="height: 15rem">
                                            <%--                                        <p>课程数量</p>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-4 my-3">
                                <div class="card">
                                    <!-- 盒子内容 -->
                                    <div class="card-body" id="auditing" style="height: 15rem">
                                            <%--                                        <p>教学计划审核情况</p>--%>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                    <div class="col-lg-6 my-3">
                        <div class="row row-cards">
                            <div class="col-12">
                                <div class="card">
                                    <!-- 盒子内容 -->
                                    <div class="card-body" style="height: 10rem">
                                        <%--   留言列表--%>
                                        <%--   使用 jquery  ajax 获取数据--%>
                                        <div class="table-container">
                                            <table class="table table-hover" id="messageTable">
                                                <thead>
                                                <tr>
                                                    <th>留言内容</th>
                                                    <th>课程名</th>
                                                </tr>
                                                </thead>
                                                <tbody></tbody>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="col-12 my-3">
                                <div class="card">
                                    <div class="card-body" style="height: 14rem">
                                        <p>系统公告</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 my-3">
                        <div class="card">
                            <!-- 盒子内容 -->
                            <div class="card-body" id="listChart" style="height: 25rem">

                            </div>

                        </div>
                    </div>
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

<script src="/static/lib/tooltipster/tooltipster.bundle.min.js"></script>

<%--       查询主页的留言列表--%>

<script>
    <%--       查询主页的留言列表--%>
    $(document).ready(function () {
        $.ajax({
            url: "/supervision/findMessageList", // 后端接口 URL
            type: "GET",
            dataType: 'json',
            success: function (data) {
                var tableBody = $('#messageTable tbody');
                tableBody.empty(); // 清空表格内容
                $.each(data, function (index, message) {
                    var row = '<tr  ' +
                        'title="留言内容:  ' +
                        message.messageName +
                        '\n课程名称内容：  ' +
                        message.courseList.cName +
                        '" >'
                        +
                        '<td class="text-truncate" style="max-width: 15px">' + message.messageName +
                        '</td>' +
                        '<td >' + message.courseList.cName + '</td>' +
                        '</tr>';
                    tableBody.append(row); // 添加新行到表格
                });


            },
            error: function (xhr, status, error) {
                console.error("Error fetching message list: " + error);
            }
        });
    });


</script>


<%--用户数量分配情况--%>
<script>

    <%--查询用户人数--%>
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/VUserNumber', // 后端接口地址
            type: 'GET',
            //请尝试在前端的 AJAX 请求中添加一个 dataType 属性，并将其设置为 "json"，以确保前端能正确解析从后端返回的 JSON 数据。
            dataType: 'json',
            // 同时设置 contentType: "application/json; charset=utf-8" 来指定发送请求的数据类型和字符编码。
            contentType: 'application/json; charset=utf-8',
            success: function (data) {

                // console.log(data);
                // 将返回的 JSON
                var userData = data;
                // 初始化Echarts图表
                var myChart = echarts.init(document.getElementById("main"));
                // 设置图表的配置项和数据
                var option = {
                    tooltip: {
                        trigger: 'item',
                    },
                    // 图表标题
                    title: {
                        text: "用户数量",
                    },
                    // legend: {
                    //     orient: 'vertical', // 将图例垂直显示
                    //     right: 'right',
                    //     data: Object.keys(userData) // 使用 JSON 数据的键作为图例数据
                    // },
                    series: [
                        {
                            name: '人数',
                            type: 'pie',
                            radius: ['40%', '70%'],                             // 整饼图的大小

                            data: Object.keys(userData).map(function (key) {
                                return {value: userData[key], name: key};
                            })
                        }
                    ]
                };
                // 使用指定的配置项和数据绘制图表
                myChart.setOption(option);
            },
            error: function () {
                alert('Failed to fetch department data.');
            }
        });
    });


</script>


<%--审核情况--%>
<script>
    <%--审核情况数量--%>
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/VAuditing', // 后端接口地址
            type: 'GET',
            //请尝试在前端的 AJAX 请求中添加一个 dataType 属性，并将其设置为 "json"，以确保前端能正确解析从后端返回的 JSON 数据。
            dataType: 'json',
            // 同时设置 contentType: "application/json; charset=utf-8" 来指定发送请求的数据类型和字符编码。
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                // 将返回的JSON数据存储在变量中
                var jsonData = data;

                // 初始化ECharts实例
                var auditing = echarts.init(document.getElementById('auditing'));

                // 构建ECharts所需的数据结构
                var legendData = [];
                var seriesData = [];

                // 遍历jsonData中的每个对象
                jsonData.forEach(function (item) {
                    legendData.push(item.stateDescription); // 将状态描述添加到图例数据中
                    var count = item.count;
                    if (item.stateDescription === '未审核') {
                        count = -count; // 如果状态描述为"未审核"，将数量变为负数
                    }
                    seriesData.push({
                        name: item.stateDescription,
                        type: 'bar',
                        stack: 'Total',
                        label: {
                            show: true,
                            position: 'top'
                        },
                        emphasis: {
                            focus: 'series'
                        },
                        data: [count] // 将处理后的数量添加到数据中
                    });
                });

                // ECharts配置项
                var option = {

                    title: {
                        text: "教学计划审核情况",
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    legend: {
                        right: '10', // 调整图例距离右侧的距离
                        top: '10', // 调整图例距离顶部的距离
                        data: legendData
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: [
                        {
                            type: 'value'
                        }
                    ],
                    yAxis: [
                        {
                            type: 'category',
                            axisTick: {
                                show: false
                            },
                            data: ['审核']
                        }
                    ],
                    series: seriesData
                };

                // 使用配置项和数据显示图表
                auditing.setOption(option);
            },


            error: function () {
                alert('Failed to fetch department data.');
            }
        });
    });


</script>


<%--校历--%>
<script>
    // 初始化列表图表
    var listChart = echarts.init(document.getElementById('listChart'));

    const layouts = [
        [[0, 0]],
        [
            [-0.25, 0],
            [0.25, 0]
        ],
        [
            [0, -0.2],
            [-0.2, 0.2],
            [0.2, 0.2]
        ],
        [
            [-0.25, -0.25],
            [-0.25, 0.25],
            [0.25, -0.25],
            [0.25, 0.25]
        ]
    ];
    const pathes = [];
    const colors = ['#c4332b', '#16B644', '#6862FD', '#FDC763'];

    function getVirtulData(year, month) {
        year = year || new Date().getFullYear().toString();
        month = month || new Date().getMonth() + 1;
        let date = +echarts.number.parseDate(year + '-' + month + '-01');
        let end = +echarts.number.parseDate(year + '-' + (month + 1) + '-01');
        let dayTime = 3600 * 24 * 1000;
        let data = [];
        for (let time = date; time < end; time += dayTime) {
            let items = [];
            let eventCount = Math.round(Math.random() * pathes.length);
            for (let i = 0; i < eventCount; i++) {
                items.push(Math.round(Math.random() * (pathes.length - 1)));
            }
            data.push([echarts.format.formatTime('yyyy-MM-dd', time), items.join('|')]);
        }
        return data;
    }

    var now = new Date();
    var currentYear = now.getFullYear();
    var currentMonth = now.getMonth() + 1;

    var option = {
        tooltip: {},
        title: {
            text: "日历",
        },
        calendar: [
            {
                left: 'center',

                cellSize: [65, 60],
                yearLabel: {show: false},
                orient: 'vertical',
                dayLabel: {
                    firstDay: 1,
                    nameMap: ['日', '一', '二', '三', '四', '五', '六']
                },
                monthLabel: {
                    show: false
                },
                range: currentYear + '-' + currentMonth
            }
        ],
        series: [
            {
                type: 'custom',
                coordinateSystem: 'calendar',
                renderItem: function (params, api) {
                    const cellPoint = api.coord(api.value(0));
                    const cellWidth = params.coordSys.cellWidth;
                    const cellHeight = params.coordSys.cellHeight;
                    const value = api.value(1);
                    const events = value && value.split('|');
                    if (isNaN(cellPoint[0]) || isNaN(cellPoint[1])) {
                        return;
                    }
                    const group = {
                        type: 'group',
                        children:
                            (layouts[events.length - 1] || []).map(function (
                                itemLayout,
                                index
                            ) {
                                return {
                                    type: 'path',
                                    shape: {
                                        pathData: pathes[+events[index]],
                                        x: -8,
                                        y: -8,
                                        width: 16,
                                        height: 16
                                    },
                                    position: [
                                        cellPoint[0] +
                                        echarts.number.linearMap(
                                            itemLayout[0],
                                            [-0.5, 0.5],
                                            [-cellWidth / 2, cellWidth / 2]
                                        ),
                                        cellPoint[1] +
                                        echarts.number.linearMap(
                                            itemLayout[1],
                                            [-0.5, 0.5],
                                            [-cellHeight / 2 + 20, cellHeight / 2]
                                        )
                                    ],
                                    style: api.style({
                                        fill: colors[+events[index]]
                                    })
                                };
                            }) || []
                    };
                    group.children.push({
                        type: 'text',
                        style: {
                            x: cellPoint[0],
                            y: cellPoint[1] - cellHeight / 2 + 15,
                            text: echarts.format.formatTime('dd', api.value(0)),
                            fill: '#777',
                            textFont: api.font({fontSize: 14})
                        }
                    });
                    return group;
                },
                dimensions: [undefined, {type: 'ordinal'}],
                data: getVirtulData(currentYear, currentMonth)
            }
        ]
    };


    // 使用配置项显示列表图表
    listChart.setOption(option);
</script>

</body>
</html>