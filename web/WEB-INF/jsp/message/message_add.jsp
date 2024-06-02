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

    <title>留言添加页面</title>

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


        <form id="addUser">

            <%--            课程id--%>
            <input type="hidden" name="messageCourseId" value="${Data.CId}">
            <input type="hidden" name="messageUserId" value="${uId}">

            <div class="input-group mb-3">
                <label class="input-group-text">课程名称</label>
                <input type="text" class="form-control"
                       value="${Data.CName}" readonly
                >
            </div>

            <!-- 内容 -->
            <div class="input-group mb-3">
                <span class="input-group-text">留言内容</span>
                <textarea class="form-control" aria-label="With textarea" style="height: 200px" id="messageName"
                          name="messageName"></textarea>
            </div>

            <!-- 提交/取消 -->
            <button type="button" class="btn btn-secondary" onclick="addButton()">提交</button>
            <a type="button" class="btn btn-primary" href="/supervision/findAllCourse?evaluate=Message">取消</a>
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

    //    提交添加的新的按钮
    function addButton() {
        var form = $("#addUser");
        //将数据
        var formData = form.serialize();

        $.ajax({
            url: "/supervision/AddMessageSave/",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findAllCourse?evaluate=Message';
                console.log(response);
            }
        });
    }

</script>
</body>
</html>