package com.ningpai.customer.bean;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 礼品卡段Bean
 */
public class GiftcardSegment {
    /**
     * 礼品卡段ID
     */
    private Long id;
    /**
     * 卡段前部
     */
    private String cardPrefix;
    /**
     * 卡段中部
     */
    private String cardMid;
    /**
     * 卡段后部
     */
    private String cardSuffix;
    /**
     * 礼品卡金额
     */
    private BigDecimal cardPrice;
    /**
     * 礼品卡数量
     */
    private Integer cardNum;
    /**
     * 制作卡段时间
     */
    private Date createTime;
    /**
     * 制作人
     */
    private String createName;
    /**
     * 分页开始的条数
     */
    private int startRowNum;
    /**
     * 分页结束的条数
     */
    private int endRowNum;
    /**
     * 卡段下所有礼品卡
     */
    private List<Giftcard> giftcardList;

    public List<Giftcard> getGiftcardList() {
        return giftcardList;
    }

    public void setGiftcardList(List<Giftcard> giftcardList) {
        this.giftcardList = giftcardList;
    }

    public int getStartRowNum() {
        return startRowNum;
    }

    public void setStartRowNum(int startRowNum) {
        this.startRowNum = startRowNum;
    }

    public int getEndRowNum() {
        return endRowNum;
    }

    public void setEndRowNum(int endRowNum) {
        this.endRowNum = endRowNum;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCardPrefix() {
        return cardPrefix;
    }

    public void setCardPrefix(String cardPrefix) {
        this.cardPrefix = cardPrefix;
    }

    public String getCardMid() {
        return cardMid;
    }

    public void setCardMid(String cardMid) {
        this.cardMid = cardMid;
    }

    public String getCardSuffix() {
        return cardSuffix;
    }

    public void setCardSuffix(String cardSuffix) {
        this.cardSuffix = cardSuffix;
    }

    public BigDecimal getCardPrice() {
        return cardPrice;
    }

    public void setCardPrice(BigDecimal cardPrice) {
        this.cardPrice = cardPrice;
    }

    public Integer getCardNum() {
        return cardNum;
    }

    public void setCardNum(Integer cardNum) {
        this.cardNum = cardNum;
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

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }
}
