package com.L.service.user.impl;

import com.L.entity.general.College;
import com.L.entity.user.TUser;
import com.L.entity.user.UUser;
import com.L.mapper.user.TUserMapper;
import com.L.service.user.TUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/22 0:55
 */

@Service
public class TUserServiceImpl implements TUserService {


    @Autowired
    private TUserMapper tUserMapper;

    @Override
    public int countTUser() {
        return tUserMapper.countTUser();
    }

    @Override
    public int countTUserAll(String tName) {
        return tUserMapper.countTUserAll(tName);
    }

    @Override
    public List<TUser> findAllTUserList(int startIndex, int pageSize) {
        return tUserMapper.findAllTUserList(startIndex, pageSize);
    }

    @Override
    public int deleteTUserId(int tId) {
        return tUserMapper.deleteTUserId(tId);
    }

    @Override
    public int addTUser(TUser tUser) {
        return tUserMapper.addTUser(tUser);
    }

    @Override
    public int addAll(UUser uUser) {
        uUser.setURoleNo(3);
        return tUserMapper.addAll(uUser);
    }

    @Override
    public TUser updateTUserId(int tId) {
        return tUserMapper.updateTUserId(tId);
    }

    @Override
    public int updateTUser(TUser tUser) {
        return tUserMapper.updateTUser(tUser);
    }

    @Override
    public List<College> findAllCollege() {
        return tUserMapper.findAllCollege();
    }

    @Override
    public int deleteTUserbatch(List<String> tId) {

        for (String tIdDet : tId) {
            int tIdInt = Integer.parseInt(tIdDet);
            tUserMapper.deleteTUserId(tIdInt);
        }

        return 0;
    }
}
