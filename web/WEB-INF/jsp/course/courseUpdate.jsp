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

    <title>课程修改页面</title>

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
        <form id="updateDateA" enctype="multipart/form-data">

            <input type="hidden" name="CId" value="${updateData.CId}">


            <!-- 教学名称 -->
            <div class="input-group mb-3">
                <span class="input-group-text" id="inputGroup-sizing-default">课程名称</span>
                <input type="text" class="form-control" aria-label="Sizing example input"
                       aria-describedby="inputGroup-sizing-default" id="CName" name="CName"
                       value="${updateData.CName}">
            </div>

            <!-- 教学预期 -->
            <div class="input-group mb-3">
                <span class="input-group-text" id="ts">学分</span>
                <input type="text" class="form-control" aria-label="Sizing example input"
                       aria-describedby="ts" id="CCredit" name="CCredit" value="${updateData.CCredit}">
            </div>


            <!-- 选择教师 -->
            <div class="input-group mb-3">
                <span class="input-group-text">授课教师</span>
                <!-- 教师列表 -->
                <select class="form-control" id="CTeacherId" name="CTeacherId">
                    <!-- 下拉框将由 JavaScript 动态生成 -->
                </select>
            </div>


            <!-- 选择教室 -->
            <div class="input-group mb-3">
                <span class="input-group-text">选择教室</span>
                <!-- 教室列表 -->
                <select id="CClassRoom" name="CClassRoom" class="form-select">

                </select>
            </div>

            <!-- 选择日期 -->
            <div class="input-group mb-3">
                <span class="input-group-text">日期</span>
                <input id="CTimeStart" name="CTimeStart" type="date" class="form-control"
                       aria-label="Sizing example input"
                       aria-describedby="inputGroup-sizing-default" value="${updateData.CTimeStart}">
            </div>

            <!-- 选择日期 -->
            <div class="input-group mb-3">
                <span class="input-group-text">日期</span>
                <input id="CTimeEnd" name="CTimeEnd" type="date" class="form-control" aria-label="Sizing example input"
                       aria-describedby="inputGroup-sizing-default" value="${updateData.CTimeEnd}">
            </div>

            <!-- 提交/取消 -->
            <button type="button" class="btn btn-secondary" onclick="updateButton()">提交</button>
            <a type="button" class="btn btn-primary" href="/supervision/findAllCourse?target=Course">取消</a>
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
        var form = $("#updateDateA");
        //将数据
        var formData = form.serialize();

        $.ajax({
            url: "/supervision/updateCourseDate",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findAllCourse?target=Course';
                console.log(response);
            }
        });
    }


    //    查询所有学院
    var CTeacherId = ${updateData.CClassRoom};
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/findAllcTeacherId', // 后端接口地址
            type: 'GET',
            success: function (data) {
                var departmentSelect = $('#CTeacherId');
                departmentSelect.empty(); // 清空下拉框中的现有选项
                $.each(data, function (index, cTeacherId) {
                    var option = $('<option>', {
                        value: cTeacherId.tId,
                        text: cTeacherId.tName
                    });
                    if (CTeacherId == cTeacherId.tId) {
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


    //    查询所有教室
    var CClassRoom = ${updateData.CTeacherId};
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/findAllRoomId', // 后端接口地址
            type: 'GET',
            success: function (data) {
                var departmentSelect = $('#CClassRoom');
                departmentSelect.empty(); // 清空下拉框中的现有选项
                $.each(data, function (index, cClassRoom) {
                    var option = $('<option>', {
                        value: cClassRoom.roomId,
                        text: cClassRoom.classRoom
                    });
                    if (CClassRoom == cClassRoom.roomId) {
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


    <%--    时间校验--%>
    const startDateInput = document.getElementById('CTimeStart');
    const endDateInput = document.getElementById('CTimeEnd');

    startDateInput.addEventListener('change', function () {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);

        if (endDate && startDate > endDate) {
            alert('第一个时间不能比第二个时间晚，请重新选择');
            startDateInput.value = ''; // 清空第一个日期输入框
        }
    });

    endDateInput.addEventListener('change', function () {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);

        if (startDate && endDate < startDate) {
            alert('第二个时间不能比第一个时间早，请重新选择');
            endDateInput.value = ''; // 清空第二个日期输入框
        }
    });


</script>
</body>
</html>