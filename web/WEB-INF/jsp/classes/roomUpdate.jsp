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

    <title>教室修改页面</title>

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
            <form id="UpDate">
                <input type="hidden" name="roomId" value="${roomByRId.roomId}">
                <!-- 教学名称 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">教室</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" id="classRoom" name="classRoom"
                           value="${roomByRId.classRoom}">
                </div>
                <!-- 提交/取消 -->
                <button type="button" class="btn btn-secondary" onclick="updateButton()">提交</button>
                <a type="button" class="btn btn-primary" href="/supervision/findAllRoom">取消</a>
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
        var form = $("#UpDate");
        //将数据
        var formData = form.serialize();

        $.ajax({
            url: "/supervision/updateRoomId",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findAllRoom';
                console.log(response);
            }
        });
    }
</script>
</body>
</html>