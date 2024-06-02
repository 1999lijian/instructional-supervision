package com.L.controller.course;

import com.L.entity.course.Course;
import com.L.entity.course.Listencords;
import com.L.entity.course.Score;
import com.L.entity.user.RRole;
import com.L.service.course.CourseService;
import com.L.service.evaluate.EvaluateService;
import com.L.service.teaching.TeachingService;
import com.L.service.user.UUserService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author LIJIAN
 * @Date 2024/3/18 23:34
 */
@Controller
@RequestMapping("/supervision")
public class VisualizationController {
    @Autowired
    private CourseService courseService;

    @Autowired
    private EvaluateService evaluateService;

    @Autowired
    private UUserService uUserService;

    @Autowired
    private TeachingService teachingService;


    @Value("${upload.path}")
    private String rootPath;

    private Gson gson = new Gson();

    //    课程评价可视化 进行跳转到 显示可视化页面
    @RequestMapping("/VCourse/{cId}")
    public String VCourse(@PathVariable int cId, Model model) {

//        获得课程的数据 id
//        获得课程的数据 课程名 及 评价的内容及选项
        List<Course> date = courseService.getCourseName(cId);
//获取课程名称
        if (!date.isEmpty()) {
//            特定索引位置的 cName 值
            String CourseName = date.get(0).getCName();
//            获得第一个的值
//            存储
            model.addAttribute("CourseName", CourseName);
        }
//        统计数量
        Map<String, Map<String, Integer>> scoreOptionCount = new HashMap<>();
        for (Course course : date) {
            String scoreName = course.getScore().getScoreName();
            String optionName = course.getOption().getOptionName();
            if (!scoreOptionCount.containsKey(scoreName)) {
                scoreOptionCount.put(scoreName, new HashMap<>());
            }
            Map<String, Integer> options = scoreOptionCount.get(scoreName);
            options.put(optionName, options.getOrDefault(optionName, 0) + 1);
        }
        // 创建一个JSON数组来存储所有评分项和选项计数
        JsonArray jsonArray = new JsonArray();
        // 遍历scoreOptionCount映射
        for (Map.Entry<String, Map<String, Integer>> entry : scoreOptionCount.entrySet()) {
            String scoreName = entry.getKey();
            Map<String, Integer> options = entry.getValue();
            JsonObject scoreObject = new JsonObject();
            scoreObject.addProperty("scoreName", scoreName);
            JsonArray optionsArray = new JsonArray();
            for (Map.Entry<String, Integer> optionEntry : options.entrySet()) {
                JsonObject optionObject = new JsonObject();
                optionObject.addProperty("optionName", optionEntry.getKey());
                optionObject.addProperty("count", optionEntry.getValue());
                optionsArray.add(optionObject);
            }
            scoreObject.add("options", optionsArray);
            jsonArray.add(scoreObject);
        }
        // 使用Gson库将JSON数组转换为字符串
        Gson gsonop = new GsonBuilder().setPrettyPrinting().create();
        String jsonOutput = gsonop.toJson(jsonArray);
        model.addAttribute("jsonOutput", jsonOutput);
        //    统计学生评价的未评价 和 已评价人数 功能
        Map<String, Integer> statisticsSUserEvaluate = courseService.findStatisticsSUserEvaluate(cId);
        String statisticsSUserEvaluateJson = gsonop.toJson(statisticsSUserEvaluate);
        model.addAttribute("statisticsSUserEvaluateJson", statisticsSUserEvaluateJson);
        return "course/course_visualization";
    }

