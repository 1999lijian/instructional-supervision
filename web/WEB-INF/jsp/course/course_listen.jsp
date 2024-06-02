<%--
  User: LIJIAN
  Date: 2024/1/16
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>听课页面</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">

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
    <!-- 内容 -->
    <div class="col-10 ">

        <div class="container">
            <h2>听课评价表：${ListenData.CName}</h2>
            <table class="table  table-bordered">

                <input type="hidden" name="CId" value="${ListenData.CId}">
                <input type="hidden" name="uId" value="${ListenUId}">


                <thead class="thead-dark">
                <tr>
                    <th scope="col">一级指标</th>
                    <th scope="col">二级指标</th>
                    <th scope="col">评价依据</th>
                    <th scope="col">评价结果</th>

                </tr>
                </thead>
                <tbody>
                <tr>
                    <td rowspan="3">教学资料及教学态度</td>
                    <td rowspan="2">资料齐全规范，讲课精神饱满</td>

                    <td>教师携带教学大纲、教学进度、教案(规范详实)、教材等，<br>
                        教学进度表格式规范完整，实际授进度与教学进度表计划基本吻合。
                    </td>
                    <td>
                        <div id="radioGroupContainer1"></div>
                    </td>

                </tr>
                <tr>
                    <td>讲课有热情，精神饱满，对学生违反课学纪律的现象严抓严管，课堂秩序良好</td>
                    <td>
                        <div id="radioGroupContainer2"></div>
                    </td>

                </tr>
                <tr>
                    <td>尊重学生,治学严谨<br></td>
                    <td>老师为人师表，认真上好每一节课，关爱每一个学生，师生关系融治。</td>
                    <td>
                        <div id="radioGroupContainer3"></div>
                    </td>

                </tr>

                </tbody>

                <tbody>
                <tr>
                    <td rowspan="5">教学内容</td>
                    <td rowspan="2">教学目标明确进度适宜</td>

                    <td>授课内容符合教学大纲，切合教学目标，内容设计体现
                        ”知识、理解<br>、应用、分析、综合或评价"等层次，
                        并按照层次设计课堂活动及案例帮助实现目标
                    </td>
                    <td>
                        <div id="radioGroupContainer4"></div>
                    </td>

                </tr>
                <tr>
                    <td>课堂内容导入、讲解、总结等环节完整，教学环节时间分配合理</td>
                    <td>
                        <div id="radioGroupContainer5"></div>
                    </td>

                </tr>
                <tr>
                    <td>观点正确，表述清楚，逻辑性强</td>
                    <td>讲课概念准确清楚，逻辑性强，无照本宣科现象。</td>
                    <td>
                        <div id="radioGroupContainer6"></div>
                    </td>

                </tr>

                <tr>
                    <td>内容充实， 结构合理，重点突出</td>
                    <td>课程内容信息饱满，有一定深度，学生通过努力可以接受。<br>
                        重点内容的教学时间得到保证。
                    </td>
                    <td>
                        <div id="radioGroupContainer7"></div>
                    </td>

                </tr>
                <tr>
                    <td>注意介绍本学科研究和发展动态</td>
                    <td>案例、活动、讨论等内容能紧密结合行业动态，注意介绍本学科研究和发展动态。</td>
                    <td>
                        <div id="radioGroupContainer8"></div>
                    </td>

                </tr>
                </tbody>
                <tbody>
                <tr>
                    <td rowspan="3">教学方法</td>
                    <td>理论联系实际善于启发思维
                    </td>
                    <td>采用适宜的运用灵活多样的教学方式方法，激发学生学习兴趣，<br>
                        引导学生思考，组织讨论、练习、活动等，体现以学生能力培养为中心。
                    </td>
                    <td>
                        <div id="radioGroupContainer9"></div>
                    </td>

                </tr>
                <tr>
                    <td>实现师生互动课堂气氛活跃
                    </td>
                    <td>教师走近学生，注意观察学生反应，或有采用其他关注学生的方式，<br>
                        对学生回答及时评价，课堂开展有效互动。
                    </td>
                    <td>
                        <div id="radioGroupContainer10"></div>
                    </td>

                </tr>
                <tr>
                    <td>有效利用各种教学媒体
                    </td>
                    <td>板书布局合理美观，有效利用教学资源，有效利用各种教学媒体和手段，效果较好</td>
                    <td>
                        <div id="radioGroupContainer11"></div>
                    </td>

                </tr>
                </tbody>
                <tbody>
                <tr>
                    <td rowspan="2">教学效果</td>
                    <td>学习气氛浓厚</td>

                    <td>学生认真听课，记笔记，主动参与问答、练习等学习活动。</td>
                    <td>
                        <div id="radioGroupContainer12"></div>
                    </td>

                </tr>
                <tr>
                    <td>学生学有所获</td>
                    <td>学生理解或掌握教学内容，学生的学习能力和创新性思维能力得到了提高.</td>
                    <td>
                        <div id="radioGroupContainer13"></div>
                    </td>

                </tr>
                </tbody>
            </table>

            <!-- 提交按钮 -->
            <button type="button" class="btn btn-primary" onclick="submitForm()">提交</button>
            <a type="button" class="btn btn-primary"  href="/supervision/findAllCourse?evaluate=Listening" >取消</a>
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


