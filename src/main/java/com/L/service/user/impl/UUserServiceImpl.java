package com.L.service.user.impl;

import com.L.entity.user.RRole;
import com.L.entity.user.UUser;
import com.L.mapper.classes.ClassesMapper;
import com.L.mapper.user.UUserMapper;
import com.L.service.user.UUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 13:45
 */
@Service
public class UUserServiceImpl implements UUserService {
    @Autowired
    private UUserMapper uUserMapper;




    @Override
    public UUser login(String uName, String uPassword) {
        return uUserMapper.login(uName, uPassword);
    }

    @Override
    public UUser UserId(int uId) {
        return uUserMapper.UserId(uId);
    }

    @Override
    public void upUserId(Map<String, String> userMap) {
        uUserMapper.upUserId(userMap);
    }

    @Override
    public void upUserPassword(int uId, String uPassword) {
        uUserMapper.upUserPassword(uId, uPassword);
    }

    @Override
    public List<RRole> countRole() {
        return uUserMapper.countRole();
    }




}
