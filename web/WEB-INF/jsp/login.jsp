<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>登录页面</title>
    <!-- bootstrap.css -->
    <link rel="stylesheet" href="/static/lib/bootstrap/css/bootstrap.min.css">
    <!-- 自定义样式 引入 -->
    <link rel="stylesheet" href="/static/css/login.css">

</head>

<body class="text-center">

<div class="form-signin w-100 m-auto">
    <form id="login" action="/supervision/login" method="post" class="needs-validation" novalidate>
        <img class="mb-4" src="/static/img/login.png" alt="" width="72" height="57">
        <h1 class="h3 mb-3 fw-normal">高校教学督导管理</h1>
        <div id="errorMessages" style="color: red;">
            ${errorMsg}
        </div>
        <div class="form-floating">
            <input type="text" class="form-control" id="uName" placeholder="请输入用户名" name="uName" required>
            <label for="uName">用户名</label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" id="uPassword" placeholder="请输入密码" name="uPassword" required>
            <label for="uPassword">密码</label>

        </div>


        <button class="w-100 btn btn-lg btn-primary" type="submit" onclick="checkLoginForm()">登录</button>

        <p class="mt-5 mb-3 text-muted">LIJIAN</p>
    </form>


</div>



<!-- jquery.js -->
<script src="/static/lib/jquery/jquery.js"></script>
<script src="/static/js/popper.min.js"></script>
<!-- bootstrap.js -->
<script src="/static/lib/bootstrap/js/bootstrap.js"></script>

<script>
    <%--    用户名为空   密码为空提示--%>
    (function () {
        window.addEventListener('load', function () {
            var forms = document.getElementsByClassName('needs-validation');
            var validation = Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');


                }, false);
            });
        }, false);
    })();


    // 三秒后隐藏错误消息
    setTimeout(function () {
        document.getElementById('errorMessages').style.display = 'none';
    }, 2500); // 3000 毫秒 = 3 秒

</script>
</body>
</html>