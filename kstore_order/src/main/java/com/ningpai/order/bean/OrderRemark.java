package com.ningpai.order.bean;

import java.util.Date;

/**
 * 订单备注表
 * Created by Administrator on 2017/2/15.
 */
public class OrderRemark {
    private Long remarkId;//备注id
    private Long orderId; //订单id
    private String orderCode; //订单编号
    private String remarkContent;//备注内容
    private Date creatTime; //创建备注时间
    private String ordercustomer;// 操作人

    public OrderRemark(Long remarkId, Long orderId, String orderCode, String remarkContent, Date creatTime,String ordercustomer) {
        this.remarkId = remarkId;
        this.orderId = orderId;
        this.orderCode = orderCode;
        this.remarkContent = remarkContent;
        this.creatTime = creatTime;
        this.ordercustomer=ordercustomer;
    }

    public OrderRemark() {
    }

    public String getOrdercustomer() {
        return ordercustomer;
    }

    public void setOrdercustomer(String ordercustomer) {
        this.ordercustomer = ordercustomer;
    }

    public Long getRemarkId() {
        return remarkId;
    }

    public void setRemarkId(Long remarkId) {
        this.remarkId = remarkId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
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
