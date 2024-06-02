package com.L.service.user.impl;

import com.L.entity.user.AUser;
import com.L.entity.user.UUser;
import com.L.mapper.user.AUserMapper;
import com.L.service.user.AUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/21 15:52
 */

@Service
public class AUserServiceImpl implements AUserService {


    @Autowired
    private AUserMapper aUserMapper;


    @Override
    public int countAUser() {
        return aUserMapper.countAUser();
    }

    @Override
    public int countAUserAll(String aName) {
        return aUserMapper.countAUserAll(aName);
    }

    @Override
    public List<AUser> findAllAUserList(int startIndex, int pageSize) {
        return aUserMapper.findAllAUserList(startIndex, pageSize);
    }

    @Override
    public int deleteAUserId(int aId) {
        return aUserMapper.deleteAUserId(aId);
    }

    @Override
    public int addAUser(AUser aUser) {
        return aUserMapper.addAUser(aUser);
    }

    @Override
    public int addAll(UUser uUser) {
//        设为管理员
        uUser.setURoleNo(1);
        return aUserMapper.addAll(uUser);
    }

    @Override
    public AUser updateAUserId(int aId) {
        return aUserMapper.updateAUserId(aId);
    }

    @Override
    public int updateAUser(AUser aUser) {
        return aUserMapper.updateAUser(aUser);
    }

    @Override
    public int deleteAUserbatch(List<String> aId) {
        for (String aIdDet : aId) {
            int aIdInt = Integer.parseInt(aIdDet);
            aUserMapper.deleteAUserId(aIdInt);
        }
        return 0;
    }


}
