package com.L.entity.course;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/3/27 20:54
 */
//听课评价记录
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Listencords {

    private int listencordsId;
    private int listencordsUserId;
    private int listencordsCords;
    private String listencordsList;


}
