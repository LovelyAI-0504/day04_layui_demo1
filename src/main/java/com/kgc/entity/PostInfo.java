package com.kgc.entity;

import lombok.Data;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

@Data
@ToString
public class PostInfo {
    private Integer id;

    private String title;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date posttime;

    private Integer clicknum;

    private Integer clicknum1;

    public Integer getClicknum1() {
        return clicknum1;
    }

    public void setClicknum1(Integer clicknum1) {
        this.clicknum1 = clicknum1;
    }

    private String content;

    private Integer topicid;

    private String pic;

    private Topic topic;

    public Topic getTopic() {
        return topic;
    }

    public void setTopic(Topic topic) {
        this.topic = topic;
    }

    public PostInfo(Integer id, String title, Date posttime, Integer clicknum, String content, Integer topicid, String pic) {
        this.id = id;
        this.title = title;
        this.posttime = posttime;
        this.clicknum = clicknum;
        this.content = content;
        this.topicid = topicid;
        this.pic = pic;
    }

    public PostInfo() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Date getPosttime() {
        return posttime;
    }

    public void setPosttime(Date posttime) {
        this.posttime = posttime;
    }

    public Integer getClicknum() {
        return clicknum;
    }

    public void setClicknum(Integer clicknum) {
        this.clicknum = clicknum;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getTopicid() {
        return topicid;
    }

    public void setTopicid(Integer topicid) {
        this.topicid = topicid;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }
}