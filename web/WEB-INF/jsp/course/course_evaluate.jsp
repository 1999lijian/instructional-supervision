<%--
  User: LIJIAN
  Date: 2024/2/27
  Time: 20:56
  To change this template use File | Settings | File Templates.
--%>
<%--
  User: LIJIAN
  Date: 2024/1/16
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%--
  User: LIJIAN
  Date: 2024/2/21
  Time: 17:13
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>课程评价</title>

    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/lib/bootstrap-fileinput/fileinput.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <%--    通用的样式--%>
    <link rel="stylesheet" type="text/css" href="/static/css/currency.css">
    <style>

        /* 图像为圆形 */
        .login-icon {
            border-radius: 50%;
        }


        /* 用户按钮阴影 浮动效果取消 */
        .username-btn,
        .username-btn:focus,
        .username-btn:active {
            border: none !important;
            outline: none !important;
            box-shadow: none !important;
        }
    </style>
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
        <div class="col-10 rounded-div">
            <div class="container form-control mb-3">

                <form id="updateDateA">
                    <input type="hidden" name="CId" value="${evaluateData.CId}">
                    <input type="hidden" name="evaluationUser" value="${uId}">
                    <h1 class="text-center">评价课程：${evaluateData.CName}</h1>
                    <%--            <c:forEach>标签结合varStatus属性来获取循环计数器的值  --%>
                    <c:forEach var="scoreList" items="${scoreList}" varStatus="loop">
                        <div class="row">
                            <div class="col-md-3 offset-md-3 form-wrapper">

                                <div class="form-group mb-3">
                                        <%--    loop.index表示当前循环的索引，因为索引是从0开始的，所以我们在显示顺序数字时需要加1  --%>
                                    <label>${loop.index + 1}.${scoreList.scoreName}</label><br>
                                    <c:forEach var="optionList" items="${optionList}">
                                        <%--test属性指定了一个条件表达式${optionList.scoreById==scoreList.scoreId}，
                                        如果这个条件表达式为true（即成立），就会执行<c:if>标签内部的代码块。
                                        具体来说，这个条件表达式比较了optionList对象中的scoreById属性值和scoreList对象中的scoreId属性值是否相等。
                                        如果它们相等，那么<c:if>标签内部的代码将会被执行。
                                        这种条件判断可以用来根据对象属性的值来控制页面上的展示内容或执行不同的操作。
                                         如果optionList对象中的scoreById与scoreList对象中的scoreId相等，那么条件成立，<c:if>标签内部的代码会被执行。--%>
                                        <c:if test="${optionList.scoreById==scoreList.scoreId}">
                                            <div class="form-check-inline">
                                                <input class="form-check-input" type="radio"
                                                       name="${optionList.scoreById}"
                                                       id="${optionList.scoreById}" value="${optionList.optionId}">
                                                <label class="form-check-label"
                                                       for="${optionList.scoreById}">${optionList.optionName}</label>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </form>
                <div class="progress">
                    <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0"
                         aria-valuemax="100"></div>
                </div>


            </div>

            <!-- 提交/取消按钮 -->
            <button type="button" class="btn btn-secondary" onclick="checkOptionsBeforeSubmit()">提交</button>
            <a type="button" class="btn btn-primary" href="/supervision/findAllCourse?evaluate=Evaluate">取消</a>
        </div>
    </div>


</div>



<!-- jquery.js -->
<script src="/static/lib/jquery/jquery.js"></script>
<!-- popper.js -->
<script src="/static/js/popper.min.js"></script>
<!-- bootstrap.js -->
<script src="/static/lib/bootstrap/js/bootstrap.js"></script>

<script src="/static/lib/bootstrap-fileinput/fileinput.min.js"></script>
<script src="/static/lib/bootstrap-fileinput/zh.js"></script>

<script>

</script>
<script>

    <%--进度条 与选项联动--%>
    // 获取问题总数
    var totalQuestions = ${scoreList.size()}; // 假设scoreList是一个List对象，可以使用size()方法获取问题总数

    // 监听所有回答选项的change事件
    document.querySelectorAll('input[type=radio]').forEach(input => {
        input.addEventListener('change', function () {
            // 获取已选择的回答选项数量
            var selectedOptions = document.querySelectorAll('input[type=radio]:checked').length;

            // 计算进度条宽度
            var progressWidth = selectedOptions / totalQuestions * 100;

            // 更新进度条样式
            document.querySelector('.progress-bar').style.width = progressWidth + '%';
            document.querySelector('.progress-bar').setAttribute('aria-valuenow', progressWidth);
        });
    });

    //检查提交时选项不为空
    function checkOptionsBeforeSubmit() {
        // 获取所有问题的容器
        var questionContainers = document.querySelectorAll('.form-wrapper');

        // 遍历每个问题的容器
        for (var i = 0; i < questionContainers.length; i++) {
            // 获取当前问题容器下的所有单选按钮
            var radioButtons = questionContainers[i].querySelectorAll('input[type=radio]');
            var checked = false;

            // 遍历当前问题的所有单选按钮
            for (var j = 0; j < radioButtons.length; j++) {
                // 如果有任意一个单选按钮被选中，则将 checked 设置为 true，并跳出循环
                if (radioButtons[j].checked) {
                    checked = true;
                    break;
                }
            }

            // 如果当前问题没有任何一个选项被选中，则弹出提示框提醒用户并且终止提交操作
            if (!checked) {
                alert('请确保每个问题至少选择一个选项');
                return;
            }
        }

        // 如果所有问题都至少选择了一个选项，则调用提交函数
        updateButton();
    }


    //    提交添加的新的按钮
    function updateButton() {

        var form = $("#updateDateA");
        //将数据
        var formData = form.serialize();
        $.ajax({
            url: "/supervision/SaveCourseEvaluateById",
            type: "POST",

            data: formData,
            success: function (response) {
                window.location.href = '/supervision/findAllCourse?evaluate=Evaluate';
                console.log(response);
            }
        });
    }


</script>
</body>
</html>
