package com.ningpai.order.dao;

import com.ningpai.order.bean.BackOrderRemark;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/12.
 */
public interface BackOrderRemarkMapper {
    Integer getRemarkTotal(Long backOrderId);

    List<BackOrderRemark> getBackOrderRemarks(Map map);

    void addBackOrderRemarkAjax(BackOrderRemark backOrderRemark);
}
