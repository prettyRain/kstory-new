package com.ningpai.order.dao.impl;

import com.ningpai.manager.base.BasicSqlSupport;
import com.ningpai.order.bean.OrderRemark;
import com.ningpai.order.dao.OrderRemarkMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/2/15.
 */
@Repository("OrderRemarkMapper")
public class OrderRemarkMapperImpl extends BasicSqlSupport implements OrderRemarkMapper {

    /**
     * 根据订单id查询订单的备注
     * @param paramMap
     * @return
     */
    public List<OrderRemark> selectOrderRemarkByOrderId(Map<String, Object> paramMap){
       Object o = this;
      return this.
              selectList("com.ningpai.order.dao.OrderRemarkMapper.selectOrderRemarkByOrderId",paramMap);
    }

    /**
     * 根据orderId查询总条数
     * @param orderId
     * @return
     */
    public Integer getTotalCount(Long orderId){
        List list = this.selectList("com.ningpai.order.dao.OrderRemarkMapper.getTotalCount",
                orderId);
        return list.size();
    };
    /**
     * 订单备注添加
     * @param orderRemark
     */
    public int addorderremarksajax(OrderRemark orderRemark){
        return this.insert("com.ningpai.order.dao.OrderRemarkMapper.addorderremarksajax",orderRemark);
    }
}
