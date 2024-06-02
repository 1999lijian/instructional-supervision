package com.L.entity.course;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/5 9:17
 */
//评价问题
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Score {
    private int scoreId;
    //    评价内容
    private String scoreName;

    //    选项列表
    private List<Option> optionList;

}
