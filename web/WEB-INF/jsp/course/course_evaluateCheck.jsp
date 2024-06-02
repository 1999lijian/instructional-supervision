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

    <title>查看课程评价</title>

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
                                    <label>${loop.index + 1}.${scoreList.scoreName}</label><br>
                                    <c:forEach var="optionItem" items="${optionList}">
                                        <c:if test="${optionItem.scoreById == scoreList.scoreId}">
                                            <div class="form-check-inline">
                                                    <%--
                                                    optionSelected 变量来跟踪是否已经选择了一个选项。
                                                    一旦找到符合条件的选项并选择了单选按钮，
                                                    就将 optionSelected 设置为 true，然后在后续循环中检查这个变量
                                                    --%>
                                                <c:set var="optionSelected" value="false"/>
                                                <c:forEach var="evaluationRecord" items="${evaluationRecordsById}">
                                                    <c:if test="${optionSelected eq false}">
                                                        <c:if test="${optionItem.optionId eq evaluationRecord.evaluationOption}">
                                                            <input class="form-check-input" type="radio"
                                                                   name="${optionItem.scoreById}"
                                                                   id="${optionItem.scoreById}"
                                                                   value="${optionItem.optionId}" checked>
                                                            <c:set var="optionSelected" value="true"/>
                                                        </c:if>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${optionSelected eq false}">
                                                    <input class="form-check-input" type="radio"
                                                           name="${optionItem.scoreById}"
                                                           id="${optionItem.scoreById}"
                                                           value="${optionItem.optionId}">
                                                </c:if>
                                                <label class="form-check-label"
                                                       for="${optionItem.scoreById}">${optionItem.optionName}</label>
                                            </div>
                                        </c:if>
                                    </c:forEach>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </form>
            </div>
            <!-- 提交/取消按钮 -->
            <button type="button" class="btn btn-secondary" onclick="checkOptionsBeforeSubmit()">修改</button>
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


<script>

</script>
<script>


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


    // 提示用户确认修改
    //使用 confirm() 方法来显示一个带有确认和取消选项的对话框。
    // 这个方法会返回 true（用户点击了“确定”）或者 false（用户点击了“取消”）
    function updateButton() {
        if (confirm("确认是否修改？")) {
            var form = $("#updateDateA");
            var formData = form.serialize();
            $.ajax({
                url: "/supervision/UpCourseEvaluateById",
                type: "POST",
                data: formData,
                success: function (response) {
                    window.location.href = '/supervision/findAllCourse?evaluate=Evaluate';
                    console.log(response);
                }
            });
        } else {
            // 用户取消操作时的逻辑
            console.log("用户取消了修改操作。");
        }
    }


</script>
</body>
</html>
