package com.L.mapper.user;

import com.L.entity.user.RRole;
import com.L.entity.user.UUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 3:00
 */
@Repository
public interface UUserMapper {
    // 用户登录
    UUser login(@Param("uName") String uName, @Param("uPassword") String uPassword);

    //查询个人信息
    UUser UserId(int uId);

    //    更新个人信息
    void upUserId(Map<String, String> userMap);

    //    修改密码
    void upUserPassword(@Param("uId") int uId, @Param("uPassword") String uPassword);

    //    统计各个角色人数
    List<RRole> countRole();


}
