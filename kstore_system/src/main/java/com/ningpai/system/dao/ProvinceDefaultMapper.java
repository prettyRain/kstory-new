/*
 * Copyright 2013 NINGPAI, Inc. All rights reserved.
 * NINGPAI PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package com.ningpai.system.dao;

import com.ningpai.system.bean.ProvinceDefault;

import java.util.List;
import java.util.Map;

/**
 * 设置默认地区
 * 
 * @author NINGPAI-LIH
 * @since 2015年1月10日10:27:28
 *
 */
public interface ProvinceDefaultMapper {

    /**
     * 修改所有的默认地址为已删除
     * 
     * @return
     */
    int deleteAllDefault();

    /**
     * 插入新的默认的地址
     * 
     * @param record
     * @return
     */
    int insertSelective(ProvinceDefault record);

    /**
     * 查询默认地址
     * 
     * @return
     */
    Long selectDefaultId();
    /**
     * 根据区县id查找是否已经存在
     */
    Long queryIdByDistrictId(Long districtId);

    /**
     * 查询地址列表的总数
     */
    Integer queryCount();
    /**
     * 查询地址列表
     */
    List<ProvinceDefault> queryAddressList(Map map);

    void updateAddressDefault(Long districtId);
    void deleteAddressNew(List arr);
    public void saveUpdateAddress(Map map);
    public Long queryDistrictIdByCd(Map map);
}
