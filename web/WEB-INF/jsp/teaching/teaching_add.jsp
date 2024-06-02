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

    <title>教学计划添加页面</title>

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
            <form action="/supervision/addTeaching" method="post" enctype="multipart/form-data">

                <%--编写人ID--%>
                <c:choose>
                    <c:when test="${userRole eq 3  }">
                        <input type="hidden" name="tUser" value="${uId}">
                    </c:when>
                </c:choose>


                <!-- 教学名称 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">教学名称</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="inputGroup-sizing-default" id="tName" name="tName">
                </div>

                <!-- 教学预期 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="ts">教学预期</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="ts" id="tExpect" name="tExpect">
                </div>

                <!-- 教学内容 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">教学内容</span>
                    <textarea class="form-control" aria-label="With textarea" style="height: 200px" id="tContent"
                              name="tContent"></textarea>
                </div>


                <!-- 选择文件 -->
                <div class="input-group  mb-3">
                    <span class="input-group-text">教学文件</span>
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
                <a type="button" class="btn btn-primary" href="/supervision/findAllTeaching?target=Teaching">取消</a>
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


    // 提交按钮事件
    $('#add-button').click(function (event) {
        // 阻止表单默认提交行为
        event.preventDefault();

        // 获取教学名称、教学预期、教学内容和文件的值
        var tName = $('#tName').val().trim();
        var tExpect = $('#tExpect').val().trim();
        var tContent = $('#tContent').val().trim();
        var file = $('#file').val();

        // 验证教学名称、教学预期、教学内容和文件是否为空
        if (tName === '' || tExpect === '' || tContent === '' || file === '') {
            alert('请填写所有必填字段！');
            return;
        }

        // 如果所有必填字段都不为空，提交表单
        $('form').submit();
    });


</script>
</body>

</html>