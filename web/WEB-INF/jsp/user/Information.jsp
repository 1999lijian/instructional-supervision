<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人修改信息</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <%--    通用的样式--%>
    <link rel="stylesheet" type="text/css" href="/static/css/currency.css">
    <link rel="stylesheet" type="text/css" href="/static/css/Information.css">



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
            <%--警告框--%>
            <div class="alert alert-danger" role="alert" style="display: none;">
                <%--                    span 元素用于显示未填写字段的名称--%>
                <span id="errorMessage"></span>
            </div>

            <div>
                <%--                修改用户 用form表单进行提交--%>
                <form id="updateData">
                    <input type="hidden" name="uId" value="${SUserId.UId}">
                    <div class="form">
                        <label for="uPassword">密码</label>
                        <%--                        required属性来标记必填字段，这样浏览器会在提交表单之前自动验证这些字段是否为空  --%>
                        <input type="text" class="form-control"
                               name="UPassword"
                               value="${SUserId.UPassword}"
                               id="uPassword"
                        >
                    </div>
                    <%--
                    <c:choose> 标签用于在多个条件中进行选择，类似于 Java 中的 switch 语句。
                    在这里，它用来判断用户的类型并执行相应的代码块。
                    <c:when> 标签用于指定 <c:choose> 标签中的每个条件情况。
                    在这里，每个 <c:when> 标签都检查不同类型的用户信息是否存在，并在条件满足时执行相应的代码块。
                    ${not empty SUserId.AUser.AName} 这里使用 EL 表达式来检查特定类型用户的姓名是否存在。
                    如果用户类型是 AUser，并且 AName 不为空，则条件成立。
                    <c:set> 标签用于设置变量的值，
                    这里用来设置 userType 和 userName 的值，以便后续在页面上使用。
                    在最终的 <input> 标签中，使用了 ${userType}.${userType}Name 和 ${userName} 来设置输入框的名称和值。
                    这样根据不同的用户类型，会显示对应的用户姓名信
                    --%>
                    <%--                    not empty  不为空--%>
                    <c:choose>
                        <c:when test="${not empty SUserId.AUser.AName}">
                            <c:set var="userType" value="AName"/>
                            <c:set var="userName" value="${SUserId.AUser.AName}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.svUser.svName}">
                            <c:set var="userType" value="svName"/>
                            <c:set var="userName" value="${SUserId.svUser.svName}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.TUser.TName}">
                            <c:set var="userType" value="TName"/>
                            <c:set var="userName" value="${SUserId.TUser.TName}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.SUser.SName}">
                            <c:set var="userType" value="SName"/>
                            <c:set var="userName" value="${SUserId.SUser.SName}"/>
                        </c:when>
                    </c:choose>
                    <div class="form">
                        <label for="Name">姓名</label>
                        <input type="text" class="form-control"
                               name="${userType}"
                               value="${userName}"
                               id="Name"
                        >
                    </div>

                    <c:choose>
                        <c:when test="${not empty SUserId.SUser.SDate}">
                            <div class="form">
                                <span class="input-group-text" id="s">出生年月</span>
                                <input name="SDate" type="date" class="form-control" aria-label="Sizing example input"
                                       aria-describedby="inputGroup-sizing-default" value="${SUserId.SUser.SDate}">
                            </div>
                        </c:when>
                    </c:choose>


                    <%--                性别--%>
                    <c:choose>
                        <c:when test="${not empty SUserId.svUser.svSex}">
                            <div class="form">
                                <label>性别</label>
                                <select class="form-control" name="svSex">
                                    <c:forEach var="i" begin="0" end="1">
                                        <option value="${i}" ${SUserId.svUser.svSex == i ? 'selected' : ''}>${i == 0 ? '男' : '女'}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:when>

                        <c:when test="${not empty SUserId.TUser.TSex}">
                            <div class="form">
                                <label>性别</label>
                                <select class="form-control" name="TSex">
                                    <c:forEach var="i" begin="0" end="1">
                                        <option value="${i}" ${SUserId.TUser.TSex == i ? 'selected' : ''}>${i == 0 ? '男' : '女'}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:when>


                        <c:when test="${not empty SUserId.SUser.SSex}">
                            <div class="form">
                                <label>性别</label>
                                <select class="form-control" name="SSex">
                                    <c:forEach var="i" begin="0" end="1">
                                        <option value="${i}" ${SUserId.SUser.SSex == i ? 'selected' : ''}>${i == 0 ? '男' : '女'}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:when>
                    </c:choose>

                    <%--手机号码--%>
                    <c:choose>
                        <c:when test="${not empty SUserId.AUser.APhone}">
                            <c:set var="PhoneType" value="APhone"/>
                            <c:set var="PhoneV" value="${SUserId.AUser.APhone}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.svUser.svPhone}">
                            <c:set var="PhoneType" value="svPhone"/>
                            <c:set var="PhoneV" value="${SUserId.svUser.svPhone}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.TUser.TPhone}">
                            <c:set var="PhoneType" value="TPhone"/>
                            <c:set var="PhoneV" value="${SUserId.TUser.TPhone}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.SUser.SPhone}">
                            <c:set var="PhoneType" value="SPhone"/>
                            <c:set var="PhoneV" value="${SUserId.SUser.SPhone}"/>
                        </c:when>
                    </c:choose>

                    <div class="form">
                        <label for="phone">联系电话</label>
                        <input type="text" class="form-control" name="${PhoneType}" value="${PhoneV}" id="phone">
                    </div>


                    <%--邮箱--%>
                    <c:choose>
                        <c:when test="${not empty SUserId.AUser.AEmail}">
                            <c:set var="EmailType" value="AEmail"/>
                            <c:set var="EmailV" value="${SUserId.AUser.AEmail}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.svUser.svEmail}">
                            <c:set var="EmailType" value="svEmail"/>
                            <c:set var="EmailV" value="${SUserId.svUser.svEmail}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.TUser.TEmail}">
                            <c:set var="EmailType" value="TEmail"/>
                            <c:set var="EmailV" value="${SUserId.TUser.TEmail}"/>
                        </c:when>

                        <c:when test="${not empty SUserId.SUser.SEmail}">
                            <c:set var="EmailType" value="SEmail"/>
                            <c:set var="EmailV" value="${SUserId.SUser.SEmail}"/>
                        </c:when>
                    </c:choose>

                    <div class="form">
                        <label for="email">电子邮箱</label>
                        <input type="text" class="form-control" name="${EmailType}" value="${EmailV}" id="email">
                    </div>


                    <%--QQ--%>
                    <c:choose>

                        <c:when test="${not empty SUserId.AUser.AQQ}">
                            <c:set var="QQType" value="AQQ"/>
                            <c:set var="QQV" value="${SUserId.AUser.AQQ}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.svUser.svQQ}">
                            <c:set var="QQType" value="svQQ"/>
                            <c:set var="QQV" value="${SUserId.svUser.svQQ}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.TUser.TQQ}">
                            <c:set var="QQType" value="TQQ"/>
                            <c:set var="QQV" value="${SUserId.TUser.TQQ}"/>
                        </c:when>
                        <c:when test="${not empty SUserId.SUser.SQQ}">
                            <c:set var="QQType" value="SQQ"/>
                            <c:set var="QQV" value="${SUserId.SUser.SQQ}"/>
                        </c:when>
                    </c:choose>




                    <div class="form">
                        <label for="QQ">QQ</label>
                        <input type="text" class="form-control" name="${QQType}" value="${QQV}" id="QQ">
                    </div>

                </form>
            </div>

            <div class="modal-footer">
                <%--                提交按钮事件 addUserButton --%>
                <button type="button" class="btn btn-secondary" onclick="updateButton()">确认修改</button>
                <a type="button" class="btn btn-primary" href="/supervision/management">返回</a>
            </div>
        </div>
    </div>
