package com.L.mapper.supervision;

import com.L.entity.supervision.Supervision;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/2/19 21:53
 */
@Repository
public interface SupervisionMapper {

    //    分页总数
    int countSupervision();

    //    查询分页总数
    int countSupervisionAll(String supName);

    //    分页
    List<Supervision> findAllSupervisionList(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);

//    添加教学计划
    int addSupervision(Supervision supervision);

    //文件保存
    //文件保存
    int savaFileSupervision(@Param("fName") String fName, @Param("fUid") String fUid, @Param("fPath") String fPath);

//    删除督导计划
    int deleteSupervision(int supId);

    //    根据id查询信息
    Supervision findSupervisionById(int supId);

    //   修改时 查看文件内容
    Supervision viewFileSuId(String fUid);

    //    根据id进行修改
    int updateSupervision(Supervision supervision);




}
