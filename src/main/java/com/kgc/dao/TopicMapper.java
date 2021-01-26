package com.kgc.dao;

import com.kgc.entity.PostInfo;
import com.kgc.entity.Topic;
import com.kgc.entity.TopicExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TopicMapper {
    long countByExample(TopicExample example);

    int deleteByExample(TopicExample example);

    int deleteByPrimaryKey(Integer topicid);

    int insert(Topic record);

    int insertSelective(Topic record);

    List<Topic> selectByExample(TopicExample example);

    Topic selectByPrimaryKey(Integer topicid);

    int updateByExampleSelective(@Param("record") Topic record, @Param("example") TopicExample example);

    int updateByExample(@Param("record") Topic record, @Param("example") TopicExample example);

    int updateByPrimaryKeySelective(Topic record);

    int updateByPrimaryKey(Topic record);

    List<Topic> selTop();

    Topic selTopById();
}