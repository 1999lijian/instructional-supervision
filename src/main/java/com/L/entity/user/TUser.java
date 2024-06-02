package com.L.entity.user;

import com.L.entity.general.College;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 2:46
 * 教师 实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TUser {

    //     ID
    private int tId;
    // 关联账号ID
    private int tuid;
    //    姓名
    private String tName;
    //    性别
    private int tSex;
    //    职称
    private String tTitle;
    //    所属学院
    private int tCollegeNo;
    //    所教课程
    private int tCourseNo;
    //    联系电话
    private String tPhone;
    //    邮箱
    private String tEmail;
    //    QQ
    private String tQQ;
    //    备注
    private String tNotes;
    //    用户
    private UUser uUser;


    //    学院
    private College collegeTU;


}



