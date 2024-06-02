package com.L.controller.teaching;

import com.L.entity.teaching.Teaching;
import com.L.entity.util.Page;
import com.L.service.course.CourseService;
import com.L.service.teaching.TeachingService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @Author LIJIAN
 * @Date 2024/1/16 17:23
 */
@Controller
@RequestMapping("/supervision")
public class TeachingController {

    @Autowired
    private TeachingService teachingService;
    @Autowired
    private CourseService courseService;

    @Value("${upload.path}")
    private String rootPath;

    //    查询教学计划列表
    @RequestMapping("/findAllTeaching")
    public String findAllTeaching(HttpServletRequest request, Model model) {
        int startIndex = 0;
        int pageSize = 9;
        try {
            startIndex = Integer.parseInt(request.getParameter("page.startIndex"));  //从前台获取 开始数据的索引
            pageSize = Integer.parseInt(request.getParameter("page.pageSize"));
        } catch (Exception e) {
        }
        // 获取用户ID
        int uId = (int) request.getSession().getAttribute("uId");

// 查询角色
        int checkRole = courseService.checkRole(uId);
        Page page = new Page(startIndex, pageSize);
        int total = 0;
        List<Teaching> list = new ArrayList<>();

        switch (checkRole) {
            case 1: // 管理员或督导员
//                查询所有教学计划
                list = teachingService.findAllTeachingList(startIndex, pageSize);
                total = teachingService.countTeaching();
                page.setTotal(total);
                break;
            case 3: // 教师
//                查询属于自己编写的教学计划
                list = teachingService.findAllTeachingListTUserId(startIndex, pageSize, uId);
                total = teachingService.countTeachingTUserId(uId);
                page.setTotal(total);
                break;
        }

        model.addAttribute("page", page);
        model.addAttribute("findAllTeachingList", list);


        return "teaching/teaching";
    }


    //跳转添加教学计划页面
    @RequestMapping("/UpTeaching")
    public String UpTeaching() {
        return "teaching/teaching_add";
    }

    //添加教学计划
    @RequestMapping("/addTeaching")
    public String addTeaching(Teaching teaching, @RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
        //        System.out.println(teaching);
        // uploads文件夹位置
        // 原始名称
        String originalFileName = file.getOriginalFilename();
        // 生成随机的uid作为新文件名
        String uid = UUID.randomUUID().toString();
        String newFileName = uid + originalFileName.substring(originalFileName.lastIndexOf("."));
        File newFile = new File(rootPath + File.separator + newFileName);
        // 判断目标文件所在目录是否存在
        if (!newFile.getParentFile().exists()) {
            // 如果目标文件所在的目录不存在，则创建父目录
            newFile.getParentFile().mkdirs();
        }
        //        测试显示上传完整路径
        //        System.out.println(newFile);
        // 将内存中的数据写入磁盘
        file.transferTo(newFile);
        // 获取新文件的全路径
        String filePath = newFile.getPath();
        // 调用service层方法，将文件信息写入数据库
        teachingService.savaFileTeaching(originalFileName, uid, filePath);
        teachingService.addTeaching(teaching);
        return "redirect:/supervision/findAllTeaching?target=Teaching";
    }


    /*
      @PathVariable是一个Spring MVC注解，用于将URL路径中的参数绑定到方法的参数上。
        例如，假设我们有以下的请求URL：
       GET /users/{id}
          其中，{id}是一个占位符，代表用户的ID。
         在Spring MVC的控制器方法中，我们可以使用@PathVariable注解来将URL路径中的{id}绑定到方法的参数上
            */
    //     根据id删除教学计划
    @RequestMapping("/deleteTeaching/{teId}")
    public String deleteTeaching(@PathVariable int teId) {
        teachingService.deleteTeaching(teId);
        return "redirect:/supervision/findAllTeaching";
    }

    //     根据id查询教学计划返回页面值
    @RequestMapping("/updateTeachingTeId/{teId}")
    public String updateTeachingTeId(@PathVariable int teId, Model model) {
//        测试获取修改的信息 id
//        System.out.println(teId);
        Teaching updateTeachingDate = teachingService.findTeachingById(teId);
//        test
//        System.out.println(updateTeachingDate);
        model.addAttribute("updateTeachingDate", updateTeachingDate);
        return "teaching/teachingUpdate";
    }


    //    查看文件
    @RequestMapping("/findFileTeaching")
    public ResponseEntity<byte[]> findFileTeaching(String fUid, HttpServletRequest request) throws IOException {

//根据uid查询文件
//        uid是唯一性
        Teaching s = teachingService.viewFileTeId(fUid);
//        System.out.println(s);
//        test:文件是否存在
//        if (file.exists()) {
//            System.out.println("文件存在");
//        } else {
//            System.out.println("文件不存在");
//        }
        // 获取文件名
        String fileName = s.getFileSava().getFName();
//        为前端是处理格式
//        在服务器端进行格式处理
        String downfilename = "";
        if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
            fileName = URLEncoder.encode(fileName, "UTF-8");
        } else {
            downfilename = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
        }
//        根据文件存储的路径 创建File对象存储
        File file = new File(s.getFileSava().getFPath());
//        设置HTTP响应头信息
        HttpHeaders headers = new HttpHeaders();
//        设置响应头中的Content-Disposition字段，指示浏览器如何处理响应内容。在这里，将文件作为附件下载，downfilename是下载文件名。
        headers.setContentDispositionFormData("attachment", downfilename);
//        设置响应内容的Content-Type，这里指示浏览器以二进制流的形式下载文件。
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//        使用ResponseEntity对象封装响应数据，其中包括文件的字节数组作为响应主体，设置响应头信息headers
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
    }


    //    @RequestParam的required属性设置为false，即可使file参数成为可选参数。
//    这样，即使请求中没有文件上传字段，方法也能够正常执行。
//    如果请求中包含文件上传字段，Spring MVC会将其绑定到file参数中；
//    如果请求中没有文件上传字段，file参数将为null。
//这种方法避免了对当前请求的multipart检查，并允许您在方法中处理可选的文件上传
//    更新教学计划信息
    @RequestMapping("/updateTeaching")
    public String updateTeaching(Teaching teaching, @RequestParam(value = "file", required = false) MultipartFile file) throws IOException {
        if (file != null && !file.isEmpty()) {
            // 用户选择了文件
            String originalFileName = file.getOriginalFilename();
            String uid = UUID.randomUUID().toString();
            String newFileName = uid + originalFileName.substring(originalFileName.lastIndexOf("."));
            File newFile = new File(rootPath + File.separator + newFileName);
            if (newFile.getParentFile() != null) {
                if (!newFile.getParentFile().exists()) {
                    newFile.getParentFile().mkdirs();
                }
                file.transferTo(newFile);
                String filePath = newFile.getPath();
                com.L.entity.util.File file1 = new com.L.entity.util.File();
                file1.setFName(originalFileName);
                file1.setFPath(filePath);
                file1.setFUid(uid);
                int fileTeachingPNum = teachingService.savaFileTeachingP(file1);
                teaching.setTFile(fileTeachingPNum);
            } else {
                // 处理newFile.getParentFile()为null的情况
            }
        } else {
            // 用户未选择文件，或文件为空
        }

//        System.out.println(file);
//        System.out.println(teaching);



        // 更新教学计划信息
        teachingService.updateTeaching(teaching);

        return "redirect:/supervision/findAllTeaching?target=Teaching";
    }
}
