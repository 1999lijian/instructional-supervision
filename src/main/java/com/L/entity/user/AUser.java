package com.L.entity.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * <p>
 * 管理员基本信息类
 */

/*
@Data
@NoArgsConstructor
@AllArgsConstructor 注解是用于生成 JavaBean 类的 getter、setter 方法、equals 方法、hashCode 方法、toString 方法等的常用注解。



@Data 注解可以简化我们在类中编写大量的 getter、setter 方法的工作，只需要在类上添加 @Data 注解，就可以自动生成相应的方法。
@NoArgsConstructor 注解是生成无参构造方法，用于创建对象时不需要传入参数。
@AllArgsConstructor 注解是生成全参构造方法，用于创建对象时需要传入所有参数。
*/

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AUser {

    //    管理员ID
    private int aId;
    //管理员关联账号ID
    private int auid;
    //    管理员姓名
    private String aName;
    //    所属部门
    private int aDepartmentNo;
    //    联系电话
    private String aPhone;
    //    邮箱
    private String aEmail;
    //    QQ
    private String aQQ;
    //    备注
    private String aNotes;

//    用户
    private UUser uUser;



}
