package com.L.controller.course;

import com.L.entity.course.TourClass;
import com.L.entity.util.Page;
import com.L.service.course.CourseService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/4/25 22:17
 * <p>
 * 课程巡查控制层
 */
@Controller
@RequestMapping("/supervision")
public class CourseTourController {

    @Autowired
    private CourseService courseService;
    @Value("${upload.path}")
    private String rootPath;
    private Gson gson = new Gson();

    //    详细巡查课程细看：跳转
    @RequestMapping("/findCourseTourList/{cId}")
    public String findCourseTourList(@PathVariable int cId, Model model, HttpServletRequest request) {

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
        int total = courseService.countCourseTourList(cId);
        // 计算总页数
        Page page = new Page(startIndex, pageSize);
        page.setTotal(total);
        List<TourClass> courseTourList = courseService.findCourseTourList(startIndex, pageSize, cId);
// 文件路径处理
        for (TourClass tourClass : courseTourList) {
//            获取数据存储路径
            String fPath = tourClass.getFileTourClass().getFPath();
            // 图片资源根路径 服务器端
            String imagePathRoot = "http://localhost:8080/static/upload/";
            // 将本地路径转换成相对路径
            String relativePath = fPath.replace("G:\\project\\SSM_test\\web\\static\\upload\\", "");
//            System.out.println("相对路径：" + relativePath);
// 拼接成完整的URL
            String imageUrl = imagePathRoot + relativePath;
            // 将处理后的URL设置回TourClass对象中
            tourClass.getFileTourClass().setFPath(imageUrl);

        }

//        System.out.println(courseTourList);

        model.addAttribute("page", page);
//        System.out.println(courseTourList);
        model.addAttribute("courseTourList", courseTourList);


        return "course/courseTourList";
    }


}
