package com.ningpai.task;

import com.ningpai.dst.order.service.DstOrderService;
import com.ningpai.order.bean.BackOrder;
import com.ningpai.order.service.BackOrderService;
import com.ningpai.order.service.OrderService;
import com.ningpai.util.TaskScheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 每2分钟查询一次np_order表，将未推送的ERP订单推送上去
 */
@Controller
public class SynTradeTask{

    @Autowired
    private DstOrderService dstOrderService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private BackOrderService backOrderService;

    public void run() {
        System.out.println("检查订单推送ERP情况-------------------------------");
        List list = orderService.querySynOrder();
        int num = 0;
        for (Object o : list) {
            Long orderId = (Long) o;
            String result = dstOrderService.synUpdateOrderToERP(orderId);
            if("1".equals(result)){
                num++;
            }
        }
        System.out.println("-------------订单未推送数："+list.size()+"，本次推送成功数："+num+"-------------");
        /*System.out.println("检查退货单、退款单推送ERP情况中-------------------------------");
        List list2 = backOrderService.querySynBackOrder();
        int num2 = 0;
        for (Object o : list2) {
            BackOrder backOrder = (BackOrder) o;
            if("1".equals(backOrder.getIsBack())){
                if("6".equals(backOrder.getBackCheck())){
                    //退款
                    int i = dstOrderService.synAddBackOrderPrice(backOrder.getOrderCode());
                    if(i==1){
                        num2++;
                    }
                }else{
                    //退货
                    int i = dstOrderService.synAddBackOrder(backOrder.getOrderCode());
                    if(i==1){
                        num2++;
                    }
                }
            }else if("2".equals(backOrder.getIsBack())){
                //退款
                int i = dstOrderService.synAddBackOrderPrice(backOrder.getOrderCode());
                if(i==1){
                    num2++;
                }
            }
        }
        System.out.println("-------------退款退货单未推送数："+list2.size()+"，本次推送成功数："+num2+"-------------");*/
    }
}
