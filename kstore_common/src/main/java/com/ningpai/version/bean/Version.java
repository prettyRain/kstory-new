/**
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.version.bean;

import java.util.Date;

/**
 * 系统版本Bean
 * 
 * @author NINGPAI-zhangqiang
 * @since 2014年6月26日 上午10:20:06
 * @version 0.0.1
 */
public class Version {
    /**
     * 版本编号
     * 
     * @see {@link #getVersionId()}
     * @see {@link #setVersionId(Long)}
     */
    private Long versionId;
    /**
     * 版本号
     * 
     * @see #getVersionCode()
     * @see #setVersionCode(String)
     */
    private String versionCode;
    /**
     * 版本内容
     * 
     * @see #getVersionContent()
     * @see #setVersionContent(String)
     */
    private String versionContent;
    /**
     * 版本时间
     * 
     * @see #getVersionTime()
     * @see #setVersionTime(Date)
     */
    private Date versionTime;

    /**
     * 是否强制更新：0 不强制；1强制
     */
    private String isMust;

    /**
     * 系统版本类型 1：APP商城；2：Mobile微商城；3：PC商城；4：Boss管理后台
     */
    private String sysType;

    /**
     * 状态：0无效；1有效
     */
    private String status;

    /**
     * Android App 下载地址
     */
    private String url;

    /**
     * 创建人
     */
    private String createPerson;

    public Long getVersionId() {
        return versionId;
    }

    public void setVersionId(Long versionId) {
        this.versionId = versionId;
    }

    public String getVersionCode() {
        return versionCode;
    }

    public void setVersionCode(String versionCode) {
        this.versionCode = versionCode;
    }

    public String getVersionContent() {
        return versionContent;
    }

    public void setVersionContent(String versionContent) {
        this.versionContent = versionContent;
    }

    /**
     * 获得版本时间
     * @return
     */
    public Date getVersionTime() {
        if (this.versionTime != null) {
            return new Date(this.versionTime.getTime());
        } else {
            return null;
        }
    }

    /**
     * 版本时间
     * @param versionTime
     */
    public void setVersionTime(Date versionTime) {
        if (versionTime != null) {
            Date empTime = (Date) versionTime.clone();
            if (empTime != null) {
                this.versionTime = empTime;
            }
        }
        this.versionTime = versionTime;
    }

    public String getIsMust() {
        return isMust;
    }

    public void setIsMust(String isMust) {
        this.isMust = isMust;
    }

    public String getSysType() {
        return sysType;
    }

    public void setSysType(String sysType) {
        this.sysType = sysType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getCreatePerson() {
        return createPerson;
    }

    public void setCreatePerson(String createPerson) {
        this.createPerson = createPerson;
    }
}
