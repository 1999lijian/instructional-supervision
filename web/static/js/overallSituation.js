// 获取全选复选框和所有用户复选框
const selectAllCheckbox = document.getElementById('selectAllCheckbox');
const userCheckboxes = document.querySelectorAll('input[name="selectedUsers"]');

// 添加全选/取消全选的事件监听器
selectAllCheckbox.addEventListener('change', function () {
    userCheckboxes.forEach(checkbox => {
        checkbox.checked = selectAllCheckbox.checked;
    });
});

// 添加用户复选框的事件监听器，以便在取消全选时取消全选复选框的选中状态
userCheckboxes.forEach(checkbox => {
    checkbox.addEventListener('change', function () {
        if (!checkbox.checked) {
            selectAllCheckbox.checked = false;
        }
    });
});





