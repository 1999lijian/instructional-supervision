package com.L.entity.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * <p>
 * 角色 实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RRole {
    //    角色ID
    private int rId;
    //    角色名称
    private String rRole;
}
