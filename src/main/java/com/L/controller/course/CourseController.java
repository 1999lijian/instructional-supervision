package com.L.controller.course;

import com.L.entity.course.*;
import com.L.entity.user.TUser;
import com.L.entity.util.Page;
import com.L.service.course.CourseService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * @Author LIJIAN
 * @Date 2024/2/23 22:40
 */

@Controller
@RequestMapping("/supervision")
public class CourseController {


    @Autowired
    private CourseService courseService;
    @Value("${upload.path}")
    private String rootPath;
    private Gson gson = new Gson();

    //    查询课程列表
//    路径中不包含路径变量，而是通过查询参数传递参数。
//    通过在方法参数中使用 @RequestParam("uId") 注解，
//    Spring MVC 将会自动将查询参数 uId 的值传递给方法中的 uId 参数。
//    可以在方法中直接使用这个值进行相应的处理。


    @RequestMapping("/findAllCourse")
    public String findAllTeaching(HttpServletRequest request, Model model) {
//                获取session中的用户id
        int uId = (int) request.getSession().getAttribute("uId");
        int startIndex = 0;
        int pageSize = 9;
        try {
            startIndex = Integer.parseInt(request.getParameter("page.startIndex"));  //从前台获取 开始数据的索引
            pageSize = Integer.parseInt(request.getParameter("page.pageSize"));
        } catch (Exception e) {
        }
        Page page = new Page(startIndex, pageSize);
//        判断是否什么角色
        int checkRole = courseService.checkRole(uId);
//        如果是真就 调用 查询所有课程  管理员 督导员
        if (checkRole == 1) {
            List<Course> list = courseService.findAllCourseList(startIndex, pageSize);
            int total = courseService.countCourse();
            page.setTotal(total);
            model.addAttribute("page", page);
            model.addAttribute("findAllCourseList", list);
            Map<Integer, Boolean> courseListenMap = new HashMap<>();
            Map<Integer, Boolean> courseVCourseMap = new HashMap<>();
            Map<Integer, Boolean> courseListenTMap = new HashMap<>();
            Map<Integer, Boolean> coursePatrolMap = new HashMap<>();
            for (Course course : list) {
                //         查询是否听课评价
                boolean courseListen = courseService.findCourseListen(course.getCId(), uId);
                courseListenMap.put(course.getCId(), courseListen);
                //         查询是否听课评价
                boolean courseListenT = courseService.findCourseListenT(course.getCId());
                courseListenTMap.put(course.getCId(), courseListenT);
                //            查看是否有数据评价
                boolean courseVCourse = courseService.checkCourseEvaluateByTId(course.getCId());
                courseVCourseMap.put(course.getCId(), courseVCourse);
//                是否有巡查记录
                boolean coursePatrol = courseService.checkCourseTourList(course.getCId());
                coursePatrolMap.put(course.getCId(), coursePatrol);
            }

            model.addAttribute("courseListenMap", courseListenMap);
            model.addAttribute("courseVCourseMap", courseVCourseMap);
            model.addAttribute("courseListenTMap", courseListenTMap);
            model.addAttribute("coursePatrolMap", coursePatrolMap);

            return "course/course";
        } else if (checkRole == 3) {
//            教师
            List<Course> list = courseService.findAllCourseListTeacherList(startIndex, pageSize, uId);
            System.out.println(list);
            int total = courseService.findAllCourseListTeacher(uId);
            model.addAttribute("page", page);
            model.addAttribute("findAllCourseList", list);
            Map<Integer, Boolean> courseListenTMap = new HashMap<>();
            Map<Integer, Boolean> courseVCourseMap = new HashMap<>();
            Map<Integer, Boolean> coursePatrolMap = new HashMap<>();
            for (Course course : list) {
                //         查询是否听课评价
                boolean courseListenT = courseService.findCourseListenT(course.getCId());
                courseListenTMap.put(course.getCId(), courseListenT);
                //            查看是否有数据评价
                boolean courseVCourse = courseService.checkCourseEvaluateByTId(course.getCId());
                courseVCourseMap.put(course.getCId(), courseVCourse);

                boolean coursePatrol = courseService.checkCourseTourList(course.getCId());
                coursePatrolMap.put(course.getCId(), coursePatrol);
            }
            model.addAttribute("courseListenTMap", courseListenTMap);
            model.addAttribute("courseVCourseMap", courseVCourseMap);
            model.addAttribute("coursePatrolMap", coursePatrolMap);

            return "course/course";
        }
//      学生  如果是4就 调用 查询属于自己课程
        List<Course> list = courseService.findAllCourseListBelong(startIndex, pageSize, uId);
        int total = courseService.countCourseBelong(uId);
        page.setTotal(total);
        model.addAttribute("page", page);
        model.addAttribute("findAllCourseList", list);
//        存储是否评价的数据
        Map<Integer, Boolean> courseEvaluationMap = new HashMap<>();
        for (Course course : list) {
            boolean checkCourseEvaluateById = courseService.checkCourseEvaluateById(course.getCId(), uId);
            courseEvaluationMap.put(course.getCId(), checkCourseEvaluateById);
        }
//        {1=false, 8=true}
//        System.out.println(courseEvaluationMap);
        model.addAttribute("courseEvaluationMap", courseEvaluationMap);
        return "course/course";
    }


