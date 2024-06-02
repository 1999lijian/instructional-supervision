package com.L.service.classes;

import com.L.entity.classes.ClassST;
import com.L.entity.classes.ClassStudentCourse;
import com.L.entity.general.Room;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/26 9:23
 */
public interface ClassesService {


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

    //    删除班级 及 删除绑定的相关数据
    int deleteClass(int CIId);

    //    修改班级信息
    int updateClassST(ClassST classST);

}
