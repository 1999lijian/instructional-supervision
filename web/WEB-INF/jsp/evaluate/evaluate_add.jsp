<%--
  User: LIJIAN
  Date: 2024/1/16
  Time: 18:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <title>评价添加</title>

    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">

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


        <form action="/supervision/addEvaluateDate" method="post">

            <div class="input-group mb-3">
                <span class="input-group-text">问题</span>
                <input type="text" class="form-control" name="scoreName">
            </div>
            <div id="inputContainer">
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">选项一</span>
                    <input name="optionName" type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default">
                    <button class="btn btn-outline-secondary add-btn" type="button">添加</button>
                </div>
            </div>


            <!-- 提交/取消 -->
            <button type="submit" class="btn btn-secondary" id="add-button">提交</button>
            <a type="button" class="btn btn-primary" href="/supervision/findAllEvaluate">取消</a>
        </form>


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
    // 获取输入框容器
    const inputContainer = document.getElementById("inputContainer");

    // 添加按钮点击事件处理程序
    let inputCount = 1; // 初始化输入框组计数器

    inputContainer.addEventListener("click", function (event) {
        if (event.target.classList.contains("add-btn") && inputCount < 5) {
            // 创建新的输入框组
            const newInputGroup = document.createElement("div");
            newInputGroup.classList.add("input-group", "mb-3");

            // 创建带有文本的 span 元素
            const newSpan = document.createElement("span");
            newSpan.classList.add("input-group-text");
            newSpan.textContent = "新选项";

            // 创建新的输入框和移除按钮
            const newInput = document.createElement("input");
            newInput.type = "text";
            newInput.name = "optionName"; // 设置 name 属性
            newInput.classList.add("form-control");
            newInput.setAttribute("aria-label", "Sizing example input");
            newInput.setAttribute("aria-describedby", "inputGroup-sizing-default");

            const removeButton = document.createElement("button");
            removeButton.classList.add("btn", "btn-outline-secondary", "remove-btn");
            removeButton.type = "button";
            removeButton.textContent = "移除";

            // 将 span 元素、输入框和移除按钮添加到新的输入框组中
            newInputGroup.appendChild(newSpan);
            newInputGroup.appendChild(newInput);
            newInputGroup.appendChild(removeButton);

            // 将新的输入框组添加到输入框容器中
            inputContainer.appendChild(newInputGroup);

            // 增加输入框组计数器
            inputCount++;

            // 移除按钮点击事件处理程序
            removeButton.addEventListener("click", function () {
                inputContainer.removeChild(newInputGroup);
                inputCount--; // 减少输入框组计数器
            });
        }
    });
</script>

</body>
</html>