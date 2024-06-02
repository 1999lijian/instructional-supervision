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

    <title>巡课页面</title>

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
            <form action="/supervision/AddCourseTourClass" method="post" enctype="multipart/form-data">
                <input type="hidden" name="tourClassCourse" value="${Data.CId}">
                <h1 class="text-center">课程名称：${Data.CName}</h1>


                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">课堂纪律</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" id="tourClassDiscipline"
                           name="tourClassDiscipline">
                </div>


                <!-- 内容 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">巡查内容</span>
                    <textarea class="form-control" aria-label="With textarea" style="height: 200px"
                              id="tourClassContent"
                              name="tourClassContent"></textarea>
                </div>


                <!-- 选择日期 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="s">时间</span>
                    <input id="tourClassTime" name="tourClassTime" type="datetime-local" class="form-control"
                           aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default">
                </div>

                <!-- 照片上传 -->
                <div class="input-group  mb-3">
                    <span class="input-group-text">巡课照片</span>
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
                <a type="button" class="btn btn-primary" href="/supervision/findAllCourse?evaluate=Patrol">返回</a>
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
        allowedFileExtensions: ['JPEG', 'JPG', 'PNG', 'RAW'],
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


    //    自动获取时间
    // 获取当前日期时间
    const now = new Date();
    // 获取小时和分钟
    const hours = now.getHours().toString().padStart(2, '0'); // 保证两位数输出
    const minutes = now.getMinutes().toString().padStart(2, '0'); // 保证两位数输出
    // 格式化日期时间为YYYY-MM-DDTHH:MM
    const formattedDateTime = now.toISOString().slice(0, 10) + 'T' + hours + ':' + minutes;
    // 将格式化后的日期时间填充到输入字段中
    document.getElementById("tourClassTime").value = formattedDateTime;


</script>

</body>
</html>