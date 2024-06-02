package com.L.entity.classes;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/3/18 17:31
 */
//班级关联学生
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClassStudent {
    private int scId;
    private int cIIdsc;
    private int sIdsc;
}
