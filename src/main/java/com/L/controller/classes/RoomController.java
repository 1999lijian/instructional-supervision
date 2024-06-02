package com.L.controller.classes;

import com.L.entity.general.Room;
import com.L.entity.util.Page;
import com.L.service.classes.ClassesService;
import com.L.service.course.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/26 9:38
 */
@Controller
@RequestMapping("/supervision")
public class RoomController {


    @Autowired
    private ClassesService classesService;
    @Autowired
    private CourseService courseService;


    //    查询班级列表
    @RequestMapping("/findAllRoom")
    public String findAllRoom(HttpServletRequest request, Model model) {
        int startIndex = 0;
        int pageSize = 9;
        try {
            startIndex = Integer.parseInt(request.getParameter("page.startIndex"));  //从前台获取 开始数据的索引
            pageSize = Integer.parseInt(request.getParameter("page.pageSize"));
        } catch (Exception e) {
        }
        Page page = new Page(startIndex, pageSize);
        List<Room> list = classesService.findAllRoomList(startIndex, pageSize);
        int total = classesService.countRoom();
        page.setTotal(total);
        model.addAttribute("page", page);
        model.addAttribute("findAllRoomList", list);
        return "classes/room";
    }


    //    查询所有教室
    @RequestMapping("/findAllRoomId")
    @ResponseBody
    public List<Room> findAllRoomId() {
        return courseService.findAllRoomId();
    }


    //    修改教室信息 ：跳转
    @RequestMapping("/updateRoom/{roomId}")
    public String updateRoom(@PathVariable int roomId, Model model) {
        Room roomByRId = classesService.findRoomByRId(roomId);
        model.addAttribute("roomByRId", roomByRId);
        return "classes/roomUpdate";
    }

    //修改教室 更新数据
    @RequestMapping("/updateRoomId")
    public String updateUser(Room room) {
        classesService.updateRoom(room);
        return "redirect: /supervision/findAllRoom";
    }

    //    删除教室信息 ：跳转
    @RequestMapping("/deleteRoom/{roomId}")
    public String deleteRoom(@PathVariable int roomId) {
        classesService.deleteRoom(roomId);
        return "redirect: /supervision/findAllRoom";
    }

//    addRoom

    //    添加教室
    @RequestMapping("/addRoom")
    public String addRoom(Room room) {

        classesService.addRoom(room);

        return "redirect:/supervision/findAllRoom";
    }

}
