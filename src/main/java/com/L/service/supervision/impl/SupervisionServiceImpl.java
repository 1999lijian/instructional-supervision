package com.L.service.supervision.impl;

import com.L.entity.supervision.Supervision;
import com.L.mapper.supervision.SupervisionMapper;
import com.L.service.supervision.SupervisionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/2/27 16:38
 */
@Service
public class SupervisionServiceImpl implements SupervisionService {

    @Autowired
    private SupervisionMapper supervisionMapper;


    @Override
    public int countSupervision() {
        return supervisionMapper.countSupervision();
    }

    @Override
    public int countSupervisionAll(String supName) {
        return supervisionMapper.countSupervisionAll(supName);
    }

    @Override
    public List<Supervision> findAllSupervisionList(int startIndex, int pageSize) {
        return supervisionMapper.findAllSupervisionList(startIndex, pageSize);
    }

    @Override
    public int addSupervision(Supervision supervision) {
        return supervisionMapper.addSupervision(supervision);
    }

    @Override
    public int savaFileSupervision(String fName, String fUid, String fPath) {
        return supervisionMapper.savaFileSupervision(fName, fUid, fPath);
    }

    @Override
    public int deleteSupervision(int supId) {
        return supervisionMapper.deleteSupervision(supId);
    }

    @Override
    public Supervision findSupervisionById(int supId) {
        return supervisionMapper.findSupervisionById(supId);
    }

    @Override
    public Supervision viewFileSuId(String fUid) {
        return supervisionMapper.viewFileSuId(fUid);
    }

    @Override
    public int updateSupervision(Supervision supervision) {
        return supervisionMapper.updateSupervision(supervision);
    }

    @Override
    public int deletesupervisionbatch(List<String> supId) {
        for (String supIdDet : supId) {
            int supIdInt = Integer.parseInt(supIdDet);
            supervisionMapper.deleteSupervision(supIdInt);
        }

        return 0;
    }
}
