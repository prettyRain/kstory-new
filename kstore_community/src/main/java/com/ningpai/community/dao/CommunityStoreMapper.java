/**
 * Copyright 2014 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */

package com.ningpai.community.dao;

import com.ningpai.community.bean.CommunityStore;

import java.util.Map;

import java.util.List;

/**  
 * @Description: np_community_store的dao:
 * @author hehu
 * @date 2017-02-18 16:54:30
 * @version V1.0  
 */
public interface CommunityStoreMapper {

	/**
	* 根据主键删除 
	* 参数:主键  
	* 返回:删除个数  
	* @date 2017-02-18 16:54:30
	*/
	int deleteByPrimaryKey(Long communityStoreId);

	/**
	* 插入，空属性不会插入
	* 参数:pojo对象  
	* 返回:添加个数  
	* @date 2017-02-18 16:54:30
	*/
	int insertSelective(CommunityStore record);

	/**
	* 根据主键查询
	* 参数:查询条件,主键值
	* 返回:对象  
	* @date 2017-02-18 16:54:30
	*/
	CommunityStore selectByPrimaryKey(Long communityStoreId);

	/**
	* 根据主键修改，空值条件不会修改成null
	* 参数:1.要修改成的值
	* 返回:成功修改个数  
	* @date 2017-02-18 16:54:30
	*/
	int updateByPrimaryKeySelective(CommunityStore record);

	/**
	* 分页查询列表数量
	* 参数:1.赛选条件bean对象
	* 参数:2.分页封装对象
	* 返回:pageBean封装的list的对象  
	* @date 2017-02-18 16:54:30
	*/
	Integer selectListCount(Map<String, Object> map);

	/**
	* 分页查询列表
	* 参数:1.赛选条件bean对象
	* 参数:2.分页封装对象
	* 返回:pageBean封装的list的对象  
	* @date 2017-02-18 16:54:30
	*/
	List<Object> selectList(Map<String, Object> map);

	/**
	* 删除多条记录
	* 参数:1.主键数组
	* 返回:影响行数  
	* @date 2017-02-18 16:54:30
	*/
	int deleteMuilti(Long communityStoreIds[]);

	/**
	 * 加载所有社区店
	 * @return
     */
	List<CommunityStore> loadAllCommunityStores();

	/**
	 * 社区店详细信息
	 * @param communityStoreId
	 * @return
     */
	CommunityStore selectVo(Long communityStoreId);

	/**
	 * 根据区县id查询社区店详细信息
	 * @param districtId
	 * @return
     */
	List<CommunityStore> loadAllCommunityStores(Map<String,Object> map);
}