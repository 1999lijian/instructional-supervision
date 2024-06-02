package com.L.entity.user;

import com.L.entity.general.College;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 2:38
 * 学生信息 实体
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SUser {

    //     学生ID
    private int sId;
    // 学生关联账号ID
    private int suid;
    //    学号
    private int sNo;
    //    姓名
    private String sName;
    //    性别
    private int sSex;
    //    出生年月
    private String sDate;
    //    所属学院
    private int sCollegeNo;
    //    联系电话
    private String sPhone;
    //    邮箱
    private String sEmail;
    //    QQ
    private String sQQ;
    //    备注
    private String sNotes;
    //    用户
    private UUser uUser;
    //    学院
    private College college;


}