    //    添加用户
    @RequestMapping("/addCourse")
    public String addCourse(Course course) {
//        System.out.println(course);
        courseService.addCourse(course);
        return "redirect: /supervision/findAllCourse?target=Course";
    }


    //     根据id删除教学计划
    @RequestMapping("/deleteCourse/{cId}")
    public String deleteCourse(@PathVariable int cId) {
        courseService.deletCourse(cId);
        return "redirect: /supervision/findAllCourse";
    }


    //修改用户 根据id查询用户
    @RequestMapping("/updateCourse/{cId}")
    public String updateCourse(@PathVariable int cId, Model model) {

        Course courseDate = courseService.updateCourse(cId);
//        System.out.println(courseDate);
        model.addAttribute("updateData", courseDate);
        return "course/courseUpdate";
    }


    //修改用户 更新数据
    @RequestMapping("/updateCourseDate")
    public String updateCourseDate(Course course) {
        courseService.updateCourseDate(course);
//        System.out.println(course);
        return "redirect: /supervision/findAllCourse";
    }


    //    课程评价 根据id
    @RequestMapping("/updateCourseEvaluateById/{cId}/{uId}")
    public String updateCourseEvaluateById(@PathVariable("cId") int cId, @PathVariable("uId") int uId, Model model) {
        //        获取的课程id 和 用户id 进行判断用户是否进行了过评价
        boolean checkCourseEvaluateById = courseService.checkCourseEvaluateById(cId, uId);
        //        课程信息
        Course courseDate = courseService.updateCourse(cId);
        model.addAttribute("evaluateData", courseDate);
//        获取问题
        List<Score> scoreList = courseService.findAllScore();
        model.addAttribute("scoreList", scoreList);
        List<Option> optionList = courseService.findOption_ScoreById();
//            可以通过访问不同的键值来获取不同的选项列表
        model.addAttribute("optionList", optionList);
        if (checkCourseEvaluateById) {
            //        已评价
//                获取评价记录
            List<EvaluationRecords> evaluationRecordsById = courseService.findEvaluationRecordsById(cId, uId);
//        存储
            model.addAttribute("evaluationRecordsById", evaluationRecordsById);
//        已评价 跳转到 查看评价
            return "course/course_evaluateCheck";
        }
//        未评价的用户 转入 评价界面
        return "course/course_evaluate";
    }


    //    保存课程评价
    @RequestMapping("/SaveCourseEvaluateById")
    public String SaveCourseEvaluateById(@RequestParam LinkedHashMap<String, String> formData) {
//       课程id
        int evaluationCourse = 0;
        // 遍历Map，找到键为"CId"的值
        for (String key : formData.keySet()) {
            if (key.equals("CId")) {
                evaluationCourse = Integer.parseInt(formData.get(key));
                break;
            }
        }
//        获取用户ID
        int evaluationCourses = 0;
        for (String key : formData.keySet()) {
            if (key.equals("evaluationUser")) {
                evaluationCourses = Integer.parseInt(formData.get(key));
                break;
            }
        }
        formData.remove("CId");
        formData.remove("evaluationUser");
        List<EvaluationRecords> EvaluationRecords = new ArrayList<>();
//              剩下数据都是评价的遍历  遍历Map，将数据保存到EvaluationRecords对象中
        for (Map.Entry<String, String> entry : formData.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            EvaluationRecords evaluationRecord = new EvaluationRecords();
//            填入课程ID
            evaluationRecord.setEvaluationCourse(evaluationCourse);
            evaluationRecord.setEvaluationScore(Integer.parseInt(key));
            evaluationRecord.setEvaluationOption(Integer.parseInt(value));
            //            填入用户ID
            evaluationRecord.setEvaluationUser(evaluationCourses);
            EvaluationRecords.add(evaluationRecord);
        }
        courseService.SaveCourseEvaluateById(EvaluationRecords);
        return "redirect:/supervision/findAllCourse";
    }

