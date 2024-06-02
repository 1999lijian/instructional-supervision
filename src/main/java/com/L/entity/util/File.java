package com.L.entity.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/2/19 21:45
 */
//文件
@Data
@NoArgsConstructor
@AllArgsConstructor
public class File {
//    id
    private int fId;
//    文件名
    private String fName;
//    文件uid
    private String fUid;
//    文件存储地址
    private String fPath;


}
