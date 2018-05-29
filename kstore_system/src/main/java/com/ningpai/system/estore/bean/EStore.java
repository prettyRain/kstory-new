/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.system.estore.bean;

import javax.validation.constraints.Pattern;
import java.util.Date;

/**
 * 管易云实体类
 *
 */
public class EStore {
    /**
     * ID
     */
    private Long estoreid;

   /**
    *  接口url
    */
    @Pattern(regexp = "[^''\\[\\]\\<\\>?\\\\!]+")
    private String url;

   /**
    *  主账号（无用）
    */
    @Pattern(regexp = "[^''\\[\\]\\<\\>?\\\\!]+")
    private String dbhost;

   /**
    *  AppKey
    */
    @Pattern(regexp = "[^''\\[\\]\\<\\>?\\\\!]+")
    private String appkey;

   /**
    * secret
    */
    @Pattern(regexp = "[^''\\[\\]\\<\\>?\\\\!]+")
    private String secret;

   /**
    *  sessionkey
    */
   //@NotNull
    @Pattern(regexp = "[^''\\[\\]\\<\\>?\\\\!]+")
    private String sessionkey;

   /**
    *  申请ERP地址
    */
    @Pattern(regexp = "[^''\\[\\]\\<\\>?\\\\!]+")
    private String address;

   /**
    * ERP提供商
    */
    @Pattern(regexp = "[^''\\[\\]\\<\\>?\\\\!]+")
    private String provider;

   /**
    * ERP图片
    */
    @Pattern(regexp = "[^''\\[\\]\\<\\>?\\\\!]+")
    private String image;

   /**
    * 是否开启
    */
    private String isopen;

   /**
    * 创建时间
    */
    private Date createtime;

   /**
    *  修改时间
    */
    private Date updatetime;

   /**
    *  删除标记
    */
    private String delflag;

    private  String  shopId;

    private String storageId;

    public String getShopId() {
        return shopId;
    }

    public void setShopId(String shopId) {
        this.shopId = shopId;
    }

    public String getStorageId() {
        return storageId;
    }

    public void setStorageId(String storageId) {
        this.storageId = storageId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    /**
     * 获取时间
     * */
    public Date getCreatetime() {
        return createtime==null?null: (Date) createtime.clone();
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Long getEstoreid() {
        return estoreid;
    }

    public void setEstoreid(Long estoreid) {
        this.estoreid = estoreid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getDbhost() {
        return dbhost;
    }

    public void setDbhost(String dbhost) {
        this.dbhost = dbhost;
    }

    /**
     * 时间
     * @return
     */
    public Date getCreateTime() {
        if (this.createtime != null) {
            return new Date(this.createtime.getTime());
        } else {
            return null;
        }
    }
    /**
     * 时间
     * @return
     */
    public void setCreateTime(Date createTime) {
        if (createTime != null) {
            Date tEmp = (Date) createTime.clone();
            if (tEmp != null) {
                this.createtime = tEmp;
            }
        }
    }
    /**
     * 时间
     * @return
     */
    public Date getUpdatetime() {
        if (this.updatetime != null) {
            return new Date(this.updatetime.getTime());
        } else {
            return null;
        }
    }
    /**
     * 时间
     * @return
     */
    public void setUpdatetime(Date updatetime) {
        if (updatetime != null) {
            Date tEmp = (Date) updatetime.clone();
            if (tEmp != null) {
                this.updatetime = tEmp;
            }
        }
    }

    public String getDelflag() {
        return delflag;
    }

    public void setDelflag(String delflag) {
        this.delflag = delflag;
    }

    public String getAppkey() {
        return appkey;
    }

    public void setAppkey(String appkey) {
        this.appkey = appkey;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }

    public String getSessionkey() {
        return sessionkey;
    }

    public void setSessionkey(String sessionkey) {
        this.sessionkey = sessionkey;
    }

    public String getIsopen() {
        return isopen;
    }

    public void setIsopen(String isopen) {
        this.isopen = isopen;
    }

}
