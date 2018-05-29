/*
 * Copyright 2013 NingPai, Inc. All rights reserved.
 * NINGPAI PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package com.ningpai.order.controller;

import com.ningpai.common.safe.CSRFTokenManager;
import com.ningpai.common.util.DateUtil;
import com.ningpai.community.bean.CommunityStore;
import com.ningpai.community.service.CommunityStoreService;
import com.ningpai.customer.bean.CustomerAddress;
import com.ningpai.goods.bean.WareHouse;
import com.ningpai.goods.service.WareHouseService;
import com.ningpai.logger.util.OperaLogUtil;
import com.ningpai.order.bean.Order;
import com.ningpai.order.bean.OrderExpress;
import com.ningpai.order.bean.OrderGoods;
import com.ningpai.order.bean.OrderRemark;
import com.ningpai.order.bean.vo.OrderOldAddress;
import com.ningpai.order.service.OrderCouponService;
import com.ningpai.order.service.OrderLogService;
import com.ningpai.order.service.OrderService;
import com.ningpai.other.util.CustomerConstantStr;
import com.ningpai.system.bean.Pay;
import com.ningpai.system.service.ILogisticsCompanyBiz;
import com.ningpai.system.service.PayService;
import com.ningpai.thirdaudit.bean.StoreInfo;
import com.ningpai.thirdaudit.mapper.StoreInfoMapper;
import com.ningpai.util.*;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author NINGPAI-LIH 订单总控制器 2014-04-09
 */
@Controller
public class OrderController {

    /**
     * 日志
     * */
    public static final MyLogger LOGGER = new MyLogger(OrderController.class);

    private static final String STATUS = "status";
    private static final String ORDER = "order";
    private static final String PAGEBEAN = "pageBean";
    private static final String BEGINTIME = "beginTime";
    private static final String ENDTIME = "endTime";
    private static final String BEGINPRICE = "beginPrice";
    private static final String ENDPRICE = "endPrice";
    private static final String DATE = "yyyy-MM-dd";

    /**
     * 订单
     */
    private OrderService orderService;
    /**
     * 订单优惠劵
     */
    private OrderCouponService orderCouponService;

    /**
     * 订单操作记录
     */
    private OrderLogService orderLogService;
    @Resource(name = "WareHouseService")
    private WareHouseService wareHouseService;

    @Resource(name = "logisticsCompanyBizImpl")
    private ILogisticsCompanyBiz logisticsCompanyBiz;

    @Resource(name = "storeMapper")
    private StoreInfoMapper storeInfoMapper;
    @Resource(name = "payService")
    private PayService payService;
    @Resource(name="CommunityStoreService")
    private CommunityStoreService communityStoreService;
    /**
     * 修改订单价格
     *
     * @param orderId
     *            要修改的订单id
     * @param orderCodex
     *            订单编号
     * @param price
     *            要减去的订单价格
     * @param request
     * @return
     */
    @RequestMapping("/modifyorderprice")
    public ModelAndView modifyOrderPrice(Long orderId, String orderCodex, Double price, HttpServletRequest request, String reason) {
        // 添加操作 0:修改价格
        orderLogService.insertSelective(reason, orderId, request.getSession().getAttribute(CustomerConstantStr.NAME).toString(), "0");
        // 修改订单价格
        orderService.modifyOrderPrice(BigDecimal.valueOf(price), orderId);
        Order order = orderService.orderDetail(orderId);
        //pc端订单
//        if("0".equals(order.getOrderMType())){
            List<OrderGoods> orderGoodses = orderService.queryOrderGoods(orderId);
            BigDecimal all = BigDecimal.ZERO;
            for(OrderGoods og : orderGoodses){
                all = all.add(og.getGoodsBackPrice());
            }
            for(OrderGoods orderGoods : orderGoodses){
                orderService.modifyGoodsBackPrice(orderGoods.getGoodsBackPrice().subtract(orderGoods.getGoodsBackPrice().multiply(BigDecimal.valueOf(price)).divide(all, 2)),orderId,orderGoods.getGoodsInfoId(),orderGoods.getGoodsCouponPrice());
            }
//        }
        String operaCode = "修改订单价格";
        String operaContent = request.getSession().getAttribute(CustomerConstantStr.OPERAPATH) + "减去订单" + orderCodex + "的价格：" + price;
        OperaLogUtil.addOperaLog(request, request.getSession().getAttribute(CustomerConstantStr.NAME).toString(), operaCode, operaContent);
        return new ModelAndView(new RedirectView(OrderConstants.INITORDER));
    }

    /**
     * 新订单列表页面分页
     *
     * @param order
     * @param status
     * @param pageBean
     * @param request
     * @return
     */

    @ResponseBody
    @RequestMapping("/newajaxgetpagefoot")
    public PageBean newajaxgetpagefoot(Order order, String status, PageBean pageBean, HttpServletRequest request) {
        String statusNew =  status;
        order.setBusinessId(0L);

        if (StringUtils.isEmpty(statusNew)) {
            statusNew = "1";
        }
        // String token =
        // request.getSession().getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME).toString();
        return orderService.newajaxgetpagefoot(statusNew, order, pageBean);
    }

    /**
     * 异步查看用户订单状态
     * @param request
     * @param orderId 订单id
     * @return
     */
    @ResponseBody
    @RequestMapping("/pay_status_check")
    public String pay_status_check(HttpServletRequest request,Long orderId){
        // 获取用户id
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 判断用户id是否为空
        if (customerId == null || orderId == null) {
            return "非法访问！！！";
        }
        Map<String,Long> map = new HashMap<String,Long>();
        map.put("orderId",orderId);
        map.put("customerId",customerId);
        return this.orderService.findOrderStatus(map);
    }



