<%--
  User: LIJIAN
  Date: 2024/1/16
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程列表</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <%--    通用的样式--%>
    <link rel="stylesheet" type="text/css" href="/static/css/currency.css">
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
        <div class="col-10  rounded-div">
            <jsp:include page="../../jsp/breadcrumb.jsp"/>
            <div class="d-grid gap d-md-flex  my-1">
                <c:choose>
                    <c:when test="${userRole eq 1 }">
                        <div class="col-auto">
                                <%--                            添加按钮--%>
                            <button type="button" class="btn btn-danger btn-sm"
                                    data-bs-toggle="modal" data-bs-target="#addModal" id="buttonDivButton"
                                    style="display: none">添加
                            </button>
                        </div>
                        <%--                            批量删除--%>
                        <div class="col-auto">
                            <button type="button" class="btn btn-danger btn-sm mx-3" id="buttonDiv"
                                    style="display: none">
                                批量删除
                            </button>
                        </div>
                    </c:when>
                </c:choose>
                <%--                搜索框--%>
                <div class="container">
                    <div class="row justify-content-end">
                        <%--                搜索框--%>
                        <div class="col-auto">
                            <input type="text" id="searchInput" class="form-control" placeholder="Search...">

                        </div>
                        <%--                        重置按钮--%>
                        <div class="col-auto">
                            <button id="resetButton" class="btn btn-secondary">重置</button>
                        </div>
                    </div>
                </div>
            </div>


            <div>
                <table class="table table-hover">
                    <thead class="table-light">
                    <tr>
                        <th><input class="form-check-input" type="checkbox" id="selectAllCheckbox"></th>
                        <!-- 这里是选择框的列头 -->
                        <th>id</th>
                        <th>课程名称</th>
                        <th>课程学分</th>
                        <th>授课教师</th>
                        <th>开始时间</th>
                        <th>结束时间</th>
                        <th>教室地点</th>
                        <th>
                            操作
                        </th>

                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="findAllCourseList" items="${findAllCourseList}" varStatus="pages">
                        <tr>

                            <td>
                                <input class="form-check-input" type="checkbox" name="selectedUsers"
                                       value="${findAllCourseList.CId}">
                            </td>
                            <td>${pages.index + 1}</td>
                            <td class="text-muted">
                                    ${findAllCourseList.CName}
                            </td>
                            <td class="text-muted">
                                    <%--  class为"text-truncate"的div元素，它的最大宽度被设置为50像素
                                    使用了"text-truncate"类来截断文本，使其在指定的最大宽度内显示，并以省略号来表示被截断的部分
                                    --%>
                                <div class="text-truncate" style="max-width: 80px;">
                                        ${findAllCourseList.CCredit}
                                </div>

                            </td>
                            <td class="text-muted">
                                <div class="text-truncate" style="max-width: 80px;">
                                        ${findAllCourseList.TUser.TName}
                                </div>
                            </td>
                            <td class="text-muted">
                                    ${findAllCourseList.CTimeStart}
                            </td>
                            <td class="text-muted">
                                    ${findAllCourseList.CTimeEnd}
                            </td>

                            <td class="text-muted">
                                    ${findAllCourseList.CRoom.classRoom}
                            </td>
                            <td>

                                    <%--判断角色按钮<%int number = 1;
                                    // 假设这里是获取的数值if (number == 1)
                                    { %><div>
                                    <p>The number is 1.</p> </div>
                                    <%}  %> --%>
                                <div class="dropdown" onmouseleave="hideDropdown('dropdown${pages.index}')">
                                    <button class="btn btn-outline-primary dropbtn  "
                                            onmouseover="toggleDropdown('btn${pages.index}', 'dropdown${pages.index}')"

                                    >操作
                                    </button>
                                    <div class="dropdown-content" id="dropdown${pages.index}">
                                        <c:choose>
                                            <c:when test="${userRole eq 1 }">
                                                <a id="Course${pages.index}" class="content"
                                                   href="/supervision/updateCourse/${findAllCourseList.CId}">修改</a>
                                                <a data-bs-toggle="modal" data-bs-target="#exampleModal"
                                                   id="CourseD${pages.index}" class="content"
                                                   onclick="deleteId(${findAllCourseList.CId})">删除</a>
                                            </c:when>
                                        </c:choose>

                                        <c:choose>
                                            <c:when test="${userRole eq 2 or userRole eq 3 or userRole eq 4}">
                                                <c:choose>
                                                    <%--                                                如果是false 查看评价--%>
                                                    <c:when test="${courseEvaluationMap[findAllCourseList.CId] == true}">
                                                        <a href="/supervision/updateCourseEvaluateById/${findAllCourseList.CId}/${uId}"
                                                           id="Evaluate${pages.index}" class="content">查看评价</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/supervision/updateCourseEvaluateById/${findAllCourseList.CId}/${uId}"
                                                           id="Evaluate${pages.index}" class="content">课程评价</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                        </c:choose>


                                        <c:choose>
                                            <c:when test="${userRole eq 2 }">
                                                <c:choose>
                                                    <%--                                                如果是true 查看评价--%>
                                                    <c:when test="${courseListenMap[findAllCourseList.CId] == true}">
                                                        <a href="/supervision/findCourseListenDate/${findAllCourseList.CId}/${uId}"
                                                           id="Listening${pages.index}" class="content">查看听课</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/supervision/updateCourseListening/${findAllCourseList.CId}/${uId}"
                                                           id="Listening${pages.index}" class="content">听课评价</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                        </c:choose>


                                        <c:choose>
                                            <c:when test="${userRole eq 2 }">
                                                <a
                                                        id="Patrol${pages.index}" class="content"
                                                        href="/supervision/updateCourseTourClass/${findAllCourseList.CId}"
                                                >巡课</a>
                                            </c:when>
                                        </c:choose>


                                        <c:choose>
                                            <c:when test="${userRole eq 2 or  userRole eq 3}">
                                                <c:choose>
                                                    <c:when test="${coursePatrolMap[findAllCourseList.CId] == true}">
                                                        <a
                                                                id="Detailed${pages.index}" class="content"
                                                                href="/supervision/findCourseTourList/${findAllCourseList.CId}"
                                                        >详细查看</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/supervision/findCourseTourList/${findAllCourseList.CId}"
                                                           id="Detailed${pages.index}" class="content zlisten-link"
                                                        >暂时数据</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                        </c:choose>


                                        <c:choose>
                                            <c:when test="${userRole eq 4 }">
                                                <a
                                                        id="Message${pages.index}" class="content"
                                                        href="/supervision/AddMessage/${findAllCourseList.CId}"
                                                >留言</a>
                                            </c:when>
                                        </c:choose>

                                        <c:choose>
                                            <c:when test="${userRole eq 2 or   userRole eq 3   or userRole eq 1}">
                                                <c:choose>
                                                    <%--                                                如果是true 查看评价--%>
                                                    <c:when test="${courseVCourseMap[findAllCourseList.CId] == true}">
                                                        <a href="/supervision/VCourse/${findAllCourseList.CId}"
                                                           id="visualization${pages.index}" class="content"
                                                        >评价可视化</a>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <a href="/supervision/VCourse/${findAllCourseList.CId}"
                                                           id="visualization${pages.index}" class="content"
                                                        >暂时数据</a>
                                                    </c:otherwise>


                                                </c:choose>
                                            </c:when>
                                        </c:choose>


                                        <c:choose>
                                            <c:when test="${userRole eq 2 or   userRole eq 3   or userRole eq 1}">
                                                <c:choose>
                                                    <c:when test="${courseListenTMap[findAllCourseList.CId] == true}">
                                                        <a href="/supervision/VCourseListen/${findAllCourseList.CId}"
                                                           id="zlisten${pages.index}" class="content"
                                                        >听课评价可视化</a>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <a href="/supervision/VCourseListen/${findAllCourseList.CId}"
                                                           id="zlisten${pages.index}" class="content  zlisten-link"
                                                        >暂时数据</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                        </c:choose>


                                    </div>
                                </div>

                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- 分页标签 -->
                <nav class="Page navigation  example    d-flex  justify-content-center   ">
                    <ul class="pagination">
                        <li class="page-item"
                            <c:if test="${!page.hasPrevious}">class="disabled"</c:if> >
                            <a href="?page.startIndex=0" class="page-link">
                                <span> 首页 </span>
                            </a>
                        </li>
                        <%--跳到下一页 判断是否有下一页 则不可点击后跳 class="disabled" --%>
                        <li class="page-item${!page.hasPrevious ? ' disabled' : ''}">
                            <a href="?page.startIndex=${page.startIndex-page.pageSize}" class="page-link">
                                <span> 上一页 </span>
                            </a>
                        </li>

                        <c:forEach begin="0" end="${page.totalPage-1}" varStatus="pages">
                            <c:if test="${pages.count*page.pageSize-page.startIndex<=15 && pages.count*page.pageSize-page.startIndex>=-5}">
                                <li class="page-item"
                                    <c:if test="${pages.index*page.pageSize==page.startIndex}">class="disabled" </c:if>>
                                    <a href="?page.startIndex=${pages.index*page.pageSize}" class="page-link"
                                       <c:if test="${pages.index*page.pageSize==page.startIndex}">class="current"</c:if>
                                    >${pages.count}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                        <%--跳到下一页 判断是否有下一页 则不可点击后跳 class="disabled" --%>
                        <li class="page-item${!page.hasNext ? ' disabled' : ''}">
                            <a href="?page.startIndex=${page.startIndex+page.pageSize}" class="page-link">
                                <span> 下一页 </span>
                            </a>
                        </li>

                        <li class="page-item" <c:if test="${!page.hasNext}">class="disabled"</c:if>>
                            <a href="?page.startIndex=${page.last}" class="page-link">
                                <span> 尾页 </span>
                            </a>
                        </li>
                    </ul>
                </nav>

            </div>

        </div>


    </div>
