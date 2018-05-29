package com.ningpai.dst.order.service;

import com.ningpai.common.util.DateUtil;
import com.ningpai.customer.bean.CustomerInfo;
import com.ningpai.customer.dao.CustomerInfoMapper;
import com.ningpai.dst.order.bean.*;
import com.ningpai.goods.vo.GoodsProductVo;
import com.ningpai.order.bean.*;
import com.ningpai.order.controller.BackOrderController;
import com.ningpai.order.dao.OrderGoodsMapper;
import com.ningpai.order.service.BackOrderLogService;
import com.ningpai.order.service.BackOrderService;
import com.ningpai.order.service.OrderCouponService;
import com.ningpai.order.service.OrderService;
import com.ningpai.util.ERPUtil;
import com.ningpai.util.MethodConstants;
import com.ningpai.util.ResultUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONString;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 电商通订单service
 */
@Service
public class DstOrderService {

    @Resource
    private OrderService orderService;

    @Resource
    private BackOrderService backOrderService;

    @Resource
    private OrderCouponService orderCouponService;

    @Resource
    private BackOrderController backOrderController;

    @Resource
    private OrderGoodsMapper orderGoodsMapper;

    @Resource
    private CustomerInfoMapper customerInfoMapper;

    @Resource
    private BackOrderLogService backOrderLogService;
    /**
     * 订单查询
     * @return
     */
    public Map dstGetOrder(TreeMap map) {
        Map resultMap = new HashMap();
        //订单接口需要传shopId，从数据库读取
        map.put("shopId","1");
        String result = ERPUtil.requestDST(map, "dstOrderBatchget");
        if(result==null || "".equals(result)){
            resultMap.put("message","接口调用失败");
            return resultMap;
        }
        JSONObject resultJson = JSONObject.fromObject(result);
        //判断返回结果是否成功（code）
        String code = (String) resultJson.get("code");
        resultMap.put("code",code);
        if(!"0000".equals(code) || "failure".equals((String) resultJson.get("flag"))){
            if(code.indexOf("ERROR-PLAT")>-1){
                resultMap.put("message",resultJson.get("msg"));
            }else {
                resultMap.put("message", resultJson.get("message"));
            }
            return resultMap;
        }
        JSONObject dataJson = JSONObject.fromObject(resultJson.get("data"));
        //获取分页信息
        JSONObject orderPageInfo = JSONObject.fromObject(dataJson.get("orderPageInfo"));
        resultMap.put("pageIndex",orderPageInfo.get("pageIndex"));
        resultMap.put("pageSize",orderPageInfo.get("pageSize"));
        resultMap.put("total",orderPageInfo.get("totalAmount"));
        System.out.println("查询结果总数--------------" + orderPageInfo.get("totalAmount"));
        //获取订单列表
        Map<String, Class> paramMap = new HashMap<String, Class>();
        paramMap.put("goodsList", DstOrderGoodsChild.class);
        JSONArray jsonArray = JSONArray.fromObject(dataJson.get("orderList"));
        List list = new ArrayList();
        for (int i = 0; i < jsonArray.size(); i++) {
            list.add(JSONObject.toBean(jsonArray.getJSONObject(i), DstOrderVo.class, paramMap));
        }
        resultMap.put("orderList",list);
        resultMap.put("message","订单查询成功");
        return resultMap;
    }

    /**
     * 批量添加订单
     * @param orderList
     * @return
     */
    public Map dstAddOrder(List<DstOrder> orderList){
        TreeMap map = new TreeMap();
        for (DstOrder dstOrder : orderList) {
            if(dstOrder==null){
                return null;
            }
            //订单接口需要传shopId，从数据库读取
            dstOrder.setShopId(ERPUtil.getShopId());
        }
        map.put("order",orderList);
        String result = ERPUtil.requestDST(map, "dstOrderBatchAdd");
        map.clear();
        map.put("flag",null);
        map.put("code",null);
        map.put("message",null);
        return ResultUtil.resultToMap(result,map);
    }

    /**
     * 批量获取售后单
     * @param map
     * @return
     */
    public Map dstGetRefundOrder(TreeMap map){
        Map resultMap = new HashMap();
        //订单接口需要传shopId，从数据库读取
        map.put("shopId","1");
        String result = ERPUtil.requestDST(map, "dstRefundOrderBatchget");
        if(result==null || "".equals(result)){
            return null;
        }
        JSONObject resultJson = JSONObject.fromObject(result);
        //判断返回结果是否成功（code）
        String code = (String) resultJson.get("code");
        resultMap.put("code",code);
        if(!"0000".equals(code) || "failure".equals((String) resultJson.get("flag"))){
            if(code.indexOf("ERROR-PLAT")>-1){
                resultMap.put("message",resultJson.get("msg"));
            }else {
                resultMap.put("message", resultJson.get("message"));
            }
            resultMap.put("data",resultJson.get("data"));
            return resultMap;
        }
        JSONObject dataJson = JSONObject.fromObject(resultJson.get("data"));
        //获取分页信息
        resultMap.put("total",dataJson.get("total"));
        System.out.println("查询结果总数--------------" + dataJson.get("total"));
        //获取订单列表
        Map<String, Class> paramMap = new HashMap<String, Class>();
        paramMap.put("refundOrderGoodsList", DstRefundOrderGoods.class);
        JSONArray jsonArray = JSONArray.fromObject(dataJson.get("refundOrderList"));
        List list = new ArrayList();
        for (int i = 0; i < jsonArray.size(); i++) {
            list.add(JSONObject.toBean(jsonArray.getJSONObject(i), DstOrderVo.class, paramMap));
        }
        resultMap.put("refundOrderList",list);
        return resultMap;
    }

