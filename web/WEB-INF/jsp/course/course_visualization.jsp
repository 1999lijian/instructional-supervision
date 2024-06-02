<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>


    <title>学生评价可视化页面</title>

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
                    <div class="col-lg-4 my-3">
                        <div class="row row-cards">
                            <div class="col-12">
                                <div class="card">
                                    <!-- 盒子内容 -->
                                    <div class="card-body" id="main" style="height: 15rem"></div>
                                </div>
                            </div>
                            <div class="col-12 my-2">
                                <div class="card">
                                    <div class="card-body" style="height: 20rem">
                                        <%--                                        <p>问题列表</p>--%>
                                        <table id="scoreTable" class="table table-hover">
                                            <thead class="table-light">
                                            <tr>
                                                <th>问题列表</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <!-- Data will be dynamically added here -->
                                            </tbody>
                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 my-3">
                        <div class="card">
                            <!-- 盒子内容 -->
                            <div class="card-body" id="chart" style="height: 36rem ">
                            </div>
                        </div>
                    </div>
                    <a type="button" class="btn btn-primary"
                       href="/supervision/findAllCourse?visualization=visualization">返回</a>
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
    <%--    问题列表 --%>
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/VDateProblem', // 后端接口地址
            type: 'GET',
            success: function (data) {
                console.log(data);
                // 清空表格内容
                $('#scoreTable tbody').empty();
                // 遍历返回的数据并添加到表格中
                data.forEach(function (score) {
                    $('#scoreTable tbody').append(
                        '<tr>' +
                        '<td>' + score.scoreName + '</td>' +
                        '</tr>'
                    );
                });
            },
            error: function () {
                alert('Failed to fetch department data.');
            }
        });
    });
</script>


<script>

    var chart = echarts.init(document.getElementById('chart'));
    // JSON 数据
    var jsonData = ${jsonOutput};
    // 检查 JSON 数据是否为空
    if (!jsonData || Object.keys(jsonData).length === 0) {
        // 如果 JSON 数据为空，显示弹窗提示信息
        alert("暂时没有该课程的评价！");

        // 返回到之前的页面
        window.history.back();
    } else {
        // 如果 JSON 数据不为空，继续处理数据
        // 在这里添加您需要执行的操作
        var dimensions = ['scoreName'];
        var source = [];
        jsonData.forEach(function (item) {
            dimensions = dimensions.concat(item.options.map(option => option.optionName));
            var dataObj = {'scoreName': item.scoreName};
            item.options.forEach(function (option) {
                dataObj[option.optionName] = option.count;
            });
            source.push(dataObj);
        });
        //   使用了 flatMap 方法来动态生成 bar series
        //      jsonData.flatMap：flatMap 方法是数组的一个方法，它首先将每个元素映射为一个新值（通过提供的函数），
        // 然后将所有的结果组合成一个新数组。在这里，我们首先对 jsonData 数组中的每个元素（即每个包含 scoreName 和 options 的对象）应用一个函数。
        // item => item.options.map(option => ({ type: 'bar' }))：
        // 对于每个 item，即每个包含 scoreName 和 options 的对象，
        // 将其转换为一个新数组。对于每个选项（option），返回一个包含 type: 'bar' 的对象，表示一个 bar series。
        // 结果：通过使用 flatMap 方法，
        // 将每个选项映射为一个包含 type: 'bar' 的对象数组，
        // 并将所有这些数组合并为一个单独的数组。这样，
        // 就生成了与每个选项对应的 bar series 数组，以便在 ECharts 中显示相应的数据。
        // JSON 数据中每个选项的数量动态生成对应数量的 bar series
        var series = jsonData.flatMap(item => item.options.map(option => ({
            type: 'bar'
        })));

        var option = {
            legend: {},
            title: {
                text: "课程名称：${CourseName}",
            },
            tooltip: {},
            dataset: {
                dimensions: dimensions,
                source: source
            },
            xAxis: {
                type: 'category',
            },
            yAxis: {
                type: 'value',
                minInterval: 1, // 指定刻度之间的最小间隔为1
            },
            series: series,
            toolbox: {
                feature: {
                    saveAsImage: {show: true} // 保存图片工具
                    // 还可以添加其他工具，根据需要配置
                }
            }
        };

        chart.setOption(option);

    }


    // 评价 未评价  人数
    // 这是你的评价数据
    var evaluationData = ${statisticsSUserEvaluateJson};

    var myChart = echarts.init(document.getElementById("main"));

    var option = {
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        title: {
            text: "人数",
        },
        legend: {
            orient: 'vertical',
            left: 'right',
            data: Object.keys(evaluationData)
        },
        series: [
            {
                name: '人数',
                type: 'pie',
                radius: '55%',
                center: ['50%', '60%'],
                data: Object.keys(evaluationData).map(function (key) {
                    return {value: evaluationData[key], name: key};
                }),
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    myChart.setOption(option);


</script>

</body>
</html>