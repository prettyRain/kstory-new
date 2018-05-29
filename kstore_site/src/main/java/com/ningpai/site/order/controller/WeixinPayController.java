package com.ningpai.site.order.controller;

import com.ningpai.common.util.EmailUtils;
import com.ningpai.common.util.tenpay.util.XMLUtil;
import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.service.GiftcardService;
import com.ningpai.customer.vo.GiftcardVo;
import com.ningpai.deposit.bean.Deposit;
import com.ningpai.deposit.bean.Trade;
import com.ningpai.dst.order.service.DstOrderService;
import com.ningpai.index.service.TopAndBottomService;
import com.ningpai.order.bean.Order;
import com.ningpai.order.bean.OrderGoods;
import com.ningpai.order.dao.OrderGoodsMapper;
import com.ningpai.order.service.OrderService;
import com.ningpai.order.service.SynOrderService;
import com.ningpai.site.customer.bean.OrderNotice;
import com.ningpai.site.customer.deposit.bean.TradeConst;
import com.ningpai.site.customer.deposit.service.SiteDepositService;
import com.ningpai.site.customer.deposit.service.TradeService;
import com.ningpai.site.customer.service.OrderNoticeService;
import com.ningpai.site.customer.vo.CustomerConstantStr;
import com.ningpai.site.order.service.SiteOrderService;
import com.ningpai.site.order.util.WeixinHttpUtil;
import com.ningpai.site.order.util.WeixinPayCommonUtil;
import com.ningpai.site.order.util.WeixinPayConfigUtil;
import com.ningpai.site.order.util.WeixinXmlUtil;
import com.ningpai.system.bean.Pay;
import com.ningpai.system.bean.Receivables;
import com.ningpai.system.service.PayService;
import com.ningpai.system.service.ReceivablesService;
import com.ningpai.util.MyLogger;
import com.ningpai.util.UtilDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.util.*;

/**
 * 微信扫码支付
 * Created by dll on 2017/6/20.
 */
@Controller
public class WeixinPayController {

    /** 记录日志对象 */
    public static final MyLogger LOGGER = new MyLogger(WeixinPayController.class);

    private static final String UNKNOWN = "unknown";
    private static final String WEIXIN_PAY = "order/weixinpay";
    private static final String WEIXINPAY_RECHARGE = "order/weixinpay_recharge";

    @Resource(name = "payService")
    private PayService payService;

    @Resource(name = "OrderService")
    private OrderService orderser;

    @Resource(name = "SiteOrderService")
    private SiteOrderService siteOrderService;

    @Resource(name = "receivablesService")
    private ReceivablesService receivablesService;

    @Resource(name = "TopAndBottomService")
    private TopAndBottomService topAndBottomService;

    @Autowired
    private SiteDepositService depositService;

    @Autowired
    private TradeService tradeService;

    @Resource(name = "emailUtilsSite")
    private EmailUtils emailUtils;

    /**
     * 通知消息
     */
    @Resource(name="orderNoticeServiceSite")
    private OrderNoticeService orderNoticeService;
    @Resource(name = "OrderGoodsMapper")
    private OrderGoodsMapper orderGoodsMapper;

    @Autowired
    private GiftcardService giftcardService;

    @Resource
    private DstOrderService dstOrderService;

    @Resource
    private OrderService orderService;


    /**
     * 调用微信支付
     * @param request
     * @param response
     * @param orderId 需要支付的订单Id
     * @param payId 支付方式
     * @return 返回微信扫码支付二维码链接
     * @throws IOException
     */
    @RequestMapping("/weixinpay")
    public ModelAndView weixinpay(HttpServletRequest request, HttpServletResponse response,Long orderId,Long payId) throws IOException {

        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);

        ModelAndView mav = null;
        // 获取用户id

        // 判断用户id是否为空
        if (customerId == null) {
            mav = new ModelAndView("redirect:/customer/login.html");
            return mav;
        }
        // 返回订单商品的商品名称，取第一个
        String goodsName = orderser.queryGoodsInfoName(orderId);
        // 获取订单信息
        Order order = siteOrderService.getPayOrder(orderId);

