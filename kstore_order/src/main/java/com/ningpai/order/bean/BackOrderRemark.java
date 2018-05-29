package com.ningpai.order.bean;

import java.util.Date;

/**
 * 退单备注
 * Created by Administrator on 2017/6/12.
 */
public class BackOrderRemark {
    private Long remarkId;//退单备注id
    private Long backOrderId;//退单id
    private String backOrderCode;//退单编号
    private String remarkContent;//备注内容
    private Date creatTime;//创建时间
    private String backcustomer;//操作人

    public BackOrderRemark() {
    }

    public BackOrderRemark(Long remarkId, Long backOrderId, String backOrderCode, String remarkContent, Date creatTime,String backcustomer) {
        this.remarkId = remarkId;
        this.backOrderId = backOrderId;
        this.backOrderCode = backOrderCode;
        this.remarkContent = remarkContent;
        this.creatTime = creatTime;
        this.backcustomer=backcustomer;
    }

    public String getBackcustomer() {
        return backcustomer;
    }

    public void setBackcustomer(String backcustomer) {
        this.backcustomer = backcustomer;
    }

    public Long getRemarkId() {
        return remarkId;
    }

    public void setRemarkId(Long remarkId) {
        this.remarkId = remarkId;
    }

    public Long getBackOrderId() {
        return backOrderId;
    }

    public void setBackOrderId(Long backOrderId) {
        this.backOrderId = backOrderId;
    }

    public String getBackOrderCode() {
        return backOrderCode;
    }

    public void setBackOrderCode(String backOrderCode) {
        this.backOrderCode = backOrderCode;
    }

    public String getRemarkContent() {
        return remarkContent;
    }

    public void setRemarkContent(String remarkContent) {
        this.remarkContent = remarkContent;
    }

    public Date getCreatTime() {
        return creatTime;
    }

    public void setCreatTime(Date creatTime) {
        this.creatTime = creatTime;
    }
}
