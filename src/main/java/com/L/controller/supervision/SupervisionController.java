package com.L.controller.supervision;

import com.L.entity.supervision.Supervision;
import com.L.entity.util.Page;
import com.L.service.supervision.SupervisionService;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

/**
 * @Author LIJIAN
 * @Date 2024/1/16 17:23
 */
@Controller
@RequestMapping("/supervision")
public class SupervisionController {

    @Autowired
    private SupervisionService supervisionService;

    @Value("${upload.path}")
    private String rootPath;

    //    查询督导计划列表
    @RequestMapping("/findAllSupervision")
    public String findAllSupervision(HttpServletRequest request, Model model) {
        int startIndex = 0;
        int pageSize = 9;

        try {
            startIndex = Integer.parseInt(request.getParameter("page.startIndex"));  //从前台获取 开始数据的索引
            pageSize = Integer.parseInt(request.getParameter("page.pageSize"));
        } catch (Exception e) {
        }
        Page page = new Page(startIndex, pageSize);
        List<Supervision> list = supervisionService.findAllSupervisionList(startIndex, pageSize);
        int total = supervisionService.countSupervision();
        page.setTotal(total);
        model.addAttribute("page", page);
        model.addAttribute("findAllSupervisionList", list);
        return "supervision/supervision";
    }

    //跳转添加督导计划页面
    @RequestMapping("/UpSupervision")
    public String UpSupervision() {
        return "supervision/supervision_add";
    }


    //添加教学计划
    @RequestMapping("/addSupervision")
    public String addTeaching(Supervision supervision, @RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
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
        supervisionService.savaFileSupervision(originalFileName, uid, filePath);

        supervisionService.addSupervision(supervision);
        return "redirect:/supervision/findAllSupervision?target=Supervision";
    }

    //     根据id删除计划
    @RequestMapping("/deleteSupervision/{supId}")
    public String deleteSupervision(@PathVariable int supId) {
        supervisionService.deleteSupervision(supId);
        return "redirect:/supervision/findAllSupervision";
    }


    //     根据id查询返回页面值
    @RequestMapping("/updateSupervisionSuId/{supId}")
    public String updateTeachingTeId(@PathVariable int supId, Model model) {
        Supervision updateSupervisionDate = supervisionService.findSupervisionById(supId);
//        System.out.println(updateSupervisionDate);
        model.addAttribute("updateSupervisionDate", updateSupervisionDate);
        return "supervision/supervisionUpdate";
    }


    //    更新督导信息
    @RequestMapping("/updateSupervision")
    public String updateSupervision(Supervision supervision) {
//        System.out.println(supervision);
        supervisionService.updateSupervision(supervision);
        return "redirect: /supervision/findAllSupervision";
    }


    //    查看文件
    @RequestMapping("/findFileSupervision")
    public ResponseEntity<byte[]> findFileSupervision(String fUid, HttpServletRequest request) throws IOException {
//根据uid查询文件
//        uid是唯一性
        Supervision s = supervisionService.viewFileSuId(fUid);
        // 获取文件名
        String fileName = s.getSupervisionFileSava().getFName();
//        为前端是处理格式
//        在服务器端进行格式处理
        String downfilename = "";
        if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
            fileName = URLEncoder.encode(fileName, "UTF-8");
        } else {
            downfilename = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
        }
//        根据文件存储的路径 创建File对象存储
        File file = new File(s.getSupervisionFileSava().getFPath());
//        设置HTTP响应头信息
        HttpHeaders headers = new HttpHeaders();
//        设置响应头中的Content-Disposition字段，指示浏览器如何处理响应内容。在这里，将文件作为附件下载，downfilename是下载文件名。
        headers.setContentDispositionFormData("attachment", downfilename);
//        设置响应内容的Content-Type，这里指示浏览器以二进制流的形式下载文件。
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//        使用ResponseEntity对象封装响应数据，其中包括文件的字节数组作为响应主体，设置响应头信息headers
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
    }


    //    督导计划详细查看
//    supervisionInspection
    @RequestMapping("/supervisionInspection/{supId}")
    public String supervisionInspection(@PathVariable int supId, Model model) {
//        测试获取修改的信息 id
        Supervision updateSupervisionDate = supervisionService.findSupervisionById(supId);
        model.addAttribute("updateSupervisionDate", updateSupervisionDate);
        return "supervision/supercision_check";
    }



    //    批量删除学生用户
//    @RequestBody 注解来告诉Spring MVC框架将请求体中的JSON数据映射到方法参数上
    @RequestMapping("/deletesupervisionbatch")
    public String deletesupervisionbatch(@RequestBody List<String> requestData) {

//        System.out.println(requestData);
        // 调用service层的方法删除学生用户
        supervisionService.deletesupervisionbatch(requestData);

        return "redirect: /supervision/findAllAUser";
    }


}
