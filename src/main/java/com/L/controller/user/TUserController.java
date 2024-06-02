package com.L.controller.user;

import com.L.entity.general.College;
import com.L.entity.user.TUser;
import com.L.entity.user.UUser;
import com.L.entity.util.Page;
import com.L.service.user.TUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/22 0:54
 * <p>
 * 教师管理页面
 */
@Controller
@RequestMapping("/supervision")
public class TUserController {


    @Autowired
    private TUserService tUserService;


    //    查询所有的用户
    @RequestMapping("/findAllTUser")
    public String findAllTUser(HttpServletRequest request, Model model) {
        //    每页开始元素的索引
        int startIndex = 0;
        //    每页的数量
        int pageSize = 9;
        try {
            startIndex = Integer.parseInt(request.getParameter("page.startIndex"));  //从前台获取 开始数据的索引
            pageSize = Integer.parseInt(request.getParameter("page.pageSize"));
        } catch (Exception e) {
        }
        // 查询总记录数
        int total = tUserService.countTUser();
        // 计算总页数
//        System.out.println(total);
//        System.out.println(startIndex);
        Page page = new Page(startIndex, pageSize);
        page.setTotal(total);
        List<TUser> allTUserList = tUserService.findAllTUserList(startIndex, pageSize);
//        测试
//        System.out.println(allAUserList);
        model.addAttribute("page", page);
        model.addAttribute("finAllTUser", allTUserList);
        return "user/TUser/TUserList";
    }


    //    添加用户
    @RequestMapping("/addTUser")
    public String addTUser(TUser tUser, UUser uUser) {
        tUserService.addAll(uUser);
//        测试
//        System.out.println(tUser);
        tUserService.addTUser(tUser);
        return "redirect:/supervision/findAllTUser";
    }


    /*
      @PathVariable是一个Spring MVC注解，用于将URL路径中的参数绑定到方法的参数上。
      例如，假设我们有以下的请求URL：
      GET /users/{id}
      其中，{id}是一个占位符，代表用户的ID。
      在Spring MVC的控制器方法中，我们可以使用@PathVariable注解来将URL路径中的{id}绑定到方法的参数上
           */
    //    根据ID删除用户
    @RequestMapping("/deleteTUserId/{tId}")
    public String deleteTUserId(@PathVariable int tId) {
        tUserService.deleteTUserId(tId);
        return "redirect: /supervision/findAllTUser";
    }


    //修改用户 根据id查询用户
    @RequestMapping("/updateTUserId/{tId}")
    public String updateTUserId(@PathVariable int tId, Model model) {

        TUser tUser = tUserService.updateTUserId(tId);
//        System.out.println(tUser);
        model.addAttribute("updateTUserdata", tUser);
        return "user/TUser/TUserUpdate";
    }


    //修改用户 更新数据
    @RequestMapping("/updateTUser")
    public String updateTUser(TUser tUser) {

//        System.out.println(tUser);
        tUserService.updateTUser(tUser);

        return "redirect: /supervision/findAllTUser";
    }

    //    查询所有学院
    @RequestMapping("/findAllCollegeTU")
    @ResponseBody
    public List<College> findAllCollege() {
        return tUserService.findAllCollege();
    }


    //    批量删除用户
//    @RequestBody 注解来告诉Spring MVC框架将请求体中的JSON数据映射到方法参数上
    @RequestMapping("/deleteTUserbatch")
    public String deleteTUserbatch(@RequestBody List<String> requestData) {

//        System.out.println(requestData);
        // 调用service层的方法删除用户
        tUserService.deleteTUserbatch(requestData);

        return "redirect: /supervision/findAllSVUser";
    }


}
