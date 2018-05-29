/**
 * Copyright 2014 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */

package com.ningpai.community.dao.impl;
import org.springframework.stereotype.Repository;
import java.util.Map;
import java.util.List;

import com.ningpai.community.bean.CommunityStore;
import com.ningpai.community.dao.CommunityStoreMapper;

/**  
 * @Description: np_community_store的dao的实现类:
 * @author hehu
 * @date 2017-02-18 16:54:30
 * @version V1.0  
 */
@Repository("CommunityStoreMapper") 
public class CommunityStoreMapperImpl extends com.ningpai.manager.base.BasicSqlSupport implements CommunityStoreMapper {

	/*
	* (non-Javadoc) 
	* @see com.ningpai.community.dao.CommunityStoreMapper#deleteByPrimaryKey(java.lang.Long)
	*/
	@Override
	public int deleteByPrimaryKey(Long communityStoreId) {
		return this.update("com.ningpai.mybatis.mapper.CommunityStoreMapper.deleteByPrimaryKey", communityStoreId);
	}

	/*
	* (non-Javadoc)
	* @see com.ningpai.community.dao.CommunityStoreMapper#insertSelective(com.ningpai.community.bean.CommunityStore)
	*/
	@Override
	public int insertSelective(CommunityStore record) {
		return this.insert("com.ningpai.mybatis.mapper.CommunityStoreMapper.insertSelective", record);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.dao.CommunityStoreMapper#selectByPrimaryKey(java.lang.Long)
	*/
	@Override
	public CommunityStore selectByPrimaryKey(Long communityStoreId) {
		return this.selectOne("com.ningpai.mybatis.mapper.CommunityStoreMapper.selectByPrimaryKey", communityStoreId);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.dao.CommunityStoreMapper#updateByPrimaryKeySelective(com.ningpai.community.bean.CommunityStore)
	*/
	@Override
	public int updateByPrimaryKeySelective(CommunityStore record) {
		return this.update("com.ningpai.mybatis.mapper.CommunityStoreMapper.updateByPrimaryKeySelective", record);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.dao.CommunityStoreMapper#deleteMuilti(java.lang.Long communityStoreIds)
	*/
	@Override
	public int deleteMuilti(Long communityStoreIds[]) {
		return this.update("com.ningpai.mybatis.mapper.CommunityStoreMapper.deleteMuilti", communityStoreIds);
	}

	@Override
	public List<CommunityStore> loadAllCommunityStores() {
		return this.selectList("com.ningpai.mybatis.mapper.CommunityStoreMapper.loadAllCommunityStores");
	}

	@Override
	public CommunityStore selectVo(Long communityStoreId) {
		return this.selectOne("com.ningpai.mybatis.mapper.CommunityStoreMapper.selectVo", communityStoreId);
	}

	@Override
	public List<CommunityStore> loadAllCommunityStores(Map<String,Object> map) {
		return this.selectList("com.ningpai.mybatis.mapper.CommunityStoreMapper.loadAllCommunityStores",map);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.dao.CommunityStoreMapper#selectList(java.util.Map<String,Object> map)
	*/
	@Override
	public List<Object> selectList(Map<String,Object> map) {
		return this.selectList("com.ningpai.mybatis.mapper.CommunityStoreMapper.selectList", map);
	}

	/* 
	* (non-Javadoc)
	* @see com.ningpai.community.dao.CommunityStoreMapper#selectListCount(java.util.Map<String,Object> map)
	*/
	@Override
	public Integer selectListCount(Map<String,Object> map) {
		return this.selectOne("com.ningpai.mybatis.mapper.CommunityStoreMapper.selectListCount", map);
	}
}