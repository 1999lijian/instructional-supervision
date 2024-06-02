package com.L.entity.course;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/3/7 10:44
 */
//评价记录
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EvaluationRecords {


    private int evaluationId;

    private int evaluationCourse;

    private int evaluationScore;

    private int evaluationOption;

    private int evaluationUser;

}
