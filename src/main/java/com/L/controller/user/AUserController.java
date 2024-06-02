package com.L.controller.user;

import com.L.entity.user.AUser;
import com.L.entity.user.UUser;
import com.L.entity.util.Page;
import com.L.service.user.AUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 15:29
 * <p>
 * <p>
 * 管理员信息管理
 */
@Controller
@RequestMapping("/supervision")
public class AUserController {

    @Autowired
    private AUserService aUserService;


    //    查询管理员所有的用户
    @RequestMapping("/findAllAUser")
    public String findAllAUser(HttpServletRequest request, Model model) {
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
        int total = aUserService.countAUser();
        // 计算总页数
        Page page = new Page(startIndex, pageSize);
        page.setTotal(total);
        List<AUser> allAUserList = aUserService.findAllAUserList(startIndex, pageSize);
        model.addAttribute("page", page);
        model.addAttribute("finAllAUser", allAUserList);

        return "user/AUser/AUserList";
    }

//        测试
//        System.out.println(aUser);

    //    添加用户
    @RequestMapping("/addAUser")
    public String addAUser(AUser aUser, UUser uUser) {
        aUserService.addAll(uUser);
        aUserService.addAUser(aUser);
        return "redirect:/supervision/findAllAUser";
    }


    /*
      @PathVariable是一个Spring MVC注解，用于将URL路径中的参数绑定到方法的参数上。
      例如，假设我们有以下的请求URL：
      GET /users/{id}
      其中，{id}是一个占位符，代表用户的ID。
      在Spring MVC的控制器方法中，我们可以使用@PathVariable注解来将URL路径中的{id}绑定到方法的参数上
           */
    //    根据ID删除用户
    @RequestMapping("/deleteAUserId/{aId}")
    public String deleteAUserId(@PathVariable int aId) {
//        System.out.println(aId);
        aUserService.deleteAUserId(aId);
        return "redirect: /supervision/findAllAUser";
    }


    //修改用户 根据id查询用户
    @RequestMapping("/updateAUserId/{aId}")
    public String updateUserId(@PathVariable int aId, Model model) {
//        System.out.println(id);
        AUser aUser = aUserService.updateAUserId(aId);
//        System.out.println(aUser);
        model.addAttribute("updateAUserdata", aUser);
        return "user/AUser/AUserUpdate";
    }


    //修改用户 更新数据
    @RequestMapping("/updateAUser")
    public String updateUser(AUser aUser) {
//        System.out.println(aUser);
        aUserService.updateAUser(aUser);
        return "redirect: /supervision/findAllAUser";
    }


    //    批量删除学生用户
//    @RequestBody 注解来告诉Spring MVC框架将请求体中的JSON数据映射到方法参数上
    @RequestMapping("/deleteAUserbatch")
    public String deleteAUserbatch(@RequestBody List<String> requestData) {

//        System.out.println(requestData);
        // 调用service层的方法删除学生用户
        aUserService.deleteAUserbatch(requestData);

        return "redirect: /supervision/findAllAUser";
    }


}
