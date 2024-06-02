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

    <title>督导计划添加页面</title>

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
            <form action="/supervision/addSupervision" method="post" enctype="multipart/form-data">

                <!-- 教学名称 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">督导名称</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" id="supName" name="supName">
                </div>

                <!-- 选择日期 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="s">开始时间</span>
                    <input id="supTimeStart" name="supTimeStart" type="date" class="form-control"
                           aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default">
                </div>
                <!-- 选择日期 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="a">结束时间</span>
                    <input id="supTimeEnd" name="supTimeEnd" type="date" class="form-control"
                           aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default">
                </div>


                <!-- 教学内容 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">要求</span>
                    <textarea class="form-control" aria-label="With textarea" style="height: 200px" id="ask"
                              name="ask"></textarea>
                </div>


                <!-- 选择文件 -->
                <div class="input-group  mb-3">
                    <span class="input-group-text">督导文件</span>
                    <div class="form-control ">
                        <input name="fileUrl" class="form-control" type="hidden" th:field="*{fileUrl}">
                        <input name="host" class="form-control" type="hidden">
                        <div class="file-loading">
                            <input class="fileUpload" type="file" id="file" name="file">
                        </div>
                    </div>
                </div>

                <!-- 提交/取消 -->
                <button type="submit" class="btn btn-secondary" id="add-button">提交</button>

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

    const fileUploadOption = {
        theme: 'explorer-fas',
        language: 'zh',
        allowedFileExtensions: ['doc', 'docx', 'ppt', 'pptx', 'pdf'],
        dropZoneEnabled: true,

        autoReplace: false,
        overwriteInitial: true,
        layoutTemplates: {
            actionUpload: '',//去除上传预览缩略图中的上传图片
            //actionZoom:'',   //去除上传预览缩略图中的查看详情预览的缩略图标
            //actionDownload:'', //去除上传预览缩略图中的下载图标
            actionDelete: '', //去除上传预览的缩略图中的删除图标
        },
        showUploadedThumbs: false,
        showUpload: false,
        fileDropZoneTitle: 'xxx',
        // previewFileType: ['image'],
        initialPreviewAsData: true, // 默认为数据
        initialPreviewFileType: 'image', // 默认为`image`，在下面的配置中可以覆盖
        preferIconicPreview: true, // 这将强制缩略图按照以下文件扩展名的图标显示


    }

    $(".fileUpload").fileinput(fileUploadOption);


    // 表单验证 是否为空
    function validateForm() {
        var supName = $('#supName').val().trim();
        var supTimeStart = $('#supTimeStart').val().trim();
        var supTimeEnd = $('#supTimeEnd').val().trim();
        var ask = $('#ask').val().trim();
        var fileName = $('#file').val().trim();

        // 验证督导名称、开始时间、结束时间、要求和文件是否为空
        if (supName === '' || supTimeStart === '' || supTimeEnd === '' || ask === '' || fileName === '') {
            alert('请填写所有必填字段！');
            return false; // 阻止表单提交
        }

        return true; // 允许表单提交
    }

    // 在提交按钮点击时调用验证函数
    $('#add-button').on('click', function () {
        return validateForm();
    });


</script>
<%--时间校验--%>
<script>
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
</script>
</body>
</html>