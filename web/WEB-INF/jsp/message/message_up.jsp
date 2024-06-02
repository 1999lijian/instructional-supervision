<%--
  User: LIJIAN
  Date: 2024/2/21
  Time: 17:13
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--编码的解析器--%>

<html>
<head>

    <title>留言修改页面</title>

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
    <div class="row ">
        <!-- 左边 -->
        <jsp:include page="../../jsp/Menu.jsp"/>

        <!-- 内容 -->
        <div class="col-10 rounded-div">
            <form id="messageUpDate">
                <%--                留言ID--%>
                <input type="hidden" name="messageId" value="${Date.messageId}">
                <%--    课程ID  --%>
                <input type="hidden" name="messageCourseId" value="${Date.messageCourseId}">


                <!-- 课程名称 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">课程名称</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default"
                           value="${Date.courseList.CName}" readonly>
                </div>

                <!-- 教学名称 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">留言内容</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" id="messageName" name="messageName"
                           value="${Date.messageName}">
                </div>






                <!-- 提交/取消 -->
                <button type="button" class="btn btn-secondary" onclick="updateButton()" id="buttonSub">提交</button>
                <a type="button" class="btn btn-primary" href="/supervision/findMessageId/?target=Course">返回</a>
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

<script src="/static/lib/bootstrap-fileinput/fileinput.min.js"></script>
<script src="/static/lib/bootstrap-fileinput/zh.js"></script>


<script>


    //    提交添加的新的按钮
    function updateButton() {
        var form = $("#messageUpDate");
        //将数据
        var formData = form.serialize();

        $.ajax({
            url: "/supervision/UpMessageDate",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findMessageId/?target=Course';
                console.log(response);
            }
        });
    }


    document.addEventListener("DOMContentLoaded", function () {
        // 获取 URL 参数
        const urlParams = new URLSearchParams(window.location.search);
        // 获取需要显示的内容的 ID 跳转
        const target = urlParams.get('target');
        if (target) {
            // 获取输入框元素
            var messageNameInput = document.getElementById("messageName");
            // 根据 target 参数的值来判断是否设置输入框为只读
            if (target === 'specificValue') { // 在这里替换 'specificValue' 为您想要的特定值
                messageNameInput.readOnly = true;
                // 隐藏提交按钮
                var submitButton = document.getElementById("buttonSub"); // 使用按钮的 id 查找按钮元素
                submitButton.style.display = "none";
            } else {
                messageNameInput.readOnly = false;
            }
        }
    });


</script>
</body>
</html>