    //    修改课程评价信息
    @RequestMapping("/UpCourseEvaluateById")
    public String UpCourseEvaluateById(@RequestParam LinkedHashMap<String, String> formData) {

        System.out.println(formData);
//        {CId=1, evaluationUser=4, 1=1, 2=8, 6=15}
        int evaluationCourse = 0;
        // 遍历Map，找到键为"CId"的值
        for (String key : formData.keySet()) {
            if (key.equals("CId")) {
                evaluationCourse = Integer.parseInt(formData.get(key));
                break;
            }
        }
//        获取用户ID
        int evaluationCourses = 0;
        for (String key : formData.keySet()) {
            if (key.equals("evaluationUser")) {
                evaluationCourses = Integer.parseInt(formData.get(key));
                break;
            }
        }
        formData.remove("CId");
        formData.remove("evaluationUser");

//        剩下修改的信息
        List<EvaluationRecords> EvaluationRecords = new ArrayList<>();
//              剩下数据都是评价的遍历  遍历Map，将数据保存到EvaluationRecords对象中
        for (Map.Entry<String, String> entry : formData.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            EvaluationRecords evaluationRecord = new EvaluationRecords();
//            填入课程ID
            evaluationRecord.setEvaluationCourse(evaluationCourse);
            evaluationRecord.setEvaluationScore(Integer.parseInt(key));
            evaluationRecord.setEvaluationOption(Integer.parseInt(value));
            //            填入用户ID
            evaluationRecord.setEvaluationUser(evaluationCourses);
            EvaluationRecords.add(evaluationRecord);
        }
//        [EvaluationRecords(evaluationId=0, evaluationCourse=1, evaluationScore=1, evaluationOption=1, evaluationUser=4),
//        EvaluationRecords(evaluationId=0, evaluationCourse=1, evaluationScore=2, evaluationOption=7, evaluationUser=4),
//        EvaluationRecords(evaluationId=0, evaluationCourse=1, evaluationScore=6, evaluationOption=13, evaluationUser=4)]
//        System.out.println(EvaluationRecords);
//       逐条更新
        for (EvaluationRecords record : EvaluationRecords) {
            courseService.UpCourseEvaluateById(record);
        }


        return "redirect:/supervision/findAllCourse";

    }


    //    updateCourseTourClass
//    课程巡课跳转及数据课程信息传入
    @RequestMapping("/updateCourseTourClass/{cId}")
    public String updateCourseTourClass(@PathVariable int cId, Model model) {
//        课程信息
        Course courseDate = courseService.updateCourse(cId);
        model.addAttribute("Data", courseDate);
        return "course/course_TourClass";
    }

    //    课程巡课信息
    @RequestMapping("/AddCourseTourClass")
    public String AddCourseTourClass(TourClass tourClass, @RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
        // 原始名称
        String originalFileName = file.getOriginalFilename();
        // 生成随机的uid作为新文件名
        String uid = UUID.randomUUID().toString();
        String newFileName = uid + originalFileName.substring(originalFileName.lastIndexOf("."));
        // 新文件
        File newFile = new File(rootPath + File.separator + newFileName);
        // 判断目标文件所在目录是否存在
        if (!newFile.getParentFile().exists()) {
            // 如果目标文件所在的目录不存在，则创建父目录
            newFile.getParentFile().mkdirs();
        }
        // 将内存中的数据写入磁盘
        file.transferTo(newFile);
        // 获取新文件的全路径
        String filePath = newFile.getPath();
        // 调用service层方法，将文件信息写入数据库
        courseService.savaFileTourClass(originalFileName, uid, filePath);
        courseService.AddCourseTourClass(tourClass);
        return "redirect:/supervision/findAllCourse";
    }


    //    查询所有老师
    @RequestMapping("/findAllcTeacherId")
    @ResponseBody
    public List<TUser> findAllcTeacherId() {
        return courseService.findAllTeacher();
    }


