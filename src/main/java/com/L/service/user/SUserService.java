package com.L.service.user;

import com.L.entity.classes.ClassST;
import com.L.entity.general.College;
import com.L.entity.user.SUser;
import com.L.entity.user.UUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/23 0:23
 */
public interface SUserService {

    //    查询所有的用户
//    分页总数
    int countSUser();

    //    查询分页总数  查询名字时
    int countSUserAll(String sName);

    //    分页
    List<SUser> findAllSUserList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);

    //    删除用户 根据id进行删除
    int deleteSUserId(int sId);

    // 添加用户（个人信息）
    int addSUser(SUser sUser);

    // 添加用户（账号密码）
    int addAll(UUser uUser);


    //    根据aId查询用户 aId
    SUser updateSUserId(int sId);

    //    修改用户 根据aId进行修改
    int updateSUser(SUser sUser);

    // 查询所有学院 提供选项
    List<College> findAllCollege();

    // 查询所有班级 提供选项
    List<ClassST> findAllClass();


    //    批量导入学生用户（用户名、密码、学号、姓名）
    int addStudentsList(List<UUser> studentsList, List<SUser> studentInfoList, List<ClassST> studentInfoListClass);

    //    批量删除
    int deleteSUserbatch(List<String> sId);


}
