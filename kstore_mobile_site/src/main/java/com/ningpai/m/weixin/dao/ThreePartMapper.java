/*
 * Copyright 2013 NingPai, Inc. All rights reserved.
 * NINGPAI PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package com.ningpai.m.weixin.dao;

import com.ningpai.m.weixin.bean.ThreePart;

import java.util.Map;

/**
 * 第三方登入Mapper
 * 
 * @author NINGPAI-zhangqiang
 * @since 2014年8月26日 下午6:04:38
 * @version 0.0.1
 */
public interface ThreePartMapper {

    /**
     * 查询第三方
     * 
     * @param openid
     * @return ThreePart
     */
    ThreePart selectThreePart(String openid);

    /**
     *删除绑定关系
     * @param openid
     */
    void deleteThreepart(String openid);
    /**
     * 插入
     * 
     * @param tp
     * @return int
     */
    int insertThreePart(ThreePart tp);
    /**
     * 查询手机号是否已与这种登录方式绑定
     * @param map
     * @return
     */
    ThreePart queryPartByMobile(Map map);
}
