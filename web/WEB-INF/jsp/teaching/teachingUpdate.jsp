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

    <title>教学计划修改页面</title>

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
                           value="${updateTeachingDate.TName}">
                </div>

                <!-- 教学预期 -->
                <div class="input-group mb-3">
                    <span class="input-group-text" id="ts">教学预期</span>
                    <input type="text" class="form-control" aria-label="Sizing example input"
                           aria-describedby="ts" id="TExpect" name="TExpect" value="${updateTeachingDate.TExpect}">
                </div>

                <!-- 教学内容 -->
                <div class="input-group mb-3">
                    <span class="input-group-text">教学内容</span>
                    <%--                <textarea> 元素与 <input> 元素不同，它没有 value 属性来表示默认值。取而代之的是，
                    在 <textarea> 元素的开始标签 <textarea> 和结束标签 </textarea> 之间添加文本内容。在您提供的示例中，
                    应该在 <textarea> 标签的开始和结束之间添加要显示的文本内容，而不是使用 value 属性。--%>
                    <textarea class="form-control" aria-label="With textarea" style="height: 200px" id="TContent"
                              name="TContent">${updateTeachingDate.TContent}</textarea>
                </div>

                <!-- 选择文件 -->
                <div class="input-group mb-3">
                    <input type="file" id="file" name="file" style="display: none;" onchange="updateFileName(this)">
                    <button id="fileButton" type="button" onclick="document.getElementById('file').click() ">选择文件
                    </button>
                    <input type="text" class="form-control" id="filename" value="${updateTeachingDate.fileSava.FName}"
                           disabled>
                    <a type="button" id="buttonToHide" class="btn btn-secondary  trigger-btn"
                       href="/supervision/findFileTeaching?fUid=${updateTeachingDate.fileSava.FUid}"
                    >查看文件
                    </a>
                </div>


                <!-- 提交/取消 -->
                <button type="button" class="btn btn-secondary" onclick="updateButton()">提交</button>
                <a type="button" class="btn btn-primary" href="/supervision/findAllTeaching?target=Teaching">返回</a>
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
    var fileSelected = false; // 用于标记用户是否选择了文件

    function updateFileName(input) {
        var fileName = input.files[0].name;
        document.getElementById('filename').value = fileName;

        // 更新的名字后，查看文件按钮不显示
        var buttonToHide = document.querySelector('.trigger-btn');
        if (buttonToHide) {
            buttonToHide.style.display = 'none';
        }

        // 标记用户已选择文件
        fileSelected = true;
    }

    function updateButton() {
        var form = document.getElementById("updateTeachingDate");
        var formData = new FormData(form);

        var tName = $('#TName').val().trim();
        var tExpect = $('#TExpect').val().trim();
        var tContent = $('#TContent').val().trim();

        // 验证教学名称、教学预期、教学内容和文件是否为空
        if (tName === '' || tExpect === '' || tContent === '') {
            alert('请填写所有必填字段！');
            return;
        }

        // 如果用户选择了文件，则提交带有文件的表单数据
        if (fileSelected) {
            $.ajax({
                url: "/supervision/updateTeaching",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    // 请求成功后的处理逻辑
                    window.location.href = '/supervision/findAllTeaching?target=Teaching';
                    console.log(response);
                }
            });
        } else {

            // 如果用户没有选择文件，则提交不带文件的表单数据
            $.ajax({
                url: "/supervision/updateTeaching",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    // 请求成功后的处理逻辑
                    window.location.href = '/supervision/findAllTeaching?target=Teaching';
                    console.log(response);
                }
            });
        }
    }


    //获取详细查看 的值
    // 设置表单元素为只读
    // 隐藏选择文件按钮
    // 隐藏提交按钮
    // 获取 URL 中的参数值
    function getParameterByName(name, url) {
        //未提供 url 参数，则默认为当前页面的 URL。
        if (!url) url = window.location.href;
        //创建了一个正则表达式，用于匹配 URL 中指定名称的参数。
        name = name.replace(/[\[\]]/g, "\\$&");
        //使用正则表达式来在 URL 中查找匹配的参数，并将结果存储在 results 中。
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        //没有找到匹配的参数，则返回 null。
        if (!results) return null;
        //找到了参数但没有值，则返回一个空字符串。
        if (!results[2]) return '';
        // 返回解码后的参数值，通过 decodeURIComponent 函数将 URL 编码的特殊字符解码，并将 + 替换为空格。
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    // 在页面加载时执行
    window.onload = function () {
        var teachingParam = getParameterByName('teaching');
        if (teachingParam === 'check') {
            // 设置表单元素为只读
            document.getElementById('TName').readOnly = true;
            document.getElementById('TExpect').readOnly = true;
            document.getElementById('TContent').readOnly = true;
            // 隐藏选择文件按钮
            document.getElementById('fileButton').style.display = 'none';
            // 隐藏提交按钮
            document.querySelector('button[type="button"]').style.display = 'none';
        }
    };


</script>
</body>
</html>