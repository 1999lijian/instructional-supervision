package com.L.entity.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 2:49
 * 用户实体类
 */



@Data
@NoArgsConstructor
@AllArgsConstructor
public class UUser {
    //    用户ID
    private int uId;
    //    用户登录
    private String uName;
//        用户唯一标识
    private String uIds;
    //    用户密码
    private String uPassword;
    //   角色id
    private int uRoleNo;
    //    角色
    private RRole rRole;

    private SUser sUser;
    private  TUser tUser;
    private  SVUser svUser;
    private  AUser aUser;





}