package com.L.entity.teaching;

import com.L.entity.util.File;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/2/19 21:38
 */
//教学计划
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Teaching {

    //    id
    private int teId;
    //    教学名称
    private String tName;
    //    教学预期
    private String tExpect;
    //    教学内容
    private String tContent;
    //    教学文件
    private int tFile;
    //    状态
    private int tState;
    //    属于教师ID
    private int tUser;


    private File fileSava;

}
