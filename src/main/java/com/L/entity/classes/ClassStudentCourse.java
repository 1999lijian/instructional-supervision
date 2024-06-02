package com.L.entity.classes;

import com.L.entity.course.Course;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/3/18 17:31
 */
//班级关联课程
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClassStudentCourse {
    private int ccId;
    private int cIIdcc;
    private int sIdcc;

    private Course course;


}
