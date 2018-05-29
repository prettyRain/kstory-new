/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.system.estore.service;

import com.ningpai.system.estore.bean.EStore;

/**
 * 管易云servie
 *
 */
public interface EStoreService {
    /**
     * 查询管易云信息
     *
     * @return
     */
    EStore findEStore();

    /**
     * 修改管易云信息
     *
     * @param estore
     * @return
     */
    int updateEStore(EStore estore);
}
