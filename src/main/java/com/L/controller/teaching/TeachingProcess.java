package com.L.controller.teaching;

import com.L.entity.teaching.Teaching;
import com.L.service.teaching.TeachingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author LIJIAN
 * @Date 2024/2/27 2:52
 */
@Controller
@RequestMapping("/supervision")
public class TeachingProcess {

    @Autowired
    private TeachingService teachingService;


    //     根据id查询审核的教学计划返回页面
    @RequestMapping("/updateTeachingTeIdC/{teId}")
    public String updateTeachingTeId(@PathVariable int teId, Model model) {
//        测试获取修改的信息 id
//        System.out.println(teId);
        Teaching updateTeachingDate = teachingService.findTeachingById(teId);
//        test
//        System.out.println(updateTeachingDate);

        model.addAttribute("updateTeachingDate", updateTeachingDate);
        return "teaching/teaching_check";
    }

    //    审核 功能
    @RequestMapping("/AuditingTeaching/{teId}")
    public String AuditingTeaching(@PathVariable int teId) {
        teachingService.updateTeachingState(teId, 1);

        return "redirect:/supervision/findAllTeaching";
    }


}
