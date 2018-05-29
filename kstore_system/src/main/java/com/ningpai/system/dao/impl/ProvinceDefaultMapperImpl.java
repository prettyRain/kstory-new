/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.system.dao.impl;

import org.springframework.stereotype.Repository;

import com.ningpai.manager.base.BasicSqlSupport;
import com.ningpai.system.bean.ProvinceDefault;
import com.ningpai.system.dao.ProvinceDefaultMapper;

import java.util.List;
import java.util.Map;

/**
 * 设置默认地址
 * 
 * @author NINGPAI-LIH
 * @since 2015年1月10日10:57:24
 *
 */

@Repository("ProvinceDefaultMapper")
public class ProvinceDefaultMapperImpl extends BasicSqlSupport implements
        ProvinceDefaultMapper {

    /*
     * 修改所有的默认地址为已删除
     * 
     * @see com.ningpai.system.dao.ProvinceDefaultMapper#deleteAllDefault()
     */
    @Override
    public int deleteAllDefault() {
        return this
                .update("com.ningpai.system.dao.ProvinceDefaultMapper.deleteAllDefault");
    }

    /*
     * 插入新的默认的地址
     * 
     * @see
     * com.ningpai.system.dao.ProvinceDefaultMapper#insertSelective(com.ningpai
     * .system.bean.ProvinceDefault)
     */
    @Override
    public int insertSelective(ProvinceDefault record) {
        return this.insert(
                "com.ningpai.system.dao.ProvinceDefaultMapper.insertSelective",
                record);
    }

    /*
     * 查询默认地址
     * 
     * @see com.ningpai.system.dao.ProvinceDefaultMapper#selectDefaultId()
     */
    @Override
    public Long selectDefaultId() {
        return this
                .selectOne("com.ningpai.system.dao.ProvinceDefaultMapper.selectDefaultId");
    }

    /**
     * 根据区县id查找是否已经存在
     * @param districtId
     * @return
     */
    @Override
    public Long queryIdByDistrictId(Long districtId) {
        return this.selectOne("com.ningpai.system.dao.ProvinceDefaultMapper.queryIdByDistrictId",districtId);
    }

    /**
     * 查询地址类表的总数
     */
    @Override
    public Integer queryCount() {
        return this.selectOne("com.ningpai.system.dao.ProvinceDefaultMapper.queryCount");
    }


    /**
     * 查询地址列表
     */
    @Override
    public List<ProvinceDefault> queryAddressList(Map map) {
        return this.selectList("com.ningpai.system.dao.ProvinceDefaultMapper.queryAddressList",map);
    }

    @Override
    public void updateAddressDefault(Long districtId) {
        this.update("com.ningpai.system.dao.ProvinceDefaultMapper.updateAddressDefault",districtId);
    }

    @Override
    public void deleteAddressNew(List list) {
        this.update("com.ningpai.system.dao.ProvinceDefaultMapper.deleteAddressNew",list);
    }

    @Override
    public void saveUpdateAddress(Map map) {
        this.update("com.ningpai.system.dao.ProvinceDefaultMapper.saveUpdateAddress",map);
    }

    @Override
    public Long queryDistrictIdByCd(Map map) {
        return this.selectOne("com.ningpai.system.dao.ProvinceDefaultMapper.queryDistrictIdByCd",map);
    }


}
