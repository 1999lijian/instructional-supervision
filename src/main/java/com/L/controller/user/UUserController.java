package com.L.controller.user;

import com.L.entity.user.UUser;
import com.L.service.user.UUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 13:47
 * <p>
 * <p>
 * 用户相关功能
 * <p>
 * 登录
 * 退出
 */
@Controller
@RequestMapping("/supervision")
public class UUserController {

    //  @Autowired : 自动注入 注解 bean
    @Autowired
    private UUserService uUserService;

    //登录功能
    @RequestMapping("/login")
    public String login(@RequestParam("uName") String uName,
                        @RequestParam("uPassword") String uPassword,
                        Model model, HttpSession session) {
        // 调用service方法
        UUser login = uUserService.login(uName, uPassword);
        if (login != null) {
            // 根据用户角色判断进入哪个页面
            session.setAttribute("uName", uName);
            session.setAttribute("uId", login.getUId());
            session.setAttribute("userRole", login.getURoleNo());
            session.setAttribute("RRole", login.getRRole().getRRole());
            return "management";
        }
        // 登录失败
        model.addAttribute("errorMsg", "用户名或密码错误或检查角色选择");
        return "login";
    }

    //    退出功能
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        //清除session
        session.removeAttribute("uName");
        session.removeAttribute("userRole");
        session.removeAttribute("RRole");
        session.removeAttribute("uId");
//        使当前会话无效的方法
        session.invalidate();
        return "login";
    }


    //    返回主页
    @RequestMapping("/management")
    public String managementUser() {
        return "management";
    }


    //    个人信息查询
// 根据登录是存储在会话中id查询用户 ：个人信息
    @RequestMapping("/findSUser/{uId}")
    public String updateUserId(@PathVariable int uId, Model model) {
        UUser sUser = uUserService.UserId(uId);
//        test
//        System.out.println(sUser);
//                将查询到的用户信息存储到model中
        model.addAttribute("SUserId", sUser);
//
        System.out.println("SUserId" + sUser);
        return "user/Information";
    }


    //    修改个人信息
    @RequestMapping("/findSUserId")
    public String findSUserId(@RequestParam LinkedHashMap<String, String> formData) {
//        System.out.println("Received form data: " + formData);
//        个人信息
//        {uid=4, UPassword=admin4, SUser=LIJIAN, SDate=2024-01-21, SSex=1, SPhone=1, SEmail=231@qq.com, SQQ=21323}
//        获取是那个用户
//        System.out.println("Received form data: " + formData.get("uId"));
//        System.out.println(formData);
        int uidString = Integer.parseInt(formData.get("uId"));
//获取密码的值
        String UPassword = formData.get("UPassword");
//修改的密码
        uUserService.upUserPassword(uidString, UPassword);
//        移除密码的值
        formData.remove("UPassword");
//测试
//        System.out.println(" remove UPassword: " + formData);
        List<UUser> uUserList = new ArrayList<>();
//      剩下的数据  SUser=LIJIAN, SDate=2024-01-21, SSex=1, SPhone=1, SEmail=231@qq.com, SQQ=21323
        //        记录是那个表
        String countKeys = null;
//        遍历获取表单表头是属于那个信息
        for (String key : formData.keySet()) {
            if (key.equals("SName")) {
                countKeys = "SUser";
            } else if (key.equals("AName")) {
                countKeys = "AUser";
            } else if (key.equals("TName")) {
                countKeys = "TUser";
            } else if (key.equals("svName")) {
                countKeys = "svUser";
            }
        }
        // 添加默认情况处理
        if (countKeys == null) {
            countKeys = "DefaultUserType"; // 设置一个默认值
        }
//        添加判断的 when的条件
        formData.put("userType", countKeys);
//        测试
//        System.out.println("formData: " + formData);
        uUserService.upUserId(formData);
        return "redirect: /supervision/management";
    }


}
