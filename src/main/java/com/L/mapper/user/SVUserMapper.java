package com.L.mapper.user;

import com.L.entity.general.College;
import com.L.entity.user.SVUser;
import com.L.entity.user.UUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/23 0:16
 */

@Repository
public interface SVUserMapper {

    //    查询所有的用户
//    分页总数
    int countSVUser();

    //    查询分页总数  查询名字时
    int countSVUserAll(String svName);

    //    分页
    List<SVUser> findAllSVUserList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);

    //    删除用户 根据id进行删除
    int deleteSVUserId(int svId);

    // 添加用户（个人信息）
    int addSVUser(SVUser svUser);

    // 添加用户（账号密码）
    int addAll(UUser uUser);


    //    根据aId查询用户 aId
    SVUser updateSVUserId(int svId);

    //    修改用户 根据aId进行修改
    int updateSVUser(SVUser svUser);


    // 查询所有学院 提供选项
    List<College> findAllCollege();


}
