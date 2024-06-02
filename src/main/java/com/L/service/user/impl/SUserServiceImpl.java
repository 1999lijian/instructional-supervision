package com.L.service.user.impl;

import com.L.entity.classes.ClassST;
import com.L.entity.classes.ClassStudent;
import com.L.entity.general.College;
import com.L.entity.user.SUser;
import com.L.entity.user.UUser;
import com.L.mapper.classes.ClassesMapper;
import com.L.mapper.user.SUserMapper;
import com.L.service.user.SUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/23 0:23
 */

@Service
public class SUserServiceImpl implements SUserService {


    @Autowired
    private SUserMapper sUserMapper;
    @Autowired
    private ClassesMapper classesMapper;


    @Override
    public int countSUser() {
        return sUserMapper.countSUser();
    }

    @Override
    public int countSUserAll(String sName) {
        return sUserMapper.countSUserAll(sName);
    }

    @Override
    public List<SUser> findAllSUserList(int startIndex, int pageSize) {
        return sUserMapper.findAllSUserList(startIndex, pageSize);
    }

    @Override
    public int deleteSUserId(int sId) {
        return sUserMapper.deleteSUserId(sId);
    }

    @Override
    public int addSUser(SUser sUser) {
        return sUserMapper.addSUser(sUser);
    }

    @Override
    public int addAll(UUser uUser) {
        uUser.setURoleNo(4);
        return sUserMapper.addAll(uUser);
    }

    @Override
    public SUser updateSUserId(int sId) {
        return sUserMapper.updateSUserId(sId);
    }

    @Override
    public int updateSUser(SUser sUser) {
        return sUserMapper.updateSUser(sUser);
    }

    @Override
    public List<College> findAllCollege() {
        return sUserMapper.findAllCollege();
    }

    @Override
    public List<ClassST> findAllClass() {
        return sUserMapper.findAllClass();
    }


    @Override
    public int addStudentsList(List<UUser> studentsList, List<SUser> studentInfoList, List<ClassST> studentInfoListClass) {
        //        存储班级名称ID
        List<ClassStudent> classStudentList = new ArrayList<>();
//遍历插入的班级名称
        for (ClassST classST : studentInfoListClass) {
            //  ClassST 类中有一个名为 getCIName() 的方法来获取 cIName 属性值
            String cIName = classST.getCIName();
            int classesByCINameId = classesMapper.findClassesByCINameId(cIName);
            ClassStudent classStudent = new ClassStudent();
            classStudent.setCIIdsc(classesByCINameId);
            classStudentList.add(classStudent);
        }
//存储用户表的自增ID
        List<Integer> suidList = new ArrayList<>();
        //        存入数据用户表信息
        for (UUser uUser : studentsList) {
            sUserMapper.addAllList(uUser);
            suidList.add(uUser.getUId());
        }
//        把用户表增ID存储到学生列表中
        for (int i = 0; i < studentInfoList.size(); i++) {
            studentInfoList.get(i).setSuid(suidList.get(i));
        }
//        存储学生表的自增ID
        List<Integer> sIdList = new ArrayList<>();
        //        存入数据学生表信息
        for (SUser sUser : studentInfoList) {
            sUserMapper.addSUserList(sUser);
            sIdList.add(sUser.getSId());
        }
        //        把学生表增ID存储到班级学生绑定表列表中
        int i = 0;
        for (ClassStudent student : classStudentList) {
            student.setSIdsc(sIdList.get(i));
            i++;
        }
//        存入班级学生绑定表信息
        for (ClassStudent classStudentListOn : classStudentList) {
            classesMapper.addClassStudent(classStudentListOn);
        }


        return 0;
    }

    @Override
    public int deleteSUserbatch(List<String> sId) {
        for (String sIdDet : sId) {
            int sIdInt = Integer.parseInt(sIdDet);
            sUserMapper.deleteSUserId(sIdInt);
        }

        return 0;
    }


}