</div>
<!-- 删除弹出的框 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">是否确认删除</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                是否确认删除
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="delete-button">确认</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>


<%--添加的框--%>
<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%--                添加用户 用form表单进行提交--%>
                <form id="addUser">
                    <div class="form">
                        <label for="cName">课程名</label>
                        <input type="text" class="form-control" id="cName" placeholder="请输入课程名"
                               name="cName">
                    </div>
                    <div class="form">
                        <label for="cCredit">学分</label>
                        <input type="text" class="form-control" id="cCredit" placeholder="请输入学分"
                               name="cCredit"
                        >
                    </div>


                    <div class="form">
                        <label for="cTeacherId">授课教师</label>
                        <select class="form-control" id="cTeacherId" name="cTeacherId">
                            <!-- 下拉框将由 JavaScript 动态生成 -->
                        </select>
                    </div>


                    <!-- 选择日期 -->
                    <div class="form">
                        <span class="input-group-text" id="s">开始时间</span>
                        <input id="cTimeStart" name="cTimeStart" type="date" class="form-control"
                               aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default">
                    </div>

                    <!-- 选择日期 -->
                    <div class="form">
                        <span class="input-group-text" id="e">结束时间</span>
                        <input id="cTimeEnd" name="cTimeEnd" type="date" class="form-control"
                               aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default">
                    </div>


                    <%--                    获取数据库权限表--%>
                    <div class="form">
                        <label for="cClassRoom">教室地址</label>
                        <select class="form-control" id="cClassRoom" name="cClassRoom">
                            <!-- 下拉框将由 JavaScript 动态生成 -->
                        </select>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <%--                提交按钮事件 addUserButton --%>
                <button type="button" class="btn btn-secondary" onclick="addButton()">确认</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<%--批量删除的模态框--%>
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalLabel">确认删除</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                确定要删除所选用户吗？
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="confirmDeleteButton">删除</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">取消</button>
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
<script src="/static/js/overallSituation.js"></script>
<script>


    <%--删除按钮 传入需要删除的id--%>

    function deleteId(cId) {
        // 在触发确认按钮后
        document.getElementById("delete-button").addEventListener("click", function () {
            //进行ajax
            $.ajax({
                url: '/supervision/deleteCourse/' + cId,
                success: function (response) {
                    // 删除成功后的处理逻辑
                    console.log('删除成功');
                    //跳转业务
                    window.location.href = '/supervision/findAllCourse?target=Course';
                },
                error: function (error) {
                    // 删除失败后的处理逻辑
                    console.log('删除失败', error);
                }
            });

        });
    }

    //    提交添加的新的按钮
    function addButton() {
        var form = $("#addUser");
        //将数据
        var formData = form.serialize();

        $.ajax({
            url: "/supervision/addCourse/",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findAllCourse?target=Course';
                console.log(response);
            }
        });
    }

    // 在模态框关闭时清除表单数据
    $('#addModal').on('hidden.bs.modal', function () {
        // 清空表单数据
        $('#addUser')[0].reset();
    });

    // 点击下拉菜单按钮显示或隐藏下拉菜单内容
    function toggleDropdown(btnId, dropdownId) {
        var dropdownContent = document.getElementById(dropdownId);

        // 切换下拉菜单内容的显示状态
        if (dropdownContent.style.display === "block") {
            dropdownContent.style.display = "none";
        } else {
            // 隐藏所有其他下拉菜单内容
            var allDropdowns = document.getElementsByClassName("dropdown-content");
            for (var i = 0; i < allDropdowns.length; i++) {
                allDropdowns[i].style.display = "none";
            }

            dropdownContent.style.display = "block";
        }
    }

    // 鼠标移开下拉菜单按钮时隐藏下拉菜单内容
    function hideDropdown(dropdownId) {
        var dropdownContent = document.getElementById(dropdownId);
        dropdownContent.style.display = "none";
    }


    //    查询所有教师
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/findAllcTeacherId', // 后端接口地址
            type: 'GET',
            success: function (data) {
                var departmentSelect = $('#cTeacherId');
                $.each(data, function (index, cTeacherId) {
                    departmentSelect.append($('<option>', {
                        value: cTeacherId.tId,
                        text: cTeacherId.tName
                    }));
                });
            },
            error: function () {
                alert('Failed to fetch department data.');
            }
        });
    });


    //    查询所有教室
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/findAllRoomId', // 后端接口地址
            type: 'GET',
            success: function (data) {
                var departmentSelect = $('#cClassRoom');
                $.each(data, function (index, cClassRoom) {
                    departmentSelect.append($('<option>', {
                        value: cClassRoom.roomId,
                        text: cClassRoom.classRoom
                    }));
                });
            },
            error: function () {
                alert('Failed to fetch department data.');
            }
        });
    });


