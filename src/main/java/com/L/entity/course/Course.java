package com.L.entity.course;

import com.L.entity.general.Room;
import com.L.entity.user.TUser;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/2/23 22:22
 */

//课程
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Course {


    //    id
    private int cId;
    //    课程名称
    private String cName;
    //   学分
    private int cCredit;

    //    授课教师
    private int cTeacherId;
    //    教学教室
    private int cClassRoom;
    //    开始时间
    private String cTimeStart;
    //    结束时间
    private String cTimeEnd;

    private Room cRoom;

    private TUser tUser;

    private EvaluationRecords evaluationRecords;
    private Option option;
    private Score score;


}