<script>
    // JavaScript动态生成单选按钮组函数
    function createRadioGroup(containerPrefix, numGroups, groupNamePrefix, options) {
        for (var i = 1; i <= numGroups; i++) {
            var containerId = containerPrefix + i;
            var groupName = groupNamePrefix + i;
            createRadioGroupHelper(containerId, groupName, options);
        }
    }

    // 辅助函数用于生成单个单选按钮组
    function createRadioGroupHelper(containerId, groupName, options) {
        var container = document.getElementById(containerId);
        var radioGroup = document.createElement('div');
        radioGroup.classList.add('form-check-group');

        options.forEach(function (option) {
            var input = document.createElement('input');
            input.type = 'radio';
            input.name = groupName;
            input.value = option.value;

            var label = document.createElement('label');
            label.textContent = option.label;

            radioGroup.appendChild(input);
            radioGroup.appendChild(label);
        });

        container.appendChild(radioGroup);
    }

    // 设置选项内容数组
    var options = [
        {value: '优秀', label: '优秀'},
        {value: '良好', label: '良好'},
        {value: '中等', label: '中等'},
        {value: '差', label: '差'}
    ];

    // 在不同的容器中生成收音机按钮组
    createRadioGroup('radioGroupContainer', 13, 'exampleRadios', options);

    // 用于获取所有已选择的单选按钮组的值
    function getAllRadioValues() {
        var radioValues = {};
        var radioGroups = document.querySelectorAll('input[type="radio"]');

        radioGroups.forEach(function (radio) {
            if (radio.checked) {
                if (!radioValues[radio.name]) {
                    radioValues[radio.name] = radio.value;
                }
            }
        });

        return radioValues;
    }

    //校验
    function checkAllRadioGroups() {
        var numGroups = 13; // 假设有多少个单选按钮组
        var allGroupsChecked = true;

        for (var i = 1; i <= numGroups; i++) {
            var groupName = 'exampleRadios' + i;
            var radioButtons = document.querySelectorAll('input[name="' + groupName + '"]');
            var groupChecked = false;

            radioButtons.forEach(function (radioButton) {
                if (radioButton.checked) {
                    groupChecked = true;
                }
            });

            if (!groupChecked) {
                // 如果某个单选按钮组没有选中任何选项，则设置标志为false并中断循环
                allGroupsChecked = false;
                break;
            }
        }

        return allGroupsChecked;
    }













    //提示
    function highlightUncheckedGroups() {
        var numGroups = 13; // 假设有13个单选按钮组

        for (var i = 1; i <= numGroups; i++) {
            var groupName = 'exampleRadios' + i;
            var radioButtons = document.querySelectorAll('input[name="' + groupName + '"]');
            var groupChecked = false;

            radioButtons.forEach(function (radioButton) {
                if (radioButton.checked) {
                    groupChecked = true;
                }
            });

            // 如果某个组没有选中任何选项，则为该组添加红色边框样式
            if (!groupChecked) {
                var containerId = 'radioGroupContainer' + i;
                var container = document.getElementById(containerId);
                container.style.border = '1px solid red';
            } else {
                // 如果该组有选中的选项，则移除红色边框样式（如果之前已经添加了）
                var containerId = 'radioGroupContainer' + i;
                var container = document.getElementById(containerId);
                container.style.border = 'none';
            }
        }
    }



    function submitForm() {
        // 首先执行单选按钮组的校验
        var allGroupsChecked = checkAllRadioGroups();

        // 突出显示未选择的单选按钮组（如果有）
        highlightUncheckedGroups();

        if (allGroupsChecked) {
            // 所有单选按钮组都至少有一个选中的选项
            // 获取隐藏字段的值
            var CId = document.querySelector('input[name="CId"]').value;
            var uId = document.querySelector('input[name="uId"]').value;

            // 获取单选按钮组的值
            var formData = getAllRadioValues();

            // 将隐藏字段的值添加到表单数据中 课程ID 用户ID
            formData.CId = CId;
            formData.uId = uId;
            // 提交表单的代码可以在这里添加
            $.ajax({
                type: 'POST',
                url: '/supervision/updateCourseListeningDateUp', // 后端处理页面的URL
                data: formData,
                success: function (response) {
                    // 处理提交成功的情况
                    alert('评价提交成功！');
                    window.location.href = '/supervision/findAllCourse?evaluate=Listening';
                    // 可以在这里重置表单或者执行其他操作
                },
                error: function (xhr, status, error) {
                    // 处理提交失败的情况
                    console.error('提交错误:', error);
                    alert('评价提交失败，请重试！');
                }
            });
        } else {

        }
    }


</script>

</body>
</html>
