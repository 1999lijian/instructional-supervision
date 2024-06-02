package com.L.mapper.user;

import com.L.entity.general.College;
import com.L.entity.user.TUser;
import com.L.entity.user.UUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/22 0:54
 */

@Repository
public interface TUserMapper {


    //    查询所有的信息管理人员
//    分页总数
    int countTUser();

    //    查询分页总数  查询名字时
    int countTUserAll(String tName);

    //    分页
    List<TUser> findAllTUserList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);

    //    删除用户 根据id进行删除
    int deleteTUserId(int tId);

    // 添加用户（个人信息）
    int addTUser(TUser tUser);

    // 添加用户（账号密码）
    int addAll(UUser uUser);


    //    根据aId查询用户 aId
    TUser updateTUserId(int tId);

    //    修改用户 根据aId进行修改
    int updateTUser(TUser tUser);


    // 查询所有学院 提供选项
    List<College> findAllCollege();


}
