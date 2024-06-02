package com.L.service.evaluate.impl;

import com.L.entity.course.Option;
import com.L.entity.course.Score;
import com.L.mapper.evaluate.EvaluateMapper;
import com.L.service.evaluate.EvaluateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LIJIAN
 * @Date 2024/3/19 20:21
 */
@Service
public class EvaluateServiceImpl implements EvaluateService {

    @Autowired
    private EvaluateMapper evaluateMapper;


    @Override
    public int countScore() {
        return evaluateMapper.countScore();
    }

    @Override
    public int countScoreAll(String optionName) {
        return evaluateMapper.countScoreAll(optionName);
    }

    @Override
    public List<Option> findAllScore(int startIndex, int pageSize) {
        return evaluateMapper.findAllScore(startIndex, pageSize);
    }

    @Override
    public int deleteOption(int optionId) {
        return evaluateMapper.deleteOption(optionId);
    }

    @Override
    public Option findOptionById(int optionId) {
        return evaluateMapper.findOptionById(optionId);
    }

    @Override
    public int updateOptionById(Option option) {
        return evaluateMapper.updateOptionById(option);
    }

    @Override
    public int addScore(Score score) {
        evaluateMapper.addScore(score);
//        返回 插入的id
        return score.getScoreId();
    }

    @Override
    public int addOption(Option option) {
        return evaluateMapper.addOption(option);
    }

    @Override
    public List<Score> findScoreByName() {
        return evaluateMapper.findScoreByName();
    }


}
