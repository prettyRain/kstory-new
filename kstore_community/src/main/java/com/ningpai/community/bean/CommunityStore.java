/**
 * Copyright 2014 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */

package com.ningpai.community.bean;

import com.ningpai.system.bean.City;
import com.ningpai.system.bean.District;
import com.ningpai.system.bean.Province;

import java.io.Serializable;
import java.util.Date;

/**  
 * @Description: np_community_store表的实体bean
 * @author hehu
 * @date 2017-02-18 16:54:30
 * @version V1.0  
 */
public class CommunityStore implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	*社区店主键id
	*/
	private Long communityStoreId;

	/**
	*社区店名称
	*/
	private String communityStoreName;

	/**
	*联系方式
	*/
	private String contact;

	/**
	*联系方式
	*/
	private String contactMobile;

	/**
	*社区店地址
	*/
	private String communityStoreAddress;

	/**
	*省份id
	*/
	private Long provinceId;

	/**
	*市id
	*/
	private Long cityId;

	/**
	*区id
	*/
	private Long districtId;

	/**
	*是否启用,0未启用，1已启用，默认0
	*/
	private String openFlag;

	/**
	*删除标记，0未删除，1已删除，默认为0
	*/
	private String delFlag;

	/**
	*创建时间
	*/
	private Date createTime;

	private Province province;

	private City city;

	private District district;

	public Long getCommunityStoreId() {
		return communityStoreId;
	}

	public void setCommunityStoreId(Long communityStoreId) {
		this.communityStoreId = communityStoreId; 
	}

	public String getCommunityStoreName() {
		return communityStoreName;
	}

	public void setCommunityStoreName(String communityStoreName) {
		this.communityStoreName = communityStoreName; 
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact; 
	}

	public String getContactMobile() {
		return contactMobile;
	}

	public void setContactMobile(String contactMobile) {
		this.contactMobile = contactMobile; 
	}

	public String getCommunityStoreAddress() {
		return communityStoreAddress;
	}

	public void setCommunityStoreAddress(String communityStoreAddress) {
		this.communityStoreAddress = communityStoreAddress; 
	}

	public Long getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(Long provinceId) {
		this.provinceId = provinceId; 
	}

	public Long getCityId() {
		return cityId;
	}

	public void setCityId(Long cityId) {
		this.cityId = cityId; 
	}

	public Long getDistrictId() {
		return districtId;
	}

	public void setDistrictId(Long districtId) {
		this.districtId = districtId; 
	}

	public String getOpenFlag() {
		return openFlag;
	}

	public void setOpenFlag(String openFlag) {
		this.openFlag = openFlag; 
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag; 
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime; 
	}

	public Province getProvince() {
		return province;
	}

	public void setProvince(Province province) {
		this.province = province;
	}

	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	public District getDistrict() {
		return district;
	}

	public void setDistrict(District district) {
		this.district = district;
	}
}