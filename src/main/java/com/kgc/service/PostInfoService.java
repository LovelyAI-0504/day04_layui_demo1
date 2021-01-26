package com.kgc.service;

import com.github.pagehelper.PageInfo;
import com.kgc.entity.PostInfo;

import java.util.List;

public interface PostInfoService {

    //查询
    List<PostInfo> findPostAndTop(PostInfo postInfo);

    //分页模糊查询
    PageInfo<PostInfo> findPostAndTopInPage(PostInfo postInfo,Integer page,Integer pageSize);

    //添加数据
    String savePost(PostInfo postInfo);

    //根据ID查找数据
    PostInfo findPostById(Integer id);

    //根据ID修改数据
    String updPostById(PostInfo postInfo);

    //根据ID删除数据
    String delPostById(Integer id);
}
