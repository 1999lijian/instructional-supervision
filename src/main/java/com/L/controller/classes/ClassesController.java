package com.L.controller.classes;

import com.L.entity.classes.ClassST;
import com.L.entity.classes.ClassStudentCourse;
import com.L.entity.course.Course;
import com.L.entity.util.Page;
import com.L.service.classes.ClassesService;
import com.L.service.course.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/26 9:13
 */
@Controller
@RequestMapping("/supervision")
public class ClassesController {


    @Autowired
    private ClassesService classesService;
    @Autowired
    private CourseService courseService;


    //    查询班级列表
    @RequestMapping("/findAllClasses")
    public String findAllClasses(HttpServletRequest request, Model model) {
        int startIndex = 0;
        int pageSize = 9;

        try {
            startIndex = Integer.parseInt(request.getParameter("page.startIndex"));  //从前台获取 开始数据的索引
            pageSize = Integer.parseInt(request.getParameter("page.pageSize"));
        } catch (Exception e) {

        }
        Page page = new Page(startIndex, pageSize);
        List<ClassST> list = classesService.findAllClassesList(startIndex, pageSize);
        int total = classesService.countClasses();
        page.setTotal(total);

        model.addAttribute("page", page);
        model.addAttribute("findAllClassesList", list);
        return "classes/classes";
    }

    //    加入课程
    @RequestMapping("/addClasses/{CIId}")
    public String addClasses(@PathVariable int CIId, Model model) {

        ClassST classesByCIName = classesService.findClassesByCIName(CIId);

        //        绑定课程的数据
        List<ClassStudentCourse> classesByClassStudentCourse = classesService.findClassesByClassStudentCourse(CIId);
        System.out.println(classesByClassStudentCourse);
        model.addAttribute("classesDate", classesByCIName);
        model.addAttribute("classesByClassStudentCourse", classesByClassStudentCourse);

        return "classes/classes_add";
    }

    //    查询所有课程名称
    @RequestMapping("/findAllCourseName")
    @ResponseBody
    public List<Course> findAllCourse() {
        return courseService.findCourseName();
    }

    //    提交课程
    @RequestMapping("/addClassesSubmit")
    public String addClassesSubmit(@RequestParam("cIIdcc") int cIIdcc, @RequestParam("sIdcc") List<String> sIdccList) {
//        查询已将添加
        List<String> classesByClassStudentCourse = classesService.findClassesByClassStudentCourseP(cIIdcc);
//        System.out.println(classesByClassStudentCourse);
//移除相同
        sIdccList.removeAll(classesByClassStudentCourse);
//        System.out.println(sIdccList);

        ClassStudentCourse classStudentCourse = new ClassStudentCourse();
//        班级ID
        classStudentCourse.setCIIdcc(cIIdcc);
//        遍历加入的课程
        for (String sIdcc : sIdccList) {
//            添加课程ID
            classStudentCourse.setSIdcc(Integer.parseInt(sIdcc));
            classesService.addClassStudentCourse(classStudentCourse);
        }
        return "redirect:/supervision/findAllClasses";
    }


    //    //    修改教室信息 ：跳转
//    @RequestMapping("/updateRoom/{roomId}")
//    public String updateRoom(@PathVariable int roomId, Model model) {
//        Room roomByRId = classesService.findRoomByRId(roomId);
//        model.addAttribute("roomByRId", roomByRId);
//        return "classes/roomUpdate";
//    }
//
//    //修改教室 更新数据
//    @RequestMapping("/updateRoomId")
//    public String updateUser(Room room) {
//        classesService.updateRoom(room);
//        return "redirect: /supervision/findAllRoom";
//    }
//
    //    删除班级信息
    @RequestMapping("/deleteClass/{CIId}")
    public String deleteClass(@PathVariable int CIId) {
        classesService.deleteClass(CIId);
        return "redirect: /supervision/findAllRoom";
    }


    //    添加教室
    @RequestMapping("/addClass")
    public String addClass(ClassST classST) {
        classesService.addClasses(classST);
        return "redirect:/supervision/findAllClasses";
    }


    //    修改班级信息 ：跳转
    @RequestMapping("/updateClasses/{CIId}")
    public String updateClasses(@PathVariable int CIId, Model model) {
        ClassST classesByCIName = classesService.findClassesByCIName(CIId);
        model.addAttribute("classesByCIName", classesByCIName);
        return "classes/classUpdate";
    }


    //修改班级 更新数据
    @RequestMapping("/updateClasses")
    public String updateUser(ClassST classST) {
        classesService.updateClassST(classST);
        return "redirect: /supervision/findAllClasses";
    }


}
