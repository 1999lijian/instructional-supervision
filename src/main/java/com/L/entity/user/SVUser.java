package com.L.entity.user;

import com.L.entity.general.College;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 2:42
 * <p>
 * 督导员 实体
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SVUser {

    //     ID
    private int svId;
    // 关联账号ID
    private int svuid;
    //    姓名
    private String svName;
    //    性别
    private int svSex;
    //    职称
    private String svTitle;
    //    所属学院
    private int svCollegeNo;
    //    督导级别
//    暂时为String类型
    private String svLevel;
    //    联系电话
    private String svPhone;
    //    邮箱
    private String svEmail;
    //    QQ
    private String svQQ;
    //    备注
    private String svNotes;


    //    用户
    private UUser uUser;
    //    学院
    private College collegeSVU;
}
