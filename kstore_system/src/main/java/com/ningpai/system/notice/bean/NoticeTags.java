package com.ningpai.system.notice.bean;

import java.util.Date;

/**
 * 消息标签
 * Created by dll on 2018/1/29.
 */
public class NoticeTags {


    private Long id;

    private String name;

    private int status;

    private Date createTime;

    public NoticeTags() {
    }

    public NoticeTags(String name, int status, Date createTime) {
        this.name = name;
        this.status = status;
        this.createTime = createTime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
