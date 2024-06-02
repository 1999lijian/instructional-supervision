<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生管理列表</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/index.css">
    <%--    通用的样式--%>
    <link rel="stylesheet" type="text/css" href="/static/css/currency.css">
    <%--    提示框的样式--%>
    <link rel="stylesheet" type="text/css" href="/static/css/PromptStyle.css">
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
        <div class="col-10  rounded-div">
            <jsp:include page="../../../jsp/breadcrumb.jsp"/>
            <div>
                <div class="d-grid gap d-md-flex  my-1">
                    <div class="col-auto">
                        <%--                            添加按钮--%>
                        <button type="button" class="btn btn-danger btn-sm"
                                data-bs-toggle="modal" data-bs-target="#addModal">添加
                        </button>
                    </div>
                    <%--                            批量删除--%>
                    <div class="col-auto">
                        <button type="button" class="btn btn-danger btn-sm mx-3" id="deleteButton">批量删除</button>
                    </div>
                    <%--批量导入 表格--%>
                    <div class="col-auto">
                        <form action="/supervision/batchImportSUser" method="post" enctype="multipart/form-data">
                            <label for="fileInput" class="btn btn-danger btn-sm mx-2">
                                <span id="fileNameLabel">批量导入</span>
                                <input id="fileInput" name="file" type="file" style="display: none;" accept=".xls,.xlsx"
                                       onchange="updateFileName(this)">
                            </label>
                            <button id="submitButton" type="submit" class="btn btn-primary btn-sm"
                                    style="display: none;">提交导入
                            </button>
                            <button id="cancelButton" type="button" class="btn btn-secondary btn-sm"
                                    style="display: none;" onclick="cancelUpload()">取消
                            </button>
                        </form>
                    </div>


                    <%--                搜索框--%>
                    <div class="container">
                        <div class="row justify-content-end">
                            <div class="col-auto">
                                <input type="text" id="searchInput" class="form-control" placeholder="Search...">
                            </div>
                            <%--                            重置按钮--%>
                            <div class="col-auto">
                                <button id="resetButton" class="btn btn-secondary">重置</button>
                            </div>
                        </div>
                    </div>
                </div>
                <table class="table ">
                    <thead class="table-light">
                    <tr>
                        <th><input class="form-check-input" type="checkbox" id="selectAllCheckbox"></th>
                        <!-- 这里是选择框的列头 -->
                        <th>id</th>
                        <th>登录密码</th>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>所属学院</th>
                        <th>联系电话</th>
                        <th>邮箱</th>
                        <th>QQ</th>
                        <th>备注</th>
                        <th>
                            操作
                        </th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="finAllSUser" items="${finAllSUser}" varStatus="pages">
                        <tr>
                            <td>
                                <input class="form-check-input" type="checkbox" name="selectedUsers"
                                       value="${finAllSUser.SId}">
                            </td>

                            <td>${pages.index + 1}</td>
                            <td class="text-muted">
                                    ${finAllSUser.UUser.UPassword}
                            </td>
                            <td class="text-muted">
                                    ${finAllSUser.SNo}
                            </td>
                            <td class="text-muted">
                                    ${finAllSUser.SName}
                            </td>

                            <td class="text-muted">
                                    ${finAllSUser.college.collegeName}
                            </td>

                            <td class="text-muted">
                                    ${finAllSUser.SPhone}
                            </td>
                            <td class="text-muted">
                                    ${finAllSUser.SEmail}
                            </td>
                            <td class="text-muted">
                                    ${finAllSUser.SQQ}
                            </td>
                            <td class="text-muted">
                                    ${finAllSUser.SNotes}
                            </td>
                            <td>
                                <div class="dropdown" onmouseleave="hideDropdown('dropdown${pages.index}')">
                                    <button class="btn btn-outline-primary dropbtn"
                                            onmouseover="toggleDropdown('btn${pages.index}', 'dropdown${pages.index}')">
                                        操作
                                    </button>
                                    <div class="dropdown-content" id="dropdown${pages.index}">
                                        <a href="/supervision/updateSUserId/${finAllSUser.SId}">修改</a>
                                        <a data-bs-toggle="modal" data-bs-target="#exampleModal"
                                           onclick="deleteUserId(${finAllSUser.SId})">删除</a>
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
                        <label for="uName">用户名</label>
                        <input type="text" class="form-control" id="uName" placeholder="请输入登录用户名"
                               name="uName">
                        <span id="uNameError" class="error"></span>
                    </div>
                    <div class="form">
                        <label for="uPassword">密码</label>
                        <input type="password" class="form-control" id="uPassword" placeholder="请输入密码"
                               name="uPassword"
                        >
                        <span id="uPasswordError" class="error"></span>
                    </div>

                    <%--                    随机分配一个学号  年+数字--%>
                    <div class="form">
                        <label for="sNo">学号</label>
                        <input type="text" class="form-control" id="sNo" placeholder="请输入学号"
                               name="sNo">
                    </div>

                    <div class="form">
                        <label for="sName">姓名</label>
                        <input type="text" class="form-control" id="sName" placeholder="请输入姓名"
                               name="sName">
                    </div>
                    <div class="form">
                        <label for="sSex">性别</label>
                        <select class="form-control" id="sSex" name="sSex">
                            <option value="0">男</option>
                            <option value="1">女</option>
                        </select>
                    </div>


                    <!-- 选择日期 -->
                    <div class="form">
                        <span class="input-group-text" id="s">出生年月</span>
                        <input id="sDate" name="sDate" type="date" class="form-control"
                               aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default">
                    </div>


                    <%--                    获取数据库权限表--%>


                    <div class="form">
                        <label for="sCollegeNo">所属学院</label>
                        <select class="form-control" id="sCollegeNo" name="sCollegeNo">
                            <!-- 下拉框将由 JavaScript 动态生成 -->
                        </select>
                    </div>

                    <div class="form">
                        <label for="ClassId">所属班级</label>
                        <select class="form-control" id="ClassId" name="ClassId">
                            <!-- 下拉框将由 JavaScript 动态生成 -->
                        </select>
                    </div>


                    <div class="form">
                        <label for="sPhone">联系电话</label>
                        <input type="text" class="form-control" id="sPhone" placeholder="请输入联系电话"
                               name="sPhone">
                        <span id="aPhoneError" class="error"></span>
                    </div>

                    <div class="form">
                        <label for="sEmail">邮箱</label>
                        <input type="text" class="form-control" id="sEmail" placeholder="请输入邮箱"
                               name="sEmail">
                        <span id="aEmailError" class="error"></span>
                    </div>
                    <div class="form">
                        <label for="sQQ">QQ</label>
                        <input type="text" class="form-control" id="sQQ" placeholder="请输入QQ"
                               name="sQQ">
                    </div>

                    <div class="form">
                        <label for="sNotes">备注</label>
                        <input type="text" class="form-control" id="sNotes" placeholder="请输入备注"
                               name="sNotes">
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
                <button type="button" class="btn btn-primary" id="confirmDeleteButton">删除</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>

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
<script src="/static/js/SUser.js"></script>


