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

    <title>教学审核页面</title>

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
        <form id="updateTeachingDate" enctype="multipart/form-data">

            <input type="hidden" name="teId" value="${updateTeachingDate.teId}">


            <!-- 教学名称 -->
            <div class="input-group mb-3">
                <span class="input-group-text" id="inputGroup-sizing-default">教学名称</span>
                <input type="text" class="form-control" aria-label="Sizing example input"
                       aria-describedby="inputGroup-sizing-default" id="TName" name="TName"
                       value="${updateTeachingDate.TName}" readonly>
            </div>

            <!-- 教学预期 -->
            <%--            在 <input> 标签中添加 readonly 属性 只读属性--%>
            <div class="input-group mb-3">
                <span class="input-group-text" id="ts">教学预期</span>
                <input type="text" class="form-control" aria-label="Sizing example input"
                       aria-describedby="ts" id="TExpect" name="TExpect" value="${updateTeachingDate.TExpect}" readonly>
            </div>

            <!-- 教学内容 -->
            <div class="input-group mb-3">
                <span class="input-group-text">教学内容</span>
                <%--                <textarea> 元素与 <input> 元素不同，它没有 value 属性来表示默认值。取而代之的是，
                在 <textarea> 元素的开始标签 <textarea> 和结束标签 </textarea> 之间添加文本内容。在您提供的示例中，
                应该在 <textarea> 标签的开始和结束之间添加要显示的文本内容，而不是使用 value 属性。--%>
                <textarea class="form-control" aria-label="With textarea" style="height: 200px" id="TContent"
                          name="TContent" readonly>${updateTeachingDate.TContent} </textarea>
            </div>

            <!-- 选择文件 -->
            <div class="input-group mb-3">

                <input type="text" class="form-control" id="filename" value="${updateTeachingDate.fileSava.FName}"
                       disabled>
                <a type="button" id="buttonToHide" class="btn btn-secondary  "
                   href="/supervision/findFileTeaching?fUid=${updateTeachingDate.fileSava.FUid}"
                >查看文件
                </a>
            </div>


            <!-- 提交/取消 -->

            <c:choose>
                <c:when test="${updateTeachingDate.TState eq 0  }">
                    <a type="button" class="btn btn-secondary"
                       href="/supervision/AuditingTeaching/${updateTeachingDate.teId}">审核通过</a>
                </c:when>
            </c:choose>


            <c:choose>
                <c:when test="${updateTeachingDate.TState eq 1  }">
                    <a type="button" class="btn btn-primary" href="/supervision/findAllTeaching?targets=Check">返回列表</a>
                </c:when>
                <c:otherwise>
                    <a type="button" class="btn btn-primary" href="/supervision/findAllTeaching?targets=Check">暂时</a>
                </c:otherwise>
            </c:choose>


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
