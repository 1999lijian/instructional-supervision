<%--
  User: LIJIAN
  Date: 2024/3/25
  Time: 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>
<%--菜单页面--%>
<!-- 左边 -->
<div class=" col-2  " id="col2Content">
    <div class="flex-shrink-0 my-3 ms bg-tertiary " style="width: 280px;">
        <ul class="list-unstyled ps-0  ">
            <%--个人信息--%>
            <li class="mb-1">
                <a href="/supervision/management"
                   class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                   aria-expanded="false">
                    主页
                </a>
            </li>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#personalInformation-collapse"
                        aria-expanded="false">
                    个人信息
                </button>
                <div class="collapse" id="personalInformation-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <li><a href="/supervision/findSUser/${uId}"
                               class="link-dark d-inline-flex text-decoration-none rounded  personal-info-link">修改个人信息</a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="border-top" style=" width: 85%; "></li>
            <%--用户管理--%>
            <c:choose>
                <c:when test="${userRole eq 1}">
                    <li class="mb-1">
                        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                                data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="false">
                            用户管理
                        </button>
                        <div class="collapse" id="home-collapse">
                            <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">

                                <li><a href="/supervision/findAllAUser"
                                       class="link-dark d-inline-flex text-decoration-none rounded">系统管理员信息列表</a>
                                </li>
                                <li><a href="/supervision/findAllSUser"
                                       class="link-dark d-inline-flex text-decoration-none rounded">学生信息列表</a>
                                </li>
                                <li><a href="/supervision/findAllTUser"
                                       class="link-dark d-inline-flex text-decoration-none rounded">教师信息列表</a>
                                </li>
                                <li><a href="/supervision/findAllSVUser"
                                       class="link-dark d-inline-flex text-decoration-none rounded">督导员信息列表</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </c:when>
            </c:choose>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#course-collapse" aria-expanded="false">
                    课程管理
                </button>
                <div class="collapse" id="course-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <c:choose>
                            <c:when test="${userRole eq 1 or  userRole eq 2 or  userRole eq 3  or   userRole eq 4}">
                                <%--target=Course 传值 给下页面 进行显示相关按钮--%>
                                <li><a href="/supervision/findAllCourse?target=Course"
                                       class="link-dark d-inline-flex text-decoration-none rounded"
                                       id="link-Course">课程信息</a>
                                </li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <%-- 学生--%>
                            <c:when test="${ userRole eq 4}">
                                <li><a href="/supervision/findAllCourse?evaluate=Evaluate"
                                       class="link-dark d-inline-flex text-decoration-none rounded"
                                       id="link-Evaluate">课程评价</a>
                                </li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <%-- 督导 和 教师--%>
                            <c:when test="${userRole eq 2  }">
                                <li><a href="/supervision/findAllCourse?evaluate=Listening"
                                       class="link-dark d-inline-flex text-decoration-none rounded"
                                       id="link-Evaluates">听课评价</a>
                                </li>
                            </c:when>
                        </c:choose>

                        <c:choose>
                            <%--督导员--%>
                            <c:when test="${userRole eq 2  }">
                                <li><a href="/supervision/findAllCourse?evaluate=Patrol"
                                       class="link-dark d-inline-flex text-decoration-none rounded"
                                       id="link-Patrol">巡查课程</a>
                                </li>
                            </c:when>
                        </c:choose>

                        <c:choose>
                            <c:when test="${userRole eq 2 or userRole eq 3 }">
                                <li><a href="/supervision/findAllCourse?evaluate=Detailed"
                                       class="link-dark d-inline-flex text-decoration-none rounded"
                                       id="link-Patroldetailed">巡查记录</a>
                                </li>
                            </c:when>
                        </c:choose>
                    </ul>
                </div>
            </li>

            <%--                教学管理--%>
            <c:choose>
                <c:when test="${userRole eq 1 or userRole eq 2 or userRole eq 3}">
                    <li class="mb-1">
                        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                                data-bs-toggle="collapse" data-bs-target="#teaching-collapse"
                                aria-expanded="false">
                            教学管理
                        </button>
                        <div class="collapse " id="teaching-collapse">
                            <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                                <c:choose>
                                    <c:when test="${userRole eq 1 or  userRole eq 2 or userRole eq 3}">
                                        <li>
                                            <a href="/supervision/findAllTeaching?target=Teaching"
                                               class="link-dark d-inline-flex text-decoration-none rounded">教学计划</a>
                                        </li>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${userRole eq 1 or   userRole eq 2}">
                                        <li>
                                            <a href="/supervision/findAllTeaching?targets=Check"
                                               class="link-dark d-inline-flex text-decoration-none rounded">教学审核</a>
                                        </li>
                                    </c:when>
                                </c:choose>
                            </ul>
                        </div>
                    </li>
                </c:when>
            </c:choose>


            <%--修改定位--%>
            <%--                督导管理--%>
            <c:choose>
                <c:when test="${userRole eq 1or userRole eq 2or userRole eq 3}">
                    <li class="mb-1">
                            <%--                            修改定位--%>
                        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                                data-bs-toggle="collapse" data-bs-target="#supervision-collapse"
                                aria-expanded="false">
                            督导管理
                        </button>
                        <div class="collapse " id="supervision-collapse">
                            <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                                <c:choose>
                                    <c:when test="${userRole eq 1 or  userRole eq 2}">

                                        <li><a href="/supervision/findAllSupervision?target=Supervision"
                                               class="link-dark d-inline-flex text-decoration-none rounded">督导计划</a>
                                        </li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${userRole eq 1 or  userRole eq 2 or userRole eq 3}">
                                        <li><a href="/supervision/findAllSupervision?targets=Checks"
                                               class="link-dark d-inline-flex text-decoration-none rounded">查看督导任务</a>
                                        </li>
                                    </c:when>
                                </c:choose>
                            </ul>
                        </div>
                    </li>
                </c:when>
            </c:choose>
            <%--                数据可视化管理--%>
            <c:choose>
                <c:when test="${userRole eq 1 or userRole eq 2or userRole eq 3}">
                    <li class="mb-1">
                        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                                data-bs-toggle="collapse" data-bs-target="#dataVisualization-collapse"
                                aria-expanded="false">
                            数据可视化
                        </button>
                        <div class="collapse" id="dataVisualization-collapse">
                            <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">


                                <li><a href="/supervision/findAllCourse?visualization=visualization&uId=${uId}"
                                       class="link-dark d-inline-flex text-decoration-none rounded">学生评价可视化</a>
                                </li>

                                <li><a href="/supervision/findAllCourse?visualization=zlisten&uId=${uId}"
                                       class="link-dark d-inline-flex text-decoration-none rounded">听课评价可视化</a>
                                </li>


                            </ul>
                        </div>
                    </li>
                </c:when>
            </c:choose>


            <c:choose>
                <c:when test="${userRole eq 1}">

                    <%--评价管理--%>
                    <li class="mb-1">
                        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                                data-bs-toggle="collapse" data-bs-target="#evaluate-collapse"
                                aria-expanded="false">
                            评价管理
                        </button>
                        <div class="collapse" id="evaluate-collapse">
                            <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                                <li><a href="/supervision/findAllEvaluate"
                                       class="link-dark d-inline-flex text-decoration-none rounded">评分列表管理</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </c:when>
            </c:choose>


            <%--留言--%>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#LeaveAMessage-collapse"
                        aria-expanded="false">
                    留言
                </button>
                <div class="collapse" id="LeaveAMessage-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <c:choose>
                            <c:when test="${ userRole eq 4}">
                                <li><a href="/supervision/findAllCourse?evaluate=Message"
                                       class="link-dark d-inline-flex text-decoration-none rounded">添加留言</a>
                                </li>
                            </c:when>
                        </c:choose>
                        <li><a href="/supervision/findMessageId/?target=Course"
                               class="link-dark d-inline-flex text-decoration-none rounded">查看留言</a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="border-top" style=" width: 85%; "></li>
            <c:choose>
                <c:when test="${userRole eq 1}">
                    <li class="border-top" style=" width: 85%; "></li>
                    <%--系统信息维护--%>
                    <li class="mb-1">
                        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                                data-bs-toggle="collapse" data-bs-target="#Information-collapse"
                                aria-expanded="false">
                            系统信息维护
                        </button>
                        <div class="collapse" id="Information-collapse">
                            <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                                <li><a href="/supervision/findAllClasses"
                                       class="link-dark d-inline-flex text-decoration-none rounded">班级信息维护</a>
                                </li>
                                <li><a href="/supervision/findAllRoom"
                                       class="link-dark d-inline-flex text-decoration-none rounded">教室信息维护</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </c:when>
            </c:choose>
        </ul>
    </div>


