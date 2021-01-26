package com.kgc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kgc.dao.PostInfoMapper;
import com.kgc.entity.PostInfo;
import com.kgc.entity.PostInfoExample;
import com.kgc.service.PostInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostInfoServiceImpl implements PostInfoService {

    @Autowired
    private PostInfoMapper postInfoMapper;

    //查询
    @Override
    public List<PostInfo> findPostAndTop(PostInfo postInfo) {
        return postInfoMapper.selPostAndTopInPage(postInfo);
    }

    //分页模糊查询
    @Override
    public PageInfo<PostInfo> findPostAndTopInPage(PostInfo postInfo, Integer page, Integer pageSize) {
        PageHelper.startPage(page,pageSize);
        return new PageInfo<PostInfo>(postInfoMapper.selPostAndTopInPage(postInfo));
    }

    //添加数据
    @Override
    public String savePost(PostInfo postInfo) {
        int count = postInfoMapper.insertSelective(postInfo);
        if (count>0){
            return "添加数据成功...";
        } else {
            return "添加数据失败!!!";
        }
    }

    //根据ID查找数据
    @Override
    public PostInfo findPostById(Integer id) {
        return postInfoMapper.selectByPrimaryKey(id);
    }

    //根据ID修改数据
    @Override
    public String updPostById(PostInfo postInfo) {
        int count = postInfoMapper.updateByPrimaryKeySelective(postInfo);
        if (count>0){
            return "修改数据成功...";
        } else {
            return "修改数据失败!!!";
        }
    }

    //根据ID删除数据
    @Override
    public String delPostById(Integer id) {
        int count = postInfoMapper.deleteByPrimaryKey(id);
        if (count>0){
            return "删除数据成功...";
        } else {
            return "修改数据失败!!!";
        }
    }
}
