/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.customer.bean;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 礼品卡Bean
 */
public class Giftcard {
    /**
     * 礼品卡ID
     */
    private Long id;
    /**
     * 礼品卡号
     */
    @NotNull
    private String giftcardNo;
    /**
     * 礼品卡密码
     */
    @NotNull
    private String giftcardPwd;
    /**
     * 礼品卡余额
     */
    private BigDecimal giftcardPrice;
    /**
     * 礼品卡类型（0：虚拟卡，1：实体卡）
     */
    private String giftcardType;
    /**
     * 激活状态（'-1'：无效，'0'：未激活，'1'：已激活，'2'：已失效(已绑定或者未绑定已过期)）
     */
    private String activeFlag;
    /**
     * 激活时间
     */
    private Date activeTime;
    /**
     * 激活人
     */
    private String activeName;
    /**
     * 购买礼品卡的时间
     */
    private Date createTime;
    /**
     * 购买礼品卡的订单
     */
    private String orderCode;
    /**
     * 购买礼品卡的客户
     */
    private Long customerId;
    /**
     * 实体卡所属卡段id
     */
    private Long segmentId;

    public Giftcard() {
    }

    public Giftcard(String giftcardNo, String giftcardPwd) {
        this.giftcardNo = giftcardNo;
        this.giftcardPwd = giftcardPwd;
    }

    public Long getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(Long segmentId) {
        this.segmentId = segmentId;
    }

    /**
     *获取激活时间
     * */
    public Date getActiveTime() {
        if (this.activeTime != null) {
            return new Date(this.activeTime.getTime());
        } else {
            return null;
        }
    }
    /**
     *设置激活时间
     * */
    public void setActiveTime(Date createTime) {
        if (createTime != null) {
            Date timeTemp = (Date) createTime.clone();
            if (timeTemp != null) {
                this.activeTime = timeTemp;
            }
        }
    }

    /**
     *获取创建时间
     * */
    public Date getCreateTime() {
        if (this.createTime != null) {
            return new Date(this.createTime.getTime());
        } else {
            return null;
        }
    }
    /**
     *设置创建时间
     * */
    public void setCreateTime(Date createTime) {
        if (createTime != null) {
            Date timeTemp = (Date) createTime.clone();
            if (timeTemp != null) {
                this.createTime = timeTemp;
            }
        }
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getGiftcardNo() {
        return giftcardNo;
    }

    public void setGiftcardNo(String giftcardNo) {
        this.giftcardNo = giftcardNo;
    }

    public BigDecimal getGiftcardPrice() {
        return giftcardPrice;
    }

    public void setGiftcardPrice(BigDecimal giftcardPrice) {
        this.giftcardPrice = giftcardPrice;
    }

    public String getGiftcardType() {
        return giftcardType;
    }

    public void setGiftcardType(String giftcardType) {
        this.giftcardType = giftcardType;
    }

    public String getActiveFlag() {
        return activeFlag;
    }

    public void setActiveFlag(String activeFlag) {
        this.activeFlag = activeFlag;
    }

    public String getActiveName() {
        return activeName;
    }

    public void setActiveName(String activeName) {
        this.activeName = activeName;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getGiftcardPwd() {
        return giftcardPwd;
    }

    public void setGiftcardPwd(String giftcardPwd) {
        this.giftcardPwd = giftcardPwd;
    }
}
