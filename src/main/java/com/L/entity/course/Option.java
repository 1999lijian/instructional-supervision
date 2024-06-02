package com.L.entity.course;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/3/5 9:22
 */
//问题选项
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Option {


    private int optionId;
    //    问题选项
    private String optionName;
    //    选项问题id
    private int scoreById;


    private Score scores;

}
