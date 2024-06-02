package com.L.service.classes.Impl;

import com.L.entity.classes.ClassST;
import com.L.entity.classes.ClassStudentCourse;
import com.L.entity.general.Room;
import com.L.mapper.classes.ClassesMapper;
import com.L.service.classes.ClassesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/26 9:24
 */
@Service
public class ClassesServiceImpl implements ClassesService {

    @Autowired
    private ClassesMapper classesMapper;


    @Override
    public int countClasses() {
        return classesMapper.countClasses();
    }

    @Override
    public int countClassesAll(String cIName) {
        return classesMapper.countClassesAll(cIName);
    }

    @Override
    public List<ClassST> findAllClassesList(int startIndex, int pageSize) {
        return classesMapper.findAllClassesList(startIndex, pageSize);
    }

    @Override
    public List<Room> findAllRoomList(int startIndex, int pageSize) {
        return classesMapper.findAllRoomList(startIndex, pageSize);
    }

    @Override
    public int countRoom() {
        return classesMapper.countRoom();
    }

    @Override
    public ClassST findClassesByCIName(int CIId) {
        return classesMapper.findClassesByCIName(CIId);
    }

    @Override
    public List<ClassStudentCourse> findClassesByClassStudentCourse(int CIId) {
        return classesMapper.findClassesByClassStudentCourse(CIId);
    }

    @Override
    public List<String> findClassesByClassStudentCourseP(int CIId) {
        return classesMapper.findClassesByClassStudentCourseP(CIId);
    }

    @Override
    public int addClassStudentCourse(ClassStudentCourse classStudentCourse) {
        return classesMapper.addClassStudentCourse(classStudentCourse);
    }

    @Override
    public Room findRoomByRId(int roomId) {
        return classesMapper.findRoomByRId(roomId);
    }

    @Override
    public int updateRoom(Room room) {
        return classesMapper.updateRoom(room);
    }

    @Override
    public int deleteRoom(int roomId) {
        return classesMapper.deleteRoom(roomId);
    }

    @Override
    public int addRoom(Room room) {
        return classesMapper.addRoom(room);
    }

    @Override
    public int addClasses(ClassST classST) {
        return classesMapper.addClasses(classST);
    }

    @Override
    public int deleteClass(int CIId) {
//        删除绑定学生
        classesMapper.deleteClassStudent(CIId);
        //        删除绑定课程
        classesMapper.deleteClassCourse(CIId);
        return classesMapper.deleteClass(CIId);

    }

    @Override
    public int updateClassST(ClassST classST) {
        return classesMapper.updateClassST(classST);
    }
}