    /**
     * 根据商品id查询个数 boss后台删除商品用
     * 0:不允许删除商品;1:允许
     * @return
     */
    @RequestMapping("/checkDeleteByGoodsIds")
    @ResponseBody
    public String checkDeleteByGoodsIds(HttpServletRequest request) {

        String[] tags = request.getParameterValues("goodsIds[]");
        Long[] goodsIds=null;
        if(tags.length>0&&tags !=null){
            goodsIds=new Long[tags.length];
            for(int i=0;i< tags.length;i++){
                goodsIds[i]=Long.valueOf(tags[i]);
            }
        }
      if(orderService.queryOrderCountBygoodsIds(goodsIds)>0){
          return "0";
      }else{
          return "1";
      }
    }


    /**
     * 根据货品id查询个数 boss后台删除货品用
     * 0:不允许删除货品;1:允许
     * @return
     */
    @RequestMapping("/checkDeleteByGoodsInfoIds")
    @ResponseBody
    public String checkDeleteByGoodsInfoIds( HttpServletRequest request) {
        String[] tags = request.getParameterValues("goodsInfoIds[]");
        Long[] goodsInfoIds=null;
        if(tags.length>0&&tags !=null){
            goodsInfoIds=new Long[tags.length];
            for(int i=0;i< tags.length;i++){
                goodsInfoIds[i]=Long.valueOf(tags[i]);
            }
        }
      if(orderService.queryOrderCountBygoodsInfoIds(goodsInfoIds)>0){
          return "0";
      }else{
          return "1";
      }
    }


