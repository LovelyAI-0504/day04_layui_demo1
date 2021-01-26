package com.kgc.service.impl;

import com.kgc.dao.TopicMapper;
import com.kgc.entity.Topic;
import com.kgc.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TopicServiceImpl implements TopicService {

    @Autowired
    private TopicMapper topicMapper;

    //查询所有数据
    @Override
    public List<Topic> findTop() {
        return topicMapper.selTop();
    }
}
