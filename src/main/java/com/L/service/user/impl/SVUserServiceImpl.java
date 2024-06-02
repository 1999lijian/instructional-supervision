package com.L.service.user.impl;

import com.L.entity.general.College;
import com.L.entity.user.SVUser;
import com.L.entity.user.UUser;
import com.L.mapper.user.SVUserMapper;
import com.L.service.user.SVUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/1/23 0:23
 */

@Service
public class SVUserServiceImpl implements SVUserService {


    @Autowired
    private SVUserMapper svUserMapper;

    @Override
    public int countSVUser() {
        return svUserMapper.countSVUser();
    }

    @Override
    public int countSVUserAll(String svName) {
        return svUserMapper.countSVUserAll(svName);
    }

    @Override
    public List<SVUser> findAllSVUserList(int startIndex, int pageSize) {
        return svUserMapper.findAllSVUserList(startIndex, pageSize);
    }

    @Override
    public int deleteSVUserId(int svId) {
        return svUserMapper.deleteSVUserId(svId);
    }

    @Override
    public int addSVUser(SVUser svUser) {
        return svUserMapper.addSVUser(svUser);
    }

    @Override
    public int addAll(UUser uUser) {
        uUser.setURoleNo(2);
        return svUserMapper.addAll(uUser);
    }

    @Override
    public SVUser updateSVUserId(int svId) {
        return svUserMapper.updateSVUserId(svId);
    }

    @Override
    public int updateSVUser(SVUser svUser) {
        return svUserMapper.updateSVUser(svUser);
    }

    @Override
    public List<College> findAllCollege() {
        return svUserMapper.findAllCollege();
    }

    @Override
    public int deleteSVUserbatch(List<String> svId) {

        for (String svIdDet : svId) {
            int svIdInt = Integer.parseInt(svIdDet);
            svUserMapper.deleteSVUserId(svIdInt);
        }

        return 0;
    }
}