        // 判断订单 是否是当前用户的订单
        if (!customerId.equals(order.getCustomerId()) || !("0").equals(order.getOrderStatus())) {
            mav = new ModelAndView("redirect:/customer/myorder.html");
            return mav;
        }

        // 支付的实际金额
        BigDecimal payTotalPrice = order.getOrderPrice();

        Pay pay = null;
        // 查询使用的支付信息
        if(order.getShippingProvince().contains("内蒙古")){
            pay = payService.findByPayId(35L);
        }else{
            pay = payService.findByPayId(payId);
        }

        if (pay == null) {
            mav = new ModelAndView("redirect:/customer/myorder.html");
            return mav;
        }



        //获取前台是否选择使用礼品卡账户进行支付
        String isgiftcard = request.getParameter("isgiftcard");

        if(("1").equals(isgiftcard)) {
            Map<String,Object> queryMap = new HashMap<>();
            queryMap.put("customerId",customerId);
            Deposit deposit = depositService.getDeposit(queryMap);
            //同时需要将订单使用的礼品卡金额同步到订单中
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("giftcardPrice", deposit.getPreDeposit());
            map.put("orderId", orderId);
            map.put("payId", pay.getPayType());
            orderser.updategiftcardPrice(map);
            payTotalPrice = payTotalPrice.subtract(deposit.getPreDeposit()).setScale(2,BigDecimal.ROUND_HALF_UP);
            //礼品卡支付金额
            order.setGiftcardPrice(deposit.getPreDeposit());
        }else{
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("giftcardPrice", 0);
            map.put("orderId", orderId);
            map.put("payId", pay.getPayType());
            order.setGiftcardPrice(BigDecimal.ZERO);
            orderser.updategiftcardPrice(map);
        }
        // 单笔订单 生成单笔的付款单信息
        order.setOrderPrice(payTotalPrice);
        this.getReceivables(pay, request, order);

        // 账号信息
        String appid = pay.getApiKey();
        String mch_id = pay.getPartner();
        String key = pay.getPartnerKey();
        // 回调接口
        String notify_url = pay.getBackUrl();

