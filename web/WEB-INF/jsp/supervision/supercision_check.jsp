<%--
  User: LIJIAN
  Date: 2024/2/27
  Time: 3:06
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
<%--编码的解析器--%>

<html>
<head>

    <title>查看督导任务</title>

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
            <%--
            enctype="multipart/form-data"
            是HTML表单中的一个属性，
            用于指定表单数据的编码类型。
            它告诉浏览器在将表单数据发送到服务器时，
            使用多部分表单数据编码格式来处理文件上传。
            这种编码格式可以将二进制文件数据和其他文本数据一起发送到服务器。一般来说，
            如果表单中包含文件上传功能，就需要设置enctype="multipart/form-data"。
            --%>
            <form id="updateSupervisionDate" enctype="multipart/form-data">
                <input type="hidden" name="supId" value="${updateSupervisionDate.supId}">
                <!-- 督导名称 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">督导名称</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" id="supName" name="supName"
                           value="${updateSupervisionDate.supName}" readonly>
                </div>


                <!-- 选择日期 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">日期</span>
                    <input id="supTimeStart" name="supTimeStart" type="date" class="form-control"
                           aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" value="${updateSupervisionDate.supTimeStart}"
                           readonly>
                </div>

                <div class="input-group mb-3">
                    <span class="input-group-text">日期</span>
                    <input id="supTimeEnd" name="supTimeEnd" type="date" class="form-control"
                           aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" value="${updateSupervisionDate.supTimeEnd}"
                           readonly>
                </div>


                <div class="input-group mb-3">
                    <span class="input-group-text" id="ts">督导要求</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="ts" id="TExpect" name="TExpect" value="${updateSupervisionDate.ask}"
                           readonly>
                </div>


                <!-- 选择文件 -->
                <div class="input-group mb-3">

                    <input type="text" class="form-control" id="filename"
                           value="${updateSupervisionDate.supervisionFileSava.FName}"
                           disabled>
                    <a type="button" id="buttonToHide" class="btn btn-secondary  "
                       href="/supervision/findFileSupervision?fUid=${updateSupervisionDate.supervisionFileSava.FUid}"
                    >查看文件
                    </a>
                </div>

                <a type="button" class="btn btn-primary" href="/supervision/findAllSupervision?targets=Checks">返回</a>
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

</body>
</html>
