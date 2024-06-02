package com.L.entity.course;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/4/23 16:22
 */
//回复留言
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MessageReply {

    private int replyId;
    private String messageReply;
    private int messageReplyId;


}
