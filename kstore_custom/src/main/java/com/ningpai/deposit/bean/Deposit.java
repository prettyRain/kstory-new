package com.ningpai.deposit.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 预存款dto
 */
public class Deposit implements Serializable {

    private Long id;
    private Long customerId;
    private BigDecimal preDeposit;
    private BigDecimal freezePreDeposit;
    private String payPassword;
    private Integer passwordErrorCount;
    private Date passwordTime;
    private String giftcardNo;
    private String userSaltVal;

    public String getUserSaltVal() {
        return userSaltVal;
    }

    public void setUserSaltVal(String userSaltVal) {
        this.userSaltVal = userSaltVal;
    }

    public String getGiftcardNo() {
        return giftcardNo;
    }

    public void setGiftcardNo(String giftcardNo) {
        this.giftcardNo = giftcardNo;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

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

    public String getPayPassword() {
        return payPassword;
    }

    public void setPayPassword(String payPassword) {
        this.payPassword = payPassword;
    }

    public Integer getPasswordErrorCount() {
        return passwordErrorCount;
    }

    public void setPasswordErrorCount(Integer passwordErrorCount) {
        this.passwordErrorCount = passwordErrorCount;
    }

    public Date getPasswordTime() {
        return passwordTime;
    }

    public void setPasswordTime(Date passwordTime) {
        this.passwordTime = passwordTime;
    }

    public int addPwdErrorCount() {
        passwordErrorCount += 1;
        return passwordErrorCount;
    }
}
