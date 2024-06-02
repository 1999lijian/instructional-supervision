package com.L.mapper.classes;

import com.L.entity.classes.ClassST;
import com.L.entity.classes.ClassStudent;
import com.L.entity.classes.ClassStudentCourse;
import com.L.entity.general.Room;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/26 9:17
 */
@Repository
public interface ClassesMapper {


    //    分页总数
    int countClasses();

    //    查询分页总数
    int countClassesAll(String cIName);

    //    分页
    List<ClassST> findAllClassesList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);


    //    教室
    //    分页
    List<Room> findAllRoomList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);

    //    分页总数
    int countRoom();

    //    查询班级名称
    ClassST findClassesByCIName(int CIId);

    //    根据班级id查询绑定课程
    List<ClassStudentCourse> findClassesByClassStudentCourse(@Param("CIId") int CIId);

    //    提交课程
    //    根据班级id查询绑定课程
    List<String> findClassesByClassStudentCourseP(@Param("CIId") int CIId);

    //    添加班级课程
    int addClassStudentCourse(ClassStudentCourse classStudentCourse);

    //    获取修改教室信息
    Room findRoomByRId(int roomId);

    //    修改教室 根据进行ID修改
    int updateRoom(Room room);

    //删除教室
    int deleteRoom(int roomId);

    //    添加教室
    int addRoom(Room room);

    //    添加班级
    int addClasses(ClassST classST);

    //  删除班级
    int deleteClass(int CIId);

    //   删除相关绑定的数据 ： 学生
    int deleteClassStudent(int CIId);

    //   删除相关绑定的数据 ： 课程
    int deleteClassCourse(int CIId);

    //    根据班级名称查询ID
    int findClassesByCINameId(String cIName);

    //    班级绑定学生ID
    int addClassStudent(ClassStudent classStudent);

    //    修改班级信息
    int updateClassST(ClassST classST);
}