    //    听课课程评价可视化 进行跳转到 显示可视化页面
    @RequestMapping("/VCourseListen/{cId}")
    public String VCourseListen(@PathVariable int cId, Model model) {
        // 查询听课的数据
        List<Listencords> courseListenVC = courseService.findCourseListenVC(cId);
        // 获取评价的数据
        // 初始化一个用于统计值出现次数的 Map
        Map<String, Map<String, Integer>> keyToValueCounts = new HashMap<>();
        for (Listencords listencords : courseListenVC) {
            String listencordsListString = listencords.getListencordsList();
            // 使用 Gson 将 JSON 字符串转换为 Map<String, String>
            Map<String, String> listencordsMap = gson.fromJson(listencordsListString, new TypeToken<Map<String, String>>() {
            }.getType());
            // 遍历评价数据中的键值对
            for (Map.Entry<String, String> entry : listencordsMap.entrySet()) {
                String key = entry.getKey();
                String value = entry.getValue();
                // 检查 key 是否以 "exampleRadios" 开头
                if (key.startsWith("exampleRadios")) {
                    // 检查 key 是否在 keyToValueCounts 中存在，如果不存在则添加
                    if (!keyToValueCounts.containsKey(key)) {
                        keyToValueCounts.put(key, new HashMap<>());
                    }
                    // 获取当前 key 对应的值出现次数 Map
                    Map<String, Integer> valueCounts = keyToValueCounts.get(key);
                    // 统计每个键对应值的出现次数
                    if (valueCounts.containsKey(value)) {
                        valueCounts.put(value, valueCounts.get(value) + 1);
                    } else {
                        valueCounts.put(value, 1);
                    }
                }
            }
        }
        // 输出每个键对应值的出现次数
        for (Map.Entry<String, Map<String, Integer>> keyEntry : keyToValueCounts.entrySet()) {
            String key = keyEntry.getKey();
            Map<String, Integer> valueCounts = keyEntry.getValue();
        }
        for (Map<String, Integer> valueCounts : keyToValueCounts.values()) {
            for (String key : new String[]{"优秀", "良好", "中等", "差"}) {
                valueCounts.putIfAbsent(key, 0);
            }
        }
        String keyToValueCountsJson = gson.toJson(keyToValueCounts);
//    列表来存储每个键对应的值
        List<Integer> youxiuValues = new ArrayList<>();
        List<Integer> GoodValues = new ArrayList<>();
        List<Integer> SecondaryValues = new ArrayList<>();
        List<Integer> DifferenceValues = new ArrayList<>();
// 输出每个键对应值的出现次数
        for (int i = 1; i <= 13; i++) {
            String key = "exampleRadios" + i;
            Map<String, Integer> valueCounts = keyToValueCounts.get(key);
            if (valueCounts != null) {
                int excellentCount = valueCounts.getOrDefault("优秀", 0);
                int excellentCountGood = valueCounts.getOrDefault("良好", 0);
                int excellentCountSecondary = valueCounts.getOrDefault("中等", 0);
                int excellentCountDifference = valueCounts.getOrDefault("差", 0);
                youxiuValues.add(excellentCount);
                GoodValues.add(excellentCountGood);
                SecondaryValues.add(excellentCountSecondary);
                DifferenceValues.add(excellentCountDifference);
            }
        }
//        [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
//        传出 数值
        model.addAttribute("youxiuValues", youxiuValues);
        model.addAttribute("GoodValues", GoodValues);
        model.addAttribute("SecondaryValues", SecondaryValues);
        model.addAttribute("DifferenceValues", DifferenceValues);
        return "course/course_visualization_listen";
    }


    //    统计各个角色人数
    //在 Spring MVC 控制器中使用 @ResponseBody 注解来直接返回 JSON 数据，
// 可以修改您的控制器方法以便返回 JSON 数据而不是视图
    @GetMapping("/VUserNumber")
    @ResponseBody
    public String VUserNumber() {
        List<RRole> rRoles = uUserService.countRole();
        // 创建一个Map来存储角色和出现次数的对应关系
        Map<String, Integer> roleCountMap = new HashMap<>();
        // 遍历角色列表，统计每个角色出现的次数
        for (RRole rRole : rRoles) {
            String role = rRole.getRRole();
            roleCountMap.put(role, roleCountMap.getOrDefault(role, 0) + 1);
        }
        // 将 Map 转换为 JSON
        String userNumber = gson.toJson(roleCountMap);
// 返回数据
        return userNumber;
    }


    //    审核情况数据可视化
    @GetMapping("/VAuditing")
    @ResponseBody
    public String VAuditing() {
        List<Map<String, String>> allTeachingState = teachingService.findAllTeachingState();
        // 测试
//        System.out.println(allTeachingState);
//转为 json
        String json = gson.toJson(allTeachingState);
// 返回数据
        return json;
    }


    //    学生数据可视化的问题列表
    @GetMapping("/VDateProblem")
    @ResponseBody
    public List<Score> VDateProblem() {
        return evaluateService.findScoreByName();
    }

}
