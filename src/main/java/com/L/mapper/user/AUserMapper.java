package com.L.mapper.user;

import com.L.entity.user.AUser;
import com.L.entity.user.UUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 15:30
 */

@Repository
public interface AUserMapper {

    //    查询所有的信息管理人员
//    分页总数
    int countAUser();

    //    分页
    List<AUser> findAllAUserList(@Param("startIndex") int startIndex,
                                 @Param("pageSize") int pageSize);


    //    查询分页总数  查询名字时
    int countAUserAll(String aName);

    //    删除用户 根据id进行删除
    int deleteAUserId(int aId);

    // 添加用户（个人信息）
    int addAUser(AUser aUser);

    // 添加用户（账号密码）
    int addAll(UUser uUser);

    //    根据aId查询用户 aId
    AUser updateAUserId(int aId);

    //    修改用户 根据aId进行修改
    int updateAUser(AUser aUser);


}
