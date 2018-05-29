/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.system.bean;

import java.util.Date;

/**
 * 默认地址
 * 
 * @author NINGPAI-LIH
 * @since 2015年1月10日09:57:07
 *
 */
public class ProvinceDefault {
    /*
     * 主键
     */
    private Long dId;

    /*
     * 默认的地区id
     */
    private Long districtId;

    /*
     * 创建时间
     */
    private Date createTime;

    /*
     * 删除标记
     */
    private String deFalg;

    /*
     * 修改时间
     */
    private Date modifyTime;

    /**
     * 区县
     * @return
     */
    private District district;

    /**
     * 城市
     * @return
     */
    private City city;

    /**
     * 省
     * @return
     */
    private Province province;

    /**
     *  字符串的时间
     * @return
     */
    private String timeString;
    public Long getdId() {
        return dId;
    }

    public void setdId(Long dId) {
        this.dId = dId;
    }

    public Long getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Long districtId) {
        this.districtId = districtId;
    }
    /**
     * 获取时间
     * */
    public Date getCreateTime() {
        return createTime==null?null: (Date) createTime.clone();
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getDeFalg() {
        return deFalg;
    }

    public void setDeFalg(String deFalg) {
        this.deFalg = deFalg;
    }
    /**
     * 获取时间
     * */
    public Date getModifyTime() {
        return modifyTime==null?null: (Date) modifyTime.clone();
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public District getDistrict() {
        return district;
    }

    public void setDistrict(District district) {
        this.district = district;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

    public String getTimeString() {
        return timeString;
    }

    public void setTimeString(String timeString) {
        this.timeString = timeString;
    }
}
