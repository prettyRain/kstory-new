/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.weixin.bean;

import java.util.Date;

/**
 * 微信群发组
 * 
 * @author NINGPAI-zhangqiang
 * @since 2014年9月3日 下午3:58:57
 * @version 0.0.1
 */
public class WXGroup {
    private Long wxId;

    private String openid;

    private Date getTime;

    private String emp1;

    private String emp2;

    public Long getWxId() {
        return wxId;
    }

    public void setWxId(Long wxId) {
        this.wxId = wxId;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }
    /**
     * 获取时间
     * */
    public Date getGetTime() {
        return getTime==null?null: (Date) getTime.clone();
    }

    public void setGetTime(Date getTime) {
        this.getTime = getTime;
    }

    public String getEmp1() {
        return emp1;
    }

    public void setEmp1(String emp1) {
        this.emp1 = emp1;
    }

    public String getEmp2() {
        return emp2;
    }

    public void setEmp2(String emp2) {
        this.emp2 = emp2;
    }
}