        String currTime = WeixinPayCommonUtil.getCurrTime();
        String strTime = currTime.substring(8, currTime.length());
        String strRandom = WeixinPayCommonUtil.buildRandom(4) + "";
        String nonce_str = strTime + strRandom;
        //  价格   注意：价格的单位是分
        String order_price = payTotalPrice.multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).toString();
        String body = goodsName;   // 商品名称
        // 订单号 订单修改价格后不能重复支付 所以不能直接用订单编号进行下单 需要追加 一个随机数 例如：_1234
        String out_trade_no = order.getOrderCode() + "_" + WeixinPayCommonUtil.buildRandom(4);
        System.out.println(out_trade_no);
        // 获取发起电脑 ip
        String spbill_create_ip = getIpAddr(request);
        //交易类型 NATIVE--原生扫码支付
        String trade_type = "NATIVE";

        SortedMap<Object,Object> packageParams = new TreeMap<Object,Object>();
        packageParams.put("appid", appid);
        packageParams.put("mch_id", mch_id);
        packageParams.put("nonce_str", nonce_str);
        packageParams.put("body", body);
        packageParams.put("out_trade_no", out_trade_no);
        packageParams.put("total_fee", order_price);
        packageParams.put("spbill_create_ip", spbill_create_ip);
        packageParams.put("notify_url", notify_url);
        packageParams.put("trade_type", trade_type);

        String urlCode = null;
        try {
            String sign = WeixinPayCommonUtil.createSign("UTF-8", packageParams,key);
            packageParams.put("sign", sign);
            String requestXML = WeixinPayCommonUtil.getRequestXml(packageParams);
            System.out.println("requestXML:"+requestXML);
            String resXml = WeixinHttpUtil.postData(WeixinPayConfigUtil.UFDODER_URL, requestXML);
            System.out.println("resXml:"+resXml);
            Map map = WeixinXmlUtil.doXMLParse(resXml);
            urlCode = (String) map.get("code_url");
            // urlCode：二维码链接
            mav = new ModelAndView(WEIXIN_PAY).addObject("urlCode", urlCode);
            mav.addObject("orderCode",order.getOrderCode()).addObject("orderId",orderId).addObject("order_price",payTotalPrice);
        }catch (Exception e){
            e.printStackTrace();
        }

        return topAndBottomService.getSimpleTopAndBottom(mav);

    }

    @RequestMapping("/weixinpay_recharge")
    public ModelAndView weixinpay_recharge(HttpServletRequest request, HttpServletResponse response,String totalFee,Long payId) throws IOException {
        ModelAndView mav = null;
        // 获取用户id
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 判断用户id是否为空
        if (customerId == null) {
            mav = new ModelAndView("redirect:/customer/login.html");
            return mav;
        }

        BigDecimal test = null;
        try{
            test = new BigDecimal(totalFee);
        }catch (Exception ex){
            response.getWriter().write("请输入合法数字!");
            return null;
        }

        if(test!=null){//负数
            if(test.compareTo(BigDecimal.ZERO)<0){
                response.getWriter().write("请输入合法数字!");
                return null;
            }
        }
        //上限
        if(test.compareTo(TradeConst.MAX_PER_RECHARGE)>0){
            response.getWriter().write("充值大于上限!");
            return null;
        }

        // 查询使用的支付信息
        Pay pay = payService.findByPayId(payId);
        if (pay == null) {
            mav = new ModelAndView("redirect:/customer/myorder.html");
            return mav;
        }

        //Random random = new Random();
        int randomNum = new Random().nextInt(9000) + 1000;
        // 子订单号
        String orderCode = "R" + UtilDate.mathString(new Date()) + randomNum;

        BigDecimal totalPrice = new BigDecimal(totalFee);

        // 账号信息
        String appid = pay.getApiKey();
        String mch_id = pay.getPartner();
        String key = pay.getPartnerKey();
        // 回调接口
        String notify_url = pay.getBackUrl();

        String currTime = WeixinPayCommonUtil.getCurrTime();
        String strTime = currTime.substring(8, currTime.length());
        String strRandom = WeixinPayCommonUtil.buildRandom(4) + "";
        String nonce_str = strTime + strRandom;
        //  价格   注意：价格的单位是分
        String order_price = totalPrice.multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).toString();
        String body = customerId + "预存款充值";   // 商品名称
        // 获取发起电脑 ip
        String spbill_create_ip = getIpAddr(request);
        //交易类型 NATIVE--原生扫码支付
        String trade_type = "NATIVE";

        SortedMap<Object,Object> packageParams = new TreeMap<Object,Object>();
        packageParams.put("appid", appid);
        packageParams.put("mch_id", mch_id);
        packageParams.put("nonce_str", nonce_str);
        packageParams.put("body", body);
        packageParams.put("out_trade_no", orderCode);
        packageParams.put("total_fee", order_price);
        packageParams.put("spbill_create_ip", spbill_create_ip);
        packageParams.put("notify_url", notify_url);
        packageParams.put("trade_type", trade_type);

        String urlCode = null;
        try {
            String sign = WeixinPayCommonUtil.createSign("UTF-8", packageParams,key);
            packageParams.put("sign", sign);
            String requestXML = WeixinPayCommonUtil.getRequestXml(packageParams);
            System.out.println("requestXML:"+requestXML);
            String resXml = WeixinHttpUtil.postData(WeixinPayConfigUtil.UFDODER_URL, requestXML);
            System.out.println("resXml:"+resXml);
            Map map = WeixinXmlUtil.doXMLParse(resXml);
            urlCode = (String) map.get("code_url");
            // urlCode：二维码链接
            mav = new ModelAndView(WEIXINPAY_RECHARGE).addObject("urlCode", urlCode);
            mav.addObject("body" ,body).addObject("order_price",totalFee).addObject("orderCode",orderCode);
            saveTrade(customerId,orderCode,totalPrice);
        }catch (Exception e){
            e.printStackTrace();
        }

        return topAndBottomService.getSimpleTopAndBottom(mav);

    }

    /**
     * 微信扫码支付成功后回调
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/weixin_notify")
    public void weixin_notify(HttpServletRequest request, HttpServletResponse response){
        try {
            //读取参数
            InputStream inputStream ;
            StringBuffer sb = new StringBuffer();
            inputStream = request.getInputStream();
            String s ;
            BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
            while ((s = in.readLine()) != null){
                sb.append(s);
            }
            in.close();
            inputStream.close();

            //解析xml成map
            Map<String, String> m = new HashMap<String, String>();
            m = XMLUtil.doXMLParse(sb.toString());
            System.out.println("----------------------"+m);
            //过滤空 设置 TreeMap
            SortedMap<Object,Object> packageParams = new TreeMap<Object,Object>();
            Iterator it = m.keySet().iterator();
            while (it.hasNext()) {
                String parameter = (String) it.next();
                String parameterValue = m.get(parameter);

                String v = "";
                if(null != parameterValue) {
                    v = parameterValue.trim();
                }
                packageParams.put(parameter, v);
            }

            // 账号信息
            String key = WeixinPayConfigUtil.API_KEY; // key

            System.out.println(packageParams);
            //判断签名是否正确
            if(WeixinPayCommonUtil.isTenpaySign("UTF-8", packageParams,key)) {
                //------------------------------
                //处理业务开始
                //------------------------------
                String resXml = "";
                if("SUCCESS".equals((String)packageParams.get("result_code"))){
                    // 这里是支付成功
                    //////////执行自己的业务逻辑////////////////
                    // 接收返回信息，剔除订单号随机部分 _0123
                    String out_trade_no = packageParams.get("out_trade_no").toString();
                    //判断是否为预付款充值订单
                    if(out_trade_no.contains("R")){
                        Map<String,Object> qMap = new HashMap<>();
                        qMap.put("orderCode",out_trade_no);
                        Trade trade = tradeService.findByOrderCodeAndCustomerId(qMap);
                        if(trade == null){
                            LOGGER.debug("没有查到充值订单信息");
                        }
                        Long customerId = trade.getCustomerId();
                        Map<String,Object> param = new HashMap<>();
                        param.put("orderCode",out_trade_no);
                        param.put("status","6");//6数据库枚举，充值成功
                        param.put("customerId",customerId);
                        tradeService.recharge(param);
                    }else{
                        out_trade_no = out_trade_no.split("_")[0];
                        //修改订单状态为已付款待发货
                        Order or = siteOrderService.getPayOrderByCode(out_trade_no);
                        if ("0".equals(or.getOrderStatus())) {

                            OrderNotice record = new OrderNotice();
                            int count = 0;
                            List<OrderGoods> orderGoodsList = this.orderGoodsMapper.selectOrderGoodsList(or.getOrderId());

                            //如果货品中包含电子礼品卡则支付成功后激动该笔订单相应的卡号
                            for(OrderGoods og:orderGoodsList){
                                if(og.getGoodsInfoName().indexOf("电子卡") != -1){
                                    GiftcardVo gc = new GiftcardVo();
                                    gc.setActiveFlag("1");
                                    gc.setActiveTime(new Date());
                                    gc.setOrderCode(or.getOrderCode());
                                    giftcardService.updateGiftcard(gc);

                                    //支付成功后发送将电子礼品卡账户卡号密码发送发送到指定的电子邮箱
                                    List<Giftcard> giftcards = this.giftcardService.selectGiftcardByOrderCode(or.getOrderCode());
                                    emailUtils.sendGiftCardEmails(request,or.getGiftcardEmail(),giftcards);
                                }
                            }

                            //支付成功，更新订单到ERP
                            dstOrderService.synUpdateOrderToERP(or.getOrderId());


                            //如果使用了礼品卡支付 需要更新礼品卡账户总金额
                            if(or.getGiftcardPrice() != null && or.getGiftcardPrice().compareTo(new BigDecimal(0)) > 0){
                                //通过订单生成tradeInfo交易记录
                                depositService.genTradeByOrder(or,or.getCustomerId());
                            }

                            record.setCustomerId(or.getCustomerId());
                            record.setOrderId(or.getOrderId());
                            record.setNoticeTitle("您的订单已支付完毕");
                            if(orderGoodsList!=null &&orderGoodsList.size()>1){
                                for(OrderGoods orderGoods:orderGoodsList){
                                    count+=orderGoods.getGoodsInfoNum();
                                }
                                if(orderGoodsList.get(0).getGoodsInfoName().length()>10) {
                                    record.setNoticeContent("您所购买的  " + orderGoodsList.get(0).getGoodsInfoName().substring(0, 9) + "...  等" + count + "件商品已支付完毕，我们将及时为您处理！");
                                }else {
                                    record.setNoticeContent("您所购买的  " + orderGoodsList.get(0).getGoodsInfoName() + "...  等" + count + "件商品已支付完毕，我们将及时为您处理！");
                                }
                            }else{
                                if(orderGoodsList.get(0).getGoodsInfoName().length()>10) {
                                    record.setNoticeContent("您所购买的  " + orderGoodsList.get(0).getGoodsInfoName().substring(0, 9) + "...  已支付完毕，我们将及时为您处理！");
                                }else {
                                    record.setNoticeContent("您所购买的  " + orderGoodsList.get(0).getGoodsInfoName() + "...  已支付完毕，我们将及时为您处理！");
                                }
                            }
                            //record.setNoticeContent("您的订单 "+orderT.getOrderCode()+" 已经提交成功，我们将及时为您处理。");
                            record.setIsRead("0");
                            orderNoticeService.addNotice(record);
                            //修改订单状态 更新支付方式

                            Map<String, Object> map =  new HashMap<String, Object>();
                            map.put("orderId", or.getOrderId());
                            if(or.getShippingProvince().contains("内蒙古")){
                                map.put("payId", 11);
                            }else{
                                map.put("payId", 7);
                            }
                            map.put("status", "1");
                            orderService.updateOrderStatusAndPayId(map);
                            // 更新收款单为支付成功
                            Receivables receivables = new Receivables();
                            receivables.setReceivablesTime(new Date());
                            receivables.setOrderCode(out_trade_no);
                            this.receivablesService.updatePayStatus(receivables);
                        }
                    }
                    //////////执行自己的业务逻辑////////////////

                    System.out.println("微信扫码支付成功");
                    //通知微信.异步确认成功.必写.不然会一直通知后台.八次之后就认为交易失败了.
                    resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                            + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";

                } else {
                    System.out.println("支付失败,错误信息：" + packageParams.get("err_code"));
                    resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                            + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
                }
                //------------------------------
                //处理业务完毕
                //------------------------------
                BufferedOutputStream out = new BufferedOutputStream(
                        response.getOutputStream());
                out.write(resXml.getBytes());
                out.flush();
                out.close();
            } else{
                System.out.println("通知签名验证失败");
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * 根据支付的订单的数量 来设置订单的属性
     *
     * @param order 订单对象
     * @return
     */
    public void getReceivables(Pay p, HttpServletRequest request, Order order) {

        /**
         * 之前每笔订单只存在一种支付方式
         * 现在可以用礼品卡账户进行支付 则是两笔收款记录
         * 而在订单再次进行支付时 如果重新选择了第三方支付进行支付 则需要删除之前生成的记录
         * 故在订单存在礼品卡账户
         */
        this.receivablesService.deleteByCode(order.getOrderCode());

        if(order.getGiftcardPrice() != null && order.getGiftcardPrice().compareTo(new BigDecimal(0)) > 0){
            //添加礼品卡收款记录
            /* 添加收款单信息 */
            Pay p1 = payService.findByPayId(42L);
            Receivables receivables = new Receivables();
            Random random = new Random();
            int code = random.nextInt(10001);
            String codes = "2017" + code;
            // 收款单编号 产生的随机数
            receivables.setCashRegisterCode(codes);
            // 收款单IP
            receivables.setPayIp(getIpAddr(request));
            // 会员ID
            receivables.setCustomerId(order.getCustomerUsername());
            // 收款账号
            receivables.setPayAccount(p1.getPayAccount());
            // 给收款单信息设置IP地址
            // receivables.setPayIp(InetAddress.getLocalHost().getHostAddress());
            // 设置生成时间
            receivables.setPayTime(new Date());
            // 设置付款时间
            receivables.setReceivablesTime(new Date());
            // 给收款单信息设置支付方式
            receivables.setPayMode(p1.getPayName());
            // 设置支付类型
            receivables.setPayType("在线支付");
            // 给收款单信息设置付款金额
            receivables.setPayMoney(order.getGiftcardPrice());
            receivables.setOrderCode(order.getOrderCode());
            // 给付款单信息设置是否支付成功
            receivables.setPayStatus("1");
            // 执行为收款单信息添加信息操作
            this.receivablesService.addReceivables(receivables);
        }
        Receivables receivables = new Receivables();
        Random random = new Random();
        int code = random.nextInt(10001);
        String codes = "2017" + code;
        // 收款单编号 产生的随机数
        receivables.setCashRegisterCode(codes);
        // 收款单IP
        receivables.setPayIp(getIpAddr(request));
        // 会员ID
        receivables.setCustomerId(order.getCustomerUsername());
        // 收款账号
        receivables.setPayAccount(p.getPayAccount());
        // 给收款单信息设置IP地址
        // receivables.setPayIp(InetAddress.getLocalHost().getHostAddress());
        // 设置生成时间
        receivables.setPayTime(new Date());
        // 设置付款时间
        receivables.setReceivablesTime(new Date());
        // 给收款单信息设置支付方式
        receivables.setPayMode(p.getPayName());
        // 设置支付类型
        receivables.setPayType("在线支付");
        // 给收款单信息设置付款金额
        receivables.setPayMoney(order.getOrderPrice());
        receivables.setOrderCode(order.getOrderCode());
        // 给付款单信息设置是否支付成功
        receivables.setPayStatus("1");
        // 执行为收款单信息添加信息操作
        this.receivablesService.addReceivables(receivables);
    }

    /**
     * 获取ip地址
     *
     * @param request
     * @return
     */
    public String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    private int saveTrade(Long customerId,String orderCode,BigDecimal totalPrice){
        Map<String,Object> qParam = new HashMap<>();
        qParam.put("customerId",customerId);
        //查总账信息。获取可用的余额信息
        Deposit deposit = depositService.getDeposit(qParam);

        BigDecimal preDeposit = deposit.getPreDeposit();
        BigDecimal freezePreDeposit = deposit.getFreezePreDeposit();
        BigDecimal currentPrice = preDeposit.add(freezePreDeposit);
        Trade tTrade = new Trade();
        tTrade.setCustomerId(customerId);
        tTrade.setCreatePerson(customerId);
        tTrade.setCreateTime(new Date());
        tTrade.setOrderPrice(totalPrice);
        tTrade.setDelFlag("0");
        tTrade.setOrderCode(orderCode);
        tTrade.setOrderStatus("5");
        tTrade.setOrderType("0");
        tTrade.setTradeRemark("在线充值-微信");
        //当前可用余额信息。
        tTrade.setCurrentPrice(currentPrice);
        int ret = tradeService.saveTrade(tTrade);
        return ret;
    }


}
