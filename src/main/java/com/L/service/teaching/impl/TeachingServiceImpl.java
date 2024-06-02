package com.L.service.teaching.impl;

import com.L.entity.teaching.Teaching;
import com.L.entity.util.File;
import com.L.mapper.teaching.TeachingMapper;
import com.L.service.teaching.TeachingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Author LIJIAN
 * @Date 2024/2/19 22:22
 */
@Service
public class TeachingServiceImpl implements TeachingService {
    @Autowired
    private TeachingMapper teachingMapper;

    @Override
    public List<Teaching> findAllTeaching() {
        return teachingMapper.findAllTeaching();
    }

    @Override
    public int countTeaching() {
        return teachingMapper.countTeaching();
    }

    @Override
    public int countTeachingAll(String tName) {
        return teachingMapper.countTeachingAll(tName);
    }

    @Override
    public List<Teaching> findAllTeachingList(int startIndex, int pageSize) {
        return teachingMapper.findAllTeachingList(startIndex, pageSize);
    }

    @Override
    public int countTeachingTUserId(int tUser) {
        return teachingMapper.countTeachingTUserId(tUser);
    }

    @Override
    public List<Teaching> findAllTeachingListTUserId(int startIndex, int pageSize, int tUser) {
        return teachingMapper.findAllTeachingListTUserId(startIndex, pageSize, tUser);
    }

    @Override
    public int addTeaching(Teaching teaching) {
        return teachingMapper.addTeaching(teaching);
    }

    @Override
    public int savaFileTeaching(String fName, String fUid, String fPath) {
        return teachingMapper.savaFileTeaching(fName, fUid, fPath);
    }

    @Override
    public int savaFileTeachingP(File file) {
        teachingMapper.savaFileTeachingP(file);
        return file.getFId();
    }

    @Override
    public int deleteTeaching(int teId) {
        return teachingMapper.deleteTeaching(teId);
    }

    @Override
    public Teaching findTeachingById(int teId) {
        return teachingMapper.findTeachingById(teId);
    }

    @Override
    public Teaching viewFileTeId(String fUid) {
        return teachingMapper.viewFileTeId(fUid);
    }


    @Override
    public void updateTeaching(Teaching teaching) {
        teachingMapper.updateTeaching(teaching);
    }

    @Override
    public int updateTeachingState(int teId, int teState) {
        return teachingMapper.updateTeachingState(teId, teState);
    }

    @Override
    public List<Map<String, String>> findAllTeachingState() {
        return teachingMapper.findAllTeachingState();
    }


}
