package com.L.entity.supervision;

import com.L.entity.util.File;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/2/27 16:22
 */
//督导计划
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Supervision {


    //    id
    private int supId;
    //    名称
    private String supName;
    //    督导要求
    private String ask;
    //    开始时间
    private String supTimeStart;
    //    结束时间
    private String supTimeEnd;
    //文件
    private int supFile;


    private File supervisionFileSava;


}
