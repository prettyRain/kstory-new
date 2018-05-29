/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.system.service;


import java.util.List;
import java.util.Map;

/**
 * 默认地址
 * @author NINGPAI-LIH
 * @since 2015年1月10日10:58:32
 */
public interface DefaultAddressService {

    
    /**
     * 插入默认地址
     * @param provinceDefault 地址信息
     * @return
     */
    public int insertAddressDefaultService(Long districtId);
    
    /**
     * 获取默认地址id
     * @return 
     */
    public Long getDefaultIdService();
    /**
     * 添加地址到地址列表
     */
    public int insertAddressToAddressList(Long districtId);
    /**
     * 查询地址列表
     */
    public Map<String,Object> queryAddressList(Integer currentPage, Integer pageSize);
    /**
     * 删除地址
     */
    public void deleteAddressNew(List arr);
    /**
     * 保存修改后的地址
     */
    public String saveUpdateAddress(Long distictId,Long did);
    //根据城市 区县 查询地址
    public Long queryDistrictIdByCd(String cityName,String districtName);
}
