package com.L.controller.user;

import com.L.entity.general.College;
import com.L.entity.user.SVUser;
import com.L.entity.user.UUser;
import com.L.entity.util.Page;
import com.L.service.user.SVUserService;
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
 * @Date 2024/1/23 0:29
 * <p>
 * 督导员
 */
@Controller
@RequestMapping("/supervision")
public class SVUserController {


    @Autowired
    private SVUserService svUserService;


    //    查询所有的用SV
    @RequestMapping("/findAllSVUser")
    public String findAllSVUser(HttpServletRequest request, Model model) {
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
        int total = svUserService.countSVUser();
        // 计算总页数
//        System.out.println(total);
//        System.out.println(startIndex);
        Page page = new Page(startIndex, pageSize);
        page.setTotal(total);
        List<SVUser> allSVUserList = svUserService.findAllSVUserList(startIndex, pageSize);
//        测试
//        System.out.println(allAUserList);
        model.addAttribute("page", page);
        model.addAttribute("finAllSVUser", allSVUserList);
        return "user/SVUser/SVUserList";
    }


    //    添加用户
    @RequestMapping("/addSVUser")
    public String addSVUser(SVUser svUser, UUser uUser) {
        svUserService.addAll(uUser);
//        测试
//        System.out.println(svUser);
        svUserService.addSVUser(svUser);
        return "redirect:/supervision/findAllSVUser";
    }


    /*
      @PathVariable是一个Spring MVC注解，用于将URL路径中的参数绑定到方法的参数上。
      例如，假设我们有以下的请求URL：
      GET /users/{id}
      其中，{id}是一个占位符，代表用户的ID。
      在Spring MVC的控制器方法中，我们可以使用@PathVariable注解来将URL路径中的{id}绑定到方法的参数上
           */
    //    根据ID删除用户
    @RequestMapping("/deleteSVUserId/{svId}")
    public String deleteSVUserId(@PathVariable int svId) {
        svUserService.deleteSVUserId(svId);
        return "redirect: /supervision/findAllSVUser";
    }


    //修改用户 根据id查询用户
    @RequestMapping("/updateSVUserId/{svId}")
    public String updateSVUserId(@PathVariable int svId, Model model) {

        SVUser svUser = svUserService.updateSVUserId(svId);
//        System.out.println(svUser);
        model.addAttribute("updateSVUserdata", svUser);
        return "user/SVUser/SVUserUpdate";
    }


    //修改用户 更新数据
    @RequestMapping("/updateSVUser")
    public String updateSVUser(SVUser svUser) {
//        System.out.println(tUser);
        svUserService.updateSVUser(svUser);
        return "redirect: /supervision/findAllSVUser";
    }


    //    查询所有学院
    @RequestMapping("/findAllCollegeSVU")
    @ResponseBody
    public List<College> findAllCollege() {
        return svUserService.findAllCollege();
    }


    //    批量删除用户
//    @RequestBody 注解来告诉Spring MVC框架将请求体中的JSON数据映射到方法参数上
    @RequestMapping("/deleteSVUserbatch")
    public String deleteSVUserbatch(@RequestBody List<String> requestData) {

//        System.out.println(requestData);
        // 调用service层的方法删除用户
        svUserService.deleteSVUserbatch(requestData);

        return "redirect: /supervision/findAllSVUser";
    }


}