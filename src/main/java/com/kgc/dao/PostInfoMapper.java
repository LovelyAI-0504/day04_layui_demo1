package com.kgc.dao;

import com.kgc.entity.PostInfo;
import com.kgc.entity.PostInfoExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PostInfoMapper {
    long countByExample(PostInfoExample example);

    int deleteByExample(PostInfoExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(PostInfo record);

    int insertSelective(PostInfo record);

    List<PostInfo> selectByExample(PostInfoExample example);

    PostInfo selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") PostInfo record, @Param("example") PostInfoExample example);

    int updateByExample(@Param("record") PostInfo record, @Param("example") PostInfoExample example);

    int updateByPrimaryKeySelective(PostInfo record);

    int updateByPrimaryKey(PostInfo record);

    List<PostInfo> selPostAndTopInPage(PostInfo postInfo);
}