package com.L.controller.evaluate;

import com.L.entity.course.Option;
import com.L.entity.course.Score;
import com.L.entity.util.Page;
import com.L.service.evaluate.EvaluateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/19 20:01
 */
//评价管理
@Controller
@RequestMapping("/supervision")
public class EvaluateController {

    @Autowired
    private EvaluateService evaluateService;

    //    查询督导计划列表
    @RequestMapping("/findAllEvaluate")
    public String findAllEvaluate(HttpServletRequest request, Model model) {
        int startIndex = 0;
        int pageSize = 9;

        try {
            startIndex = Integer.parseInt(request.getParameter("page.startIndex"));  //从前台获取 开始数据的索引
            pageSize = Integer.parseInt(request.getParameter("page.pageSize"));
        } catch (Exception e) {

        }
        Page page = new Page(startIndex, pageSize);
        List<Option> list = evaluateService.findAllScore(startIndex, pageSize);
        int total = evaluateService.countScore();
        page.setTotal(total);
//        System.out.println(total);

//        System.out.println(list);
        model.addAttribute("page", page);
        model.addAttribute("findAllEvaluateList", list);
        return "evaluate/evaluate";
    }


    //     根据id问题删除选项
    @RequestMapping("/deleteEvaluate/{optionId}")
    public String deleteEvaluate(@PathVariable int optionId) {
        evaluateService.deleteOption(optionId);
        return "redirect:/supervision/findAllEvaluate";
    }


    //     根据id问题删除选项
    @RequestMapping("/updateEvaluateOptionId/{optionId}")
    public String updateEvaluateOptionId(@PathVariable int optionId, Model model) {
        Option option = evaluateService.findOptionById(optionId);
        model.addAttribute("optionUpDate", option);
        return "evaluate/evaluateUpdate";
    }


    //     根据id选项id 修改选项数据
    @RequestMapping("/updateEvaluateName")
    public String updateEvaluateName(Option option) {
//        System.out.println(option);
        evaluateService.updateOptionById(option);
        return "redirect:/supervision/findAllEvaluate";
    }

    //跳转添加页面
    @RequestMapping("/addEvaluateList")
    public String addEvaluateList() {
        return "evaluate/evaluate_add";
    }

    //跳转添加数据提交
    @RequestMapping("/addEvaluateDate")
    public String addEvaluateDate(@RequestParam("scoreName") String scoreName, @RequestParam("optionName") String optionName) {
//        System.out.println(scoreName + " " + optionName);
//         a  单个选项
//        a,b,c 多个选项
//        添加问题
        Score score = new Score();
        score.setScoreName(scoreName);
//        插入 并返回  id
        int scoreId = evaluateService.addScore(score);
//        System.out.println(scoreId);
        Option option = new Option();
        String[] optionNames = optionName.split(",");
        for (String optionName1 : optionNames) {
            // 在这里执行针对每个选项名称的操作
//            System.out.println(optionName1); // 每个选项名称
            option.setOptionName(optionName1);
            option.setScoreById(scoreId);
            evaluateService.addOption(option);
        }
        return "redirect:/supervision/findAllEvaluate";
    }


}