    //听课评价 跳转
    @RequestMapping("/updateCourseListening/{cId}/{uId}")
    public String updateCourseListening(@PathVariable("cId") int cId, @PathVariable("uId") int uId, Model model) {
        //        课程名称
        Course courseDate = courseService.updateCourse(cId);
        model.addAttribute("ListenData", courseDate);
        //用户名称
        model.addAttribute("ListenUId", uId);
        return "course/course_listen";
    }


    //    听课评价提交（保存）
    @RequestMapping("/updateCourseListeningDateUp")
    public String updateCourseListening(@RequestParam LinkedHashMap<String, String> formData) {
        int evaluationCourse = 0;
        // 遍历Map，找到键为"CId"的值
        for (String key : formData.keySet()) {
            if (key.equals("CId")) {
                evaluationCourse = Integer.parseInt(formData.get(key));
                break;
            }
        }
        int evaluationCourses = 0;
        // 遍历Map，找到键为"CId"的值
        for (String key : formData.keySet()) {
            if (key.equals("uId")) {
                evaluationCourses = Integer.parseInt(formData.get(key));
                break;
            }
        }
        formData.remove("CId");
        formData.remove("uId");
        // 使用Gson库将JSON数组转换为字符串
        Gson gsonop = new GsonBuilder().setPrettyPrinting().create();
        String jsonOutput = gsonop.toJson(formData);
        courseService.SaveCourseListen(evaluationCourses, evaluationCourse, jsonOutput);
        return "redirect:/supervision/findAllCourse";
    }

    //    听课查看数据
    @RequestMapping("/findCourseListenDate/{cId}/{uId}")
    public String findCourseListenDate(@PathVariable("cId") int cId, @PathVariable("uId") int uId, Model model) {
        //        课程名称
        Course courseDate = courseService.updateCourse(cId);
        model.addAttribute("ListenData", courseDate);
        model.addAttribute("ListenUId", uId);
        //        查询到听课选择数据
        List<Listencords> courseListenDate = courseService.findCourseListenDate(cId, uId);
        //       数据
        model.addAttribute("courseListenDate", courseListenDate);
        return "course/course_listenCheck";
    }


    //    听课修改数据
    @RequestMapping("/findCourseListenDateUP")
    public String findCourseListenDate(@RequestParam LinkedHashMap<String, String> formData) {
        int evaluationCourse = 0;
        // 遍历Map，找到键为"CId"的值
        for (String key : formData.keySet()) {
            if (key.equals("CId")) {
                evaluationCourse = Integer.parseInt(formData.get(key));
                break;
            }
        }
        int evaluationCourses = 0;
        // 遍历Map，找到键为"CId"的值
        for (String key : formData.keySet()) {
            if (key.equals("uId")) {
                evaluationCourses = Integer.parseInt(formData.get(key));
                break;
            }
        }
        formData.remove("CId");
        formData.remove("uId");
        // 使用Gson库将JSON数组转换为字符串
        Gson gsonop = new GsonBuilder().setPrettyPrinting().create();
        String jsonOutput = gsonop.toJson(formData);
        courseService.UpCourseListen(evaluationCourses, evaluationCourse, jsonOutput);
        return "redirect:/supervision/findAllCourse";
    }


    //    课程留言反馈
    @RequestMapping("/AddMessage/{cId}")
    public String AddMessage(@PathVariable int cId, Model model) {
//        课程信息
        Course courseDate = courseService.updateCourse(cId);
        model.addAttribute("Data", courseDate);
        return "message/message_add";
    }

    //    提交课程留言反馈
    @RequestMapping("/AddMessageSave")
    public String AddMessageSave(Message message) {
        courseService.SaveMessage(message);
        return "redirect:/supervision/findAllCourse";
    }

