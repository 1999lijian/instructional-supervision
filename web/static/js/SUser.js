//信息验证
const uNameInput = document.getElementById('uName');
const uNameError = document.getElementById('uNameError');

const uPasswordInput = document.getElementById('uPassword');
const uPasswordError = document.getElementById('uPasswordError');

const aPhoneInput = document.getElementById('sPhone');
const aPhoneError = document.getElementById('aPhoneError');

const aEmailInput = document.getElementById('sEmail');
const aEmailError = document.getElementById('aEmailError');

//验证函数

function validateInput(input, errorElement, pattern, errorMessage) {


    if (input && errorElement) {
        input.addEventListener('input', function () {
            if (!input.value.match(pattern)) {
                errorElement.textContent = errorMessage;
            } else {
                errorElement.textContent = '';
            }
        });
    }
}

//定义验证规则和错误消息
const validationRules = [
    { input: uNameInput, errorElement: uNameError, pattern: /^[a-zA-Z]{6,}$/, errorMessage: '用户名必须包含至少六个字母' },
    { input: uPasswordInput, errorElement: uPasswordError, pattern: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}$/, errorMessage: '密码必须包含8-16个字符，包括大小写字母和数字' },
    { input: aPhoneInput, errorElement: aPhoneError, pattern: /^1[0-9]{10}$/, errorMessage: '请输入有效的手机号' },
    { input: aEmailInput, errorElement: aEmailError, pattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, errorMessage: '请输入有效的邮箱地址' }
];



//循环调用验证函数
validationRules.forEach(rule => {

    validateInput(rule.input, rule.errorElement, rule.pattern, rule.errorMessage);
});
