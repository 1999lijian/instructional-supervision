package com.L.service.course.impl;

import com.L.entity.course.*;
import com.L.entity.general.Room;
import com.L.entity.user.TUser;
import com.L.mapper.course.CourseMapper;
import com.L.service.course.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author LIJIAN
 * @Date 2024/2/23 22:38
 */
@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseMapper courseMapper;


    @Override
    public int countCourse() {
        return courseMapper.countCourse();
    }

    @Override
    public int countCourseAll(String cName) {
        return courseMapper.countCourseAll(cName);
    }

    @Override
    public List<Course> findAllCourseList(int startIndex, int pageSize) {
        return courseMapper.findAllCourseList(startIndex, pageSize);
    }

    @Override
    public int addCourse(Course course) {
        return courseMapper.addCourse(course);
    }

    @Override
    public int deletCourse(int cId) {
        return courseMapper.deletCourse(cId);
    }

    @Override
    public Course updateCourse(int cId) {
        return courseMapper.updateCourse(cId);
    }

    @Override
    public int updateCourseDate(Course course) {
        return courseMapper.updateCourseDate(course);
    }

    @Override
    public List<Score> findAllScore() {
        return courseMapper.findAllScore();
    }

    @Override
    public List<Option> findOption_ScoreById() {
        return courseMapper.findOption_ScoreById();
    }

    @Override
    public void SaveCourseEvaluateById(List<EvaluationRecords> EvaluationRecordsList) {
        courseMapper.SaveCourseEvaluateById(EvaluationRecordsList);
    }

    @Override
    public boolean checkCourseEvaluateById(int evaluationCourse, int evaluationUser) {
        if (courseMapper.checkCourseEvaluateById(evaluationCourse, evaluationUser) > 0) {
            return true; // 已经评价过
        } else {
            return false; // 没有评价过
        }
    }

    @Override
    public boolean checkCourseEvaluateByTId(int evaluationCourse) {
        if (courseMapper.checkCourseEvaluateByTId(evaluationCourse) > 0) {
            return true; // 有评价数据
        } else {
            return false; // 没有评价数据
        }
    }

    @Override
    public List<EvaluationRecords> findEvaluationRecordsById(int evaluationCourse, int evaluationUser) {
        return courseMapper.findEvaluationRecordsById(evaluationCourse, evaluationUser);
    }

    @Override
    public void UpCourseEvaluateById(EvaluationRecords evaluationRecords) {
        courseMapper.UpCourseEvaluateById(evaluationRecords);
    }


    @Override
    public int AddCourseTourClass(TourClass tourClass) {
        return courseMapper.AddCourseTourClass(tourClass);
    }

    @Override
    public int savaFileTourClass(String fName, String fUid, String fPath) {
        return courseMapper.savaFileTourClass(fName, fUid, fPath);
    }

    @Override
    public int checkRole(int uid) {
//        如果为管理员或督导员就进行全部查询
        if (courseMapper.checkRole(uid) == 1 || courseMapper.checkRole(uid) == 2) {
            return 1;
        } else if (courseMapper.checkRole(uid) == 3) {
//            教师
            return 3;
        } else {
//           学生
            return 4;
        }
    }

    @Override
    public List<Course> findAllCourseListBelong(int startIndex, int pageSize, int suid) {
        return courseMapper.findAllCourseListBelong(startIndex, pageSize, suid);
    }

    @Override
    public int countCourseBelong(int suid) {
        return courseMapper.countCourseBelong(suid);
    }

    @Override
    public List<Course> getCourseName(int cId) {
        return courseMapper.getCourseName(cId);
    }

    @Override
    public List<TUser> findAllTeacher() {
        return courseMapper.findAllTeacher();
    }

    @Override
    public List<Course> findAllCourseListTeacherList(int startIndex, int pageSize, int tuid) {
        return courseMapper.findAllCourseListTeacherList(startIndex, pageSize, tuid);
    }

    @Override
    public int findAllCourseListTeacher(int tuid) {
        return courseMapper.findAllCourseListTeacher(tuid);
    }

    @Override
    public List<Course> findCourseName() {
        return courseMapper.findCourseName();
    }

    @Override
    public void SaveCourseListen(int listencordsUserId, int listencordsCords, String listencordsList) {
        courseMapper.SaveCourseListen(listencordsUserId, listencordsCords, listencordsList);
    }

    @Override
    public boolean findCourseListen(int listencordsCords, int listencordsUserId) {

        if (courseMapper.findCourseListen(listencordsCords, listencordsUserId) > 0) {
//            有听课信息
            return true;
        } else {
//           没有听课信息
            return false;
        }
    }

    @Override
    public List<Listencords> findCourseListenDate(int listencordsCords, int listencordsUserId) {
        return courseMapper.findCourseListenDate(listencordsCords, listencordsUserId);
    }

    @Override
    public void UpCourseListen(int listencordsUserId, int listencordsCords, String listencordsList) {
        courseMapper.UpCourseListen(listencordsUserId, listencordsCords, listencordsList);
    }

    @Override
    public boolean findCourseListenT(int listencordsCords) {
        if (courseMapper.findCourseListenT(listencordsCords) > 0) {
//            有听课信息
            return true;
        } else {
//           没有听课信息
            return false;
        }
    }

    @Override
    public List<Listencords> findCourseListenVC(int listencordsCords) {
        return courseMapper.findCourseListenVC(listencordsCords);
    }

    @Override
    public List<Room> findAllRoomId() {
        return courseMapper.findAllRoomId();
    }

    @Override
    public boolean findMessageReplyAll(int messageId) {
        if (courseMapper.findMessageReplyAll(messageId) > 0) {
//            有回复信息
            return true;
        } else {
//            没有回复信息
            return false;
        }
    }

    @Override
    public MessageReply findMessageReplyId(int messageId) {
        return courseMapper.findMessageReplyId(messageId);
    }

    @Override
    public void SaveMessage(Message message) {
        courseMapper.SaveMessage(message);
    }


    @Override
    public int countMessageAll() {
        return courseMapper.countMessageAll();
    }

    @Override
    public List<Message> findMessageIdAll(int startIndex, int pageSize) {
        return courseMapper.findMessageIdAll(startIndex, pageSize);
    }

    @Override
    public int countMessageUserIdAll(int messageUserId) {
        return courseMapper.countMessageUserIdAll(messageUserId);
    }

    @Override
    public List<Message> findMessage(int messageUserId, int startIndex, int pageSize) {
        return courseMapper.findMessage(messageUserId, startIndex, pageSize);
    }

    @Override
    public int countMessageCourseIdAll(int uId) {
        return courseMapper.countMessageCourseIdAll(uId);
    }

    @Override
    public List<Message> findMessageCourseId(int uId, int startIndex, int pageSize) {
        return courseMapper.findMessageCourseId(uId, startIndex, pageSize);
    }

    @Override
    public Message findMessageId(int messageId) {
        return courseMapper.findMessageId(messageId);
    }

    @Override
    public void DeleteMessage(int messageId) {
        courseMapper.DeleteMessage(messageId);
    }

    @Override
    public void UpMessage(Message message) {
        courseMapper.UpMessage(message);
    }

    @Override
    public List<Message> findMessageList() {
        return courseMapper.findMessageList();
    }

    @Override
    public List<Message> findMessageListUid(int uid) {
        return courseMapper.findMessageListUid(uid);
    }

    @Override
    public List<Message> findMessageListUidSUser(int uid) {
        return courseMapper.findMessageListUidSUser(uid);
    }

    @Override
    public Map<String, Integer> findStatisticsSUserEvaluate(int cId) {
        Map<String, Integer> map = new HashMap<>();
        //        该课程总数人数
        int statisticsSUserEvaluateAll = courseMapper.findStatisticsSUserEvaluateAll(cId);
        map.put("总人数", statisticsSUserEvaluateAll);
        //                该课程已评价人数
        int statisticsSUserEvaluateReviewed = courseMapper.findStatisticsSUserEvaluateReviewed(cId);
        map.put("已评价", statisticsSUserEvaluateReviewed);
//                该课程未评价人数
        int statisticsSUserEvaluateNotReviewed = statisticsSUserEvaluateAll - statisticsSUserEvaluateReviewed;
        map.put("未评价", statisticsSUserEvaluateNotReviewed);
//返回map
        return map;
    }

    @Override
    public void SaveMessageReply(MessageReply messageReply) {
        courseMapper.SaveMessageReply(messageReply);
    }

    @Override
    public void UpMessageReply(int messageId, int messageState) {
        courseMapper.UpMessageReply(messageId, messageState);
    }

    @Override
    public int countCourseTourList(int tourClassCourse) {
        return courseMapper.countCourseTourList(tourClassCourse);
    }

    @Override
    public List<TourClass> findCourseTourList(int startIndex, int pageSize, int tourClassCourse) {
        return courseMapper.findCourseTourList(startIndex, pageSize, tourClassCourse);
    }

    @Override
    public boolean checkCourseTourList(int tourClassCourse) {
        if (courseMapper.checkCourseTourList(tourClassCourse) > 0) {
            return true; // 有巡查课程记录
        } else {
            return false; // 没有巡查课程记录
        }
    }

    @Override
    public int deleteCoursebatch(List<String> cId) {
        for (String cIdDet : cId) {
            int cIdInt = Integer.parseInt(cIdDet);
            courseMapper.deletCourse(cIdInt);
        }
        return 0;
    }


}
