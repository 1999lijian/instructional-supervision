package com.L.service.course;

import com.L.entity.course.*;
import com.L.entity.general.Room;
import com.L.entity.user.TUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author LIJIAN
 * @Date 2024/2/23 22:37
 */
public interface CourseService {


    //    分页总数
    int countCourse();

    //    查询分页总数
    int countCourseAll(String cName);

    //    分页
    List<Course> findAllCourseList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);


    //    添加课程
    int addCourse(Course course);

    //    根据id删除课程
    int deletCourse(int cId);

    //        根据id查询课程
    Course updateCourse(int cId);


    int updateCourseDate(Course course);


    //   课程评价 查询问题
    List<Score> findAllScore();

    //根据问题id查询选项
    List<Option> findOption_ScoreById();

    //    提交评价记录
    void SaveCourseEvaluateById(List<EvaluationRecords> EvaluationRecordsList);

    //检查是否有评价信息
    boolean checkCourseEvaluateById(@Param("evaluationCourse") int evaluationCourse,
                                    @Param("evaluationUser") int evaluationUser);

//    教师检查是否有评价信息数据可视化

    boolean checkCourseEvaluateByTId(@Param("evaluationCourse") int evaluationCourse);


    //    查询已评价信息
    List<EvaluationRecords> findEvaluationRecordsById(@Param("evaluationCourse") int evaluationCourse,
                                                      @Param("evaluationUser") int evaluationUser);

    //    修改评价记录
    void UpCourseEvaluateById(EvaluationRecords evaluationRecords);


    //    巡课记录
    int AddCourseTourClass(TourClass tourClass);

    //   巡课照片保存
    int savaFileTourClass(@Param("fName") String fName,
                          @Param("fUid") String fUid,
                          @Param("fPath") String fPath);

    //判断角色
    int checkRole(int uid);

    //    查询属于的课程信息
    List<Course> findAllCourseListBelong(@Param("startIndex") int startIndex,
                                         @Param("pageSize") int pageSize,
                                         @Param("suid") int suid);

    //    查询属于的课程信息分页总数
    int countCourseBelong(@Param("suid") int suid);

    //    获取课程名称及评价信息
    List<Course> getCourseName(int cId);

    //     查询所有老师
    List<TUser> findAllTeacher();

    //    查询属于老师的课程信息
    List<Course> findAllCourseListTeacherList(@Param("startIndex") int startIndex,
                                              @Param("pageSize") int pageSize,
                                              @Param("tuid") int tuid);

    //    查询属于老师的课程信息分页总数
    int findAllCourseListTeacher(@Param("tuid") int tuid);

    //    查询课程名称
    List<Course> findCourseName();

    //    听课评价存储
    void SaveCourseListen(@Param("listencordsUserId") int listencordsUserId,
                          @Param("listencordsCords") int listencordsCords,
                          @Param("listencordsList") String listencordsList);


    //查询是否存储听课评价
    boolean findCourseListen(@Param("listencordsCords") int listencordsCords,
                             @Param("listencordsUserId") int listencordsUserId);


    //    查询听课信息
    List<Listencords> findCourseListenDate(@Param("listencordsCords") int listencordsCords,
                                           @Param("listencordsUserId") int listencordsUserId);


    //    听课评价修改
    void UpCourseListen(@Param("listencordsUserId") int listencordsUserId,
                        @Param("listencordsCords") int listencordsCords,
                        @Param("listencordsList") String listencordsList);


    //查询是否存储听课评价 教师
    boolean findCourseListenT(@Param("listencordsCords") int listencordsCords);

    //    听课数据可视化  查询
    List<Listencords> findCourseListenVC(@Param("listencordsCords") int listencordsCords);

    //     查询所有教室
    List<Room> findAllRoomId();


    //    检查是否有回复留言
    boolean findMessageReplyAll(int messageId);

    //    查询回复留言
    MessageReply findMessageReplyId(int messageId);

    //    提交留言
    void SaveMessage(Message message);


    //    查询分页总数:查询全部留言总数
    int countMessageAll();

    //    查询全部留言
    List<Message> findMessageIdAll(
            @Param("startIndex") int startIndex,
            @Param("pageSize") int pageSize);


    //    查询分页总数:查询属于留言总数
    int countMessageUserIdAll(int messageUserId);

    //    查询属于留言
    List<Message> findMessage(@Param("messageUserId") int messageUserId,
                              @Param("startIndex") int startIndex,
                              @Param("pageSize") int pageSize);


    //    查询分页总数:查询属于课程留言总数
    int countMessageCourseIdAll(int uId);

    //    查询课程留言
    List<Message> findMessageCourseId(@Param("uId") int uId,
                                      @Param("startIndex") int startIndex,
                                      @Param("pageSize") int pageSize);


    //    查询修改留言
    Message findMessageId(int messageId);

    //删除留言
    void DeleteMessage(int messageId);

    //    留言修改
    void UpMessage(Message message);

    //    查询主页的留言列表
    List<Message> findMessageList();

    //   查询主页的留言列表属于自己课程 教师
    List<Message> findMessageListUid(int uid);

    //    查询主页的留言列表属于自己课程 学生
    List<Message> findMessageListUidSUser(int uid);

    //    统计学生评价总人数 和已评价
    Map<String, Integer> findStatisticsSUserEvaluate(int cId);


    //回复留言
    void SaveMessageReply(MessageReply messageReply);

    //    修改留言状态 已回复了 修改状态
    void UpMessageReply(@Param("messageId") int messageId, @Param("messageState") int messageState);


    //    查询巡课记录
    //    分页总数
    int countCourseTourList(int tourClassCourse);

    //    查询巡课记录
    //    分页
    List<TourClass> findCourseTourList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize, @Param("tourClassCourse") int tourClassCourse);

    //检查是否有巡查课程记录
    boolean checkCourseTourList(@Param("tourClassCourse") int tourClassCourse);

    //    批量删除
    int deleteCoursebatch(List<String> cId);

}
