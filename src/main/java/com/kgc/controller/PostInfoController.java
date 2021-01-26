package com.kgc.controller;

import com.github.pagehelper.PageInfo;
import com.kgc.entity.PostInfo;
import com.kgc.entity.Topic;
import com.kgc.service.PostInfoService;
import com.kgc.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
public class PostInfoController {

    @Autowired
    private PostInfoService postInfoService;
    @Autowired
    private TopicService topicService;
    @Autowired
    private ServletContext servletContext;

    //跳转查看页面
    @RequestMapping(value = "showList")
    public String showList(){
        return "list";
    }

    //查看页面
    @RequestMapping(value = "show/list")
    @ResponseBody
    public Map list(
            PostInfo postInfo,
            @RequestParam(value = "page",required = false,defaultValue = "1")Integer page,
            @RequestParam(value = "limit",required = false,defaultValue = "3")Integer pageSize
    ){
        Integer max = null;
        Integer min = 0;
        if (postInfo.getClicknum()!=null&&postInfo.getClicknum1()!=null&&postInfo.getClicknum()>postInfo.getClicknum1()){
            max = postInfo.getClicknum();
            min = postInfo.getClicknum1();
        }else if (postInfo.getClicknum()!=null&&postInfo.getClicknum1()!=null&&postInfo.getClicknum()<postInfo.getClicknum1()){
            max = postInfo.getClicknum1();
            min = postInfo.getClicknum();
        }else if (postInfo.getClicknum()==null&&postInfo.getClicknum1()!=null){
            max = postInfo.getClicknum1();
        }else if (postInfo.getClicknum()!=null&&postInfo.getClicknum1()==null){
            max = postInfo.getClicknum();
        }
        postInfo.setClicknum(min);
        postInfo.setClicknum1(max);
        PageInfo<PostInfo> pageInfo = postInfoService.findPostAndTopInPage(postInfo, page, pageSize);
        Map map = new HashMap();
        map.put("code",0);
        map.put("msg","查询成功!");
        map.put("count",pageInfo.getTotal());//总记录数
        map.put("data",pageInfo.getList());
        List<PostInfo> list = pageInfo.getList();
        for (PostInfo info : list) {
            System.out.println(info);
        }
        return map;
    }

    //打开储存页面
    @RequestMapping(value = "show/Top")
    @ResponseBody
    public List<Topic> top(){
        return topicService.findTop();
    }

    //上传图片
    @RequestMapping(value = "upLoad")
    @ResponseBody
    public Map uoLoad(MultipartFile file) throws IOException {
        //判断这个路径在不在,不在就新建路径
        String path=servletContext.getRealPath("upload");//oos
        File dir=new File(path);
        if(!dir.exists())dir.mkdir();

//        System.out.println("执行到了这里1");

        //把文件夹名和文件名组合,上传
        String fileName = getFileName(file.getOriginalFilename());
        //路径名=文件夹名+"/"+文件名 upload/***.jpg(or:任意img)
        String str=path+"/"+fileName;//上传文件的原始名称
        file.transferTo(new File(str));

//        System.out.println("执行到了这里2");

        Map map=new HashMap();
        map.put("msg","文件上传成功!");
        //往页面中写入文件名使页面能搜索到
        map.put("path",fileName);
//        System.out.println("执行到了这里3/n"+fileName);
        return map;
    }

    //传入原始文件名定义新文件名
    private String getFileName(String fileName) {
        //随机ID+随机数字+"-"+原始文件名
        String newName = UUID.randomUUID()+""+new Random().nextInt(1000)+"-"+fileName;
        return newName;
    }


    //存储页面
    @RequestMapping(value = "Post/save")
    @ResponseBody
    public Map save(PostInfo postInfo){
        String msg = postInfoService.savePost(postInfo);
        Map map = new HashMap();
        map.put("msg",msg);
        return map;
    }

    //根据要修改的ID查询数据
    @RequestMapping(value = "post/toupd")
    @ResponseBody
    public Map showById(@RequestParam(value = "id")Integer id){
        Map map = new HashMap();
        map.put("post",postInfoService.findPostById(id));
        map.put("top",topicService.findTop());
        return map;
    }

    //根据ID修改数据
    @RequestMapping(value = "Post/upd")
    @ResponseBody
    public Map updById(PostInfo postInfo){
        String msg = postInfoService.updPostById(postInfo);
        Map map = new HashMap();
        map.put("msg",msg);
        return map;
    }

    //删除
    @RequestMapping(value = "post/del")
    @ResponseBody
    public Map delById(@RequestParam(value = "id") Integer id){
        String msg = postInfoService.delPostById(id);
        Map map = new HashMap();
        map.put("msg",msg);
        return map;
    }

    //去到主页面
    @RequestMapping(value = "showMain")
    public String tuMain(){;
        return "main";
    }

    //根据ID来增加点击量和查看详细图片
    @RequestMapping(value ="post/showImg")
    @ResponseBody
    public Map showImg(@RequestParam(value = "id") Integer id){
        PostInfo postById = postInfoService.findPostById(id);
        if (postById.getClicknum()==null){
            postById.setClicknum(1);
        }else {
            postById.setClicknum(postById.getClicknum()+1);
        }
        postInfoService.updPostById(postById);
        Map map = new HashMap();
        map.put("path",postById.getPic());
        return map;
    }
}
