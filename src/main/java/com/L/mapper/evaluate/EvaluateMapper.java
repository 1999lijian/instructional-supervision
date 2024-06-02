package com.L.mapper.evaluate;

import com.L.entity.course.Option;
import com.L.entity.course.Score;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/19 20:02
 */
@Repository
public interface EvaluateMapper {


    //    分页总数
    int countScore();

    //    查询分页总数
    int countScoreAll(String optionName);

    //    查询所有评价问题
    List<Option> findAllScore(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);

    //    删除相关选项问题
    int deleteOption(@Param("optionId") int optionId);

    //    根据id 查询相关问题
    Option findOptionById(@Param("optionId") int optionId);

    //    根据id 提交修改
    int updateOptionById(Option option);

    //    添加问题
    int addScore(Score score);

    //    添加选项
    int addOption(Option option);

    //    查询问题列表
    List<Score> findScoreByName();

}