</div>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        var col2Content = document.getElementById('col2Content');

        if (col2Content) {
            var breadcrumb = document.getElementById('breadcrumb');

            if (breadcrumb) {
                var breadcrumbContent = sessionStorage.getItem('breadcrumbContent') || '';

                // 设置面包屑导航的内容
                breadcrumb.innerHTML = breadcrumbContent;

                // 监听特定 div 区域内的点击事件，当用户点击链接时更新面包屑导航
                col2Content.addEventListener('click', function (event) {
                    var target = event.target;

                    // 检查点击的元素是否是链接并且不是按钮
                    if (target.tagName === 'A' && !target.closest('button')) {
                        if (!target.classList.contains('personal-info-link')) { // 检查是否是修改个人信息的链接
                            breadcrumbContent = ''; // 重置面包屑导航内容

                            // 添加主页链接
                            breadcrumbContent += '<a href="/supervision/management">主页</a>';

                            // 添加点击的链接文本到面包屑导航
                            var text = target.textContent.trim();
                            breadcrumbContent += ' / ' + text;

                            // 设置面包屑导航的内容
                            breadcrumb.innerHTML = breadcrumbContent;

                            // 将面包屑导航内容存储在会话存储中
                            sessionStorage.setItem('breadcrumbContent', breadcrumbContent);
                        }
                    }
                });
            }
        }
    });


    document.addEventListener('DOMContentLoaded', function () {
        var collapseButtons = document.querySelectorAll('[data-bs-toggle="collapse"]');

        collapseButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                var target = button.getAttribute('data-bs-target').substring(1);
                var isExpanded = button.getAttribute('aria-expanded') === 'true';

                // 关闭其他展开的菜单项
                collapseButtons.forEach(function (otherButton) {
                    if (otherButton !== button) {
                        var otherTarget = otherButton.getAttribute('data-bs-target').substring(1);
                        var otherCollapse = document.getElementById(otherTarget);

                        if (otherCollapse && otherButton.getAttribute('aria-expanded') === 'true') {
                            otherCollapse.classList.remove('show');
                            otherButton.setAttribute('aria-expanded', 'false');
                        }
                    }
                });

                // 记录展开状态到会话存储
                if (isExpanded) {
                    sessionStorage.setItem('expandedItem', target);
                } else {
                    sessionStorage.removeItem('expandedItem');
                }
            });
        });

        // 恢复展开状态
        var expandedItem = sessionStorage.getItem('expandedItem');
        if (expandedItem) {
            var collapseElement = document.getElementById(expandedItem);
            if (collapseElement) {
                var collapseButton = document.querySelector('[data-bs-target="#' + expandedItem + '"]');
                if (collapseButton) {
                    collapseElement.classList.add('show');
                    collapseButton.setAttribute('aria-expanded', 'true');
                }
            }
        }
    });


</script>

</body>
</html>
