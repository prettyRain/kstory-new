/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.system.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ningpai.system.bean.ProvinceDefault;
import com.ningpai.system.dao.ProvinceDefaultMapper;
import com.ningpai.system.service.DefaultAddressService;

/**
 * 默认地址service
 * 
 * @author NINGPAI-LIH
 * @since 2015年1月10日13:13:11
 *
 */
@Service("DefaultAddressService")
public class DefaultAddressServiceImpl implements DefaultAddressService {

    /**
     * spring注解
     */
    @Resource(name = "ProvinceDefaultMapper")
    private ProvinceDefaultMapper mapper;

    /*
     * 插入默认地址
     * 
     * @see
     * com.ningpai.system.service.DefaultAddressService#insertAddressDefaultService
     * (com.ningpai.system.bean.ProvinceDefault)
     */
    @Override
    @Transactional
    public int insertAddressDefaultService(Long districtId) {
        /*ProvinceDefault provinceDefault = new ProvinceDefault();
        provinceDefault.setDistrictId(districtId);
        provinceDefault.setCreateTime(new Date());
        provinceDefault.setDeFalg("0");*/
        // 清空默认地址
        try {
            mapper.deleteAllDefault();
            mapper.updateAddressDefault(districtId);
            return 1;
        }catch(Exception e){
            e.printStackTrace();
        }
        return  0;
    }

    /*
     * 获取默认地址id
     * 
     * @see
     * com.ningpai.system.service.DefaultAddressService#getDefaultIdService()
     */
    @Override
    public Long getDefaultIdService() {
        return mapper.selectDefaultId();
    }

    @Override
    public int insertAddressToAddressList(Long districtId) {
        ProvinceDefault provinceDefault = new ProvinceDefault();
        provinceDefault.setDistrictId(districtId);
        provinceDefault.setCreateTime(new Date());
        //0默认地址  1删除的地址  2普通地址
        provinceDefault.setDeFalg("2");
        // 清空默认地址  把0给出2
       // mapper.deleteAllDefault();
        //根据区县id查找是否已经存在
        Long provinceDefaultId = mapper.queryIdByDistrictId(districtId);
        if(provinceDefaultId != null && provinceDefaultId > 0){
            return 9;
        }
        return mapper.insertSelective(provinceDefault);
    }

    @Override
    public Map<String, Object> queryAddressList(Integer currentPage, Integer pageSize) {
            //总条数
            Integer  count = this.mapper.queryCount();
            if(count != null&&count > 0){
                //总页数
                Integer countPage = count%pageSize==0?count/pageSize:(count/pageSize)+1;
                Map<String,Integer> map = new HashMap();
                Integer start = pageSize*(currentPage-1);
                map.put("start",start);
                map.put("end",pageSize);
                //分页查询地址列表
                List<ProvinceDefault> provinceDefaultList = this.mapper.queryAddressList(map);
                Map<String,Object> objectMap = new HashedMap();
                objectMap.put("countPage",countPage);
                objectMap.put("addressList",provinceDefaultList);
                return objectMap;
            }

             return null;
    }

    @Override
    public void deleteAddressNew(List  arr) {
        this.mapper.deleteAddressNew(arr);
    }

    /**
     *
     * @param distictId 将要改成的 区县
     * @param did       要修改did这条数据
     * @return
     */
    @Override
    public String saveUpdateAddress(Long distictId,Long did) {
        Long didnew = this.mapper.queryIdByDistrictId(distictId);
        //已经存在
        if(didnew!=null && didnew>0){
            return "1";
        }
        Map map = new HashedMap();
        map.put("did",did);
        map.put("districtId",distictId);
        this.mapper.saveUpdateAddress(map);
        return "2";
    }

    @Override
    public Long queryDistrictIdByCd(String cityName, String districtName) {
        Map map = new HashedMap();
        map.put("cityName",cityName);
        map.put("districtName",districtName);
        return this.mapper.queryDistrictIdByCd(map);
    }
}