</div>


</body>

<!-- jquery.js -->
<script src="/static/lib/jquery/jquery.js"></script>
<!-- popper.js -->
<script src="/static/js/popper.min.js"></script>
<!-- bootstrap.js -->
<script src="/static/lib/bootstrap/js/bootstrap.js"></script>

<script>

    <%--    实时检查 --%>
    // 在输入框失去焦点时验证内容是否为空
    $('input[type="text"]').on('blur', function () {
        if ($(this).val().trim() === '') {
            $(this).addClass('error-input');
        } else {
            $(this).removeClass('error-input');
        }
    });

    // 格式校验函数
    function validateFields() {
        var password = document.getElementById('uPassword').value;
        var phone = document.getElementById('phone').value;
        var email = document.getElementById('email').value;

        // 密码校验：6到20位字母和数字组合
        var passwordPattern = /^(?=.*\d)(?=.*[a-zA-Z]).{6,20}$/;
        if (!passwordPattern.test(password)) {
            $('#errorMessage').text('密码格式不正确，密码必须包含字母和数字，长度为6到20位');
            $('.alert').fadeIn(); // 显示警告框
            return false;
        }

        // 联系电话校验：11位数字
        var phonePattern = /^\d{11}$/;
        if (!phonePattern.test(phone)) {
            $('#errorMessage').text('联系电话格式不正确，必须为11位数字');
            $('.alert').fadeIn(); // 显示警告框
            return false;
        }

        // 电子邮箱校验：简单验证是否包含@符号
        var emailPattern = /\S+@\S+\.\S+/;
        if (!emailPattern.test(email)) {
            $('#errorMessage').text('电子邮箱格式不正确，请输入有效的邮箱地址');
            $('.alert').fadeIn(); // 显示警告框
            return false;
        }

        // 所有字段格式校验通过
        return true;
    }

    // 提交按钮事件
    function updateButton() {

        // 在提交之前再次进行内容为空的验证
        $('input[type="text"]').each(function () {
            if ($(this).val().trim() === '') {
                $(this).addClass('error-input');
            }
        });

        // 格式校验
        if (validateFields()) {
            //统计具有 error-input 类的文本输入框的数量
            var emptyFields = $('input[type="text"].error-input').length;

            if (emptyFields === 0) {
                var form = $("#updateData");
                var formData = form.serialize();

                $.ajax({
                    url: "/supervision/findSUserId",
                    type: "POST",
                    data: formData,
                    success: function (response) {
                        window.location.href = '/supervision/management';
                        console.log(response);
                    }
                });
            } else {
                // 如果有输入框内容为空，则不提交表单
                return false;
            }
        } else {
            setTimeout(function () {
                $('.alert').fadeOut(); // 3秒后隐藏警告框
            }, 3000);
        }
    }


</script>

</html>