package com.L.entity.course;

import com.L.entity.util.File;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/3/8 9:35
 */

//巡课
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TourClass {
    //ID
    private int tourClassId;
    //    督导员ID
    private int tourClassUser;
    //        课程ID
    private int tourClassCourse;
    //    课程纪律
    private String tourClassDiscipline;
    //    巡查内容
    private String tourClassContent;
    //    巡查时间
    private String tourClassTime;
    //    巡查照片ID
    private int tourClassPhoto;

    private Course courseTourClass;
    private File fileTourClass;


}
