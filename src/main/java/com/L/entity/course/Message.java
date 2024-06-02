package com.L.entity.course;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/4/7 8:08
 */

//留言
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message {

    private int messageId;
    private String messageName;
    private int messageCourseId;
    private int messageUserId;
    private int messageState;


    private Course courseList;


}
