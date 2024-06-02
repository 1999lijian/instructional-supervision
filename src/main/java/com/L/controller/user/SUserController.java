package com.L.controller.user;

import com.L.entity.classes.ClassST;
import com.L.entity.general.College;
import com.L.entity.user.SUser;
import com.L.entity.user.UUser;
import com.L.entity.util.Page;
import com.L.service.user.SUserService;
import com.L.service.user.UUserService;
import org.apache.poi.ss.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/23 0:29
 * <p>
 * 督导员
 */
@Controller
@RequestMapping("/supervision")
public class SUserController {


    @Autowired
    private SUserService sUserService;
    @Autowired
    private UUserService uUserService;


    //    查询所有的用SV
    @RequestMapping("/findAllSUser")
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
        int total = sUserService.countSUser();
        // 计算总页数

        Page page = new Page(startIndex, pageSize);
        page.setTotal(total);
        List<SUser> allSUserList = sUserService.findAllSUserList(startIndex, pageSize);
//        测试
        model.addAttribute("page", page);
        model.addAttribute("finAllSUser", allSUserList);
        return "user/SUser/SUserList";
    }


    //    添加用户
    @RequestMapping("/addSUser")
    public String addSUser(SUser sUser, UUser uUser) {
        sUserService.addAll(uUser);
//        测试
//        System.out.println(sUser);
        sUserService.addSUser(sUser);
        return "redirect:/supervision/findAllSUser";
    }


    /*
      @PathVariable是一个Spring MVC注解，用于将URL路径中的参数绑定到方法的参数上。
      例如，假设我们有以下的请求URL：
      GET /users/{id}
      其中，{id}是一个占位符，代表用户的ID。
      在Spring MVC的控制器方法中，我们可以使用@PathVariable注解来将URL路径中的{id}绑定到方法的参数上
           */
    //    根据ID删除用户
    @RequestMapping("/deleteSUserId/{sId}")
    public String deleteSUserId(@PathVariable int sId) {
        sUserService.deleteSUserId(sId);
        return "redirect: /supervision/findAllSUser";
    }


    //修改用户 根据id查询用户
    @RequestMapping("/updateSUserId/{sId}")
    public String updateSUserId(@PathVariable int sId, Model model) {

        SUser sUser = sUserService.updateSUserId(sId);
//        System.out.println(svUser);
        model.addAttribute("updateSUserdata", sUser);
        return "user/SUser/SUserUpdate";
    }


    //修改用户 更新数据
    @RequestMapping("/updateSUser")
    public String updateSUser(SUser sUser) {

//        System.out.println(tUser);
        sUserService.updateSUser(sUser);

        return "redirect: /supervision/findAllSUser";
    }


    //    查询所有学院
    @RequestMapping("/findAllCollege")
    @ResponseBody
    public List<College> findAllCollege() {
        return sUserService.findAllCollege();
    }


    //    查询所有班级
    @RequestMapping("/findAllClass")
    @ResponseBody
    public List<ClassST> findAllClass() {
        return sUserService.findAllClass();
    }


    //    批量导入学生用户 表格
    @RequestMapping("/batchImportSUser")
    public String batchImportSUser(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
        try {
            InputStream inputStream = file.getInputStream();
            Workbook workbook = WorkbookFactory.create(inputStream); // 创建 Workbook 对象
            Sheet sheet = workbook.getSheetAt(0); // 获取第一个工作
            // 获取表头行
            Row headerRow = sheet.getRow(0);
            // 读取表头名称
            List<String> columnNames = new ArrayList<>();
            for (int i = 0; i < headerRow.getLastCellNum(); i++) {
                Cell cell = headerRow.getCell(i);
                columnNames.add(cell.getStringCellValue());
            }
            // 查找表头名称所在列的索引
            int usernameIndex = columnNames.indexOf("用户名");
            int passwordIndex = columnNames.indexOf("密码");
            int studentIdIndex = columnNames.indexOf("学号");
            int nameIndex = columnNames.indexOf("姓名");
            int classIndex = columnNames.indexOf("班级");
            // 创建用于存储学生用户信息的列表
            List<UUser> studentsList = new ArrayList<>();
            List<SUser> studentInfoList = new ArrayList<>();
            List<ClassST> studentInfoListClass = new ArrayList<>();

//            角色标识
            int SuserRole = 4;
            // 遍历工作表中的行（跳过表头）
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
                Row row = sheet.getRow(i);
                if (row != null) {
                    String username = row.getCell(usernameIndex).getStringCellValue();
                    String password = row.getCell(passwordIndex).getStringCellValue();
                    int studentId = (int) row.getCell(studentIdIndex).getNumericCellValue();
                    String name = row.getCell(nameIndex).getStringCellValue();
//                    班级
                    String className = row.getCell(classIndex).getStringCellValue();
                    // 打印学生信息
//                    System.out.println("用户名: " + username + ", 密码: " + password + ", 学号: " + studentId + ", 姓名: " + name);
                    UUser uUser = new UUser();
                    uUser.setUName(username);
                    uUser.setUPassword(password);
                    uUser.setURoleNo(SuserRole);

                    studentsList.add(uUser);
                    SUser sUser = new SUser();
                    sUser.setSNo(studentId);
                    sUser.setSName(name);
                    studentInfoList.add(sUser);

//                    班级信息
                    ClassST classST = new ClassST();
                    classST.setCIName(className);
                    studentInfoListClass.add(classST);
                }
            }
            //            System.out.println("学生信息列表: " + studentInfoList);              System.out.println("学生信息列表: " + studentsList);
            System.out.println("学生信息列表: " + studentInfoListClass);
            sUserService.addStudentsList(studentsList, studentInfoList, studentInfoListClass);


            // 处理完毕后关闭文件流
            inputStream.close();
            // 返回成功信息
            return "redirect:/supervision/findAllSUser";
        } catch (Exception e) {
            // 异常处理
            e.printStackTrace();
            return "批量导入学生信息失败：" + e.getMessage();
        }
    }

    //    批量删除学生用户
//    @RequestBody 注解来告诉Spring MVC框架将请求体中的JSON数据映射到方法参数上
    @RequestMapping("/deleteSUserbatch")
    public String deleteSUserbatch(@RequestBody List<String> requestData) {

//        System.out.println(requestData);
        // 调用service层的方法删除学生用户
        sUserService.deleteSUserbatch(requestData);

        return "redirect: /supervision/findAllSUser";
    }


}


