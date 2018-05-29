/**
 * Copyright 2014 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */

package com.ningpai.community.service.impl;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

import com.ningpai.community.bean.CommunityStore;

import com.ningpai.community.dao.CommunityStoreMapper;
import com.ningpai.community.service.CommunityStoreService;

import com.ningpai.util.PageBean;

import java.util.List;
import java.util.Map;

import java.util.HashMap;

/**  
 * @Description: np_community_store的service的实现类:
 * @author hehu
 * @date 2017-02-18 16:54:30
 * @version V1.0  
 */
@Service("CommunityStoreService") 
public class CommunityStoreServiceImpl implements CommunityStoreService {

	/*
	* (non-Javadoc) 
	* @see com.ningpai.community.service.CommunityStoreService#delete(java.lang.Long)
	*/
	@Override
	public int delete(Long communityStoreId) {
		return this.communityStoreMapper.deleteByPrimaryKey(communityStoreId);
	}

	/*
	* (non-Javadoc)
	* @see com.ningpai.community.service.CommunityStoreService#insert(com.ningpai.community.bean.CommunityStore)
	*/
	@Override
	public int insert(CommunityStore record) {
		return this.communityStoreMapper.insertSelective(record);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.service.CommunityStoreService#select(java.lang.Long)
	*/
	@Override
	public CommunityStore select(Long communityStoreId) {
		return this.communityStoreMapper.selectByPrimaryKey(communityStoreId);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.service.CommunityStoreService#update(com.ningpai.community.bean.CommunityStore)
	*/
	@Override
	public int update(CommunityStore record) {
		
		return this.communityStoreMapper.updateByPrimaryKeySelective(record);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.service.CommunityStoreService#deleteMuilti(java.lang.Long[])
	*/
	@Override
	public int deleteMuilti(Long communityStoreIds[]) {
		return this.communityStoreMapper.deleteMuilti(communityStoreIds);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.service.CommunityStoreService#selectList(com.ningpai.community.bean.CommunityStore,PageBean pageBean)
	*/
	@Override
	public PageBean selectList(CommunityStore record,PageBean pageBean) {
		pageBean.setObjectBean(record);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageBean",pageBean);
		pageBean.setRows(this.communityStoreMapper.selectListCount(map));
		pageBean.setList(this.communityStoreMapper.selectList(map));
		return pageBean;
	}

	@Override
	public List<CommunityStore> loadAllCommunityStores() {
		return this.communityStoreMapper.loadAllCommunityStores();
	}

	@Override
	public CommunityStore selectVo(Long communityStoreId) {
		return this.communityStoreMapper.selectVo(communityStoreId);
	}

	@Override
	public List<CommunityStore> loadAllCommunityStores(Long districtId) {
		Map<String,Object> map = new HashMap<>();
		map.put("districtId",districtId);
		return this.communityStoreMapper.loadAllCommunityStores(map);
	}

	@Resource(name="CommunityStoreMapper")
	private CommunityStoreMapper communityStoreMapper;
}