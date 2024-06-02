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

    <title>督导计划修改页面</title>

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


                <!-- 教学名称 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">督导名称</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" id="supName" name="supName"
                           value="${updateSupervisionDate.supName}">
                </div>


                <!-- 选择日期 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">开始时间</span>
                    <input id="supTimeStart" name="supTimeStart" type="date" class="form-control"
                           aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" value="${updateSupervisionDate.supTimeStart}">
                </div>


                <!-- 选择日期 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">结束时间</span>
                    <input id="supTimeEnd" name="supTimeEnd" type="date" class="form-control"
                           aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" value="${updateSupervisionDate.supTimeEnd}">
                </div>

                <!-- 教学内容 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">督导要求</span>
                    <textarea class="form-control" aria-label="With textarea" style="height: 200px" id="ask"
                              name="ask">${updateSupervisionDate.ask}</textarea>
                </div>

                <!-- 选择文件 -->
                <div class="input-group mb-3">
                    <input type="file" id="file" name="file" style="display: none;" onchange="updateFileName(this)">
                    <button type="button" onclick="document.getElementById('file').click() ">选择文件</button>
                    <input type="text" class="form-control" id="filename"
                           value="${updateSupervisionDate.supervisionFileSava.FName}"
                           disabled>
                    <a type="button" id="buttonToHide" class="btn btn-secondary  trigger-btn"
                       href="/supervision/findFileSupervision?fUid=${updateSupervisionDate.supervisionFileSava.FUid}"
                    >查看文件
                    </a>
                </div>


                <!-- 提交/取消 -->
                <button type="button" class="btn btn-secondary" onclick="updateButton()">提交</button>
                <a type="button" class="btn btn-primary"
                   href="/supervision/findAllSupervision?target=Supervision">取消</a>
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
    <%--文件名的变换--%>

    function updateFileName(input) {
        var fileName = input.files[0].name;
        document.getElementById('filename').value = fileName;

        //更新的名字后 查看文件 按钮不显示
        var buttonToHide = document.querySelector('.trigger-btn');
        if (buttonToHide) {
            buttonToHide.style.display = 'none';
        }
    }

    //时间校验
    const startDateInput = document.getElementById('supTimeStart');
    const endDateInput = document.getElementById('supTimeEnd');

    startDateInput.addEventListener('change', function () {
        setTimeout(function () {
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);

            if (endDate && startDate > endDate) {
                alert('第一个时间不能比第二个时间晚，请重新选择');
                startDateInput.value = ''; // 清空第一个日期输入框
            }
        }, 100);
    });

    endDateInput.addEventListener('change', function () {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);

        if (startDate && endDate < startDate) {
            alert('第二个时间不能比第一个时间早，请重新选择');
            endDateInput.value = ''; // 清空第二个日期输入框
        }
    });


    // 表单验证 是否为空
    function validateForm() {
        var supName = $('#supName').val().trim();
        var supTimeStart = $('#supTimeStart').val().trim();
        var supTimeEnd = $('#supTimeEnd').val().trim();
        var ask = $('#ask').val().trim();
        // 验证督导名称、开始时间、结束时间、督导要求和文件是否为空
        if (supName === '' || supTimeStart === '' || supTimeEnd === '' || ask === '') {
            alert('请填写所有必填字段！');
            return false; // 阻止表单提交
        }

        return true; // 允许表单提交
    }

    // 在提交按钮点击时调用验证函数
    function updateButton() {
        if (validateForm()) {
            var form = $("#updateSupervisionDate");
            var formData = form.serialize();

            $.ajax({
                url: "/supervision/updateSupervision",
                type: "POST",
                data: formData,
                success: function (response) {
                    // 请求成功后的处理逻辑
                    window.location.href = '/supervision/findAllSupervision';
                    console.log(response);
                }
            });
        }
    }


</script>
</body>
</html>