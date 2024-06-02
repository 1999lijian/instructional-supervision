<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改管理员信息</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <link rel="stylesheet" href="/static/css/PromptStyle.css">
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

    <jsp:include page="../../../jsp/Top.jsp"/>


</div>
<div class="container-fluid">

<div class="row">
    <!-- 左边 -->
    <jsp:include page="../../../jsp/Menu.jsp"/>
    <!-- 内容 -->
    <div class="col-10 rounded-div">
        <div class="table-responsive">
            <%--                修改用户 用form表单进行提交--%>
            <form id="updateData">
                <input type="hidden" name="AId" value="${updateAUserdata.AId}">
                <input type="hidden" name="auid" value="${updateAUserdata.auid}">
                <div class="form">
                    <label>密码</label>
                    <input type="text" class="form-control"
                           name="UUser.UPassword"
                           id="uPassword"
                           value="${updateAUserdata.UUser.UPassword}"
                    >
                    <span id="uPasswordError" class="error"></span>
                </div>
                <div class="form">
                    <label>姓名</label>
                    <input type="text" class="form-control"
                           name="AName"
                           value="${updateAUserdata.AName}"
                    >
                </div>


                <div class="form">
                    <label>联系电话</label>
                    <input type="text" class="form-control"
                           name="APhone"
                           id="aPhone"
                           value="${updateAUserdata.APhone}"
                    >
                    <span id="aPhoneError" class="error"></span>
                </div>
                <div class="form">
                    <label>电子邮箱</label>
                    <input type="text" class="form-control"
                           name="AEmail"
                           id="aEmail"
                           value="${updateAUserdata.AEmail}"
                    >
                    <span id="aEmailError" class="error"></span>
                </div>
                <div class="form">
                    <label>QQ</label>
                    <input type="text" class="form-control"
                           name="aQQ"
                           value="${updateAUserdata.AQQ}"
                    >
                </div>
                <div class="form">
                    <label>备注</label>
                    <input type="text" class="form-control"
                           name="aNotes"
                           value="${updateAUserdata.ANotes}"
                    >
                </div>


            </form>
        </div>
        <div class="modal-footer">
            <%--                提交按钮事件 addUserButton --%>
            <button type="button" class="btn btn-secondary" onclick="updateButton()">确认</button>
            <a type="button" class="btn btn-primary" href="/supervision/findAllAUser">取消</a>
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
<script src="/static/js/AUser.js"></script>

<script>

    //    提交添加的新的按钮
    function updateButton() {
        var form = $("#updateData");
        //将数据
        var formData = form.serialize();

        $.ajax({
            url: "/supervision/updateAUser",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findAllAUser';
                console.log(response);
            }
        });
    }

</script>
</body>
</html>