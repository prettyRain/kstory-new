/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.system.estore.dao;

import com.ningpai.system.estore.bean.EStore;

/**
 * 管易云dao
 *
 */
public interface EStoreMapper {
    /**
     * 根据id删除信息
     *
     * @param estoreid
     * @return
     */
    int deleteByPrimaryKey(Long estoreid);

    /**
     * 添加管易云
     *
     * @param record
     * @return
     */
    int insertSelective(EStore record);

    /**
     * 根据id查询管易云信息
     *
     * @param estoreid
     * @return
     */
    EStore selectByPrimaryKey(Long estoreid);

    /**
     * 查询管易云信息
     *
     * @return
     */
    EStore findEStore();

    /**
     * 修改管易云信息
     *
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(EStore record);

    /**
     * 查询管易云总数量
     *
     * @return
     */
    int selectAllCount();
}
