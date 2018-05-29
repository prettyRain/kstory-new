package com.ningpai.customer.vo;

import com.ningpai.customer.bean.DepositInfo;
import com.ningpai.customer.bean.Giftcard;

import java.math.BigDecimal;

/**
 * Created by Administrator on 2017/8/22 0022.
 */
public class GiftcardVo extends Giftcard {

    /**
     * 礼品卡绑定的用户信息
     */
    private DepositInfo depositInfo;
    /**
     * 会员总资产预存款
     */
    private BigDecimal totalDeposit;
    private BigDecimal preDeposit;
    private BigDecimal freezePreDeposit;

    private String customerUsername;

    private String customerImg;

    private String giftcardNo;
    /**
     * 用户状态
     */
    private String isFlag;
    /**
     * 分页开始的条数
     */
    private int startRowNum;
    /**
     * 分页结束的条数
     */
    private int endRowNum;

    public BigDecimal getPreDeposit() {
        return preDeposit;
    }

    public void setPreDeposit(BigDecimal preDeposit) {
        this.preDeposit = preDeposit;
    }

    public BigDecimal getFreezePreDeposit() {
        return freezePreDeposit;
    }

    public void setFreezePreDeposit(BigDecimal freezePreDeposit) {
        this.freezePreDeposit = freezePreDeposit;
    }

    public DepositInfo getDepositInfo() {
        return depositInfo;
    }

    public void setDepositInfo(DepositInfo depositInfo) {
        this.depositInfo = depositInfo;
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

    public BigDecimal getTotalDeposit() {
        return totalDeposit;
    }

    public void setTotalDeposit(BigDecimal totalDeposit) {
        this.totalDeposit = totalDeposit;
    }

    public String getCustomerUsername() {
        return customerUsername;
    }

    public void setCustomerUsername(String customerUsername) {
        this.customerUsername = customerUsername;
    }

    public String getCustomerImg() {
        return customerImg;
    }

    public void setCustomerImg(String customerImg) {
        this.customerImg = customerImg;
    }

    public String getIsFlag() {
        return isFlag;
    }

    public void setIsFlag(String isFlag) {
        this.isFlag = isFlag;
    }

    @Override
    public String getGiftcardNo() {
        return giftcardNo;
    }

    @Override
    public void setGiftcardNo(String giftcardNo) {
        this.giftcardNo = giftcardNo;
    }
}
