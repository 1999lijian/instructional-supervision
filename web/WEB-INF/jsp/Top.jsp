<%--
  User: LIJIAN
  Date: 2024/3/25
  Time: 11:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>
<%--顶部页面--%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">高校教学督导管理(${RRole}端)</a>
        <div class="btn-group">
            <img src="/static/img/login.jpg" alt="登录图标" width="40px" height="40px" class="login-icon">
            <button type="button" class="  btn btn-secondary  username-btn bg-dark ">${uName}</button>
            <button class=" btn btn-secondary  username-btn  dropdown-toggle bg-dark   dropdown-toggle-split  "
                    type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                <li><a class="dropdown-item" href="/supervision/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<script>
    // 页面加载时清除所有 sessionStorage
    document.addEventListener('DOMContentLoaded', function () {
        var logoutLink = document.querySelector('a[href="/supervision/logout"]');

        if (logoutLink) {
            logoutLink.addEventListener('click', function () {
                sessionStorage.clear(); // 清除所有 sessionStorage 中的内容
            });
        }
    });

</script>
</body>
</html>