    //    查询属于课程留言反馈
    @RequestMapping("/findMessageId")
    public String findMessageId(HttpServletRequest request, Model model) {
//获取存入uId
        int uId = (int) request.getSession().getAttribute("uId");
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
        int total = 0;
        Page page = new Page(startIndex, pageSize);
//        查询列表信息
        List<Message> allMessageList = new ArrayList<>();
//        存储是否有回复
        List<Boolean> messageReplyAllResults = new ArrayList<>();
        int checkRole = courseService.checkRole(uId);
//        管理员 督导员
        if (checkRole == 1) {
            total = courseService.countMessageAll();
            allMessageList = courseService.findMessageIdAll(startIndex, pageSize);
        } else if (checkRole == 3) {
//            教师
            // 计算总页数
            total = courseService.countMessageCourseIdAll(uId);
//            查询
            allMessageList = courseService.findMessageCourseId(uId, startIndex, pageSize);
//            检查是否有回复
//            System.out.println(allMessageList);
            for (Message message : allMessageList) {
                int messageId = message.getMessageId();
                // 使用messageId进行接下来的操作
                boolean messageReplyAll = courseService.findMessageReplyAll(messageId);
                // 将结果存储到列表中
                messageReplyAllResults.add(messageReplyAll);
//                System.out.println("messageReplyAllResults: " + messageReplyAllResults);
            }
            model.addAttribute("messageReplyAllResults", messageReplyAllResults);
        } else if (checkRole == 4) {
//            学生
            // 计算总页数
            total = courseService.countMessageUserIdAll(uId);
            //            查询
            allMessageList = courseService.findMessage(uId, startIndex, pageSize);
        }
        page.setTotal(total);
        model.addAttribute("page", page);
        model.addAttribute("finAllMessage", allMessageList);
        return "message/message";
    }


    //    查询修改留言:跳转
    @RequestMapping("/UpMessageId/{messageId}")
    public String UpMessageId(@PathVariable int messageId, Model model) {

//        检查是否有回复信息
        boolean messageReplyAll = courseService.findMessageReplyAll(messageId);
//        如果为true  有回复信息
        if (messageReplyAll) {
//            查看留言
            Message message = courseService.findMessageId(messageId);
            model.addAttribute("Date", message);
//            查看回复信息 ：单条
            MessageReply messageReply = courseService.findMessageReplyId(messageId);
            model.addAttribute("messageReply", messageReply);
            return "message/message_replyCheck";
        }
        Message message = courseService.findMessageId(messageId);
        model.addAttribute("Date", message);
        return "message/message_up";
    }

    //    回复留言:跳转
    @RequestMapping("/UpMessageIdReply/{messageId}")
    public String UpMessageIdReply(@PathVariable int messageId, Model model) {
        Message message = courseService.findMessageId(messageId);
        model.addAttribute("Date", message);
        return "message/message_reply";
    }

    //    回复留言
    @RequestMapping("/UpMessageReplyDate")
    public String UpMessageReplyDate(MessageReply messageReply) {

        //保存回复信息
        courseService.SaveMessageReply(messageReply);
//        修改状态
        courseService.UpMessageReply(messageReply.getMessageReplyId(), 1);
        return "redirect:/supervision/findMessageId";
    }


    //删除留言
    @RequestMapping("/deleteMessageId/{messageId}")
    public String deleteMessageId(@PathVariable int messageId) {
        courseService.DeleteMessage(messageId);
        return "redirect:/supervision/findMessageId";
    }

    //    查询修改留言
    @RequestMapping("/UpMessageDate")
    public String UpMessageId(Message message) {
//        System.out.println(message);
        courseService.UpMessage(message);
        return "redirect:/supervision/findMessageId";
    }


    //    查询主页的留言列表
    @GetMapping("/findMessageList")
    @ResponseBody
    public String findMessageList(HttpServletRequest request) {
// 获取用户ID
        int uId = (int) request.getSession().getAttribute("uId");
        String json = "";
// 查询角色
        int checkRole = courseService.checkRole(uId);
// 根据用户角色查询留言列表
        List<Message> messageList = null;
        switch (checkRole) {
            case 1: // 管理员或督导员
                messageList = courseService.findMessageList();
                break;
            case 3: // 教师
                messageList = courseService.findMessageListUid(uId);
                break;
            case 4: // 学生
                messageList = courseService.findMessageListUidSUser(uId);
                break;
            default:
                // 处理其他角色或错误情况
                break;
        }
// 转换为 JSON 格式
        if (messageList != null) {
            json = gson.toJson(messageList);
        }
// 返回数据
        return json;
    }

    //    批量删除学生用户
//    @RequestBody 注解来告诉Spring MVC框架将请求体中的JSON数据映射到方法参数上
    @RequestMapping("/deleteCoursebatch")
    public String deleteCoursebatch(@RequestBody List<String> requestData) {
//        System.out.println(requestData);
        // 调用service层的方法
        courseService.deleteCoursebatch(requestData);
        return "redirect: /supervision/findAllCourse";
    }


}
