package com.kgc.test;

import com.github.pagehelper.PageInfo;
import com.kgc.entity.PostInfo;
import com.kgc.service.PostInfoService;
import javafx.geometry.Pos;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

//测试类
public class PostInfoServiceImplTest {

    private ApplicationContext app;
    private PostInfoService postInfoService;

//    //新建日志对象
//    private static final Logger log = Logger.getLogger(PostInfoServiceImplTest.class);

    @Before
    public void before(){
        app = new ClassPathXmlApplicationContext("classpath:spring/applicationContext*.xml");
        postInfoService = (PostInfoService)app.getBean("postInfoServiceImpl");
    }

    //分页测试
    @Test
    public void test1(){
        PostInfo postInfo = new PostInfo();
        postInfo.setTitle("恒大");
        postInfo.setClicknum(1);
        postInfo.setClicknum1(200);
        PageInfo<PostInfo> pageInfo = postInfoService.findPostAndTopInPage(postInfo, 1, 3);
        List<PostInfo> list = pageInfo.getList();
        for (PostInfo postInfo1 : list) {
            System.out.println(postInfo1);
        }
//        List<PostInfo> list = postInfoService.findPostAndTop(new PostInfo());
//        for (PostInfo postInfo : list) {
////            System.out.println(postInfo);
//            log.info(postInfo);
//        }
    }
}
