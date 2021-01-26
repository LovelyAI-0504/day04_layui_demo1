package com.kgc.entity;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Topic {
    private Integer topicid;

    private String topicname;

    public Topic(Integer topicid, String topicname) {
        this.topicid = topicid;
        this.topicname = topicname;
    }

    public Topic() {
        super();
    }

    public Integer getTopicid() {
        return topicid;
    }

    public void setTopicid(Integer topicid) {
        this.topicid = topicid;
    }

    public String getTopicname() {
        return topicname;
    }

    public void setTopicname(String topicname) {
        this.topicname = topicname == null ? null : topicname.trim();
    }
}