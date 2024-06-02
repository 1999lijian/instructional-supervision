package com.L.service.user;

import com.L.entity.user.AUser;
import com.L.entity.user.UUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 15:52
 */
public interface AUserService {

    //    查询所有的信息管理人员
//    分页总数
    int countAUser();

    //    查询分页总数
    int countAUserAll(String aName);

    //    分页
    List<AUser> findAllAUserList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);


    //    删除用户 根据id进行删除
    int deleteAUserId(int aId);


    // 添加用户
    int addAUser(AUser aUser);

    int addAll(UUser uUser);

    //    根据id查询用户 id
    AUser updateAUserId(int aId);


    //    修改用户 根据aId进行修改
    int updateAUser(AUser aUser);

    //    批量删除
    int deleteAUserbatch(List<String> aId);


}