<script>
    <%--删除按钮 传入需要删除的id--%>

    function deleteUserId(sId) {
        // 在触发确认按钮后
        document.getElementById("delete-button").addEventListener("click", function () {
            //进行ajax
            $.ajax({
                url: '/supervision/deleteSUserId/' + sId,
                success: function (response) {
                    // 删除成功后的处理逻辑
                    console.log('删除成功');
                    //跳转业务
                    window.location.href = '/supervision/findAllSUser';
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
            url: "/supervision/addSUser/",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findAllSUser';
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


    //查询所有学院提供选项
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/findAllCollege', // 后端接口地址
            type: 'GET',
            success: function (data) {
                var departmentSelect = $('#sCollegeNo');
                $.each(data, function (index, college) {
                    departmentSelect.append($('<option>', {
                        value: college.collegeId,
                        text: college.collegeName
                    }));
                });
            },
            error: function () {
                alert('Failed to fetch department data.');
            }
        });
    });


    //查询所有班级提供选项
    $(document).ready(function () {
        $.ajax({
            url: '/supervision/findAllClass', // 后端接口地址
            type: 'GET',
            success: function (data) {
                var departmentSelect = $('#ClassId');
                $.each(data, function (index, ClassId) {
                    departmentSelect.append($('<option>', {
                        value: ClassId.cIId,
                        text: ClassId.cIName
                    }));
                });
            },
            error: function () {
                alert('Failed to fetch department data.');
            }
        });
    });


    //搜索框 检索
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


    // 获取文件名称  和 选择文件后再显示提交按钮 或取消
    function updateFileName(input) {
        var fileName = input.files[0].name;
        document.getElementById("fileNameLabel").innerText = fileName;
        document.getElementById("submitButton").style.display = "inline"; // 显示提交按钮
        document.getElementById("cancelButton").style.display = "inline"; // 显示取消按钮
    }

    function cancelUpload() {
        document.getElementById("fileInput").value = ""; // 清空文件输入框
        document.getElementById("fileNameLabel").innerText = "批量导入用户"; // 重置文件名显示
        document.getElementById("submitButton").style.display = "none"; // 隐藏提交按钮
        document.getElementById("cancelButton").style.display = "none"; // 隐藏取消按钮
    }

    //批量删除
    document.getElementById("deleteButton").addEventListener("click", function () {
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
                url: "/supervision/deleteSUserbatch/",
                type: "POST",
                // 指定内容类型为JSON
                contentType: "application/json",
                data: requestData,
                success: function (response) {
                    // 请求成功后的处理逻辑
                    window.location.href = '/supervision/findAllSUser';
                    console.log(response);
                }
            });
            // 隐藏确认对话框
            $('#confirmationModal').modal('hide');
        });
    });
</script>

</body>
</html>