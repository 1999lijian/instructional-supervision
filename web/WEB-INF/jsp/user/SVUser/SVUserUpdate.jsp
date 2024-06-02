<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改督导员用户信息</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <%--    提示框的样式--%>
    <link rel="stylesheet" type="text/css" href="/static/css/PromptStyle.css">
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
                <input type="hidden" name="svId" value="${updateSVUserdata.svId}">
                <input type="hidden" name="svuid" value="${updateSVUserdata.svuid}">
                <div class="form">
                    <label>密码</label>
                    <input type="text" class="form-control"
                           name="UUser.UPassword"
                           id="uPassword"
                           value="${updateSVUserdata.UUser.UPassword}"
                    >
                    <span id="uPasswordError" class="error"></span>
                </div>
                <div class="form">
                    <label>姓名</label>
                    <input type="text" class="form-control"
                           name="svName"
                           value="${updateSVUserdata.svName}"
                    >
                </div>

                <div class="form">
                    <label>性别</label>
                    <%-- 使用了条件（三元）运算符来判断 finAllUser.permission 和每个选项的值是否相等
                    如果相等，则添加 selected 属性
                    表示该选项为默认选项
                    请确保 finAllUser.permission 的值是一个数字
                    以便与选项的值进行比较  --%>
                    <select class="form-control" name="svSex">
                        <option value="1" ${updateSVUserdata.svSex == 0 ? 'selected' : ''}>男</option>
                        <option value="2" ${updateSVUserdata.svSex   == 1 ? 'selected' : ''}>女</option>
                    </select>
                </div>


                <div class="form">
                    <label>职称</label>
                    <input type="text" class="form-control"
                           name="svTitle"
                           value="${updateSVUserdata.svTitle}"
                    >
                </div>


                <div class="form">
                    <label>所属学院</label>
                    <select class="form-control" name="svCollegeNo" id="svCollegeNo">

                    </select>
                </div>


                <div class="form">
                    <label>督导级别</label>
                    <input type="text" class="form-control"
                           name="svLevel"
                           value="${updateSVUserdata.svLevel}"

                    >

                </div>
                <div class="form">
                    <label>联系电话</label>
                    <input type="text" class="form-control"
                           name="svPhone"
                           value="${updateSVUserdata.svPhone}"
                           id="svPhone"
                    >
                    <span id="aPhoneError" class="error"></span>
                </div>
                <div class="form">
                    <label>电子邮箱</label>
                    <input type="text" class="form-control"
                           name="svEmail"
                           value="${updateSVUserdata.svEmail}"
                           id="svEmail"
                    >
                    <span id="aEmailError" class="error"></span>
                </div>
                <div class="form">
                    <label>QQ</label>
                    <input type="text" class="form-control"
                           name="svQQ"
                           value="${updateSVUserdata.svQQ}"
                    >
                </div>
                <div class="form">
                    <label>备注</label>
                    <input type="text" class="form-control"
                           name="svNotes"
                           value="${updateSVUserdata.svNotes}"
                    >
                </div>


            </form>
        </div>
        <div class="modal-footer">
            <%--                提交按钮事件 addUserButton --%>
            <button type="button" class="btn btn-secondary" onclick="updateButton()">确认</button>
            <a type="button" class="btn btn-primary" href="/supervision/findAllTUser">取消</a>
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
<script src="/static/js/SVUser.js"></script>

<script>

    //    提交添加的新的按钮
    function updateButton() {
        var form = $("#updateData");
        //将数据
        var formData = form.serialize();

        $.ajax({
            url: "/supervision/updateSVUser",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findAllSVUser';
                console.log(response);
            }
        });
    }


    var svCollegeNo = ${updateSVUserdata.svCollegeNo};
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/findAllCollegeSVU', // 后端接口地址
            type: 'GET',
            success: function (data) {
                var departmentSelect = $('#svCollegeNo');
                departmentSelect.empty(); // 清空下拉框中的现有选项
                $.each(data, function (index, collegeSVU) {
                    var option = $('<option>', {
                        value: collegeSVU.collegeId,
                        text: collegeSVU.collegeName
                    });
                    if (svCollegeNo == collegeSVU.collegeId) {
                        option.prop('selected', true); // 设置选中状态
                    }
                    departmentSelect.append(option);
                });
            },
            error: function () {
                alert('Failed to fetch department data.');
            }
        });
    });


</script>
</body>
</html>