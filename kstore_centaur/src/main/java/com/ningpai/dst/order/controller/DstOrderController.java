package com.ningpai.dst.order.controller;

import com.ningpai.dst.order.bean.DstOrder;
import com.ningpai.dst.order.service.DstOrderService;
import com.ningpai.util.XStreamUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 电商通订单控制器
 */
@Controller
public class DstOrderController {

    @Resource
    private DstOrderService dstOrderService;

    /**
     * 批量获取订单
     * @param response
     * @param request
     */
    @RequestMapping("/dstGetOrder")
    public void dstGetOrder(HttpServletResponse response, HttpServletRequest request) {
        TreeMap map = new TreeMap();
        //create_time,pay_time,audit_time,send_time
        map.put("timeType","create_time");
        map.put("startTime","2018-04-15 00:00:00");
        map.put("endTime","2018-04-25 00:00:00");
        map.put("orderCode",request.getParameter("orderCode"));
        map.put("platOrderCode",request.getParameter("platOrderCode"));
        //state_1_notAudit未审核 state_2_audit已审核 state_3_sendOrder已生成发货单 state_9_send已发货(不填默认为state_9_send已发货状态)
        map.put("orderStatus","state_1_notAudit");
        map.put("sysTradeStatus",request.getParameter("sysTradeStatus"));
        map.put("warehouseId",request.getParameter("warehouseId"));
        map.put("expressCode",request.getParameter("expressCode"));
        map.put("outSid",request.getParameter("outSid"));
        map.put("pageSize","100");
        map.put("pageIndex","0");
        Map resultMap = dstOrderService.dstGetOrder(map);
        XStreamUtil.responseXml(response, resultMap);
    }

    /**
     * 批量获取售后单
     * @param response
     * @param request
     */
    @RequestMapping("/dstGetRefundOrder")
    public void dstGetRefundOrder(HttpServletResponse response, HttpServletRequest request) {
        TreeMap map = new TreeMap();
        //1.退货入库（默认） 2.换货入库 3.换货出库 4.补发出库
        map.put("type","1");
        map.put("startTime","2018-04-15 00:00:00");
        map.put("endTime","2018-04-25 00:00:00");
        map.put("warehouseId","1");
        map.put("refundCode",request.getParameter("refundCode"));
        //补发换货出库才有此值
        map.put("sendCode",request.getParameter("sendCode"));
        map.put("tid",request.getParameter("tid"));
        map.put("shopId",request.getParameter("shopId"));
        map.put("expressCode",request.getParameter("expressCode"));
        map.put("pageSize","100");
        map.put("pageIndex","0");
        Map resultMap = dstOrderService.dstGetRefundOrder(map);
        XStreamUtil.responseXml(response, resultMap);
    }

    /**
     * 创建订单
     * @param response
     * @param dstOrder
     */
    @RequestMapping("/dstAddOrder")
    public void dstAddOrder(HttpServletResponse response, DstOrder dstOrder) {
        List orderList = new ArrayList();
        orderList.add(dstOrder);
        Map resultMap = dstOrderService.dstAddOrder(orderList);
        XStreamUtil.responseXml(response, resultMap);
    }

    /**
     * 支付成功后，添加订单到ERP
     */
    @RequestMapping(value = "/synUpdateOrderToERP",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String synUpdateOrderToERP(Long orderId){
        return dstOrderService.synUpdateOrderToERP(orderId);
    }

    /**
     * 根据订单编号查询ERP的订单状态并修改
     * @param orderId
     * @return
     */
    @RequestMapping(value = "/synUpdateOrderStatus",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String synUpdateOrderStatus(Long[] orderId, HttpServletRequest request) {
        String result = dstOrderService.synUpdateOrderStatus(orderId, request);
        Pattern pattern = Pattern.compile("[0-9]*");
        Matcher isNum = pattern.matcher(result);
        if( !isNum.matches() ){
            return result;
        }else {
            if(Integer.valueOf(result)>0) {
                return "本次共更新"+result+"条订单！";
            }else{
                return "暂无可更新的订单！";
            }
        }
    }

    /**
     * 退款申请提交时ERP生成退款单
     * @param orderCode
     * @return
     */
    @RequestMapping("/synAddBackOrderPrice")
    @ResponseBody
    public int synAddBackOrderPrice(String orderCode) {
        return dstOrderService.synAddBackOrderPrice(orderCode);
    }

    /**
     * 退货申请提交时ERP生成退货单、退款单
     * @param orderCode
     * @return
     */
    @RequestMapping("/synAddBackOrder")
    @ResponseBody
    public int synAddBackOrder(String orderCode) {
        return dstOrderService.synAddBackOrder(orderCode);
    }


}
