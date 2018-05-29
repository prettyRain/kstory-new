package com.ningpai.order.service.impl;

import com.ningpai.order.bean.BackOrderRemark;
import com.ningpai.order.dao.BackOrderRemarkMapper;
import com.ningpai.order.service.BackOrderRemarkService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/12.
 */
@Service("backOrderRemarkService")
public class BackOrderRemarkServiceImpl implements BackOrderRemarkService {
    @Resource(name="BackOrderRemarkMapper")
    private BackOrderRemarkMapper backOrderRemarkMapper;
    @Override
    public Integer getRemarkTotal(Long backOrderId) {
        return backOrderRemarkMapper.getRemarkTotal(backOrderId);
    }

    @Override
    public List<BackOrderRemark> getBackOrderRemarks(Map map) {
        return this.backOrderRemarkMapper.getBackOrderRemarks(map);
    }

    @Override
    public void addBackOrderRemarkAjax(BackOrderRemark backOrderRemark) {
         this.backOrderRemarkMapper.addBackOrderRemarkAjax(backOrderRemark);
    }
}
