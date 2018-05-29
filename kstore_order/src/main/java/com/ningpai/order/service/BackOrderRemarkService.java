package com.ningpai.order.service;

import com.ningpai.order.bean.BackOrderRemark;

import java.util.List;
import java.util.Map;

/**
 * 退单备注
 * Created by Administrator on 2017/6/12.
 */
public interface BackOrderRemarkService {
    Integer getRemarkTotal(Long backOrderId);

    List<BackOrderRemark> getBackOrderRemarks(Map map);

    void addBackOrderRemarkAjax(BackOrderRemark backOrderRemark);
}
