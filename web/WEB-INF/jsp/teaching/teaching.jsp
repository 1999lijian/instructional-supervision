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

    <title>教学计划列表</title>


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
        <div class="col-10 rounded-div">
            <jsp:include page="../../jsp/breadcrumb.jsp"/>
            <div class="d-grid gap d-md-flex  my-1">

                <div class="col-auto">
                    <%--                            添加按钮--%>
                    <a type="button" class="btn btn-danger btn-sm" style="display: none" id="buttonDivButton"
                       href="/supervision/UpTeaching"
                    >添加</a>
                </div>
                <%--                            批量删除--%>
                <div class="col-auto">
                    <button type="button" class="btn btn-danger btn-sm mx-3" id="buttonDiv" style="display: none">
                        批量删除
                    </button>
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
                <table class="table  table-hover">
                    <thead class="table-light">
                    <tr>
                        <th><input class="form-check-input" type="checkbox" id="selectAllCheckbox"></th>
                        <!-- 这里是选择框的列头 -->
                        <th>id</th>
                        <th>教学名称</th>
                        <th>教学预期</th>
                        <th>教学内容</th>
                        <th>状态</th>
                        <th>
                            操作
                        </th>

                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="findAllTeachingList" items="${findAllTeachingList}" varStatus="pages">
                        <tr>

                            <td>
                                <input class="form-check-input" type="checkbox" name="selectedUsers"
                                       value="${findAllTeachingList.teId}">
                            </td>
                            <td>${pages.index + 1}</td>

                            <td class="text-muted">
                                    ${findAllTeachingList.TName}
                            </td>
                            <td class="text-muted">
                                    <%--  class为"text-truncate"的div元素，它的最大宽度被设置为50像素
                                    使用了"text-truncate"类来截断文本，使其在指定的最大宽度内显示，并以省略号来表示被截断的部分
                                    --%>
                                <div class="text-truncate" style="max-width: 80px;">
                                        ${findAllTeachingList.TExpect}
                                </div>

                            </td>
                            <td class="text-muted">
                                <div class="text-truncate" style="max-width: 80px;">
                                        ${findAllTeachingList.TContent}
                                </div>
                            </td>

                            <td class="text-muted">
                                    <%--判断是否有审核--%>
                                <c:choose>
                                    <c:when test="${findAllTeachingList.TState eq 1  }">
                                        已审核
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${findAllTeachingList.TState eq 0  }">
                                        未审核
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>


                                <div class="dropdown" onmouseleave="hideDropdown('dropdown${pages.index}')">
                                    <button class="btn btn-outline-primary dropbtn"
                                            onmouseover="toggleDropdown('btn${pages.index}', 'dropdown${pages.index}')">
                                        操作
                                    </button>
                                    <div class="dropdown-content" id="dropdown${pages.index}">

                                        <c:choose>
                                            <c:when test="${  userRole eq 3}">
                                                <a href="/supervision/updateTeachingTeId/${findAllTeachingList.teId}"
                                                   id="Teaching${pages.index}" class="content"
                                                >修改</a>
                                            </c:when>
                                        </c:choose>

                                        <c:choose>
                                            <c:when test="${userRole eq 1  }">
                                                <a data-bs-toggle="modal" data-bs-target="#exampleModal"
                                                   id="TeachingD${pages.index}" class="content"
                                                   onclick="deleteId(${findAllTeachingList.teId})">删除</a>
                                            </c:when>
                                        </c:choose>

                                        <c:choose>
                                            <c:when test="${userRole eq 1 or userRole eq 2 }">

                                                <%-- 根据是否审核提供不同按钮--%>
                                                <c:choose>
                                                    <c:when test="${findAllTeachingList.TState eq 1  }">
                                                        <a href="/supervision/updateTeachingTeIdC/${findAllTeachingList.teId}"
                                                           id="Check${pages.index}" class="content"
                                                        >审核查看</a>
                                                    </c:when>
                                                </c:choose>

                                                <c:choose>
                                                    <c:when test="${findAllTeachingList.TState eq 0  }">
                                                        <a href="/supervision/updateTeachingTeIdC/${findAllTeachingList.teId}"
                                                           id="Check${pages.index}" class="content"
                                                        >审核</a>
                                                    </c:when>
                                                </c:choose>
                                            </c:when>
                                        </c:choose>

                                        <a href="/supervision/updateTeachingTeId/${findAllTeachingList.teId}?teaching=check"
                                           id="TeachingDetailed${pages.index}"
                                           class="content"
                                        >详细查看</a>

                                        <c:choose>
                                            <c:when test="${userRole eq 1 or userRole eq 2  or userRole eq 3}">
                                                <a href="/supervision/findFileTeaching?fUid=${findAllTeachingList.fileSava.FUid}"
                                                >查看文件</a>
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


<!-- jquery.js -->
<script src="/static/lib/jquery/jquery.js"></script>
<!-- popper.js -->
<script src="/static/js/popper.min.js"></script>
<!-- bootstrap.js -->
<script src="/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="/static/js/overallSituation.js"></script>
<script>


    <%--删除按钮 传入需要删除的id--%>

    function deleteId(teId) {
        // 在触发确认按钮后
        document.getElementById("delete-button").addEventListener("click", function () {
            //进行ajax
            $.ajax({
                url: '/supervision/deleteTeaching/' + teId,
                success: function (response) {
                    // 删除成功后的处理逻辑
                    console.log('删除成功');
                    //跳转业务
                    window.location.href = '/supervision/findAllTeaching';
                },
                error: function (error) {
                    // 删除失败后的处理逻辑
                    console.log('删除失败', error);
                }
            });

        });
    }


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

            // 显示当前下拉菜单内容
            dropdownContent.style.display = "block";
        }
    }

    // 鼠标移开下拉菜单按钮时隐藏下拉菜单内容
    function hideDropdown(dropdownId) {
        var dropdownContent = document.getElementById(dropdownId);
        dropdownContent.style.display = "none";
    }

</script>
<%--隐藏操作 不相干操作--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {

        // 获取 URL 参数
        const urlParams = new URLSearchParams(window.location.search);
        // 获取需要显示的内容的 ID 跳转
        const target = urlParams.get('target');
        // 获取需要显示的内容的 ID
        const targets = urlParams.get('targets');
        if (target) {
            // 显示对应的内容
            var targetContent_a = document.querySelectorAll('[id^=' + target + ']');

            // 隐藏所有内容
            var contents_a = document.querySelectorAll(".content");
            contents_a.forEach(function (content) {
                content.style.display = "none";
            });
            // 显示目标内容
            // document.querySelectorAll() 返回的是一个 NodeList，而不是单个元素。因此，需要遍历 NodeList 并为每个元素设置样式
            targetContent_a.forEach(function (element) {
                element.style.display = "block";
            });

            if (${ userRole eq  3 }) {
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


</script>

</body>
</html>
