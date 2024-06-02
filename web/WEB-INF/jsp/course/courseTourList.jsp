<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程巡查记录列表</title>
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

                <%--导出详细表格--%>
                <div class="col-auto">
                    <button type="button" class="btn btn-danger btn-sm mx-3" id="exportButton"
                    >
                        导出表格
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
                <%--table-hover ： 选择表格有阴影--%>
                <table class="table table-hover ">
                    <thead class="table-light">
                    <tr>
                        <th><input class="form-check-input" type="checkbox" id="selectAllCheckbox"></th>
                        <!-- 这里是选择框的列头 -->
                        <th>id</th>
                        <th>课程名称</th>
                        <th>课程纪律</th>
                        <th>巡查内容</th>
                        <th>时间</th>
                        <th>照片</th>
                        <th>
                            操作
                        </th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="courseTourList" items="${courseTourList}" varStatus="pages">
                        <tr>
                            <td>
                                <input class="form-check-input" type="checkbox" name="selectedUsers"
                                       value="${courseTourList.tourClassId}">
                            </td>
                            <td>${pages.index + 1}</td>
                            <td class="text-muted">
                                    ${courseTourList.courseTourClass.CName}
                            </td>
                            <td class="text-muted">
                                    ${courseTourList.tourClassDiscipline}
                            </td>

                            <td class="text-muted">
                                    ${courseTourList.tourClassContent}
                            </td>
                            <td class="text-muted">
                                    ${courseTourList.tourClassTime}
                            </td>
                            <td class="text-muted">
                                    <%-- 使用 pages.index  形成单独 id 1 或 id 1++ --%>
                                <a href="#"
                                   onclick="openModal('${courseTourList.fileTourClass.FPath}', 'modal${pages.index + 1}')">
                                    <img src="${courseTourList.fileTourClass.FPath}" alt="图片"
                                         style="max-width: 90px; max-height: 90px;">
                                </a>
                            </td>


                            <td>
                                <div class="dropdown" onmouseleave="hideDropdown('dropdown${pages.index}')">
                                    <button class="btn btn-outline-primary dropbtn"
                                            onmouseover="toggleDropdown('btn${pages.index}', 'dropdown${pages.index}')">
                                        操作
                                    </button>
                                    <div class="dropdown-content" id="dropdown${pages.index}">
<%--                                        <a href="/supervision/updateAUserId/${courseTourList.tourClassId}">修改</a>--%>
<%--                                        <a data-bs-toggle="modal" data-bs-target="#exampleModal"--%>
<%--                                           onclick="deleteUserId(${courseTourList.tourClassId})">删除</a>--%>
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
<%--导出表格--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.4/xlsx.full.min.js"></script>
<%--保存图片 到表格--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>

<script>
    // 导出表格数据为 XLSX 格式，包含图片
    function exportTableToXLSXWithImages(filename) {
        var wb = XLSX.utils.book_new();
        var wsData = [[]];

        // 添加表头数据
        var headerCols = document.querySelectorAll("table th");
        for (var k = 0; k < headerCols.length; k++) {
            wsData[0].push(headerCols[k].innerText);
        }

        // 添加表格数据
        var rows = document.querySelectorAll("table tr");
        for (var i = 0; i < rows.length; i++) {
            var rowData = [];
            var cols = rows[i].querySelectorAll("td");

            for (var j = 0; j < cols.length; j++) {
                var cellData = cols[j].innerText;

                // 如果是图片单元格，将图片添加到单元格中
                var img = cols[j].querySelector("img");
                if (img) {
                    // 创建一个新的单元格对象，并将图片插入其中
                    var imgCell = {t: 's', v: ''}; // 图片单元格的数据结构
                    imgCell.l = {Target: img.src, Tooltip: img.alt}; // 链接到图片的地址
                    imgCell.s = {fill: {patternType: 'solid', fgColor: {rgb: "FFFFFFFF"}}}; // 图片单元格的样式
                    rowData.push(imgCell); // 将图片单元格添加到行数据中
                } else {
                    // 如果不是图片单元格，直接添加文本数据
                    rowData.push({t: 's', v: cellData}); // 文本单元格的数据结构
                }
            }

            wsData.push(rowData);
        }

        // 将表格数据添加到工作表中
        var ws = XLSX.utils.aoa_to_sheet(wsData);
        XLSX.utils.book_append_sheet(wb, ws, "Sheet1");

        // 生成 XLSX 文件
        var wbout = XLSX.write(wb, {bookType: 'xlsx', bookSST: true, type: 'binary'});

        // 保存 XLSX 文件
        saveAs(new Blob([s2ab(wbout)], {type: "application/octet-stream"}), filename);
    }

    // 将字符串转换为 ArrayBuffer
    function s2ab(s) {
        var buf = new ArrayBuffer(s.length);
        var view = new Uint8Array(buf);
        for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
        return buf;
    }

    // 点击按钮触发导出操作
    document.getElementById("exportButton").addEventListener("click", function () {
        exportTableToXLSXWithImages("table_with_images.xlsx");
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


    function openModal(imageSrc, modalId) {
        // 关闭当前模态框（如果存在）
        closeModal();

        // 创建模态框元素
        var modal = document.createElement('div');
        modal.classList.add('modal');
        modal.id = modalId; // 设置模态框的ID
        modal.innerHTML = `
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <img class="img-fluid" alt="放大图片">
                </div>
            </div>
        </div>
    `;

        // 将模态框添加到页面中
        document.body.appendChild(modal);

        // 获取图片元素
        var imageElement = modal.querySelector('.modal-body img');

        // 设置图片路径
        imageElement.src = imageSrc;

        // 显示模态框
        $('#' + modalId).modal('show'); // 通过ID调用模态框

        // 监听模态框关闭事件，清除当前模态框
        $('#' + modalId).on('hidden.bs.modal', function () {
            $(this).remove();
        });
    }

    function closeModal(modalId) {
        // 如果指定的模态框存在，则关闭并移除它
        if (modalId) {
            $('#' + modalId).modal('hide');
            $('#' + modalId).remove();
        }
    }


</script>


</body>


</html>