    /**
     * 支付成功后，添加订单到ERP（ERP不支持订单修改，只有在订单支付成功才添加）
     * @return
    */
    @Transactional
    public synchronized String synUpdateOrderToERP(Long orderId){
        Order order = orderService.orderDetail(orderId);
        //只有付款成功的订单才推送到电商通
        if(order==null || !"1".equals(order.getOrderStatus()) ){
            return "未付款订单无法推送";
        }
        //boss定时执行任务，防止与头像审核任务冲突，用np_customer_info
        CustomerInfo customer = customerInfoMapper.selectByCustomerId(order.getCustomerId());
        //查询订单是否已存在
        TreeMap map = new TreeMap();
        map.put("platOrderCode",order.getOrderCode());
        map.put("timeType","create_time");
        map.put("orderStatus","state_1_notAudit");
        map.put("startTime",DateUtil.dateToString(order.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
        map.put("endTime", DateUtil.dateToString(DateUtil.addSomeDays(order.getCreateTime(),1),"yyyy-MM-dd HH:mm:ss"));
        Map queryMap = this.dstGetOrder(map);
        if(queryMap ==null || (!"0000".equals(queryMap.get("code")) && !"200".equals(queryMap.get("code")))){
            //推送失败，boss定时任务会重新推送
            return queryMap.get("message").toString();
        }
        List orderList = (List) queryMap.get("orderList");
        if(orderList==null || orderList.size()==0) {
            DstOrder dstOrder = new DstOrder();
            //平台订单编号
            dstOrder.setOrderCode(order.getOrderCode());
            //买家昵称
            dstOrder.setBuyerNick(customer.getInfoRealname());
            if(customer.getInfoRealname() == null || "".equals(customer.getInfoRealname())){
                dstOrder.setBuyerNick(customer.getInfoMobile());
            }
            //订单状态(waiting_buyer_to_pay:等待买家付款 buyers_have_paid:买家已付款 sellers_have_been_shipped:卖家已发货 trade_finished:交易成功 trade_closed:交易关闭)
            dstOrder.setOrderStatus("买家已付款");
            //时间
            dstOrder.setCreated(DateUtil.dateToString(order.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
            dstOrder.setPayTime(DateUtil.dateToString(order.getPayTime(),"yyyy-MM-dd HH:mm:ss"));
            //金额
            dstOrder.setPostCharge(String.valueOf(order.getExpressPrice()));
            dstOrder.setTotalCharge(String.valueOf(order.getOrderPrice()));
            //收货信息
            dstOrder.setBuyerMessage(order.getCustomerRemark());
            dstOrder.setReceiverName(order.getShippingPerson());
            dstOrder.setReceiverMobile(order.getShippingMobile());
            dstOrder.setReceiverState(order.getShippingProvince());
            dstOrder.setReceiverCity(order.getShippingCity());
            dstOrder.setReceiverDistrict(order.getShippingCounty());
            dstOrder.setReceiverAddress(order.getShippingAddress());
            //商品明细
            List<DstOrderGoods> goodsList = new ArrayList<DstOrderGoods>();
            List<OrderGoods> orderGoodsList = order.getOrderGoodsList();
            for (OrderGoods orderGoods : orderGoodsList) {
                DstOrderGoods dstOrderGoods = new DstOrderGoods();
                dstOrderGoods.setOuterId(orderGoods.getGoodsInfoItemNo());
                dstOrderGoods.setTitle(orderGoods.getGoodsInfoName());
                dstOrderGoods.setNumber(String.valueOf(orderGoods.getGoodsInfoNum()));
                dstOrderGoods.setSalePrice(String.valueOf(orderGoods.getGoodsInfoPrice()));
                goodsList.add(dstOrderGoods);
            }
            dstOrder.setGoodsList(goodsList);
            //新增ERP订单
            orderList = new ArrayList();
            orderList.add(dstOrder);
            Map resultMap = this.dstAddOrder(orderList);
            if (resultMap != null && "success".equals(resultMap.get("flag"))) {
                System.out.println("已生成ERP订单-------" + order.getOrderCode() + "，生成时间：" + DateUtil.dateToString(new Date(),"yyyy-MM-dd HH:mm:ss"));
                //修改订单的推送状态为1
                orderService.synOrderSuccess(orderId);
                return "1";
            }
        }
        return "该电商通订单已存在";
    }

    /**
     * 根据订单编号查询ERP的订单状态并修改
     * @param orderId
     * @param request
     * @return
    */
    @Transactional
    public synchronized String synUpdateOrderStatus(Long[] orderId, HttpServletRequest request) {
        int num = 0;
        for (int i = 0; i < orderId.length; i++) {
            Order order = orderService.orderDetail(orderId[i],null);
            int returnGoodsNum = 0;
            for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                if("1".equals(orderGoods.getOrderGoodsStatus()) || "2".equals(orderGoods.getOrderGoodsStatus()) || "4".equals(orderGoods.getOrderGoodsStatus())){
                    returnGoodsNum++;
                }
            }
            // 判断商城订单状态是否符合条件 (如果订单状态不正确，则不进行该订单的查询)
            //未发货订单，更新是否发货
            if ("1".equals(order.getOrderStatus())) {
                //查询商城已付款未发货订单在ERP是否发货
                TreeMap map = new TreeMap();
                map.put("platOrderCode",order.getOrderCode());
                map.put("timeType","create_time");
                map.put("orderStatus","state_9_send");
                map.put("startTime",DateUtil.dateToString(order.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
                map.put("endTime", DateUtil.dateToString(DateUtil.addSomeDays(order.getCreateTime(),1),"yyyy-MM-dd HH:mm:ss"));
                Map map1 = this.dstGetOrder(map);
                if(map1 ==null || (!"0000".equals(map1.get("code")) && !"200".equals(map1.get("code")))){
                    return map1.get("message").toString();
                }
                List<Object> list = (List) map1.get("orderList");
                if(list!=null && list.size()>0){
                    DstOrderVo dstOrderVo = (DstOrderVo) (list.get(0));
                    //更新订单状态为发货
                    OrderExpress orderExpress = new OrderExpress();
                    orderExpress.setDelFlag("0");
                    orderExpress.setExpressName(dstOrderVo.getExpressName());
                    orderExpress.setExpressNo(dstOrderVo.getOutSid());
                    orderExpress.setExpressId(Long.valueOf(dstOrderVo.getExpressId()));
                    orderExpress.setOrderId(order.getOrderId());
                    orderService.sendOrder(orderExpress);
                    num++;
                }
            }/*else if("15".equals(order.getOrderStatus())){
                //退款中的订单更新是否同意退款
                TreeMap map = new TreeMap();
                map.put("platfrom_code",order.getOrderCode());
                map.put("type","1");
                map.put("warehouseId","1");
                map.put("startTime",DateUtil.dateToString(order.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
                map.put("endTime", DateUtil.dateToString(DateUtil.addSomeDays(order.getCreateTime(),1),"yyyy-MM-dd HH:mm:ss"));
                Map map1 = this.dstGetRefundOrder(map);
                if(gPageBean.getRows()>0 && gPageBean.getList().size()>0){
                    BackOrder backOrder = backOrderService.isBackOrder(order.getOrderCode());
                    GTradeRefund gTradeRefund = (GTradeRefund) gPageBean.getList().get(0);
                    if(gTradeRefund.isApprove() && !gTradeRefund.isCancel() && gTradeRefund.getAgree_refuse()!=null && gTradeRefund.getAgree_refuse()==1){
                        //同意退款
                        int n = 0;
                        for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                            if("4".equals(orderGoods.getOrderGoodsStatus())){
                                //更新订单商品状态为5（退款成功）
                                Map<String, Object> param = new HashMap<String, Object>();
                                param.put("orderId", order.getOrderId());
                                param.put("backOrderCode", backOrder.getBackOrderCode());
                                param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                param.put("orderGoodsStatus", '5');
                                n = n + orderGoodsMapper.updateOrderGoodsBackNew(param);
                            }
                        }
                        if("1".equals(backOrder.getIsBack())) {
                            //退货的退款，订单状态改变为未评价或交易完成
                            orderService.updateStatusBackById(order.getOrderId(), "3", backOrder.getBackPrice());
                        }else{
                            // 如果退单操作日志为 admin 退款，则改变订单状态为 18 已退款 并记录退款金额
                            orderService.updateStatusBackById(order.getOrderId(), "18", backOrder.getBackPrice());
                        }
                        // 改变退单列表状态为 4 退单结束
                        int cont = backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "4");
                        // 退单结束后把成功消费的积分奖励扣除掉,增加取消订单的积分记录,以及消费记录
                        if (cont == 1) {
                            backOrderService.reducePointOrderBack(order.getOrderId());
                            //根据订单id查询到优惠劵劵码，修改优惠劵  返还库存
                            orderCouponService.modifyCouponStatus(order.getOrderId());
                            // 记录退单操作日志
                            BackOrderLog backOrderLog = new BackOrderLog();
                            backOrderLog.setBackLogPerson("customer");
                            backOrderLog.setBackLogTime(new Date());
                            backOrderLog.setBackLogStatus("8");
                            backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                            backOrderLogService.insert(backOrderLog);
                        }
                        if(order.getGiftcardPrice() != null && order.getGiftcardPrice().compareTo(new BigDecimal(0)) > 0){
                            //支付类型是预存款支付，退款或退单
                            backOrderController.updateDepositInfo(order, order.getGiftcardPrice(), backOrder, request);
                        }
                        //订单通知消息
                        backOrderController.addOrderNotice(order.getOrderId(),order,"退款成功，请留意您的账户！","退款成功");
                        //退款完成后，ERP原订单修改退款状态，作废，保证ERP库存正确
                        for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                            map.clear();
                            map.put("tid",order.getOrderCode());
                            map.put("oid",orderGoods.getOrderGoodsId());
                            map.put("refund_state",1);
                            synUpdateTradeRefund(map);
                        }
                        num++;
                    }else if(gTradeRefund.isApprove() && !gTradeRefund.isCancel() && gTradeRefund.getAgree_refuse()!=null && gTradeRefund.getAgree_refuse()==2){
                        //拒绝退款
                        int n = 0;
                        for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                            if("4".equals(orderGoods.getOrderGoodsStatus())){
                                //更新订单商品状态为6（拒绝退款）
                                Map<String, Object> param = new HashMap<String, Object>();
                                param.put("orderId", order.getOrderId());
                                param.put("backOrderCode", backOrder.getBackOrderCode());
                                param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                param.put("orderGoodsStatus", '6');
                                n = n + orderGoodsMapper.updateOrderGoodsBackNew(param);
                            }
                        }
                        if("1".equals(backOrder.getIsBack())){
                            //退货的退款，订单状态改变为未评价或交易完成
                            orderService.updateStatusBackById(order.getOrderId(), "3", backOrder.getBackPrice());
                        }else {
                            // 如果退单操作日志为 admin 退款，则改变订单状态为 1 待发货
                            orderService.updateStatusBackById(order.getOrderId(), "1", backOrder.getBackPrice());
                        }
                        // 改变退单列表状态为 4 退单结束
                        int cont = backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "7");
                        if (cont == 1) {
                            // 记录退单操作日志
                            BackOrderLog backOrderLog = new BackOrderLog();
                            backOrderLog.setBackLogPerson("customer");
                            backOrderLog.setBackLogTime(new Date());
                            backOrderLog.setBackLogStatus("9");
                            backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                            backOrderLogService.insert(backOrderLog);
                        }
                        //订单通知消息
                        backOrderController.addOrderNotice(order.getOrderId(),order,"拒绝退款，有疑问请与客服人员联系！","拒绝退款");
                        //退款拒绝后，ERP原订单修改退款状态
                        for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                            map.clear();
                            map.put("tid",order.getOrderCode());
                            map.put("oid",orderGoods.getOrderGoodsId());
                            map.put("refund_state",0);
                            synUpdateTradeRefund(map);
                        }
                        num++;
                    }
                }
            }else if("14".equals(order.getOrderStatus())){
                //退货中的订单更新是否同意退货
                TreeMap map = new TreeMap();
                map.put("platform_code",order.getOrderCode());
                map.put("cancel",0);
                GPageBean gPageBean = synGetTradeReturn(new GPageBean(), map);
                if(gPageBean.getObjectBean()!=null){
                    return gPageBean.getObjectBean().toString();
                }
                if(gPageBean.getRows()>0 && gPageBean.getList().size()>0){
                    BackOrder backOrder = backOrderService.isBackOrder(order.getOrderCode());
                    GReturn gReturn = (GReturn) gPageBean.getList().get(0);
                    //含有礼品卡支付的退货退款，erp退款金额为0
                    BigDecimal backPrice = BigDecimal.ZERO;
                    if(gReturn.getPayments()!=null && "giftcard".equals(gReturn.getPayments().get(0).getPay_type_code())){
                        backPrice = backOrder.getBackPrice();
                    }else {
                        backPrice = gReturn.getPayments().get(0).getPayment();
                    }
                    if(gReturn.getAgree_refuse()!=null && gReturn.getAgree_refuse()==1){
                        //同意退货
                        //未入库，待商家收货
                        for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                            if("1".equals(orderGoods.getOrderGoodsStatus())){
                                //更新订单商品状态为2（待商家收货）
                                Map<String, Object> param = new HashMap<String, Object>();
                                param.put("orderId", order.getOrderId());
                                param.put("backOrderCode", backOrder.getBackOrderCode());
                                param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                param.put("orderGoodsStatus", '2');
                                orderGoodsMapper.updateOrderGoodsBackNew(param);
                            }
                        }
                        orderService.updateStatusBackById(order.getOrderId(), "10", backPrice);//待商家收货状态
                        //同意退货  跳过了让客户填写物流地址的那一步 xcy
                        backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "3");
                        // 记录退单操作日志
                        BackOrderLog backOrderLog = new BackOrderLog();
                        backOrderLog.setBackLogPerson("customer");
                        backOrderLog.setBackLogTime(new Date());
                        backOrderLog.setBackLogStatus("2");
                        backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                        backOrderLogService.insert(backOrderLog);
                        num++;
                    }else if(gReturn.getAgree_refuse()!=null && gReturn.getAgree_refuse()==2){
                        //拒绝退货
                        int n = 0;
                        for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                            if("1".equals(orderGoods.getOrderGoodsStatus())){
                                //更新订单商品状态为7（拒绝退货）
                                Map<String, Object> param = new HashMap<String, Object>();
                                param.put("orderId", order.getOrderId());
                                param.put("backOrderCode", backOrder.getBackOrderCode());
                                param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                param.put("orderGoodsStatus", '7');
                                n = n + orderGoodsMapper.updateOrderGoodsBackNew(param);
                            }
                        }
                        if(n>0){
                            orderService.updateStatusBackById(order.getOrderId(), "3", backPrice);
                        }else {
                            orderService.updateStatusBackById(order.getOrderId(), "9", backPrice);
                        }
                        // 改变退单列表状态为 2 拒绝退货
                        backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "2");
                        // 记录退单操作日志
                        BackOrderLog backOrderLog = new BackOrderLog();
                        backOrderLog.setBackLogPerson("customer");
                        backOrderLog.setBackLogTime(new Date());
                        backOrderLog.setBackLogStatus("3");
                        backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                        backOrderLogService.insert(backOrderLog);
                        //订单通知消息
                        backOrderController.addOrderNotice(order.getOrderId(),order,"退货申请已驳回，有疑问请与客服人员联系！","退货申请已驳回");
                        num++;
                    }
                }
            }else if("10".equals(order.getOrderStatus())){
                //退货中的订单，待商家收货状态
                TreeMap map = new TreeMap();
                map.put("platform_code",order.getOrderCode());
                map.put("cancel",0);
                GPageBean gPageBean = synGetTradeReturn(new GPageBean(), map);
                if(gPageBean.getObjectBean()!=null){
                    return gPageBean.getObjectBean().toString();
                }
                if(gPageBean.getRows()>0 && gPageBean.getList().size()>0){
                    BackOrder backOrder = backOrderService.isBackOrder(order.getOrderCode());
                    GReturn gReturn = (GReturn) gPageBean.getList().get(0);
                    if(gReturn.getAgree_refuse()!=null && gReturn.getAgree_refuse()==1 && gReturn.getReceive()==1){
                        //确认收货，入库成功
                        //查询生成的退款单是否同意退款
                        map.clear();
                        map.put("platfrom_code",order.getOrderCode());
                        map.put("cancel",0);
                        GPageBean gPageBean2 = synGetTradeRefund(new GPageBean(), map);
                        if(gPageBean2.getObjectBean()!=null){
                            return gPageBean2.getObjectBean().toString();
                        }
                        if(gPageBean2.getRows()>0 && gPageBean2.getList().size()>0) {
                            GTradeRefund gTradeRefund = (GTradeRefund) gPageBean2.getList().get(0);
                            BigDecimal backPrice = BigDecimal.ZERO;
                            //含有礼品卡支付的退货退款，erp退款金额为0
                            if(gTradeRefund.getAmount().compareTo(BigDecimal.ZERO)>0) {
                                backPrice = gTradeRefund.getAmount();
                            }else{
                                backPrice = backOrder.getBackPrice();
                            }
                            if (gTradeRefund.isApprove() && !gTradeRefund.isCancel() && gTradeRefund.getAgree_refuse() != null && gTradeRefund.getAgree_refuse() == 1) {
                                //同意退款，则退货成功，显示已退款，入库存
                                int n = 0;
                                for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                    if("2".equals(orderGoods.getOrderGoodsStatus())){
                                        //更新订单商品状态为3（退货成功）
                                        Map<String, Object> param = new HashMap<String, Object>();
                                        param.put("orderId", order.getOrderId());
                                        param.put("backOrderCode", backOrder.getBackOrderCode());
                                        param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                        param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                        param.put("orderGoodsStatus", '3');
                                        n = n + orderGoodsMapper.updateOrderGoodsBackNew(param);
                                    }
                                }
                                if(n>0){
                                    orderService.updateStatusBackById(order.getOrderId(), "3", backPrice);
                                }else {
                                    orderService.updateStatusBackById(order.getOrderId(), "17", backPrice);
                                }
                                BackOrder bo = new BackOrder();
                                bo.setBackOrderId(backOrder.getBackOrderId());
                                bo.setBackPrice(backPrice);
                                //修改订单退款金额时修改退单表金额
                                backOrderService.updateBackOrderReducePrice(bo);
                                // 改变退单列表状态为 4 退单结束
                                int cont = backOrderService.modifyBackOrderByCheckNew(backOrder.getBackOrderId(), "4");
                                // 退单结束后把成功消费的积分奖励扣除掉,增加取消订单的积分记录,以及消费记录
                                if (cont == 1) {
                                    backOrderService.reducePointOrderBack(order.getOrderId());
                                    //根据订单id查询到优惠劵劵码，修改优惠劵  返还库存
                                    orderCouponService.modifyCouponStatus(order.getOrderId());
                                    // 记录退单操作日志
                                    BackOrderLog backOrderLog = new BackOrderLog();
                                    backOrderLog.setBackLogPerson("customer");
                                    backOrderLog.setBackLogTime(new Date());
                                    backOrderLog.setBackLogStatus("8");
                                    backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                                    backOrderLogService.insert(backOrderLog);
                                }
                                //支付类型是预存款支付，退款或退单
                                backOrderController.updateDepositInfo(order, backPrice, backOrder, request);
                                //订单通知消息
                                backOrderController.addOrderNotice(order.getOrderId(),order,"退货成功，感谢您的支持！","退货成功");
                                //退款完成后，ERP原订单修改退款状态，作废，保证ERP库存正确
                                for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                    map.clear();
                                    map.put("tid",order.getOrderCode());
                                    map.put("oid",orderGoods.getOrderGoodsId());
                                    map.put("refund_state",1);
                                    synUpdateTradeRefund(map);
                                }
                                num++;
                            }else if(gTradeRefund.isApprove() && !gTradeRefund.isCancel() && gTradeRefund.getAgree_refuse()!=null && gTradeRefund.getAgree_refuse()==2){
                                //拒绝退款，则退货失败，入残次品库
                                int n = 0;
                                for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                    if("2".equals(orderGoods.getOrderGoodsStatus())){
                                        //更新订单商品状态为8（退货失败）
                                        Map<String, Object> param = new HashMap<String, Object>();
                                        param.put("orderId", order.getOrderId());
                                        param.put("backOrderCode", backOrder.getBackOrderCode());
                                        param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                        param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                        param.put("orderGoodsStatus", '8');
                                        n = n + orderGoodsMapper.updateOrderGoodsBackNew(param);
                                    }
                                }
                                if(n>0){
                                    orderService.updateStatusBackById(order.getOrderId(), "3", backPrice);
                                }else {
                                    // 如果退单操作日志为 admin 收货失败，则改变订单状态为 16 收货失败
                                    orderService.updateStatusBackById(order.getOrderId(), "16", backPrice);
                                }
                                // 改变退单列表状态为 8 收货失败
                                backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "8");
                                // 记录退单操作日志
                                BackOrderLog backOrderLog = new BackOrderLog();
                                backOrderLog.setBackLogPerson("customer");
                                backOrderLog.setBackLogTime(new Date());
                                backOrderLog.setBackLogStatus("6");
                                backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                                backOrderLogService.insert(backOrderLog);
                                //订单通知消息
                                backOrderController.addOrderNotice(order.getOrderId(),order,"退货失败，有疑问请与客服人员联系！","退货失败");
                                num++;
                            }
                        }
                    }
                }
            }else if("3".equals(order.getOrderStatus()) && returnGoodsNum>0){
                //已完成订单，部分退货情况
                TreeMap map = new TreeMap();
                map.put("platform_code",order.getOrderCode());
                map.put("cancel",0);
                GPageBean gPageBean = synGetTradeReturn(new GPageBean(), map);
                if(gPageBean.getObjectBean()!=null){
                    return gPageBean.getObjectBean().toString();
                }
                if(gPageBean.getRows()>0 && gPageBean.getList().size()>0) {
                    BackOrder backOrder = backOrderService.isBackOrder(order.getOrderCode());
                    GReturn gReturn = (GReturn) gPageBean.getList().get(0);
                    //含有礼品卡支付的退货退款，erp退款金额为0
                    BigDecimal backPrice = BigDecimal.ZERO;
                    if (gReturn.getPayments() != null && "giftcard".equals(gReturn.getPayments().get(0).getPay_type_code())) {
                        backPrice = backOrder.getBackPrice();
                    } else {
                        backPrice = gReturn.getPayments().get(0).getPayment();
                    }
                    if(gReturn.getAgree_refuse()!=null && gReturn.getAgree_refuse()==1){
                        //同意退货
                        if(gReturn.getReceive()==0) {
                            //未入库，待商家收货
                            for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                if ("1".equals(orderGoods.getOrderGoodsStatus())) {
                                    //更新订单商品状态为2（待商家收货）
                                    Map<String, Object> param = new HashMap<String, Object>();
                                    param.put("orderId", order.getOrderId());
                                    param.put("backOrderCode", backOrder.getBackOrderCode());
                                    param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                    param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                    param.put("orderGoodsStatus", '2');
                                    orderGoodsMapper.updateOrderGoodsBackNew(param);
                                }
                            }
                            //同意退货  跳过了让客户填写物流地址的那一步 xcy
                            backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "3");
                            // 记录退单操作日志
                            BackOrderLog backOrderLog = new BackOrderLog();
                            backOrderLog.setBackLogPerson("customer");
                            backOrderLog.setBackLogTime(new Date());
                            backOrderLog.setBackLogStatus("2");
                            backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                            backOrderLogService.insert(backOrderLog);
                            num++;
                        }else if(gReturn.getReceive()==1){
                            //确认收货，入库成功
                            //查询生成的退款单是否同意退款
                            map.clear();
                            map.put("platfrom_code",order.getOrderCode());
                            map.put("cancel",0);
                            GPageBean gPageBean2 = synGetTradeRefund(new GPageBean(), map);
                            if(gPageBean2.getObjectBean()!=null){
                                return gPageBean2.getObjectBean().toString();
                            }
                            if(gPageBean2.getRows()>0 && gPageBean2.getList().size()>0) {
                                GTradeRefund gTradeRefund = (GTradeRefund) gPageBean2.getList().get(0);
                                BigDecimal backPrice2 = BigDecimal.ZERO;
                                //含有礼品卡支付的退货退款，erp退款金额为0
                                if(gTradeRefund.getAmount().compareTo(BigDecimal.ZERO)>0) {
                                    backPrice2 = gTradeRefund.getAmount();
                                }else{
                                    backPrice2 = backOrder.getBackPrice();
                                }
                                if (gTradeRefund.isApprove() && !gTradeRefund.isCancel() && gTradeRefund.getAgree_refuse() != null && gTradeRefund.getAgree_refuse() == 1) {
                                    //同意退款，则退货成功，显示已退款，入库存
                                    for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                        if("2".equals(orderGoods.getOrderGoodsStatus())){
                                            //更新订单商品状态为3（退货成功）
                                            Map<String, Object> param = new HashMap<String, Object>();
                                            param.put("orderId", order.getOrderId());
                                            param.put("backOrderCode", backOrder.getBackOrderCode());
                                            param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                            param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                            param.put("orderGoodsStatus", '3');
                                            orderGoodsMapper.updateOrderGoodsBackNew(param);
                                        }
                                    }
                                    BackOrder bo = new BackOrder();
                                    bo.setBackOrderId(backOrder.getBackOrderId());
                                    bo.setBackPrice(backPrice2);
                                    //修改订单退款金额时修改退单表金额
                                    backOrderService.updateBackOrderReducePrice(bo);
                                    // 改变退单列表状态为 4 退单结束
                                    int cont = backOrderService.modifyBackOrderByCheckNew(backOrder.getBackOrderId(), "4");
                                    // 退单结束后把成功消费的积分奖励扣除掉,增加取消订单的积分记录,以及消费记录
                                    if (cont == 1) {
                                        backOrderService.reducePointOrderBack(order.getOrderId());
                                        //根据订单id查询到优惠劵劵码，修改优惠劵  返还库存
                                        orderCouponService.modifyCouponStatus(order.getOrderId());
                                        // 记录退单操作日志
                                        BackOrderLog backOrderLog = new BackOrderLog();
                                        backOrderLog.setBackLogPerson("customer");
                                        backOrderLog.setBackLogTime(new Date());
                                        backOrderLog.setBackLogStatus("8");
                                        backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                                        backOrderLogService.insert(backOrderLog);
                                    }
                                    //支付类型是预存款支付，退款或退单
                                    backOrderController.updateDepositInfo(order, backPrice2, backOrder, request);
                                    //订单通知消息
                                    backOrderController.addOrderNotice(order.getOrderId(),order,"退货成功，感谢您的支持！","退货成功");
                                    //退款完成后，ERP原订单修改退款状态，作废，保证ERP库存正确
                                    for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                        map.clear();
                                        map.put("tid",order.getOrderCode());
                                        map.put("oid",orderGoods.getOrderGoodsId());
                                        map.put("refund_state",1);
                                        synUpdateTradeRefund(map);
                                    }
                                    num++;
                                }else if(gTradeRefund.isApprove() && !gTradeRefund.isCancel() && gTradeRefund.getAgree_refuse()!=null && gTradeRefund.getAgree_refuse()==2){
                                    //拒绝退款，则退货失败，入残次品库
                                    // 如果退单操作日志为 admin 收货失败，则改变订单状态为 16 收货失败
                                    for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                        if("2".equals(orderGoods.getOrderGoodsStatus())){
                                            //更新订单商品状态为8（退货失败）
                                            Map<String, Object> param = new HashMap<String, Object>();
                                            param.put("orderId", order.getOrderId());
                                            param.put("backOrderCode", backOrder.getBackOrderCode());
                                            param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                            param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                            param.put("orderGoodsStatus", '8');
                                            orderGoodsMapper.updateOrderGoodsBackNew(param);
                                        }
                                    }
                                    // 改变退单列表状态为 8 收货失败
                                    backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "8");
                                    // 记录退单操作日志
                                    BackOrderLog backOrderLog = new BackOrderLog();
                                    backOrderLog.setBackLogPerson("customer");
                                    backOrderLog.setBackLogTime(new Date());
                                    backOrderLog.setBackLogStatus("6");
                                    backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                                    backOrderLogService.insert(backOrderLog);
                                    //订单通知消息
                                    backOrderController.addOrderNotice(order.getOrderId(),order,"退货失败，有疑问请与客服人员联系！","退货失败");
                                    num++;
                                }
                            }
                        }
                    }else if(gReturn.getAgree_refuse()!=null && gReturn.getAgree_refuse()==2){
                        //拒绝退货
                        for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                            if("1".equals(orderGoods.getOrderGoodsStatus())){
                                //更新订单商品状态为7（拒绝退货）
                                Map<String, Object> param = new HashMap<String, Object>();
                                param.put("orderId", order.getOrderId());
                                param.put("backOrderCode", backOrder.getBackOrderCode());
                                param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                param.put("orderGoodsStatus", '7');
                                orderGoodsMapper.updateOrderGoodsBackNew(param);
                            }
                        }
                        // 改变退单列表状态为 2 拒绝退货
                        backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "2");
                        // 记录退单操作日志
                        BackOrderLog backOrderLog = new BackOrderLog();
                        backOrderLog.setBackLogPerson("customer");
                        backOrderLog.setBackLogTime(new Date());
                        backOrderLog.setBackLogStatus("3");
                        backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                        backOrderLogService.insert(backOrderLog);
                        //订单通知消息
                        backOrderController.addOrderNotice(order.getOrderId(),order,"退货申请已驳回，有疑问请与客服人员联系！","退货申请已驳回");
                        num++;
                    }
                }else{
                    //查询生成的退款单
                    map.clear();
                    map.put("platfrom_code",order.getOrderCode());
                    map.put("cancel",0);
                    GPageBean gPageBean2 = synGetTradeRefund(new GPageBean(), map);
                    if(gPageBean2.getObjectBean()!=null){
                        return gPageBean2.getObjectBean().toString();
                    }
                    if(gPageBean2.getRows()>0 && gPageBean2.getList().size()>0) {
                        BackOrder backOrder = backOrderService.isBackOrder(order.getOrderCode());
                        GTradeRefund gTradeRefund = (GTradeRefund) gPageBean2.getList().get(0);
                        BigDecimal backPrice2 = BigDecimal.ZERO;
                        //含有礼品卡支付的退货退款，erp退款金额为0
                        if(gTradeRefund.getAmount().compareTo(BigDecimal.ZERO)>0) {
                            backPrice2 = gTradeRefund.getAmount();
                        }else{
                            backPrice2 = backOrder.getBackPrice();
                        }
                        if (gTradeRefund.isApprove() && !gTradeRefund.isCancel() && gTradeRefund.getAgree_refuse() != null && gTradeRefund.getAgree_refuse() == 1) {
                            //同意退款
                            for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                if("4".equals(orderGoods.getOrderGoodsStatus())){
                                    //更新订单商品状态为5（退款成功）
                                    Map<String, Object> param = new HashMap<String, Object>();
                                    param.put("orderId", order.getOrderId());
                                    param.put("backOrderCode", backOrder.getBackOrderCode());
                                    param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                    param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                    param.put("orderGoodsStatus", '5');
                                    orderGoodsMapper.updateOrderGoodsBackNew(param);
                                }
                            }
                            BackOrder bo = new BackOrder();
                            bo.setBackOrderId(backOrder.getBackOrderId());
                            bo.setBackPrice(backPrice2);
                            //修改订单退款金额时修改退单表金额
                            backOrderService.updateBackOrderReducePrice(bo);
                            // 改变退单列表状态为 4 退单结束
                            int cont = backOrderService.modifyBackOrderByCheckNew(backOrder.getBackOrderId(), "4");
                            // 退单结束后把成功消费的积分奖励扣除掉,增加取消订单的积分记录,以及消费记录
                            if (cont == 1) {
                                backOrderService.reducePointOrderBack(order.getOrderId());
                                //根据订单id查询到优惠劵劵码，修改优惠劵  返还库存
                                orderCouponService.modifyCouponStatus(order.getOrderId());
                                // 记录退单操作日志
                                BackOrderLog backOrderLog = new BackOrderLog();
                                backOrderLog.setBackLogPerson("customer");
                                backOrderLog.setBackLogTime(new Date());
                                backOrderLog.setBackLogStatus("8");
                                backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                                backOrderLogService.insert(backOrderLog);
                            }
                            //支付类型是预存款支付，退款或退单
                            backOrderController.updateDepositInfo(order, backPrice2, backOrder, request);
                            //订单通知消息
                            backOrderController.addOrderNotice(order.getOrderId(),order,"退款成功，感谢您的支持！","退款成功");
                            //退款完成后，ERP原订单修改退款状态，作废，保证ERP库存正确
                            for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                map.clear();
                                map.put("tid",order.getOrderCode());
                                map.put("oid",orderGoods.getOrderGoodsId());
                                map.put("refund_state",1);
                                synUpdateTradeRefund(map);
                            }
                            num++;
                        }else if(gTradeRefund.isApprove() && !gTradeRefund.isCancel() && gTradeRefund.getAgree_refuse()!=null && gTradeRefund.getAgree_refuse()==2){
                            //拒绝退款，则退货失败
                            for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                                if("4".equals(orderGoods.getOrderGoodsStatus())){
                                    //更新订单商品状态为6（拒绝退款）
                                    Map<String, Object> param = new HashMap<String, Object>();
                                    param.put("orderId", order.getOrderId());
                                    param.put("backOrderCode", backOrder.getBackOrderCode());
                                    param.put("goodsInfoId", orderGoods.getGoodsInfoId());
                                    param.put("orderGoodsId", orderGoods.getOrderGoodsId());
                                    param.put("orderGoodsStatus", '6');
                                    orderGoodsMapper.updateOrderGoodsBackNew(param);
                                }
                            }
                            // 改变退单列表状态为 7 拒绝退款
                            backOrderService.modifyBackOrderByCheck(backOrder.getBackOrderId(), "7");
                            // 记录退单操作日志
                            BackOrderLog backOrderLog = new BackOrderLog();
                            backOrderLog.setBackLogPerson("customer");
                            backOrderLog.setBackLogTime(new Date());
                            backOrderLog.setBackLogStatus("9");
                            backOrderLog.setBackOrderId(backOrder.getBackOrderId());
                            backOrderLogService.insert(backOrderLog);
                            //订单通知消息
                            backOrderController.addOrderNotice(order.getOrderId(),order,"退款申请已驳回，有疑问请与客服人员联系！","退款申请已驳回");
                            num++;
                        }
                    }
                }
            }*/
        }
        return num+"";
    }

    /**
     * 退款申请提交时ERP生成退款单
     * @param orderCode
     * @return
     **/
    @Transactional
    public synchronized int synAddBackOrderPrice(String orderCode) {
        /*TreeMap map = new TreeMap();
        map.put("cancel",0);
        map.put("platfrom_code",orderCode);
        GPageBean gPageBean = synGetTradeRefund(new GPageBean(), map);
        if(gPageBean ==null){
            return 0;
        }
        if(gPageBean.getRows()==0) {
            map.clear();
            map.put("platform_code",orderCode);
            GPageBean gPageBean1 = synGetTrade(new GPageBean(), map);
            if(gPageBean1.getObjectBean()==null && gPageBean1.getRows()>0) {
                GOrder gOrder = (GOrder) gPageBean1.getList().get(0);
                GTradeRefundVo gTradeRefundVo = new GTradeRefundVo();
                //查询商城退单信息
                BackOrder backOrder = backOrderService.isBackOrder(orderCode);
                if (backOrder != null) {
                    //上传平台退款单号会导致平台同意退款失败？？？？？
                    //gTradeRefundVo.setRefund_code(backOrder.getBackOrderCode());
                    gTradeRefundVo.setRefund_type(0);
                    switch (Integer.valueOf(backOrder.getBackReason())) {
                        case 1:
                            gTradeRefundVo.setRefund_reason("不想买了");
                            break;
                        case 2:
                            gTradeRefundVo.setRefund_reason("收货信息有误");
                            break;
                        case 3:
                            gTradeRefundVo.setRefund_reason("商品未按时发货");
                            break;
                        case 4:
                            gTradeRefundVo.setRefund_reason("其他");
                            break;
                        case 5:
                            gTradeRefundVo.setRefund_reason("商品质量问题");
                            break;
                        case 6:
                            gTradeRefundVo.setRefund_reason("收到商品与描述不符");
                            break;
                        default:
                            break;
                    }
                    gTradeRefundVo.setTrade_code(gOrder.getCode());
                    gTradeRefundVo.setShop_code(gOrder.getShop_code());
                    gTradeRefundVo.setVip_code(gOrder.getVip_code());
                    gTradeRefundVo.setPayment_type_code("zhifubao");
                    Order order = orderService.getPayOrderByCode(orderCode);
                    if(order.getGiftcardPrice()==null){
                        order.setGiftcardPrice(BigDecimal.ZERO);
                    }
                    //单退款订单，退款时礼品卡部分退回礼品卡，第三方部分退回第三方，推送到ERP的只是第三方部分
                    BigDecimal amount = backOrder.getBackPrice().subtract(order.getGiftcardPrice());
                    if(amount.compareTo(BigDecimal.ZERO)<0){
                        amount = BigDecimal.ZERO;
                    }
                    gTradeRefundVo.setAmount(amount);
                    //退货订单的仅退款
                    for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                        if("4".equals(orderGoods.getOrderGoodsStatus())){
                            //包含礼品卡支付时，因全款退回礼品卡，不需要财务支付宝退款，故不推送退款金额；
                            if(order.getGiftcardPrice()!=null && order.getGiftcardPrice().compareTo(BigDecimal.ZERO)>0) {
                                gTradeRefundVo.setPayment_type_code("giftcard");
                                gTradeRefundVo.setAmount(BigDecimal.ZERO);
                            }else{
                                gTradeRefundVo.setPayment_type_code("zhifubao");
                                gTradeRefundVo.setAmount(backOrder.getBackPrice());
                            }
                        }
                    }
                    //新增退款单
                    Map map1 = synAddTradeRefund(gTradeRefundVo);
                    //原订单修改状态为退款中
                    //退款完成后，ERP原订单修改退款状态，作废，保证ERP库存正确
                    for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                        map.clear();
                        map.put("tid", orderCode);
                        map.put("oid", orderGoods.getOrderGoodsId());
                        map.put("refund_state", 2);
                        synUpdateTradeRefund(map);
                    }
                    if (map1 != null && map1.get("code") != null) {
                        backOrderService.synBackOrderSuccess(orderCode);
                        return 1;
                    }
                }
            }
        }*/
        return 0;
    }

    /**
     * 退货申请提交时ERP生成退货单、退款单（退货有退款明细，审核入库后ERP自动生成退款单；否则需要手动添加退款单）
     * @param orderCode
     * @return
     */
    @Transactional
    public synchronized int synAddBackOrder(String orderCode) {
        /*TreeMap map = new TreeMap();
        map.put("platform_code",orderCode);
        map.put("cancel",0);
        GPageBean gPageBean = synGetTradeReturn(new GPageBean(), map);
        if(gPageBean ==null){
            return 0;
        }
        if(gPageBean.getRows()==0) {
            map.clear();
            map.put("platform_code",orderCode);
            GPageBean gPageBean1 = synGetTrade(new GPageBean(), map);
            if(gPageBean1.getObjectBean()==null && gPageBean1.getRows()>0) {
                GOrder gOrder = (GOrder) gPageBean1.getList().get(0);
                GReturnVo gReturnVo = new GReturnVo();
                //查询商城退单信息
                BackOrder backOrder = backOrderService.queryBackOrderByOrderCode(orderCode);
                if (backOrder != null) {
                    //上传平台退款单号会导致平台同意退款失败？？？？？
                    gReturnVo.setType_code("001");
                    switch (Integer.valueOf(backOrder.getBackReason())) {
                        case 1:
                            gReturnVo.setNote("不想买了");
                            break;
                        case 2:
                            gReturnVo.setNote("收货信息有误");
                            break;
                        case 3:
                            gReturnVo.setNote("商品未按时发货");
                            break;
                        case 4:
                            gReturnVo.setNote("其他");
                            break;
                        case 5:
                            gReturnVo.setNote("商品质量问题");
                            break;
                        case 6:
                            gReturnVo.setNote("收到商品与描述不符");
                            break;
                        default:
                            break;
                    }
                    gReturnVo.setTrade_platform_code(orderCode);
                    gReturnVo.setTrade_code(gOrder.getCode());
                    gReturnVo.setShop_code(gOrder.getShop_code());
                    gReturnVo.setVip_code(gOrder.getVip_code());
                    //退货商品明细
                    List<GoodsProductVo> orderGoodslist = backOrder.getOrderGoodslistVo();
                    List<GReturnDetailVo> item_detail = new ArrayList<GReturnDetailVo>();
                    for (GoodsProductVo goodsProductVo : orderGoodslist) {
                        GReturnDetailVo gReturnDetailVo = new GReturnDetailVo();
                        gReturnDetailVo.setBarcode(goodsProductVo.getGoodsInfoBarcode());
                        //ERP退货商品有批次的情况下，暂时不能上传数量，需要人工设置
                        gReturnDetailVo.setQty(goodsProductVo.getGoodsCount().intValue());
                        gReturnDetailVo.setQty(0);
                        item_detail.add(gReturnDetailVo);
                    }
                    gReturnVo.setItem_detail(item_detail);
                    //退款明细（支付方式默认为支付宝，正式需对应支付代码）
                    Order order = orderService.getPayOrderByCode(orderCode);
                    if(order.getGiftcardPrice()==null){
                        order.setGiftcardPrice(BigDecimal.ZERO);
                    }
                    List<GRefundDetailVo> refund_detail = new ArrayList<GRefundDetailVo>();
                    GRefundDetailVo gRefundDetailVo = new GRefundDetailVo();
                    //包含礼品卡支付时，因全款退回礼品卡，不需要财务支付宝退款，故不推送退款金额；
                    if(order.getGiftcardPrice()!=null && order.getGiftcardPrice().compareTo(BigDecimal.ZERO)>0) {
                        gRefundDetailVo.setPay_type_code("giftcard");
                        gRefundDetailVo.setPayment(BigDecimal.ZERO);
                    }else{
                        gRefundDetailVo.setPay_type_code("zhifubao");
                        gRefundDetailVo.setPayment(backOrder.getBackPrice());
                    }
                    refund_detail.add(gRefundDetailVo);
                    gReturnVo.setRefund_detail(refund_detail);
                    //新增退货单
                    Map map1 = synAddTradeReturn(gReturnVo);
                    if (map1 != null && map1.get("code") != null) {
                        backOrderService.synBackOrderSuccess(orderCode);
                        return 1;
                    }
                }
            }
        }*/
        return 0;
    }
}
