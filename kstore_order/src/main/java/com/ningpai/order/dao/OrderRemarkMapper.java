package com.ningpai.order.dao;

import com.ningpai.order.bean.OrderRemark;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/2/15.
 */
public interface OrderRemarkMapper {

     public List<OrderRemark> selectOrderRemarkByOrderId(Map<String, Object> paramMap);

    public int addorderremarksajax(OrderRemark orderRemark);

    Integer getTotalCount(Long orderId);
}
