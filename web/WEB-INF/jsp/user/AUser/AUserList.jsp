<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员管理列表</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" type="text/css" href="/static/css/index.css">
    <%--    通用的样式--%>
    <link rel="stylesheet" type="text/css" href="/static/css/currency.css">
    <%--    该页面的设置 样式--%>
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

        <div class="col-10 rounded-div">
            <jsp:include page="../../../jsp/breadcrumb.jsp"/>
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
                <%--table-hover ： 选择表格有阴影--%>
                <table class="table table-hover ">
                    <thead class="table-light">
                    <tr>
                        <th><input class="form-check-input" type="checkbox" id="selectAllCheckbox"></th>
                        <!-- 这里是选择框的列头 -->
                        <th>id</th>
                        <th>登录密码</th>
                        <th>姓名</th>
                        <th>联系电话</th>
                        <th>电子邮箱</th>
                        <th>QQ</th>
                        <th>备注</th>
                        <th>
                            操作
                        </th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="finAllAUser" items="${finAllAUser}" varStatus="pages">
                        <tr>
                            <td>
                                <input class="form-check-input" type="checkbox" name="selectedUsers"
                                       value="${finAllAUser.AId}">
                            </td>
                            <td>${pages.index + 1}</td>
                            <td class="text-muted">
                                    ${finAllAUser.UUser.UPassword}
                            </td>
                            <td class="text-muted">
                                    ${finAllAUser.AName}
                            </td>

                            <td class="text-muted">
                                    ${finAllAUser.APhone}
                            </td>
                            <td class="text-muted">
                                    ${finAllAUser.AEmail}
                            </td>
                            <td class="text-muted">
                                    ${finAllAUser.AQQ}
                            </td>
                            <td class="text-muted">
                                    ${finAllAUser.ANotes}
                            </td>

                            <td>
                                <div class="dropdown" onmouseleave="hideDropdown('dropdown${pages.index}')">
                                    <button class="btn btn-outline-primary dropbtn"
                                            onmouseover="toggleDropdown('btn${pages.index}', 'dropdown${pages.index}')">
                                        操作
                                    </button>
                                    <div class="dropdown-content" id="dropdown${pages.index}">
                                        <a href="/supervision/updateAUserId/${finAllAUser.AId}">修改</a>
                                        <a data-bs-toggle="modal" data-bs-target="#exampleModal"
                                           onclick="deleteUserId(${finAllAUser.AId})">删除</a>
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

                    <div class="form">
                        <label for="aName">姓名</label>
                        <input type="text" class="form-control" id="aName" placeholder="请输入姓名"
                               name="aName">
                    </div>


                    <div class="form">
                        <label for="aPhone">手机号</label>
                        <input type="text" class="form-control" id="aPhone" placeholder="请输入手机号"
                               name="aPhone">
                        <span id="aPhoneError" class="error"></span>
                    </div>

                    <div class="form">
                        <label for="aEmail">邮箱</label>
                        <input type="text" class="form-control" id="aEmail" placeholder="请输入邮箱"
                               name="aEmail">
                        <span id="aEmailError" class="error"></span>
                    </div>
                    <div class="form">
                        <label for="aQQ">QQ</label>
                        <input type="text" class="form-control" id="aQQ" placeholder="请输入QQ"
                               name="aQQ">
                    </div>

                    <div class="form">
                        <label for="aNotes">备注</label>
                        <input type="text" class="form-control" id="aNotes" placeholder="请输入备注"
                               name="aNotes">
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
<script src="/static/js/AUser.js"></script>

<script>
    <%--删除按钮 传入需要删除的id--%>

    function deleteUserId(aId) {
        // 在触发确认按钮后
        document.getElementById("delete-button").addEventListener("click", function () {
            //进行ajax
            $.ajax({
                url: '/supervision/deleteAUserId/' + aId,
                success: function (response) {
                    // 删除成功后的处理逻辑
                    console.log('删除成功');
                    //跳转业务
                    window.location.href = '/supervision/findAllAUser';
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
            url: "/supervision/addAUser/",
            type: "POST",
            data: formData,
            success: function (response) {
                // 请求成功后的处理逻辑
                window.location.href = '/supervision/findAllAUser';
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
                url: "/supervision/deleteAUserbatch/",
                type: "POST",
                // 指定内容类型为JSON
                contentType: "application/json",
                data: requestData,
                success: function (response) {
                    // 请求成功后的处理逻辑
                    window.location.href = '/supervision/findAllAUser';
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