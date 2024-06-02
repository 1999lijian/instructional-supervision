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

    <title>添加课程</title>

    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">

    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <link rel="stylesheet" href="/static/lib/select2-4.0.13/select2.css">
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


            <form action="/supervision/addClassesSubmit" method="post">

                <input type="hidden" name="cIIdcc" value="${classesDate.CIId}">
                <div class="input-group mb-3">
                    <span class="input-group-text">专业班级名称  </span>
                    <input type="text" class="form-control" value="${classesDate.CIName}">
                </div>
                <!-- 使用 Select2 实现带搜索和多选功能的下拉选择框 -->
                <div class="mb-3">
                    <label for="courseOptions" class="form-label">课程选项</label>
                    <select class="form-select" id="courseOptions" name="sIdcc" multiple>

                    </select>

                </div>


                <!-- 提交/取消 -->
                <button type="submit" class="btn btn-secondary" id="add-button">提交</button>
                <a type="button" class="btn btn-primary" href="/supervision/findAllClasses">取消</a>
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
<%-- 导入Select2  --%>
<script src="/static/lib/select2-4.0.13/select2.full.js"></script>
<script>


    $(document).ready(function () {
        var departmentSelect = $('#courseOptions');

        // 查询所有课程名称
        $.ajax({
            url: '/supervision/findAllCourseName',
            type: 'GET',
            success: function (data) {
                var selectedValues = [];
                <c:forEach var="classesByClassStudentCourse" items="${classesByClassStudentCourse}">
                selectedValues.push('${classesByClassStudentCourse.SIdcc}');
                </c:forEach>
                console.log(selectedValues);

                // 添加课程选项
                $.each(data, function (index, courseOption) {
                    var option = new Option(courseOption.cName, courseOption.cId);
                    departmentSelect.append(option);
                });

                // 初始化select2并设置已选择的值
                departmentSelect.select2({
                    placeholder: '请选择课程选项',
                    allowClear: true
                });

                selectedValues.forEach(function (value) {
                    var currentValue = departmentSelect.val() || []; // 获取当前选定的值
                    currentValue.push(value); // 将当前值添加到数组中
                    departmentSelect.val(currentValue).trigger('change'); // 设置选定的值并触发 change 事件
                });

            },
        });
    });


</script>
</body>
</html>