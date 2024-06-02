package com.L.mapper.teaching;

import com.L.entity.teaching.Teaching;
import com.L.entity.util.File;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @Author LIJIAN
 * @Date 2024/2/19 21:53
 */
@Repository
public interface TeachingMapper {

    //   查询所有教学计划
    List<Teaching> findAllTeaching();


    //    分页总数
    int countTeaching();

    //    查询分页总数
    int countTeachingAll(String tName);

    //    分页
    List<Teaching> findAllTeachingList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);

    //    分页总数 所属与教师计划ID
    int countTeachingTUserId(@Param("tUser") int tUser);

    //    分页 所属与教师计划ID
    List<Teaching> findAllTeachingListTUserId(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize, @Param("tUser") int tUser);


    // 添加教学计划
//    1.测试表单数据
//    2.测试日期
//    3.测试文件上传
    int addTeaching(Teaching teaching);

    //文件保存
    //文件保存
    int savaFileTeaching(@Param("fName") String fName, @Param("fUid") String fUid, @Param("fPath") String fPath);

    //    文件保存 更新  （增加返回id）
    int savaFileTeachingP(File file);

    //    删除教学计划
    int deleteTeaching(int teId);


    //    根据id查询信息
    Teaching findTeachingById(int teId);

    //   修改时 查看文件内容
    Teaching viewFileTeId(String fUid);

    //    根据id进行修改
    void updateTeaching(Teaching teaching);

    //修改审核状态
    int updateTeachingState(@Param("teId") int teId, @Param("tState") int tState);

    //    审核情况数据可视化
//   MapKey: 指定了 stateDescription 列作为 Map 的键。查询结果将被映射为一个 Map
    @Select("SELECT CASE WHEN tState = 0 THEN '未审核' WHEN tState = 1 THEN '审核' END AS stateDescription, COUNT(*) AS count FROM teaching GROUP BY tState ORDER BY tState")
    @MapKey("stateDescription")
    List<Map<String, String>> findAllTeachingState();

}