</script>
<%--隐藏操作 不相干操作--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 获取 URL 参数
        const urlParams = new URLSearchParams(window.location.search);
        // 获取需要显示的内容的 ID 跳转
        const target = urlParams.get('target');
        // 获取需要显示的内容的 ID
        const targets = urlParams.get('evaluate');
        // 获取需要显示的内容的 ID
        const targetv = urlParams.get('visualization');


        if (target) {
            // 显示对应的内容
            var targetContent_a = document.querySelectorAll('[id^=' + target + ']');

            // 隐藏所有内容
            var contents_a = document.querySelectorAll(".content");
            contents_a.forEach(function (content) {
                content.style.display = "none";
            });
            // 显示目标内容
            // document.querySelectorAll() 返回的是一个 NodeList，而不是单个元素。因此，你需要遍历 NodeList 并为每个元素设置样式
            targetContent_a.forEach(function (element) {
                element.style.display = "block";
            });

            if (${userRole eq 1 }) {
                document.getElementById("buttonDiv").style.display = "block";
                document.getElementById("buttonDivButton").style.display = "block";
            }
        } else if (targets) {
            // 显示对应的内容
            var targetContent_a = document.querySelectorAll('[id^=' + targets + ']');

            // 隐藏所有内容
            var contents_a = document.querySelectorAll(".content");
            contents_a.forEach(function (content) {
                content.style.display = "none";
            });
            // 显示目标内容
            // document.querySelectorAll() 返回的是一个 NodeList，而不是单个元素。因此，你需要遍历 NodeList 并为每个元素设置样式
            targetContent_a.forEach(function (element) {
                element.style.display = "block";
            });
        } else if (targetv) {
            // 显示对应的内容
            var targetContent_a = document.querySelectorAll('[id^=' + targetv + ']');

            // 隐藏所有内容
            var contents_a = document.querySelectorAll(".content");
            contents_a.forEach(function (content) {
                content.style.display = "none";
            });
            // 显示目标内容
            // document.querySelectorAll() 返回的是一个 NodeList，而不是单个元素。因此，你需要遍历 NodeList 并为每个元素设置样式
            targetContent_a.forEach(function (element) {
                element.style.display = "block";
            });
        }

    });

    //搜索框 检索 和重置
    document.getElementById('searchInput').addEventListener('input', function () {
        const searchValue = this.value.trim().toLowerCase();
        const rows = document.querySelectorAll('tbody tr');
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            let found = false;
            cells.forEach(cell => {
                if (cell.textContent.trim().toLowerCase().includes(searchValue)) {
                    found = true;
                }
            });
            if (found) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    document.getElementById('resetButton').addEventListener('click', function () {
        document.getElementById('searchInput').value = ''; // 清除搜索框内容

        const rows = document.querySelectorAll('tbody tr');
        rows.forEach(row => {
            row.style.display = ''; // 显示所有行
        });
    });


    //批量删除
    document.getElementById("buttonDiv").addEventListener("click", function () {
        var selectedUsers = document.querySelectorAll('input[name="selectedUsers"]:checked');
        var selectedUserIds = [];
        selectedUsers.forEach(function (user) {
            selectedUserIds.push(user.value);
        });
        // 显示确认对话框
        $('#confirmationModal').modal('show');

        // 确认删除按钮点击事件处理
        document.getElementById("confirmDeleteButton").addEventListener("click", function () {
            //  AJAX 请求
            //转为JSON格式
            var requestData = JSON.stringify(selectedUserIds);
            $.ajax({
                url: "/supervision/deleteCoursebatch/",
                type: "POST",
                // 指定内容类型为JSON
                contentType: "application/json",
                data: requestData,
                success: function (response) {
                    // 请求成功后的处理逻辑
                    window.location.href = '/supervision/findAllCourse?target=Course';
                    console.log(response);
                }
            });
            // 隐藏确认对话框
            $('#confirmationModal').modal('hide');
        });
    });


</script>

<script>

    <%--    时间校验--%>
    const startDateInput = document.getElementById('cTimeStart');
    const endDateInput = document.getElementById('cTimeEnd');

    startDateInput.addEventListener('change', function () {
        setTimeout(function () {
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);

            if (startDate > endDate) {
                alert('第一个时间不能比第二个时间晚，请重新选择');
                startDateInput.value = ''; // 清空第一个日期输入框
            }
        }, 100);
    });

    endDateInput.addEventListener('change', function () {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);

        if (endDate < startDate) {
            alert('第二个时间不能比第一个时间早，请重新选择');
            endDateInput.value = ''; // 清空第二个日期输入框
        }
    });


    // 找到所有具有特定类名的链接元素并添加点击事件监听器
    document.querySelectorAll('.zlisten-link').forEach(function (link) {
        link.addEventListener('click', function (event) {
            event.preventDefault(); // 阻止默认链接行为
            alert("暂时没有数据");
        });
    });

</script>

</body>
</html>