    /**
     * 查询订单列表
     *
     * @param order
     *            订单信息
     * @param pageBean
     * @return ModelAndView
     */
    @RequestMapping("/orderlist")
    public ModelAndView orderList(Order order, String status, PageBean pageBean, HttpServletRequest request) {
        String statusNew = status;
        MenuSession.sessionMenu(request);
        order.setBusinessId(0L);
        //所有社区店的集合
        List<CommunityStore> communityStores = communityStoreService.loadAllCommunityStores();
        // URL
        pageBean.setUrl(OrderConstants.INITORDER);
        // 所有仓库集合
        List<WareHouse> ware = wareHouseService.findWares();
        Long wId = order.getWareId();
        if (StringUtils.isEmpty(statusNew)) {
            statusNew = "1";
        }
        // 获得token
        String token = request.getSession().getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME).toString();
        return new ModelAndView(OrderConstants.ORDERLIST, "map", orderService.newsearchOrderList(statusNew, order, pageBean)).addObject(ORDER, order).addObject(STATUS, statusNew)
                .addObject("sx", token).addObject("ware", ware).addObject("getWareId", wId).addObject("communityStores",communityStores);
    }

    /**
     * 查询第三方订单列表
     *
     * @param order
     *            订单信息
     * @param pageBean
     * @return ModelAndView
     */
    @RequestMapping("/orderlististhird")
    public ModelAndView orderLististhird(Order order, String status, PageBean pageBean, HttpServletRequest request) {
        String statusNew = status;
        // 默认全部
        if (StringUtils.isEmpty(statusNew)) {
            statusNew = "1";
        }
        // url
        pageBean.setUrl(OrderConstants.ORDERLISTISTHIRD);
        // 获得token
        String token = request.getSession().getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME).toString();
        // 第三方订单列表
        return new ModelAndView(OrderConstants.ORDERLISTISTHIRD, "map", orderService.newsearchThirdOrderList(statusNew, order, pageBean)).addObject(ORDER, order)
                .addObject("sx", token).addObject(STATUS, statusNew);
    }

    /**
     * 跳转到添加订单页面
     *
     * @return ModelAndView
     */
    @RequestMapping("/toaddorder")
    public ModelAndView toaddorder() {
        // 得到所有启用的快递公司

        return new ModelAndView("jsp/order/toaddorder").addObject("companyList", logisticsCompanyBiz.queryAllLogisticsCompany());

    }

    /**
     * ajax 得到订单支付信息
     *
     * @return ModelAndView
     */
    @ResponseBody
    @RequestMapping("/ajaxGetorderDetail")
    public Map<String, Object> ajaxGetorderDetail(HttpServletRequest request, Long[] goodsIdP, String customerName) {

        return orderService.ajaxGetorderDetail(request, null, null, customerName);
    }

    /**
     * ajax 保存后台添加的订单信息
     *
     * @param goodsAllPrice
     * @param freightPrice
     * @param companyInfo
     * @param customerRemark
     * @param goodsIdP
     * @param goodsNum
     * @param distinctId
     * @param payType
     * @param invoiceTitle
     * @param invoiceType
     * @param invoiceContent
     * @param customerAddress
     * @return
     */
    @ResponseBody
    @RequestMapping("/ajaxsaveOrder")
    public int ajaxsaveOrder(BigDecimal goodsAllPrice, BigDecimal freightPrice, String companyInfo, String customerRemark, Long[] goodsIdP, Long[] goodsNum, Long distinctId,
            Long payType, String invoiceTitle, String invoiceType, String invoiceContent, CustomerAddress customerAddress,String deliveryName) {

        return orderService.saveAddOrder(goodsAllPrice, freightPrice, companyInfo, customerRemark, goodsIdP, goodsNum, distinctId, payType, invoiceTitle, invoiceType,
                invoiceContent, customerAddress,deliveryName);
    }

    /**
     * 查询订单明细
     *
     * @param orderId
     *            订单id
     * @return ModelAndView
     */
    @RequestMapping("/orderdetail")
    public ModelAndView orderDetail(Long orderId, HttpServletRequest request) {
        return new ModelAndView(OrderConstants.ORDERDETAIL, ORDER, orderService.orderDetail(orderId))
                .addObject("relations", orderService.queryContainerRalation(orderId))
                .addObject("orderLogs", orderLogService.selectOrderLogByOrderId(orderId));
    }

    /**
     * ajax查询订单明细
     *
     * @param orderId
     *            订单id
     * @return ModelAndView
     */
    @RequestMapping("/orderdetailajax")
    @ResponseBody
    public Map<String, Object> orderDetailAjax(Long orderId, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        // 查询单个订单详细
        Order order = orderService.orderDetail(orderId);
        //根据支付类型查询支付方式，后台修改状态订单payid为0，没有对应支付方式
        Pay pay = payService.selectPayByType(order.getPayId().toString());
        String payName = "后台修改状态订单";
        if(pay!=null){
            payName = pay.getPayName();
        }
        map.put("payName", payName);
        map.put(ORDER, order);
        map.put("relations", orderService.queryContainerRalation(orderId));
        map.put("orderLogs", orderLogService.selectOrderLogByOrderId(orderId));
        //查询订单的旧收货地址
        OrderOldAddress orderOldAddress=orderService.queryOldOrder(orderId);
        if(orderOldAddress!=null){
            map.put("oldOrderAddress",orderOldAddress);
        }

        return map;
    }

    /**
     * 修改订单地址的时候
     * @param orderId
     * @param updateState 1:修改中  2：修改结束
     * @return
     */
    @RequestMapping("/updateOrderAddressState")
    @ResponseBody
    public String updateOrderAddressState(Long orderId,String updateState){
        this.orderService.updateOrderAddressState(orderId,updateState);
        final Long a=orderId;
        /*定时器 如果是修改中 一个小时候后修改成修改结束 */
        if("1".equals(updateState)){
            Timer timer = new Timer();
            timer.schedule(new TimerTask() {
                public void run() {
                    orderService.updateOrderAddressState(a,"2");
                }
            }, 1000*60*60*10);
        }
        return "ok";
    }

    /**
     * 查询修改的状态
     * @param orderId
     * @return
     */
    @RequestMapping("/queryUpdateStateByOrderId")
    @ResponseBody
    public String queryUpdateStateByOrderId(Long orderId,String page,String statu){
        //查询修改的状态
        synchronized (this) {
            final Long a=orderId;
            if("orderPage".equals(page)){
            String updateState = this.orderService.queryUpdateStateByOrderId(orderId);
            if ("2".equals(updateState)) {
                this.orderService.updateOrderAddressState(orderId, "1");
                     /*定时器 如果是修改中 一个小时候后修改成修改结束 */
                    Timer timer = new Timer();
                    timer.schedule(new TimerTask() {
                            public void run() {
                                orderService.updateOrderAddressState(a,"2");
                            }
                        }, 1000*60*30);

            }
            return updateState;
            }else if("warehouse".equals(page)){
                //如果是在装箱提示框内 点击其他操作后 再加载装箱提示框时返回“ok”
                if("1".equals(statu)){
                    return "ok";
                }
                String updateState = this.orderService.queryUpdateStateByOrderId(orderId);
                if("2".equals(updateState)){
                    this.orderService.updateOrderAddressState(orderId,"3");
                        /*定时器 如果是修改中 一个小时候后修改成修改结束 */
                        Timer timer = new Timer();
                        timer.schedule(new TimerTask() {
                            public void run() {
                                orderService.updateOrderAddressState(a,"2");
                            }
                        }, 1000*60*30);
                }
                return updateState;
            }
        }
        return "ok";
    }
    /**
     * 校验是否支持配送
     * @param orderId 订单id
     * @param district 区县Id
     * @return
     */
    @RequestMapping("/isGualified")
    @ResponseBody
    public String isGualified(Long orderId,Long district){
        //查看此区县是否支持配送
        Long wareId=this.orderService.queryWareByDistrict(district);
         if(wareId==null){
             return "notWare";
         }
        //查看是不是在同一个仓库
        Long orderWareId=this.orderService.queryOrderWareByOrderId(orderId);
         if(wareId.equals(orderWareId)){
             //是同一个仓库
             return "ok";
         }
         //查询订单里面商品与客户端选择的区县对应的商品的库存
       List<Map<String,Long>> maps=this.orderService.queryNumByOrderId(orderId,wareId);

         //查询订单里面商品的数量
        List<Map<String,Long>> mapList=this.orderService.queryGoodinfoNumByOrderId(orderId);
        if(maps.size()==mapList.size()){
            if(maps !=null && maps.size()>0 && mapList !=null && mapList.size()>0){
                //比较仓库里商品的数量跟订单里商品的数量
                for(Map<String,Long> map:maps){
                    for(Map<String,Long> map1:mapList){
                        Long a=map.get("product_id");
                        Long  b=map1.get("goods_info_id");
                        if(map.get("product_id").toString().equals(map1.get("goods_info_id").toString())){
                            //如果订单里商品的数量大于仓库里商品的数量
                            if(map.get("ware_stock")<map1.get("goods_info_num")){
                                return "notProduct";
                            }
                        }
                    }
                }
            }
        }else if(maps.size()!=mapList.size()){
            //先选择的区县对应的仓库 没有订单里的商品或不全有
            return "notProduct";
        }

        return "ok";
    }

    @RequestMapping("/saveAddressAfterUpdate")
    @ResponseBody
    public String saveAddressAfterUpdate(CustomerAddress customerAddress,String addressType,String distinctId,String orderId){
         //查看订单是否已经出库
         String cargoState=this.orderService.isOrderGargo(Long.parseLong(orderId));
         if("2".equals(cargoState)){
             //已装箱
             return "2";
         }else if("3".equals(cargoState)){
             //已出库
             return "3";
         }
         //查询订单是否已被修改过
        synchronized(this){
            Long oldAddressId = this.orderService.isOrderOldAddress(orderId);
            if (oldAddressId != null) {
                return "9";
            }
            //保存修改后的地址
            this.orderService.saveAddressAfterUpdate(customerAddress, addressType, distinctId, orderId);
        }

        return "ok";
    }

    /**
     * ajax 查询订单备注
     * @param orderId 订单id
     * @param request
     * @return
     */
    @RequestMapping("/orderremarksajax")
    @ResponseBody
    public Map<String,Object> orderRemarksAjax(Long orderId,HttpServletRequest request, Integer currentPage,Integer pageSize){
        //根据订单ID 查询订单备注列表
        Map<String, Object> paramMap=new HashMap<String, Object>();
        paramMap.put("begin",(currentPage-1)*pageSize);
        paramMap.put("size",pageSize);
        paramMap.put("orderId",orderId);
        List<OrderRemark> orderRemarks=orderService.selectOrderRemarkByOrderId(paramMap);
        Integer totalCount=orderService.getTotalCount(orderId);
        Integer totalPage=totalCount%pageSize==0?totalCount/pageSize:totalCount/pageSize+1;
        Map<String,Object> map=new HashMap();
        map.put("orderRemarks",orderRemarks);
        map.put("totalPage",totalPage);
        return map;
    }

    /**
     * 添加备注
     * @param ordersms  订单id-订单编号
     * @param remarktext  订单备注内容
     * @return
     */
    @RequestMapping("/addremarksajax")
    @ResponseBody
    public String addorderremarksajax(String ordersms, String remarktext,HttpServletRequest request){
        //订单备注对象
        OrderRemark orderRemark=new OrderRemark();
        if(StringUtils.isNotBlank(ordersms)){
            String[] arr=ordersms.split("-");
            //设置订单id
            orderRemark.setOrderId(Long.parseLong(arr[0]));
            //设置订单编号
            orderRemark.setOrderCode(arr[1]);
        }
        if(StringUtils.isNotBlank(remarktext)){
            //设置订单内容
            orderRemark.setRemarkContent(remarktext);
        }
        orderRemark.setCreatTime(new Date());
        String customername=(String) request.getSession().getAttribute("name");
        if(StringUtils.isBlank(customername)){
            //没有登录
            return "warn";
        }
        orderRemark.setOrdercustomer(customername);
        String result=orderService.addorderremarksajax(orderRemark);
        return result;
    }
    /**
     * 查询物流信息
     *
     * @param orderId
     * @return OrderExpress
     */
    @RequestMapping("/expressdetail")
    @ResponseBody
    public OrderExpress expressDetail(Long orderId) {
        return orderService.expressDetail(orderId);
    }

    /**
     * 查看已发货列表
     *
     * @return
     * @throws java.text.ParseException
     */
    @RequestMapping("/queryysendgoodsorderlist")
    public ModelAndView queryYSendGoodsOrderList(HttpServletRequest request, PageBean pageBean, String status, Order order) throws ParseException {
        String statusNew = status;
        pageBean.setUrl(OrderConstants.QUERYYSENDGOODSORDERLIST);
        List<String> list = null;
        statusNew = "0";
        return new ModelAndView(OrderConstants.PRINTOVERLIST).addObject(PAGEBEAN, orderService.queryYOrder(request, order, pageBean, list)).addObject(STATUS, statusNew)
                .addObject(ORDER, order).addObject(BEGINTIME, request.getParameter(BEGINTIME)).addObject(ENDTIME, request.getParameter(ENDTIME))
                .addObject(BEGINPRICE, request.getParameter(BEGINPRICE)).addObject(ENDPRICE, request.getParameter(ENDPRICE))
                .addObject("sx", request.getSession().getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME).toString());
    }

    /**
     * 查看已装箱列表
     *
     * @return
     * @throws java.text.ParseException
     */
    @RequestMapping("/queryydeorderlist")
    public ModelAndView queryYDeOrderList(HttpServletRequest request, PageBean pageBean, String status, Order order) throws ParseException {
        String statusNew = status;
        pageBean.setUrl(OrderConstants.QUERYYDEORDERLIST);
        List<String> list = new ArrayList<String>();
        list.add("2");
        list.add("3");
        statusNew = "1";
        return new ModelAndView(OrderConstants.PRINTOVERLIST).addObject(PAGEBEAN, orderService.queryYOrder(request, order, pageBean, list)).addObject(STATUS, statusNew)
                .addObject(ORDER, order).addObject(BEGINTIME, request.getParameter(BEGINTIME)).addObject(ENDTIME, request.getParameter(ENDTIME))
                .addObject(BEGINPRICE, request.getParameter(BEGINPRICE)).addObject(ENDPRICE, request.getParameter(ENDPRICE))
                .addObject("sx", request.getSession().getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME).toString());
    }

    /**
     * 查看已拣货列表
     *
     * @return
     * @throws java.text.ParseException
     */
    @RequestMapping("/queryyorderlist")
    public ModelAndView queryYOrderList(HttpServletRequest request, PageBean pageBean, String status, Order order) throws ParseException {
        String statusNew = status;
        pageBean.setUrl(OrderConstants.QUERYYORDERLIST);
        List<String> list = new ArrayList<String>();
        list.add("1");
        list.add("2");
        list.add("3");
        statusNew = "2";
        return new ModelAndView(OrderConstants.PRINTOVERLIST).addObject(PAGEBEAN, orderService.queryYOrder(request, order, pageBean, list)).addObject(STATUS, statusNew)
                .addObject(ORDER, order).addObject(BEGINTIME, request.getParameter(BEGINTIME)).addObject(ENDTIME, request.getParameter(ENDTIME))
                .addObject(BEGINPRICE, request.getParameter(BEGINPRICE)).addObject(ENDPRICE, request.getParameter(ENDPRICE))
                .addObject("sx", request.getSession().getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME).toString()).addObject("orderCargoStatus");
    }

    /**
     * 查看销售量走势图
     *
     * @return
     */
    @RequestMapping("/saleCount")
    public ModelAndView saleCount(String startTime, String endTime, HttpServletRequest request) {
        String startTimeNew = startTime;
        String endTimeNew = endTime;
        // 格式化日期 如果时间不存在 初始化当前日期的前7天
        if (startTimeNew == null || endTimeNew == null || "".equals(startTimeNew) || "".equals(endTimeNew)) {
            endTimeNew = UtilDate.todayFormat(new Date());
            startTimeNew = UtilDate.addDay(endTimeNew, -6);
        }
        String sttime = startTimeNew;
        String entime = endTimeNew;
        List<String> payTime = DateUtil.getAllDateBetween2Date(startTimeNew, endTimeNew);
        List<Order> orderList = orderService.querySaleCountByDay(startTimeNew, endTimeNew);
        List<Long> count = new ArrayList<Long>();
        for (String time : payTime) {
            boolean flag = false;
            for (Order order : orderList) {
                if (time.equals(DateUtil.dateToString(order.getPayTime(), DATE))) {
                    flag = true;
                    count.add(order.getDayCount());
                }
            }
            if (!flag) {
                count.add(0L);
            }
        }
        JSONArray times = JSONArray.fromObject(payTime);
        JSONArray counts = JSONArray.fromObject(count);
        return new ModelAndView(OrderConstants.SALECOUNT).addObject("orderList", orderService.querySaleCountByDay(startTimeNew, endTimeNew)).addObject("counts", counts.toString())
                .addObject("times", times.toString()).addObject("startTime", sttime).addObject(ENDTIME, entime);
    }

    /**
     * 查看销售额走势图
     *
     * @return
     */
    @RequestMapping("/saleMoney")
    public ModelAndView saleMoney(String startTime, String endTime, HttpServletRequest request) {
        String startTimeNew = startTime;
        String endTimeNew = endTime;
        // 格式化日期 如果时间不存在 初始化当前日期的前7天
        if (startTimeNew == null || endTimeNew == null || "".equals(startTimeNew) || "".equals(endTimeNew)) {
            endTimeNew = UtilDate.todayFormat(new Date());
            startTimeNew = UtilDate.addDay(endTimeNew, -6);
        }
        String sttime = startTimeNew;
        String entime = endTimeNew;
        List<String> payTime = DateUtil.getAllDateBetween2Date(startTimeNew, endTimeNew);
        List<Order> orderList = orderService.querySaleMoneyByDay(startTimeNew, endTimeNew);
        List<BigDecimal> total = new ArrayList<BigDecimal>();
        for (String time : payTime) {
            boolean flag = false;
            for (Order order : orderList) {
                if (time.equals(DateUtil.dateToString(order.getPayTime(), DATE))) {
                    flag = true;
                    total.add(order.getDayMoney());
                }
            }
            if (!flag) {
                total.add(new BigDecimal(0));
            }
        }
        JSONArray times = JSONArray.fromObject(payTime);
        JSONArray totals = JSONArray.fromObject(total);
        return new ModelAndView(OrderConstants.SALEMONEY).addObject("orderList", orderService.querySaleCountByDay(startTimeNew, endTimeNew)).addObject("totals", totals.toString())
                .addObject("times", times.toString()).addObject("startTime", sttime).addObject(ENDTIME, entime);
    }

    /**
     * 首页统计查询
     *
     * @return map
     * @auth lih
     */
    @RequestMapping("/querystatistics")
    @ResponseBody
    public Map<String, Object> queryStatistics() {
        return orderService.queryStatistics();
    }

    /**
     * 导出订单列表
     * @param type (0:boss订单导出1:第三方店铺订单导出)
     * @author houyichang 2015/8/14
     */
    @RequestMapping("exportallorder")
    public void exportOrderList(HttpServletRequest request, HttpServletResponse response, String type, Order orderCondition) {
        // 第一步 创建一个webbook,对应一个excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步 在webbook中添加sheet，对应excel中的sheet
        HSSFSheet sheet = wb.createSheet("订单列表");
        // 第三步 在sheet中添加表头第0行，此处需要注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);

        // 第四步 创建单元格，并设置值表头，设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        // 创建一个居中格式
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        // 设置宽度
        sheet.setColumnWidth(0, 6000);
        sheet.setColumnWidth(1, 6000);
        sheet.setColumnWidth(2, 6000);
        sheet.setColumnWidth(3, 6000);
        sheet.setColumnWidth(4, 6000);
        sheet.setColumnWidth(5, 6000);
        sheet.setColumnWidth(6, 6000);
        sheet.setColumnWidth(7, 6000);
        sheet.setColumnWidth(8, 6000);
        sheet.setColumnWidth(9, 6000);
        sheet.setColumnWidth(10, 6000);

        // 设置列头信息
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("订单编号");
        cell.setCellStyle(style);
        cell = row.createCell(1);
        cell.setCellValue("总价");
        cell.setCellStyle(style);
        cell = row.createCell(2);
        cell.setCellValue("数量");
        cell.setCellStyle(style);
        cell = row.createCell(3);
        cell.setCellValue("收货人");
        cell.setCellStyle(style);
        cell = row.createCell(4);
        cell.setCellValue("联系电话");
        cell.setCellStyle(style);
        cell = row.createCell(5);
        cell.setCellValue("下单时间");
        cell.setCellStyle(style);
        cell = row.createCell(6);
        cell.setCellValue("订单状态");
        cell.setCellStyle(style);
        cell = row.createCell(7);
        cell.setCellValue("实付金额");
        cell.setCellStyle(style);
        cell = row.createCell(8);
        cell.setCellValue("商家");
        cell.setCellStyle(style);
        cell = row.createCell(9);
        cell.setCellValue("商品名称");
        cell.setCellStyle(style);
        cell = row.createCell(10);
        cell.setCellValue("商品编号");
        cell.setCellStyle(style);
        cell = row.createCell(11);
        // 第五步 写入实际数据 实际应用中这些数据从数据库中取出
        //查询商家ID
        Long thirdId = (Long) request.getSession().getAttribute("thirdId");
        StoreInfo storeInfo =null;
        List<Order> list = null;
        //如果存在店铺ID及导出店铺订单
        if(thirdId != null){
            storeInfo = storeInfoMapper.selectByStoreId(thirdId);
            orderCondition.setBusinessId(thirdId);
            list = orderService.queryBusinessIdOrderList(orderCondition);
        }else {
            if (StringUtils.isNotEmpty(type) && type.equals("0")){
                //判断订单状态
                if(orderCondition.getOrderStatus() !=null && orderCondition.getOrderStatus() != ""){
                    // 待发货
                    if ("2".equals(orderCondition.getOrderStatus())) {
                        orderCondition.setOrderStatus("1");
                    } else if ("3".equals(orderCondition.getOrderStatus())) { // 已发货
                        orderCondition.setOrderStatus("2");
                    } else if ("4".equals(orderCondition.getOrderStatus())) { // 待支付
                        orderCondition.setOrderStatus("0");
                    } else if ("5".equals(orderCondition.getOrderStatus())) { // 货到付款
                        orderCondition.setOrderStatus("");
                    } else if ("6".equals(orderCondition.getOrderStatus())) { // 已完成
                        orderCondition.setOrderStatus("3");
                    } else if ("7".equals(orderCondition.getOrderStatus())) { // 已取消
                        orderCondition.setOrderStatus("4");
                    } else if ("8".equals(orderCondition.getOrderStatus())) { // 手机订单
                        orderCondition.setOrderStatus("");
                        orderCondition.setOrderMType("2");
                    }
                }
                //查询boss订单
                list = orderService.queryBossOrderList(orderCondition);
            }
            else if (StringUtils.isNotEmpty(type) && type.equals("1")){
                //查询第三方店铺订单
                list = orderService.queryThirdOrderList();
            }
        }

        int q = 0;
        if (null != list) {
            for (int i = 0; i < list.size(); i++) {

                row = sheet.createRow((int) i + 1 + q);
                /* 第六步，创建单元格，并设置值 */
                Order order = list.get(i);
                // 如果订单编号不为空
                // 就设置订单编号列
                if (null != order.getOrderCode()) {
                    row.createCell(0).setCellValue(order.getOrderCode());
                }

                // 设置总价
                if (null != order.getOrderOldPrice()) {
                    row.createCell(1).setCellValue(order.getOrderOldPrice() + "");
                }
                //计算数量
                int num = 0;
                for(OrderGoods og : order.getOrderGoodsList()){
                    num = num + og.getGoodsInfoNum().intValue();
                }
                // 设置数量
                if (null != order.getOrderGoodsList()) {
                    row.createCell(2).setCellValue(num);
                }

                // 设置收货人
                if (null != order.getShippingPerson()) {
                    row.createCell(3).setCellValue(order.getShippingPerson());
                }

                //设置联系电话
                if (null != order.getShippingMobile()) {
                    row.createCell(4).setCellValue( order.getShippingMobile());
                }

                // 如果下单时间不为空
                // 设置显示下单时间
                if (null != order.getCreateTime()) {
                    row.createCell(5).setCellValue(new SimpleDateFormat(DATE).format(order.getCreateTime()));
                }

                // 如果订单状态不为空
                // 设置订单状态显示
                // 定义一个变量负责接送订单状态值，方便最后给列赋值
                String status = "";
                if (null != order.getOrderStatus()) {
                    // 如果状态为1 需要在进一步判断
                    if ("0".equals(order.getOrderStatus()) && null != order.getOrderLinePay()) {
                        // 如果订单付款方式不为空
                        // 设置显示订单状态
                            // 待发货
                            if ("0".equals(order.getOrderLinePay())) {
                                status = "待发货";
                            } else if ("1".equals(order.getOrderLinePay())) {
                                status = "待付款";
                            }
                    }
                    // 已付款未发货
                    if ("1".equals(order.getOrderStatus())) {
                        status = "已付款未发货";
                    }

                    // 已发货
                    if ("2".equals(order.getOrderStatus())) {
                        status = "已发货";
                    }

                    // 已完成
                    if ("3".equals(order.getOrderStatus())) {
                        status = "已完成";
                    }

                    // 已取消
                    if ("4".equals(order.getOrderStatus())) {
                        status = "已取消";
                    }

                    // 退单审核中
                    if ("14".equals(order.getOrderStatus())) {
                        status = "退单审核中";
                    }

                    // 同意退货
                    if ("8".equals(order.getOrderStatus())) {
                        status = "同意退货";
                    }

                    // 拒绝退货
                    if ("9".equals(order.getOrderStatus())) {
                        status = "拒绝退货";
                    }

                    // 待商家收货
                    if ("10".equals(order.getOrderStatus())) {
                        status = "待商家收货";
                    }

                    // 退单结束
                    if ("11".equals(order.getOrderStatus())) {
                        status = "退单结束";
                    }

                    // 退款审核中
                    if ("15".equals(order.getOrderStatus())) {
                        status = "退款审核中";
                    }

                    // 商家收货失败
                    if ("16".equals(order.getOrderStatus())) {
                        status = "商家收货失败";
                    }

                    // 已退款
                    if ("17".equals(order.getOrderStatus())) {
                        status = "已退款";
                    }

                    // 退款成功
                    if ("18".equals(order.getOrderStatus())) {
                        status = "退款成功";
                    }
                    row.createCell(6).setCellValue(status);
                }

                // 如果实付金额不为空
                // 设置显示实付金额列
                if (null != order.getOrderPrice()) {
                    row.createCell(7).setCellValue(order.getOrderPrice() + "");
                }

                // 如果商家名称不为空
                // 设置显示商家列
                if(storeInfo != null ){
                    if(storeInfo.getStoreName() != null || storeInfo.getStoreName() != ""){
                        row.createCell(8).setCellValue(storeInfo.getStoreName());
                    }else{
                        row.createCell(8).setCellValue("暂无");
                    }
                }else{
                    if (null != order.getStoreName()) {
                        row.createCell(8).setCellValue(order.getStoreName());
                    } else {
                        row.createCell(8).setCellValue("Boss");
                    }
                }

                for (int j = 0; j < list.get(i).getOrderGoodsList().size(); j++) {

                    if (j != 0) {
                        row = sheet.createRow((int) i + 1 + q + j);
                    }
                    // 如果商品名称不为空
                    // 设置显示商品名称
                    if (null != list.get(i).getOrderGoodsList().get(j).getGoodsInfoName()) {
                        row.createCell(9).setCellValue(list.get(i).getOrderGoodsList().get(j).getGoodsInfoName());
                    }
                    // 如果商品编号不为空
                    // 设置显示商品编号
                    if (null != list.get(i).getOrderGoodsList().get(j).getGoodsInfoItemNo()) {
                        row.createCell(10).setCellValue(list.get(i).getOrderGoodsList().get(j).getGoodsInfoItemNo());
                    }
                }
                q += list.get(i).getOrderGoodsList().size();
            }
        }

        // 第七步 将文件存储到指定位置
        String filename = String.valueOf(System.currentTimeMillis()).concat(".xls");
        // 设置下载时客户端Excel的名称
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", "attachment;filename=" + filename);
        OutputStream ouputStream;
        try {
            ouputStream = response.getOutputStream();
            wb.write(ouputStream);
            ouputStream.flush();
            ouputStream.close();
        } catch (IOException e) {
            LOGGER.error("",e);
        }

    }

    /**
     * 导出选中订单列表
     * @param type (0:boss订单导出1:第三方店铺订单导出)
     * @param orderIds 订单id数组
     */
    @RequestMapping("exportcheckedorder")
    public void exportCheckedOrderList(HttpServletRequest request, HttpServletResponse response, String type, Long[] orderIds) {
        // 第一步 创建一个webbook,对应一个excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步 在webbook中添加sheet，对应excel中的sheet
        HSSFSheet sheet = wb.createSheet("订单列表");
        // 第三步 在sheet中添加表头第0行，此处需要注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);

        // 第四步 创建单元格，并设置值表头，设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        // 创建一个居中格式
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        // 设置宽度
        sheet.setColumnWidth(0, 6000);
        sheet.setColumnWidth(1, 6000);
        sheet.setColumnWidth(2, 6000);
        sheet.setColumnWidth(3, 6000);
        sheet.setColumnWidth(4, 6000);
        sheet.setColumnWidth(5, 6000);
        sheet.setColumnWidth(6, 6000);
        sheet.setColumnWidth(7, 6000);
        sheet.setColumnWidth(8, 6000);
        sheet.setColumnWidth(9, 6000);
        sheet.setColumnWidth(10, 6000);

        // 设置列头信息
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("订单编号");
        cell.setCellStyle(style);
        cell = row.createCell(1);
        cell.setCellValue("总价");
        cell.setCellStyle(style);
        cell = row.createCell(2);
        cell.setCellValue("数量");
        cell.setCellStyle(style);
        cell = row.createCell(3);
        cell.setCellValue("收货人");
        cell.setCellStyle(style);
        cell = row.createCell(4);
        cell.setCellValue("联系电话");
        cell.setCellStyle(style);
        cell = row.createCell(5);
        cell.setCellValue("下单时间");
        cell.setCellStyle(style);
        cell = row.createCell(6);
        cell.setCellValue("订单状态");
        cell.setCellStyle(style);
        cell = row.createCell(7);
        cell.setCellValue("实付金额");
        cell.setCellStyle(style);
        cell = row.createCell(8);
        cell.setCellValue("商家");
        cell.setCellStyle(style);
        cell = row.createCell(9);
        cell.setCellValue("商品名称");
        cell.setCellStyle(style);
        cell = row.createCell(10);
        cell.setCellValue("商品编号");
        cell.setCellStyle(style);
        cell = row.createCell(11);

        // 第五步 写入实际数据 实际应用中这些数据从数据库中取出
        Long thirdId = (Long) request.getSession().getAttribute("thirdId");
        StoreInfo storeInfo =null;
        if(thirdId != null){
            storeInfo = storeInfoMapper.selectByStoreId(thirdId);
        }
        List<Order> list = null;
        if (StringUtils.isNotEmpty(type) && type.equals("0"))
            //查询选中的boss订单
            list = orderService.queryCheckedBossOrderList(orderIds);
        else if (StringUtils.isNotEmpty(type) && type.equals("1"))
            //查询第三方店铺订单
            list = orderService.queryThirdOrderList();
        else
            //查询店铺订单
            list = orderService.queryCheckedBusinessIdOrderList(orderIds);
        int q = 0;
        if (null != list) {
            for (int i = 0; i < list.size(); i++) {

                row = sheet.createRow((int) i + 1 + q);
                /* 第六步，创建单元格，并设置值 */
                Order order = list.get(i);
                // 如果订单编号不为空
                // 就设置订单编号列
                if (null != order.getOrderCode()) {
                    row.createCell(0).setCellValue(order.getOrderCode());
                }

                // 设置价格
                if (null != order.getOrderOldPrice()) {
                    row.createCell(1).setCellValue(order.getOrderOldPrice() + "");
                }

                //计算数量
                int num = 0;
                for(OrderGoods og : order.getOrderGoodsList()){
                    num = num + og.getGoodsInfoNum().intValue();
                }
                // 设置数量
                if (null != order.getOrderGoodsList()) {
                    row.createCell(2).setCellValue(num);
                }

                // 如果收货人不为空
                // 设置显示收货人名称
                if (null != order.getShippingPerson()) {
                    row.createCell(3).setCellValue(order.getShippingPerson());
                }

                // 设置联系电话
                if (null != order.getShippingMobile()) {
                    row.createCell(4).setCellValue(order.getShippingMobile());
                }

                // 如果下单时间不为空
                // 设置显示下单时间
                if (null != order.getCreateTime()) {
                    row.createCell(5).setCellValue(new SimpleDateFormat(DATE).format(order.getCreateTime()));
                }

                // 如果订单状态不为空
                // 设置订单状态显示
                // 定义一个变量负责接送订单状态值，方便最后给列赋值
                String status = "";
                if (null != order.getOrderStatus()) {
                    // 如果状态为1 需要在进一步判断
                    if ("0".equals(order.getOrderStatus()) && null != order.getOrderLinePay()) {
                        // 如果订单付款方式不为空
                        // 设置显示订单状态
                            // 待发货
                            if ("0".equals(order.getOrderLinePay())) {
                                status = "待发货";
                            } else if ("1".equals(order.getOrderLinePay())) {
                                status = "待付款";
                            }
                    }
                    // 已付款未发货
                    if ("1".equals(order.getOrderStatus())) {
                        status = "已付款未发货";
                    }

                    // 已发货
                    if ("2".equals(order.getOrderStatus())) {
                        status = "已发货";
                    }

                    // 已完成
                    if ("3".equals(order.getOrderStatus())) {
                        status = "已完成";
                    }

                    // 已取消
                    if ("4".equals(order.getOrderStatus())) {
                        status = "已取消";
                    }

                    // 退单审核中
                    if ("14".equals(order.getOrderStatus())) {
                        status = "退单审核中";
                    }

                    // 同意退货
                    if ("8".equals(order.getOrderStatus())) {
                        status = "同意退货";
                    }

                    // 拒绝退货
                    if ("9".equals(order.getOrderStatus())) {
                        status = "拒绝退货";
                    }

                    // 待商家收货
                    if ("10".equals(order.getOrderStatus())) {
                        status = "待商家收货";
                    }

                    // 退单结束
                    if ("11".equals(order.getOrderStatus())) {
                        status = "退单结束";
                    }

                    // 退款审核中
                    if ("15".equals(order.getOrderStatus())) {
                        status = "退款审核中";
                    }

                    // 商家收货失败
                    if ("16".equals(order.getOrderStatus())) {
                        status = "商家收货失败";
                    }

                    // 已退款
                    if ("17".equals(order.getOrderStatus())) {
                        status = "已退款";
                    }

                    // 退款成功
                    if ("18".equals(order.getOrderStatus())) {
                        status = "退款成功";
                    }
                    row.createCell(6).setCellValue(status);
                }

                // 如果实付金额不为空
                // 设置显示实付金额列
                if (null != order.getOrderPrice()) {
                    row.createCell(7).setCellValue(order.getOrderPrice() + "");
                }

                // 如果商家名称不为空
                // 设置显示商家列
                if(storeInfo != null ){
                    if(storeInfo.getStoreName() != null || storeInfo.getStoreName() != ""){
                        row.createCell(8).setCellValue(storeInfo.getStoreName());
                    }else{
                        row.createCell(8).setCellValue("暂无");
                    }
                }else{
                    if (null != order.getStoreName()) {
                        row.createCell(8).setCellValue(order.getStoreName());
                    } else {
                        row.createCell(8).setCellValue("Boss");
                    }
                }

                for (int j = 0; j < list.get(i).getOrderGoodsList().size(); j++) {

                    if (j != 0) {
                        row = sheet.createRow((int) i + 1 + q + j);
                    }
                    // 如果商品名称不为空
                    // 设置显示商品名称
                    if (null != list.get(i).getOrderGoodsList().get(j).getGoodsInfoName()) {
                        row.createCell(9).setCellValue(list.get(i).getOrderGoodsList().get(j).getGoodsInfoName());
                    }
                    // 如果商品编号不为空
                    // 设置显示商品编号
                    if (null != list.get(i).getOrderGoodsList().get(j).getGoodsInfoItemNo()) {
                        row.createCell(10).setCellValue(list.get(i).getOrderGoodsList().get(j).getGoodsInfoItemNo());
                    }
                }
                q += list.get(i).getOrderGoodsList().size();
            }
        }

        // 第七步 将文件存储到指定位置
        String filename = String.valueOf(System.currentTimeMillis()).concat(".xls");
        // 设置下载时客户端Excel的名称
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", "attachment;filename=" + filename);
        OutputStream ouputStream;
        try {
            ouputStream = response.getOutputStream();
            wb.write(ouputStream);
            ouputStream.flush();
            ouputStream.close();
        } catch (IOException e) {
            LOGGER.error("",e);
        }

    }

    /**
     * 拆分订单
     * @param request
     * @param newnum1   拆单1（商品1，商品2，商品3）
     * @param newnum2   拆单2（商品1，商品2，商品3）
     * @param newnum3   拆单3（商品1，商品2，商品3）
     * @param goodsInfoId   商品1ID,商品2ID，商品3ID
     * @param goodsprice    商品1价格，商品2价格，商品3价格
     * @param orderId   原订单id
     * @return
     */
    @RequestMapping("/splitOrder")
    @ResponseBody
    public String splitOrder(HttpServletRequest request, Integer[] newnum1, Integer[] newnum2, Integer[] newnum3, Long[] goodsInfoId, BigDecimal[] goodsprice, String[] isPresent, Long orderId) {
        List<Integer[]> newnumList = new ArrayList<Integer[]>();
        if(newnum1 != null) newnumList.add(newnum1);
        if(newnum2 != null) newnumList.add(newnum2);
        if(newnum3 != null && newnum3.length>0 && !"".equals(newnum3[0])){
            newnumList.add(newnum3);
        }
        //查询要拆分的订单
        int i = orderService.splitOrder(newnumList, goodsInfoId, goodsprice, isPresent, orderId);

        return i>0?"success":"fail";
    }

    public OrderService getOrderService() {
        return orderService;
    }

    @Resource(name = "OrderService")
    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    public OrderCouponService getOrderCouponService() {
        return orderCouponService;
    }

    @Resource(name = "OrderCouponService")
    public void setOrderCouponService(OrderCouponService orderCouponService) {
        this.orderCouponService = orderCouponService;
    }

    public OrderLogService getOrderLogService() {
        return orderLogService;
    }

    @Resource(name = "OrderLogService")
    public void setOrderLogService(OrderLogService orderLogService) {
        this.orderLogService = orderLogService;
    }

}
