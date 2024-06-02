package com.L.entity.general;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2024/2/19 21:48
 */
//教室
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Room {
    private int roomId;
    private String classRoom;
}
