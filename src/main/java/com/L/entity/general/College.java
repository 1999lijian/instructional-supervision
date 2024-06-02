package com.L.entity.general;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/3/16 18:54
 */

//学院
@Data
@NoArgsConstructor
@AllArgsConstructor
public class College {

    private int collegeId;
    //    名称
    private String collegeName;
}
