package com.ningpai.order.dao.impl;

import com.ningpai.manager.base.BasicSqlSupport;
import com.ningpai.order.bean.BackOrderRemark;
import com.ningpai.order.dao.BackOrderRemarkMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/12.
 */
@Repository("BackOrderRemarkMapper")
public class BackOrderRemarkMapperImpl extends BasicSqlSupport implements BackOrderRemarkMapper {
    @Override
    public Integer getRemarkTotal(Long backOrderId) {
        return this.selectOne("com.ningpai.order.dao.BackOrderRemarkMapper.getRemarkTotal",backOrderId);
    }

    @Override
    public List<BackOrderRemark> getBackOrderRemarks(Map map) {
        return this.selectList("com.ningpai.order.dao.BackOrderRemarkMapper.getBackOrderRemarks",map);
    }

    @Override
    public void addBackOrderRemarkAjax(BackOrderRemark backOrderRemark) {
        int i=this.insert("com.ningpai.order.dao.BackOrderRemarkMapper.addBackOrderRemarkAjax",backOrderRemark);
                System.out.println(i+"-------------------------------------");
    }
}
