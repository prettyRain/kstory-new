/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */

package com.ningpai.m.order.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ningpai.common.safe.CSRFTokenManager;
import com.ningpai.common.util.ConstantUtil;
import com.ningpai.common.util.alipaymobile.config.AlipayConfig;
import com.ningpai.common.util.alipaymobile.util.AlipayNotify;
import com.ningpai.common.util.alipaymobile.util.AlipaySubmit;
import com.ningpai.community.bean.CommunityStore;
import com.ningpai.community.service.CommunityStoreService;
import com.ningpai.coupon.bean.Coupon;
import com.ningpai.coupon.service.CouponService;
import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.bean.CustomerAddress;
import com.ningpai.customer.bean.Giftcard;
import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.customer.service.GiftcardService;
import com.ningpai.customer.vo.GiftcardVo;
import com.ningpai.dst.order.service.DstOrderService;
import com.ningpai.freighttemplate.service.FreightTemplateService;
import com.ningpai.goods.service.GoodsGroupService;
import com.ningpai.goods.service.GoodsProductService;
import com.ningpai.goods.vo.GoodsGroupVo;
import com.ningpai.goods.vo.GoodsProductVo;
import com.ningpai.m.common.service.SeoService;
import com.ningpai.m.common.util.SendEmailUtils;
import com.ningpai.m.customer.bean.OrderNotice;
import com.ningpai.m.customer.service.CustomerAddressService;
import com.ningpai.m.customer.service.OrderNoticeService;
import com.ningpai.m.customer.vo.CustomerAllInfo;
import com.ningpai.m.customer.vo.CustomerConstants;
import com.ningpai.m.deposit.bean.DepositInfo;
import com.ningpai.m.deposit.service.DepositInfoService;
import com.ningpai.m.order.bean.OrderAddress;
import com.ningpai.m.order.service.OrderMService;
import com.ningpai.m.order.service.OrderPayService;
import com.ningpai.m.shoppingcart.bean.ShoppingCart;
import com.ningpai.m.shoppingcart.service.ShoppingCartService;
import com.ningpai.m.util.LoginUtil;
import com.ningpai.m.weixin.util.WXSendMSG;
import com.ningpai.marketing.bean.Marketing;
import com.ningpai.marketing.service.MarketingService;
import com.ningpai.order.bean.Order;
import com.ningpai.order.bean.OrderGoods;
import com.ningpai.order.dao.OrderGoodsMapper;
import com.ningpai.order.service.OrderService;
import com.ningpai.order.service.SynOrderService;
import com.ningpai.other.util.CustomerConstantStr;
import com.ningpai.system.bean.*;
import com.ningpai.system.dao.IExpressConfDao;
import com.ningpai.system.service.*;
import com.ningpai.system.service.impl.ExpressConfBizImpl;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PropertieUtil;
import com.ningpai.util.ShoppingCartConstants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;

/**
 * 订单控制器
 *
 * @author NINGPAI-LIH
 * @version 1.0
 * @since 2014年4月14日 下午5:35:48
 */
@Controller
public class OrderMController {

    private static final MyLogger LOGGER = new MyLogger(OrderMController.class);

    private static final String CH_PAY = "ch_pay";
    private static final String TYPEID = "typeId";
    private static final String ADDRESSID = "addressId";
    private static final String DELIVERYPOINTID = "deliveryPointId";
    private static final String LOGIN_HTML = "../loginm.html";
    private static final String ISO_8859_1 = "ISO-8859-1";
    private static final String ORDER = "order";
    private static final String PAYLIST = "paylist";
    private static final String OUT_TRADE_NO = "out_trade_no";
    private static final String UTF_8 = "UTF-8";
    private static final String SUCCESS = "success";
    private static final String CSUCCESS = "SUCCESS";
    private static final String UNKNOWN = "unknown";

    private ExpressConfBizImpl expressConfBizImpl;

    private ShoppingCartService shoppingCartService;

    private OrderMService siteOrderService;

    private MarketingService marketingService;

    @Resource(name = "OrderService")
    private OrderService orderser;

    private GoodsProductService goodsProductService;

    @Resource(name = "customerAddressServiceM")
    private CustomerAddressService addressService;

    @Resource(name = "SeoService")
    private SeoService seoService;

    @Resource(name = "FreightTemplateService")
    private FreightTemplateService freightTemplateService;

    @Resource(name = "GoodsGroupService")
    private GoodsGroupService goodsGroupService;

    @Resource(name = "customerAddressServiceM")
    private CustomerAddressService customerAddressService;

    @Resource(name = "OrderPayService")
    private OrderPayService orderPayService;

    @Resource(name = "CouponService")
    private CouponService couponService;

    @Resource(name = "customerServiceMapper")
    private CustomerServiceMapper customerServiceMapper;

    // 自提点
    @Resource(name = "DeliveryPointService")
    private DeliveryPointService deliveryPointService;

    @Resource(name = "PaymentService")
    PaymentService paymentService;

    @Resource(name = "sendEmailUtils")
    private SendEmailUtils sendEmailUtils;

    @Autowired
    private ExpressConfBizImpl iExpressConfBiz;
    @Autowired
    private GiftcardService giftcardService;

    /**
     * 配送方式设置数据操作类
     */
    @Resource(name = "expressConfDaoImpl")
    private IExpressConfDao expressConfDaoImpl;

    @Resource(name="orderNoticeServiceM")
    private OrderNoticeService orderNoticeService;

    @Resource
    private DstOrderService dstOrderService;

    @Resource(name = "receivablesService")
    private ReceivablesService receivablesService;

    @Resource(name = "depositInfoServiceM")
    private DepositInfoService depositInfoService;

    @Resource(name = "payService")
    private PayService payService;

    @Resource(name="CommunityStoreService")
    private CommunityStoreService communityStoreService;
    @Resource(name = "OrderGoodsMapper")
    private OrderGoodsMapper orderGoodsMapper;
    @Resource(name = "OrderService")
    private OrderService orderService;

    @Resource(name = "authService")
    private AuthService authService;

    @RequestMapping("/sendEmail")
    public void sendEmail(HttpServletRequest request){
        sendEmailUtils.sendGiftCardEmails(request,"1219526576@qq.com",null);
    }

    /**
     * 获取价格
     * */
    @RequestMapping("/getMexpressprice")
    @ResponseBody
    public String getExpressPrice(Long addressId, HttpServletRequest request, Long distributionId) {
        // 用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        String thirdId = request.getParameter("thirdIds");
        String cartId = request.getParameter("cartIds");
        String[] thirdIds = thirdId.split(",");
        String[] cartIds = cartId.split(",");

        // 获取 收获地址城市
        CustomerAddress ca = addressService.queryCustomerAddressById(addressId, customerId);
        if (ca == null) {
            return "0";
        }
        BigDecimal price = new BigDecimal(0);
        // 判断商家订单
        for (int i = 0; i < thirdIds.length; i++) {
            if (thirdIds[i] != null && !"".equals(thirdIds[i])) {

                // 获取该订单的购物车Id
                List<Long> shopIds = new ArrayList<Long>();

                if ("0".equals(thirdIds[i])) {
                    for (int j = 0; j < cartIds.length; j++) {
                        // 获取购物车商品个数和重量
                        String s = cartIds[j];
                        String[] ids = s.split("-");
                        if (ids != null && ids.length != 0) {
                            for (String id : ids) {
                                shopIds.add(Long.valueOf(id));

                            }
                        }
                    }
                } else {
                    // 获取购物车商品个数和重量
                    String s = cartIds[i];
                    String[] ids = s.split("-");
                    if (ids != null && ids.length != 0) {
                        for (String id : ids) {
                            shopIds.add(Long.valueOf(id));

                        }
                    }
                }

                // 添加购物车id
                Long[] box = new Long[shopIds.size()];
                for (int j = 0; j < shopIds.size(); j++) {
                    box[j] = shopIds.get(j);
                }
                List<ShoppingCart> shlist = shoppingCartService.searchByProduct(request, box);
                BigDecimal weight = new BigDecimal(0);
                Integer nums = 0;
                if (shlist != null && !shlist.isEmpty()) {
                    for (ShoppingCart sc : shlist) {
                        // 判断是否是套装
                        if (sc.getFitId() == null) {
                            // 如果是普通商品，执行普通商品的方法
                            GoodsProductVo goodsProduct = goodsProductService.queryByPrimaryId(sc.getGoodsInfoId());
                            if (goodsProduct != null && "0".equals(goodsProduct.getIsMailBay())) {
                                weight = weight.add(goodsProduct.getGoodsInfoWeight().multiply(new BigDecimal(sc.getGoodsNum())));
                                nums += Integer.parseInt(sc.getGoodsNum().toString());
                            }

                        } else {
                            // 套装运费计算
                            GoodsGroupVo goodsGroupVo = goodsGroupService.queryVoByPrimaryKey(sc.getFitId());
                            // 遍历套装下的商品
                            for (int j = 0; j < goodsGroupVo.getProductList().size(); j++) {

                                weight = weight.add(goodsGroupVo.getProductList().get(j).getProductDetail().getGoodsInfoWeight().multiply(new BigDecimal(sc.getGoodsNum())));
                                nums += Integer.parseInt(sc.getGoodsNum().toString());

                            }

                        }
                    }

                }
                // 邮费计算
                price = price.add(freightTemplateService.getExpressPrice(distributionId, ca.getCity().getCityId(), Long.valueOf(thirdIds[i]), nums, weight));
            }

        }

        // 邮费
        return price.toString();
    }

    /**
     * 新运费计算流程
     *
     * @param addressId
     * @param request
     * @param
     * @return
     */
    @RequestMapping("/getnewMexpressprice")
    @ResponseBody
    public Map<String, Object> getnewexpressprice(Long addressId, HttpServletRequest request) {
        String[] shopCartIds = request.getParameterValues("shopIds[]");
        List<Long> cartList = new ArrayList<>();
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        if (shopCartIds != null && shopCartIds.length != 0) {
            for (String str : shopCartIds) {
                cartList.add(Long.parseLong(str));
            }
        }
        // 获取 收获地址城市
        CustomerAddress ca = customerAddressService.queryCustomerAddressById(addressId, customerId);
        if (ca == null) {
            return null;
        }
        Map<String, Object> freightMap = null;
        if (CollectionUtils.isNotEmpty(cartList) && addressId != null) {
            freightMap = shoppingCartService.getNewExpressPrice(null,ca.getCity().getCityId(), cartList,Long.parseLong(ca.getInfoCity()));
        }

        return freightMap;
    }

    /**
     * 跳转到更改发票页
     *
     * @return
     */
    @RequestMapping("tochangeInvoice")
    public ModelAndView tochangeInvoice(String orderComment,HttpServletRequest request, String invoiceType, String invoiceTitle, String taxpayerNumber, Long chPay, Long deliveryPointId, Long typeId, Long addressId,String codeNo) {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        if (customerId == null) {
            return new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
        } else {
            ModelAndView mav = new ModelAndView("order/invoice").addObject("invoiceType", invoiceType).addObject("invoiceTitle", invoiceTitle).addObject("codeNo",codeNo).addObject("taxpayerNumber",taxpayerNumber);
            // 支付类型
            mav.addObject(CH_PAY, chPay);
            // 物流方式
            mav.addObject(TYPEID, typeId);
            // 收件地址
            mav.addObject(ADDRESSID, addressId);
            // 自提点
            mav.addObject(DELIVERYPOINTID, deliveryPointId);
            if(StringUtils.isNotBlank(orderComment)){
                mav.addObject("orderComment",orderComment);
            }
            return mav;
        }

    }


    /**
     * 跳转到订单确认页
     *
     * @param box
     *            购物车id
     * @param request
     *            促销id
     *            <p/>
     *            第三方标识
     * @param
     * @param typeId
     *            0：快递配送 1：上面自提
     * @param boxgift
     *              购物车和选中赠品
     * taxpayerNumber 纳税人识别号
     * @return
     * @throws UnsupportedEncodingException
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/suborder")
    public ModelAndView subOrder(String orderComment,Long[] box, String invoiceTitle, String invoiceType,String taxpayerNumber, HttpServletRequest request, Long deliveryPointId, Long chPay, Long chExpress,
                                 Long typeId, OrderAddress orderAddress, String codeNo, HttpServletResponse response, String[] boxgift) throws UnsupportedEncodingException {
        OrderAddress orderAddressNew = orderAddress;
        Long[] boxNew = box;
        Long typeIdNew = typeId;
        CommunityStore communityStore = null;
        HttpSession session = request.getSession();
        Long customerId = (Long) session.getAttribute(CustomerConstantStr.CUSTOMERID);
        if (boxNew != null) {
            session.setAttribute("box", box);
        } else {
            boxNew = (Long[]) session.getAttribute("box");
        }
        if(ArrayUtils.isNotEmpty(boxgift)){
            session.setAttribute("boxgift", boxgift);
        }else {
            if(session.getAttribute("boxgift") != null){
                boxgift = (String[]) session.getAttribute("boxgift");
            }else {
                session.setAttribute("boxgift", null);
            }

        }

        if (customerId == null) {
            return new ModelAndView(new RedirectView(LOGIN_HTML));
        }
        //判断购物车商品是否存在删除或者下架的商品
        if (!shoppingCartService.checkHasErrorProduct(boxNew)){
            return seoService.getCurrSeo(new ModelAndView(new RedirectView(request.getContextPath() + "/myshoppingmcart.html")));
        }

            CustomerAddress  customerAddress = addressService.queryDefaultAddr(customerId);

        //若没有默认地址 则显示空地址让用户自行选择 不用填充任意一个收货地址
        if (null == customerAddress) {
            // 查询收货地址
            //customerAddress = addressService.selectByCIdFirst(customerId);
        }

        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");

        /**
         * *************************
         */
        Map<String, Object> map = shoppingCartService.newsubOrder(request, boxNew, customerAddress, boxgift);
        /***
         * *************************
         * *************************
         * *************************
         */

        // 获取购物车列表
        List<ShoppingCart> shoplist = (List<ShoppingCart>) map.get("shoplist");
        if (shoplist == null || shoplist.isEmpty() || "0".equals(map.get("stock"))) {
            ModelMap modelMap = new ModelMap();
            String stocks = JSON.toJSONString(map.get("stockInfo"));
            modelMap.addAttribute("stockinfos", stocks);
            modelMap.addAttribute("buyingLimitError",map.get("buyingLimitError"));
            return new ModelAndView(new RedirectView(request.getContextPath() + "/myshoppingmcart.html"),modelMap);
        }
        boolean stockFlag = true;
        for (ShoppingCart shoppingCart : shoplist) {
            if(shoppingCart.getGoodsDetailBean()!=null && shoppingCart.getGoodsDetailBean().getProductVo()!=null){
                Long goodsInfoStock = shoppingCart.getGoodsDetailBean().getProductVo().getGoodsInfoStock();
                if(goodsInfoStock==0) {
                    stockFlag = stockFlag & false;
                }
            }
        }
        if(customerAddress!=null){
            // 微信收货地址为空
            if (orderAddressNew.getAddressName() == null || orderAddressNew.getAddressPhone() == null || orderAddressNew.getAddressDetail() == null
                    || orderAddressNew.getAddressDetailInfo() == null) {
                    // 给订单地址赋值
                    orderAddressNew = new OrderAddress();
                    orderAddressNew.setAddressId(customerAddress.getAddressId());
                    orderAddressNew.setAddressDetailInfo(customerAddress.getAddressDetail());
                    orderAddressNew.setAddressName(customerAddress.getAddressName());
                    orderAddressNew.setAddressPhone(customerAddress.getAddressMoblie());
                    orderAddressNew.setAddressType(customerAddress.getAddressType());
                    orderAddressNew.setCommunityStoreId(customerAddress.getCommunityStoreId());
                    orderAddressNew.setAddressDetail(customerAddress.getProvince().getProvinceName() + customerAddress.getCity().getCityName()
                            + customerAddress.getDistrict().getDistrictName());
                if (typeIdNew == null || typeIdNew == 0) {
                    // 表示快递方式选择为快递配送
                    typeIdNew = 0L;
                }
            } else {
                // 城市
                orderAddressNew.setAddressCitySecondStageName(new String(orderAddressNew.getAddressCitySecondStageName().getBytes(ISO_8859_1), ConstantUtil.UTF));
                // 区县
                orderAddressNew.setAddressCountiesThirdStageName(new String(orderAddressNew.getAddressCountiesThirdStageName().getBytes(ISO_8859_1), ConstantUtil.UTF));
                // 详细地址
                orderAddressNew.setAddressDetail(new String(orderAddressNew.getAddressDetail().getBytes(ISO_8859_1), ConstantUtil.UTF));
                // 省市县详细地址
                orderAddressNew.setAddressDetailInfo(new String(orderAddressNew.getAddressDetailInfo().getBytes(ISO_8859_1), ConstantUtil.UTF));
                // 收货人名称
                orderAddressNew.setAddressName(new String(orderAddressNew.getAddressName().getBytes(ISO_8859_1), ConstantUtil.UTF));
                // 收货人手机
                orderAddressNew.setAddressPhone(new String(orderAddressNew.getAddressPhone().getBytes(ISO_8859_1), ConstantUtil.UTF));
                // 省
                orderAddressNew.setProviceFirstStageName(new String(orderAddressNew.getProviceFirstStageName().getBytes(ISO_8859_1), ConstantUtil.UTF));
            }
            if(customerAddress.getAddressType().equals("1")){
                communityStore = communityStoreService.selectVo(customerAddress.getCommunityStoreId());
            }
        }
        ModelAndView mav = new ModelAndView("order/newsuborder");
        mav.addObject("stockFlag",stockFlag);
        ExpressConf exp = iExpressConfBiz.getExpressConfByUsedField();
        List<DeliveryPoint> dps;
        // 自提点是否启用条件
        if (null != exp && exp.getUsedStatus().equals("1")) {
            // 收货地址当前城市所有的自提点
            //自提点页面显示逻辑，由于，页面跳转问题导致参数丢失，采用session保存数据
            //1.选择了自提点，
            //2没有选择自提点，
            Map<String,Object> deliveryMap = new HashMap();//自提点相关的页面显示参数集合
            if(deliveryPointId!=null){
                //request.getSession().setAttribute("deliveryPointId",deliveryPointId);
            }else{
                //deliveryPointId = (Long) request.getSession().getAttribute("deliveryPointId");
            }
            //有自提点信息
            List<DeliveryPoint> deliveries = new ArrayList<>();
            if(deliveryPointId != null){//前端或者session保存了自提点信息，获取自提点
                DeliveryPoint deliveryPoint = deliveryPointService.getDeliveryPoint(deliveryPointId);
                deliveryMap.put("choseDeliveryPoint",deliveryPoint);
            }else{//仍然没有获取到deliveryPointId，获取所有自提点地址
                if(customerAddress != null && customerAddress.getCity() != null){
                    deliveries = deliveryPointService.selectByCityId(customerAddress.getCity().getCityId());
                }
                deliveryMap.put("deliveries",deliveries);
            }
            mav.addObject("deliveryMap", deliveryMap);

        }



        // 优惠券
        if (StringUtils.isNotEmpty(codeNo)) {
            Coupon coupon = couponService.selectCouponByCodeNo(codeNo);
            mav.addObject("coupon", coupon);
        }
        // 发票类型
        mav.addObject("invoiceType", invoiceType);
        // 发票抬头
        if(StringUtils.isBlank(invoiceTitle)){
            invoiceTitle=null;
        }
        mav.addObject("invoiceTitle", invoiceTitle);
        //纳税人识别号
        mav.addObject("taxpayerNumber",taxpayerNumber);
        // 自提点
        mav.addObject(DELIVERYPOINTID, deliveryPointId);
        // 运费模板
        List<Payment> payList =  paymentService.selectAllForSite();
        //支付方式
        List<Object> pays = payService.queryAllPaySet();
        mav.addObject("ch_express", chExpress)
                .addObject("map", map)
                .addObject("sx", session.getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME))
                .addObject("customer", customerAddress)
                .addObject(TYPEID, typeIdNew)
                .addObject(CH_PAY, chPay)
                .addObject(PAYLIST, payList)
                .addObject("orderAddress", orderAddressNew)
                .addObject("communityStore",communityStore)
                .addObject("pays", pays)
                .addObject("orderComment",orderComment);

        return seoService.getCurrSeo(mav);
    }

    /**
     * 设置配送方式和支付方式
     *
     * @return
     */
    @RequestMapping("/toFreightAndPay")
    public ModelAndView toFreightAndPay(HttpServletRequest request, Long typeId, Long addressId, Long chPay, Long deliveryPointId) {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
        Long typeIdNew = typeId;
        if (customerId == null) {
            return new ModelAndView(new RedirectView(LOGIN_HTML));
        }
        if (customerId != null) {
            if (typeIdNew == null) {
                typeIdNew = 0L;
            }
            CustomerAddress customerAddress = null;
            // 查询收货地址
            if (customerId != null) {

                customerAddress = addressService.queryDefaultAddr(customerId);
            }
            if (null == customerAddress) {
                // 查询上一次收货地址
                customerAddress = addressService.selectByCIdFirst(customerId);
            }
            Long[] box = (Long[]) request.getSession().getAttribute("box");
            // 查询货品信息
            Map<String, Object> map = shoppingCartService.newsubOrder(request, box, customerAddress,null);
            ModelAndView mav = new ModelAndView("order/payType");
            mav.addObject("map", map).addObject("sx", request.getSession().getAttribute(CSRFTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME)).addObject(TYPEID, typeIdNew)
                    .addObject("ch_pay2", request.getSession().getAttribute(CH_PAY)).addObject(PAYLIST, paymentService.selectAllForSite());
            // 订单收货地址
            mav.addObject(ADDRESSID, addressId);
            // 支付方式
            mav.addObject(CH_PAY, chPay);
            // 自提点id
            mav.addObject(DELIVERYPOINTID, deliveryPointId);
            // 获取自提点对象的信息
            mav.addObject("expressConf", expressConfDaoImpl.getExpressConfByUsedField());
            // 订单收货地址
            CustomerAddress address;
            // 查询收货地址
            if (addressId != null) {
                address = addressService.queryCustomerAddressById(addressId, customerId);
            } else {
                address = addressService.selectByCIdFirst((Long) customerId);
            }
            // 收货地址当前城市所有的自提点
            List<DeliveryPoint> dps = null;
            if (address != null) {
                dps = deliveryPointService.selectDeliveryPointBycityId(Long.valueOf(address.getInfoCity()));
            }
            mav.addObject("dps", dps);
            return seoService.getCurrSeo(mav);
        } else {
            return new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
        }
    }

    /**
     * 查看个人所有的购物券
     *
     * @return
     */
    @RequestMapping("/tocouponlist")
    public ModelAndView tocouponlist(HttpServletRequest request,String codeNo,String invoiceTitle,String invoiceType,
                                     String taxpayerNumber,String addressId,String orderComment,String deliveryPointId,String typeId,String ch_pay) {
        //用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
        //没有登录 返回登录页
        if (customerId == null) {
            return new ModelAndView(new RedirectView(LOGIN_HTML));
        }
        if (customerId != null) {
            //购物车编号集合
            Long[] box = (Long[]) request.getSession().getAttribute("box");
            // 查询地区
            ModelAndView mav = new ModelAndView("order/couponlist");
            //发票抬头
            mav.addObject("invoiceTitle", invoiceTitle);
            //发票类型
            mav.addObject("invoiceType", invoiceType);
            //纳税人识别号
            mav.addObject("taxpayerNumber",taxpayerNumber);
            //地址id
            mav.addObject("addressId",addressId);
            //备注
            mav.addObject("orderComment",orderComment);
            mav.addObject("deliveryPointId",deliveryPointId);
            mav.addObject("typeId",typeId);
            mav.addObject("ch_pay",ch_pay);
            //优惠券编号
            mav.addObject("codeNo", codeNo);
            // 查订单优惠券列表
            List<Coupon> couponlist = shoppingCartService.getUsedCouponlist(request, box);
            // 订单优惠券列表
            mav.addObject("couponlist", couponlist);
            //查询用户的所有未过期且未使用的优惠券
            List<Coupon> coupons = couponService.selectCouponListByCustomerId(customerId);

            //去除此订单可以使用的
            if(couponlist!=null&& !couponlist.isEmpty()){
                for(int i=0;i<couponlist.size();i++){
                    if("1".equals(couponlist.get(i).getTimeType())){
                        couponlist.get(i).setCouponEndTime(new Date(couponlist.get(i).getCodeGetTime().getTime()+couponlist.get(i).getCouponDays()*24*60*60*1000));
                    }
                    for(int j=0;j<coupons.size();j++){
                        if(couponlist.get(i).getCodeNo().equals(coupons.get(j).getCodeNo())){
                            coupons.remove(coupons.get(j));
                            j=j-1;
                        }
                    }
                }
            }
            //不可用优惠券
            mav.addObject("coupons", coupons);
            return seoService.getCurrSeo(mav);
        } else {
            return new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
        }
    }


    /**
     * 查询订单中使用的优惠券是否可用
     *
     * @param couponNo
     * @return int
     * */
    @RequestMapping("/queryStatus")
    @ResponseBody
    public int queryStatus(HttpServletRequest request,String couponNo){
        //定义一个变量用于返回状态
        /**
         * 如果状态值为1代表使用的优惠券码是不在该用户能使用的优惠券中
         * 如果状态值为0代表使用的优惠券码用户可以使用
         * 如果状态值为-1代表传进来的参数为空
         * */
        int flag = 1;
        //购物车编号集合
        Long[] box = (Long[]) request.getSession().getAttribute("box");
        // 查订单优惠券列表
        List<Coupon> couponlist = shoppingCartService.getUsedCouponlist(request, box);
        //判断传入进来的优惠券码是否为空
        if(StringUtils.isEmpty(couponNo)){
            flag = -1;
        }else{
            //判断该用户该笔订单可使用的优惠券是否为空
            if(null != couponlist && couponlist.size() > 0){
                for(int i = 0;i < couponlist.size();i++){
                    //如果传入的优惠券码与查询出来的优惠券集合有一个相同那么就代表可以使用
                    if(couponNo.equals(couponlist.get(i).getCodeNo())){
                        flag = 0;
                        break;
                    }
                }
            }
        }

        return flag;
    }

    /**
     * 查看货品详情
     */
    @RequestMapping("/toproductsList")
    public ModelAndView toproductsList(HttpServletRequest request) {
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
        if (customerId == null) {
            return new ModelAndView(new RedirectView(LOGIN_HTML));
        }
        if (customerId != null) {
            CustomerAddress customerAddress = null;
            // 查询收货地址
            if (customerId != null) {

                customerAddress = addressService.queryDefaultAddr(customerId);
            }
            if (null == customerAddress) {
                // 查询上一次收货地址
                customerAddress = addressService.selectByCIdFirst(customerId);
            }
            Long[] box = (Long[]) request.getSession().getAttribute("box");
            // 查询货品信息
            Map<String, Object> map = shoppingCartService.newsubOrder(request, box, customerAddress,null);
            ModelAndView mav = new ModelAndView("order/productsList");
            mav.addObject("map", map);
            return seoService.getCurrSeo(mav);
        } else {
            return new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
        }
    }

    /**
     * 查询订单优惠
     *
     * @param goodsIds
     * @return int
     */
    @RequestMapping("/selectordermarketingbygoodsids")
    @ResponseBody
    public List<Marketing> selectordermarketingbygoodsids(Long[] goodsIds) {
        return new ArrayList<Marketing>();
    }

    /**
     * 修改优惠
     *
     * @param shoppingCartId
     * @param orderMarketId
     * @return int
     */
    @RequestMapping("/changeshoppingcartordermarkets")
    @ResponseBody
    public int changeshoppingcartordermarkets(Long shoppingCartId, Long orderMarketId) {
        return 0;
    }

    /**
     * 提交订单(货到付款)
     *
     * @param shoppingCartId
     *            所购买的的货品ID
     * @param deliveryPointId
     *            自提点Id
     * @param point
     *            兑换积分
     * @return ModelAndView
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/submitorder")
    public ModelAndView submitOrder(HttpServletRequest request, Long point, String invoiceType, String invoiceTitle,String taxpayerNumber, Long deliveryPointId, Long[] shoppingCartId,
                                    HttpServletResponse response,  Long typeId, OrderAddress orderAddress,String[] presentScopeId,String[] coupon_presentScopeId)
            throws UnsupportedEncodingException {
        if (point != null && point < 0) {
            throw new RuntimeException("参数格式不正确！");
        }
        // 用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 是否登录
        if (customerId == null) {
            // 返回登录页
            return new ModelAndView(new RedirectView(LOGIN_HTML));
        }
        List<Order> orders = null;
        // 保存订单
        orders = siteOrderService.newsubmitOrder(point, invoiceType, invoiceTitle, taxpayerNumber,request, shoppingCartId, typeId, orderAddress, deliveryPointId, presentScopeId,coupon_presentScopeId);

        // 返回购物车
        if (orders == null || orders.size() == 0) {
            return new ModelAndView(new RedirectView(request.getContextPath() + "/myshoppingmcart.htm"));
        }
        Order order = orders.get(0);
        // 推送消息
        orderPayService.sendOrderRe(order, request, response);
        for (int i = 0; i < orders.size(); i++) {
            Order or = orderPayService.queryGoodsProducts(orders.get(i).getOrderId());
            orders.set(i, or);
        }
        //订单通知消息
        OrderNotice record = new OrderNotice();
        Order orderT = new Order();
        for (int i = 0; i < orders.size(); i++) {
            orderT = orders.get(i);
            addNotice(customerId, orderT,"您的订单已提交成功","订单已提交成功，请尽快支付！");
        }
        // 订单成功页
        ModelAndView mav=null;

        Long chPay = 1L;
        if (StringUtils.isNotEmpty(request.getParameter(CH_PAY))) {
            chPay = Long.valueOf(request.getParameter(CH_PAY));
        }
        if(chPay.equals(Long.valueOf(2))){
            mav= new ModelAndView(new RedirectView("customer/detail-"+orders.get(0).getOrderId()+".html"));
        }
        return seoService.getCurrSeo(mav);
    }

    /**
     * 去付款
     *
     * @param orderId
     * @return ModelAndView
     */
    @RequestMapping("/gopayorder")
    public ModelAndView gopayorder(Long orderId) {
        ModelAndView mav = new ModelAndView("order/payment");

        Order order = siteOrderService.getPayOrder(orderId);
        // 订单信息
        mav.addObject("orderCode", order.getOrderCode());
        // 订单id
        mav.addObject(ConstantUtil.ORDERID, order.getOrderId());
        // 订单价格
        mav.addObject("payPrice", order.getOrderPrice());
        mav.addObject("orderId", order.getOrderId());
        mav.addObject(PAYLIST, payService.queryAllPaySet());
        return seoService.getCurrSeo(mav);
    }

    /**
     * 根据订单id进行支付 跳转到新的支付页面进行支付
     *
     * @param orderId
     *            订单id
     * @return
     */
    @RequestMapping("/orderdetailpay")
    public ModelAndView orderDetailPay(HttpServletRequest request,Long orderId) {
        // 用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 是否登录
        if (customerId == null) {
            // 返回登录页
            return new ModelAndView(new RedirectView(LOGIN_HTML));
        }
        ModelAndView mav = new ModelAndView("order/payment");
        Order order = siteOrderService.getPayOrder(orderId);

        //检查订单货品列表中是否包含礼品卡的  《电子卡或者实体卡》 字样 如果包含则不能使用礼品卡账户进行支付
        int isCardNum = 0;
        for(OrderGoods goodsInfo:order.getOrderGoodsList()){
            if(goodsInfo.getGoodsInfoName().indexOf("电子卡") > 0 || goodsInfo.getGoodsInfoName().indexOf("实体卡") > 0){
                isCardNum += 1;
            }
        }
        mav.addObject("cardNum", isCardNum);
        // 订单信
        mav.addObject("orderCode", order.getOrderCode());
        // 订单id
        mav.addObject("orderId", order.getOrderId());
        // 订单价格
        mav.addObject("payPrice", order.getOrderPrice());
        //支付方式
        List<Object> pays = payService.queryAllPaySet();

        // 获取微信接口的重定向地址
        Auth auth = authService.findAuthByAuthType("9");
        String redirect = auth.getAuthRedirectUri();
        //是微信浏览器且是微信支付路径
        if(request.getHeader("user-agent").indexOf("MicroMessenger")!=-1&&redirect.indexOf(request.getServerName())!=-1){
            // 查询使用的支付信息
            Pay pay = null;
            String url = "";
            if(order.getShippingProvince().contains("内蒙古")){
                pay = payService.findByPayId(36L);
                url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+pay.getApiKey()+"&redirect_uri=http://"+request.getServerName()+"/getwxtoken1.htm&response_type=code&scope=snsapi_base&state=36-"+isCardNum+"-"+order.getOrderCode()+"-"+order.getOrderId()+"-"+order.getOrderPrice()+"&connect_redirect=1#wechat_redirect";
                return new ModelAndView("redirect:"+url);
            }else{
                pay = payService.findByPayId(37L);
                url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+pay.getApiKey()+"&redirect_uri=http://"+request.getServerName()+"/getwxtoken1.htm&response_type=code&scope=snsapi_base&state=37-"+isCardNum+"-"+order.getOrderCode()+"-"+order.getOrderId()+"-"+order.getOrderPrice()+"&connect_redirect=1#wechat_redirect";
            }
            return new ModelAndView("redirect:"+url);
        }

        return seoService.getCurrSeo(mav).addObject("pays", pays);
    }

    /**
     * 新的订单确认 创建订单 去下一个页面选择支付方式进行支付
     * @param request
     * @param point
     * @param invoiceType
     * @param invoiceTitle
     * @param taxpayerNumber
     * @param deliveryPointId
     * @param shoppingCartId
     * @param response
     * @param typeId
     * @param orderAddress
     * @param presentScopeId
     * @return
     */
    @RequestMapping("/newsubmitorder")
    public ModelAndView newsubmitorder(HttpServletRequest request, Long point, String invoiceType, String invoiceTitle,String taxpayerNumber, Long deliveryPointId, Long[] shoppingCartId,
                                       HttpServletResponse response,  Long typeId, OrderAddress orderAddress, String[] presentScopeId,String[] coupon_presentScopeId) throws Exception {
        ModelAndView mav = new ModelAndView("order/payment");
        if (point != null && point < 0) {
            throw new RuntimeException("参数格式不正确！");
        }
        // 用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 是否登录
        if (customerId == null) {
            // 返回登录页
            return new ModelAndView(new RedirectView(LOGIN_HTML));
            //response.sendRedirect(request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/loginm.html");
        }
        // 保存订单
        List<Order> orders = null;
        try {
            orders = siteOrderService.newsubmitOrder(point, invoiceType, invoiceTitle,taxpayerNumber, request, shoppingCartId, typeId, orderAddress, deliveryPointId, presentScopeId,coupon_presentScopeId);
        }catch (Exception e){
            e.printStackTrace();
        }
        //订单总金额
        BigDecimal sumPrice=BigDecimal.ZERO;
        // 返回购物车
        if (orders == null|| orders.size()==0) {
            //return null;
        }
        Order order = orders.get(0);
        // 推送消息
        orderPayService.sendOrderRe(order, request, response);
        for (int i = 0; i < orders.size(); i++) {
            Order or = orderPayService.newQueryGoodsProducts(orders.get(i).getOrderId());
            orders.set(i, or);
            //计算总订单金额
            sumPrice= sumPrice.add(orders.get(i).getOrderPrice());
        }

        //检查订单货品列表中是否包含礼品卡的  《电子卡或者实体卡》 字样 如果包含则不能使用礼品卡账户进行支付
        int isCardNum = 0;
        for(OrderGoods goodsInfo:order.getOrderGoodsList()){
            if(goodsInfo.getGoodsInfoName().indexOf("电子卡") > 0 || goodsInfo.getGoodsInfoName().indexOf("实体卡") > 0){
                isCardNum += 1;
            }
        }
        mav.addObject("cardNum", isCardNum);
        //订单通知消息
        OrderNotice record = new OrderNotice();
        Order orderT = new Order();
        for (int i = 0; i < orders.size(); i++) {
            orderT = orders.get(i);
            addNotice(customerId, orderT,"您的订单已提交成功","订单已提交成功，请尽快支付！");
        }
        // 返回订单商品的商品名称，取第一个
        //String goodsName = orderser.queryGoodsInfoName(order.getOrderId());
        // 订单信息
        mav.addObject("orderCode", order.getOrderCode());
        // 订单id
        mav.addObject("orderId", order.getOrderId());
        // 商品名称
        //mav.addObject("goodsInfoName", goodsName);
        // 订单价格
        mav.addObject("payPrice", order.getOrderPrice());
        //支付方式
        List<Object> pays = payService.queryAllPaySet();
        mav.addObject("pays", pays);

        // 获取微信接口的重定向地址
        Auth auth = authService.findAuthByAuthType("9");
        String redirect = auth.getAuthRedirectUri();
        //是微信浏览器且是微信支付路径
        if(request.getHeader("user-agent").indexOf("MicroMessenger")!=-1&&redirect.indexOf(request.getServerName())!=-1){
            // 查询使用的支付信息
            Pay pay = null;
            String url = "";
            if(order.getShippingProvince().contains("内蒙古")){
                pay = payService.findByPayId(36L);                                                                                                                  //snsapi_base
                 url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+pay.getApiKey()+"&redirect_uri=http://"+request.getServerName()+"/getwxtoken1.htm&response_type=code&scope=snsapi_base&state=36-"+isCardNum+"-"+order.getOrderCode()+"-"+order.getOrderId()+"-"+order.getOrderPrice()+"&connect_redirect=1#wechat_redirect";
                return new ModelAndView("redirect:"+url);
            }else{
                pay = payService.findByPayId(37L);
                url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+pay.getApiKey()+"&redirect_uri=http://"+request.getServerName()+"/getwxtoken1.htm&response_type=code&scope=snsapi_base&state=37-"+isCardNum+"-"+order.getOrderCode()+"-"+order.getOrderId()+"-"+order.getOrderPrice()+"&connect_redirect=1#wechat_redirect";
            }
            return new ModelAndView("redirect:"+url);
        }

        // 商户相关资料
        /*String appid = pay.getApiKey();
        String appsecret = pay.getSecretKey();
        String partner = pay.getPartner();
        String partnerkey = pay.getPartnerKey();*/
        return seoService.getCurrSeo(mav);
    }

    /**
     * 支付宝支付
     * KKK
     *
     * @param request
     * @return ModelAndView
     */
    @RequestMapping("/alipay")
    public ModelAndView alipay(HttpServletRequest request, Long orderId,Long payId,HttpServletResponse response,String mark) throws UnsupportedEncodingException {


        // 用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 是否登录
        if (customerId == null || payId == null) {
            // 返回登录页
            return null;
        }
        Order order = siteOrderService.getPayOrder(orderId);
        // 判断订单 是否是当前用户的订单 是否为代付款订单
        if(!customerId.equals(order.getCustomerId()) || !("0").equals(order.getOrderStatus())){
            return null;
        }
        // 支付的实际金额
        BigDecimal payTotalPrice = order.getOrderPrice();
        ModelAndView mav = new ModelAndView();
        // 查询使用的支付信息
        Pay p = null;
        Properties properties = PropertieUtil.readPropertiesFile(OrderMController.class.getClassLoader().getResourceAsStream("com/ningpai/web/config/alipay.properties"));
        if(order.getShippingProvince().contains("内蒙古")){
            AlipayConfig.private_key = properties.getProperty("PRIVATE_KEY1");
            p = payService.findByPayId(26L);
        }else{
            AlipayConfig.private_key = properties.getProperty("PRIVATE_KEY");
            p = payService.findByPayId(25L);
        }

        if (p != null) {


            if(("1").equals(mark)) {
                DepositInfo deposit = depositInfoService.queryDepositInfo(customerId);
                //同时需要将订单使用的礼品卡金额同步到订单中
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("giftcardPrice", deposit.getPreDeposit());
                map.put("orderId", orderId);
                orderser.updategiftcardPrice(map);
                payTotalPrice = payTotalPrice.subtract(deposit.getPreDeposit()).setScale(2,BigDecimal.ROUND_HALF_UP);
                //礼品卡支付金额
                order.setGiftcardPrice(deposit.getPreDeposit());
            }else{
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("giftcardPrice", 0);
                map.put("orderId", orderId);
                orderser.updategiftcardPrice(map);
                order.setGiftcardPrice(new BigDecimal(0));
            }
            //更新支付订单剩余金额
            order.setOrderPrice(payTotalPrice);
            // 单笔订单 生成单笔的付款单信息
            getReceivables(p, request, order);

            if ("1".equals(p.getPayType()) || "9".equals(p.getPayType())) {
                AlipayConfig.partner = p.getApiKey();
                AlipayConfig.seller_id = p.getApiKey();

                // 支付类型
                String paymentType = "1";
                // 必填，不能修改
                // 服务器异步通知页面路径
                String notifyUrl = p.getPayComment()+"paysucccessybm.htm";
                // 需http://格式的完整路径，不能加?id=123这类自定义参数

                // 页面跳转同步通知页面路径
                String returnUrl = p.getPayComment()+"paysucccess.htm";
                // 需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

                // 商户订单号
                String outTradeNo = order.getOrderCode();
                // 商户网站订单系统中唯一订单号，必填

                // 订单名称
                String subject = order.getOrderGoodsList().get(0).getGoodsInfoName();
                // 必填
                payTotalPrice.doubleValue();
                DecimalFormat df=new DecimalFormat("0.00");
                // 付款金额
                String totalFee = df.format(payTotalPrice.doubleValue()).toString();
                // 必填

                // 商品展示地址
                String showUrl = p.getPayUrl();
                String userAgent = request.getHeader("user-agent");
                if(userAgent.indexOf("Android") != -1 || userAgent.indexOf("iPhone") != -1 || userAgent.indexOf("iPad") != -1) {
                    if (showUrl.indexOf("www") >= 0) {
                        showUrl = "http://m.ge960.com/customer/myorder-1-1.html";
                    } else {
                        showUrl = "http://testm.ge960.com/customer/myorder-1-1.html";
                    }
                }
                // 必填，需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html

                // 订单描述
                String body = "手机网购订单";
                // 选填

                // 超时时间
                String itBPay = "";
                // 选填

                // 钱包token
                String externToken = "";
                // 选填

                // ////////////////////////////////////////////////////////////////////////////////

                // 把请求参数打包成数组
                Map<String, String> sParaTemp = new HashMap<String, String>();
                sParaTemp.put("service", "alipay.wap.create.direct.pay.by.user");
                sParaTemp.put("partner", AlipayConfig.partner);
                sParaTemp.put("seller_id", AlipayConfig.seller_id);
                sParaTemp.put("_input_charset", AlipayConfig.input_charset);
                sParaTemp.put("payment_type", paymentType);
                sParaTemp.put("notify_url", notifyUrl);
                sParaTemp.put("return_url", returnUrl);
                sParaTemp.put(OUT_TRADE_NO, outTradeNo);
                sParaTemp.put("subject", subject);
                sParaTemp.put("total_fee", totalFee);
                sParaTemp.put("show_url", showUrl);
                sParaTemp.put("body", body);
                sParaTemp.put("it_b_pay", itBPay);
                sParaTemp.put("extern_token", externToken);

                // 建立请求
                String sHtmlText = AlipaySubmit.buildRequest(sParaTemp, "get", "确认");
                // 建立请求
                System.out.println(sHtmlText);
                mav.addObject("sHtmlText", sHtmlText);
                mav.setViewName("order/netbank");

            }
        }
        return seoService.getCurrSeo(mav);
    }

    /**
     * 确认付款(从订单列表页)
     *
     * @param request
     * @return ModelAndView
     */
    @RequestMapping("/orderlistpay")
    public ModelAndView orderlistpay(HttpServletRequest request,Long orderId) throws UnsupportedEncodingException {
        // 用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 是否登录
        if (customerId == null) {
            // 返回登录页
            return new ModelAndView(new RedirectView(LOGIN_HTML));
        }
        Order order = orderser.getPayOrder(orderId);
        String goodsName = orderser.queryGoodsInfoName(order.getOrderId());
        ModelAndView mav = new ModelAndView();
        // 查询使用的支付信息

        Pay p = null;
        Properties properties = PropertieUtil.readPropertiesFile(OrderMController.class.getClassLoader().getResourceAsStream("com/ningpai/web/config/alipay.properties"));
        if(order.getShippingProvince().contains("内蒙古")){
            AlipayConfig.private_key = properties.getProperty("PRIVATE_KEY1");
            p = payService.findByPayId(26L);
        }else{
            AlipayConfig.private_key = properties.getProperty("PRIVATE_KEY");
            p = payService.findByPayId(25L);
        }
        if (p != null) {
            // 单笔订单 生成单笔的付款单信息
            this.getReceivables(p, request, order);
            if ("1".equals(p.getPayType()) || "9".equals(p.getPayType())) {
                AlipayConfig.partner = p.getApiKey();
                AlipayConfig.seller_id = p.getApiKey();

                // 支付类型
                String paymentType = "1";
                // 必填，不能修改
                // 服务器异步通知页面路径
              String notifyUrl = p.getPayComment()+"paysucccessybm.htm";
                // 需http://格式的完整路径，不能加?id=123这类自定义参数

                // 页面跳转同步通知页面路径
               String returnUrl = p.getPayComment()+"paysucccess.htm";
                // 需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

                // 商户订单号
                String outTradeNo = order.getOrderCode();
                // 商户网站订单系统中唯一订单号，必填

                // 订单名称
                String subject = goodsName;
                // 必填
                DecimalFormat df=new DecimalFormat("0.00");
                // 付款金额
                String totalFee = order.getOrderPrice().toString();
                // 必填

                // 商品展示地址
                String showUrl = p.getPayUrl();
                String userAgent = request.getHeader("user-agent");
                if(userAgent.indexOf("Android") != -1 || userAgent.indexOf("iPhone") != -1 || userAgent.indexOf("iPad") != -1) {
                    if (showUrl.indexOf("www") >= 0) {
                        showUrl = "http://m.ge960.com/customer/myorder-1-1.html";
                    } else {
                        showUrl = "http://testm.ge960.com/customer/myorder-1-1.html";
                    }
                }
                // 必填，需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html

                // 订单描述
                String body = "手机网购订单";
                // 选填

                // 超时时间
                String itBPay = "";
                // 选填

                // 钱包token
                String externToken = "";
                // 选填

                // ////////////////////////////////////////////////////////////////////////////////

                // 把请求参数打包成数组
                Map<String, String> sParaTemp = new HashMap<>();
                sParaTemp.put("service", "alipay.wap.create.direct.pay.by.user");
                sParaTemp.put("partner", AlipayConfig.partner);
                sParaTemp.put("seller_id", AlipayConfig.seller_id);
                sParaTemp.put("_input_charset", AlipayConfig.input_charset);
                sParaTemp.put("payment_type", paymentType);
                sParaTemp.put("notify_url", notifyUrl);
                sParaTemp.put("return_url", returnUrl);
                sParaTemp.put(OUT_TRADE_NO, outTradeNo);
                sParaTemp.put("subject", subject);
                sParaTemp.put("total_fee", totalFee);
                sParaTemp.put("show_url", showUrl);
                sParaTemp.put("body", body);
                sParaTemp.put("it_b_pay", itBPay);
                sParaTemp.put("extern_token", externToken);

                // 建立请求
                String sHtmlText = AlipaySubmit.buildRequest(sParaTemp, "get", "确认");
                // 建立请求
                mav.addObject("sHtmlText", sHtmlText);
                mav.setViewName("order/netbank");

            } else {
                // 获取openid

                String ip = request.getRemoteAddr();
                // 订单信息
                mav.addObject(ORDER, order);
                // ip地址
                mav.addObject("ip", ip);
                // 订单id
                mav.addObject(ConstantUtil.ORDERID, order.getOrderId());
                // 商品名称
                mav.addObject("goodsInfoName", goodsName);
                // 订单价格
                mav.addObject("payPrice", order.getOrderPrice().toString().replace(".", ""));
                // 回调函数
                mav.addObject("callBackUrl", "http://shop.ningpai.com/mobile/wxpaysuc.htm");

                mav.setViewName("pay/pay");
            }
        }
        return seoService.getCurrSeo(mav);

    }

    /**
     * 调用微信支付订单
     * @param request
     * @param orderId 订单id
     * @param payId 支付方式id
     * @param response
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("getwxparam")
    @ResponseBody
    public Map<String, Object> getWXParam(HttpServletRequest request, Long orderId,Long payId,HttpServletResponse response,String mark) throws UnsupportedEncodingException {
        Map<String, Object> map = null;
        try {

            // 用户编号
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
            // 是否登录
            if (customerId == null || payId == null) {
                // 返回登录页
                return null;
            }
            Order order = siteOrderService.getPayOrder(orderId);
            // 判断订单 是否是当前用户的订单 是否为代付款订单
            if(!customerId.equals(order.getCustomerId()) || !("0").equals(order.getOrderStatus())){
                return null;
            }
            // 微信配置
            Pay pay = null;
            // 查询使用的支付信息
            if(order.getShippingProvince().contains("内蒙古")){
                pay = payService.findByPayId(36L);
            }else{
                pay = payService.findByPayId(37L);
            }

            // 支付的实际金额
            BigDecimal payTotalPrice = order.getOrderPrice();
            if(("1").equals(mark)) {
                DepositInfo deposit = depositInfoService.queryDepositInfo(customerId);
                //同时需要将订单使用的礼品卡金额同步到订单中
                Map<String, Object> map0 = new HashMap<String, Object>();
                map0.put("giftcardPrice", deposit.getPreDeposit());
                map0.put("orderId", orderId);
                orderser.updategiftcardPrice(map0);
                payTotalPrice = payTotalPrice.subtract(deposit.getPreDeposit()).setScale(2,BigDecimal.ROUND_HALF_UP);
                //礼品卡支付金额
                order.setGiftcardPrice(deposit.getPreDeposit());
            }else{
                Map<String, Object> map0 = new HashMap<String, Object>();
                map0.put("giftcardPrice", 0);
                map0.put("orderId", orderId);
                orderser.updategiftcardPrice(map0);
                order.setGiftcardPrice(new BigDecimal(0));
            }

            //更新支付订单剩余金额
            order.setOrderPrice(payTotalPrice);

            //微信支付信息
            map = siteOrderService.getWXUrl(request, response, order, pay, order.getOrderGoodsList().get(0).getGoodsInfoName());

            // 单笔订单 生成单笔的付款单信息
            getReceivables(pay, request, order);
            //订单编号
            map.put("orderId",order.getOrderId());

        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 支付宝回调通知 支付成功
     *
     * @param request
     * @param agr1
     * @return ModelAndView
     */
    @RequestMapping("/paysucccess")
    public ModelAndView paySuccess(HttpServletRequest request, HttpServletResponse agr1, HttpServletResponse response) {
        // 获取支付宝信息
        Pay p = payService.findByPayId(25L);

        // 设置商户号
        com.ningpai.common.util.alipay.config.AlipayConfig.partner = p.getApiKey();
        // 设置商户秘钥
        com.ningpai.common.util.alipay.config.AlipayConfig.key = p.getSecretKey();

        com.ningpai.common.util.alipay.config.AlipayConfig.seller_email = p.getPayAccount();
        // 获取支付宝POST过来反馈信息
        Map<String, String> params = new HashMap<String, String>();
        Map<?, ?> requestParams = request.getParameterMap();
        for (Iterator<?> iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            StringBuilder valueStr = new StringBuilder();
            for (int i = 0; i < values.length; i++) {
                if (i == values.length - 1) {
                    valueStr.append(values[i]);
                } else {
                    valueStr.append(values[i]);
                    valueStr.append(",");
                }
            }
            // 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
            // valueStr = new String(valueStr.getBytes(ISO_8859_1), "gbk");
            params.put(name, valueStr.toString());
        }

        // 订单号
        String orderCode = null;
        try {
            orderCode = new String(request.getParameter(OUT_TRADE_NO).getBytes(ISO_8859_1), UTF_8);
            // 支付宝交易号

        } catch (UnsupportedEncodingException e) {
            LOGGER.error("获取支付宝交易号错误：" + e);
        }

        // 计算得出通知验证结果
        boolean verifyResult = AlipayNotify.verify(params);
        // 重新将session登入
        Order or = siteOrderService.getPayOrderByCode(orderCode);
        if (verifyResult) {// 验证成功

            // 更新订单状态
            if ("0".equals(or.getOrderStatus())) {
                siteOrderService.payOrder(or.getOrderId());
            }
            if ("2".equals(or.getOrderMType())) {
                Customer customer = customerServiceMapper.queryCustomerInfo(or.getCustomerId());
                // 返回订单商品的商品名称，取第一个
                String goodsName = orderser.queryGoodsInfoName(or.getOrderId());
                // 微信发货通知
                Map<String, Object> paraMap = new HashMap<>();
                paraMap.put(ConstantUtil.OPENID, customer.getCustomerUsername());
                paraMap.put("orderNo", or.getOrderCode());
                paraMap.put("orderPrice", or.getOrderPrice());
                paraMap.put("goodsName", goodsName);
                paraMap.put(ConstantUtil.ORDERID, or.getOrderId());
                WXSendMSG.sendWxMsgForOrderPaySucc(paraMap, request, response);
            }
            if ("4".equals(or.getOrderCargoStatus())) {
                orderser.modifyOrderByKey(or.getOrderId(), "2");
            }

        }
        ModelAndView mav = new ModelAndView("order/pay_success_new");
        mav.addObject("orderId",or.getOrderId());
        mav.addObject("payPrice",or.getOrderPrice());

        return seoService.getCurrSeo(mav);

    }

    /**
     * 微信回调
     *
     * @param request
     * @throws IOException
     */
    @RequestMapping("/wxpaysuc")
    public void wxpaySuc(HttpServletRequest request, HttpServletResponse response) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream) request.getInputStream()));
        String line = null;
        StringBuilder sb = new StringBuilder();
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        // xml解析
        Document document;
        try {
            document = DocumentHelper.parseText(sb.toString());
            Element root = document.getRootElement();
            // 微信号
            String appId = "";
            // 订单号
            String outTradeNo = "";

            // 返回结果
            String resultCode = "";
            // 商户编号
            String mId = "";

            List<Element> elements = root.elements();
            for (Iterator<Element> it = elements.iterator(); it.hasNext();) {
                Element element = it.next();
                if ("appid".equals(element.getName())) {
                    appId = element.getText();
                } else if ("bank_type".equals(element.getName())) {
                    element.getText();
                } else if ("mch_id".equals(element.getName())) {
                    mId = element.getText();
                } else if ("result_code".equals(element.getName())) {
                    resultCode = element.getText();
                } else if (OUT_TRADE_NO.equals(element.getName())) {
                    outTradeNo = element.getText();
                    if(outTradeNo.indexOf("_")!=-1){
                        outTradeNo = outTradeNo.substring(0,outTradeNo.indexOf("_"));
                    }
                }

            }
            Order or = siteOrderService.getPayOrderByCode(outTradeNo);
            // 微信配置
            Pay pay = null;
            // 查询使用的支付信息
            if(or.getShippingProvince().contains("内蒙古")){
                pay = payService.findByPayId(36L);
            }else{
                pay = payService.findByPayId(37L);
            }
            if(or==null){
                    List<Order> orders= siteOrderService.queryOrderByOrderOldCode(outTradeNo);
                    if(!orders.isEmpty()&&orders.size()!=0){
                    for(int i=0;i<orders.size();i++){
                        if (CSUCCESS.equals(resultCode) && appId.equals(pay.getApiKey()) && mId.equals(pay.getPartner()) && "0".equals(orders.get(i).getOrderStatus())) {
                            // 判断商户号与财付通账号是否匹配
                            // 判断订单状态
                            siteOrderService.paySuccessUpdateOrder(orders.get(i).getOrderId(),"1",Long.valueOf(pay.getPayType()));

                            try {
                                //如果货品中包含电子礼品卡则支付成功后激动该笔订单相应的卡号
                                for(OrderGoods og:or.getOrderGoodsList()){
                                    if(og.getGoodsInfoName().indexOf("电子卡") != -1){
                                        GiftcardVo gc = new GiftcardVo();
                                        gc.setActiveFlag("1");
                                        gc.setActiveTime(new Date());
                                        gc.setOrderCode(or.getOrderCode());
                                        giftcardService.updateGiftcard(gc);
                                        System.out.println("-------"+or.getOrderCode());
                                        //支付成功后发送将电子礼品卡账户卡号密码发送发送到指定的电子邮箱
                                        List<Giftcard> giftcards = this.giftcardService.selectGiftcardByOrderCode(or.getOrderCode());
                                        sendEmailUtils.sendGiftCardEmails(request,or.getGiftcardEmail(),giftcards);
                                    }
                                }

                                //如果使用了礼品卡支付 需要更新礼品卡账户总金额
                                if(or.getGiftcardPrice() != null && or.getGiftcardPrice().compareTo(new BigDecimal(0)) > 0){
                                    //通过订单生成tradeInfo交易记录
                                    DepositInfo deposit = depositInfoService.queryDepositInfo(or.getCustomerId());
                                    depositInfoService.updateDepositInfo(deposit,or,or.getCustomerId());
                                }
                            }catch (Exception e){
                                e.printStackTrace();
                            }

                            //查询订单对应的收款单

                            addNotice(orders.get(i).getCustomerId(),orders.get(i),"您的订单已支付完毕","已支付完毕，我们将及时为您处理！");
                            // 修改收款单订单支付状态为支付成功
                            Receivables receivables = new Receivables();
                            receivables.setReceivablesTime(new Date());
                            receivables.setOrderCode(outTradeNo);
                            receivablesService.updatePayStatus(receivables);

                            //支付成功，更新订单到ERP
                            dstOrderService.synUpdateOrderToERP(orders.get(i).getOrderId());

                        }
                    }
                    sendSucess(response,CSUCCESS);
                }
            }else{
                // 判断返回结果
                if (CSUCCESS.equals(resultCode) && appId.equals(pay.getApiKey()) && mId.equals(pay.getPartner()) && "0".equals(or.getOrderStatus())) {
                    // 判断商户号与财付通账号是否匹配
                    // 判断订单状态
                    siteOrderService.paySuccessUpdateOrder(or.getOrderId(),"1",Long.valueOf(pay.getPayType()));
                    //synOrderService.SynOrder(or.getOrderId());
                    //查询订单对应的收款单

                    try {
                        //如果货品中包含电子礼品卡则支付成功后激动该笔订单相应的卡号
                        for(OrderGoods og:or.getOrderGoodsList()){
                            if(og.getGoodsInfoName().indexOf("电子卡") != -1){
                                GiftcardVo gc = new GiftcardVo();
                                gc.setActiveFlag("1");
                                gc.setActiveTime(new Date());
                                gc.setOrderCode(or.getOrderCode());
                                giftcardService.updateGiftcard(gc);

                                //支付成功后发送将电子礼品卡账户卡号密码发送发送到指定的电子邮箱
                                List<Giftcard> giftcards = this.giftcardService.selectGiftcardByOrderCode(or.getOrderCode());
                                sendEmailUtils.sendGiftCardEmails(request,or.getGiftcardEmail(),giftcards);
                            }
                        }

                        //如果使用了礼品卡支付 需要更新礼品卡账户总金额
                        if(or.getGiftcardPrice() != null && or.getGiftcardPrice().compareTo(new BigDecimal(0)) > 0){
                            //通过订单生成tradeInfo交易记录
                            DepositInfo deposit = depositInfoService.queryDepositInfo(or.getCustomerId());
                            depositInfoService.updateDepositInfo(deposit,or,or.getCustomerId());
                        }
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                    //支付成功，更新订单到ERP
                    dstOrderService.synUpdateOrderToERP(or.getOrderId());

                    addNotice(or.getCustomerId(),or,"您的订单已支付完毕","已支付完毕，我们将及时为您处理！");
                    // 修改收款单订单支付状态为支付成功
                    Receivables receivables = new Receivables();
                    receivables.setReceivablesTime(new Date());
                    receivables.setOrderCode(outTradeNo);
                    receivablesService.updatePayStatus(receivables);

                    sendSucess(response, CSUCCESS);
                }
            }

        } catch (DocumentException e1) {
            LOGGER.error("微信支付错误：" + e1);
            sendSucess(response, "FAIL");
        }
    }

    /**
     * 成功回调
     * */
    public void sendSucess(HttpServletResponse response, String msg) throws IOException {
        PrintWriter out = response.getWriter();
        out.println(msg);
        out.flush();
        out.close();
    }

    /**
     * 支付成功
     *
     * @param request
     * @param agr1
     * @return ModelAndView
     */
    @RequestMapping("/paysucccesswx")
    public ModelAndView paySuccessWx(HttpServletRequest request, HttpServletResponse agr1, Long orderId,BigDecimal payPrice) {
        // 重新将session登入
        ModelAndView mav = new ModelAndView("order/pay_success_new");
        mav.addObject("orderId",orderId);
        mav.addObject("payPrice",payPrice);
        return seoService.getCurrSeo(mav);

    }

    /**
     * 根据商品id查询购买过该商品的记录
     *
     * @return
     */
    @RequestMapping("/addcartsuc")
    public ModelAndView addCartSuc(Long goodsInfoId) {
        List<GoodsProductVo> goodsProductVos = orderser.queryGoodsProductVoByOrderGoods(goodsInfoId);
        return seoService.getCurrSeo(new ModelAndView(ShoppingCartConstants.ADDCART).addObject("list", goodsProductVos));
    }

    /**
     * 支付宝回调
     *
     * @param request
     * @param response
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("/paysucccessybm")
    public void paySuccessyb(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);

        // 获取支付宝POST过来反馈信息
        Map<String, String> params = new HashMap<String, String>();
        Map<?, ?> requestParams = request.getParameterMap();
        for (Iterator<?> iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            StringBuilder valueStr = new StringBuilder();
            for (int i = 0; i < values.length; i++) {
                if (i == values.length - 1) {
                    valueStr.append(values[i]);
                } else {
                    valueStr.append(values[i]);
                    valueStr.append(",");
                }
            }
            // 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
            // valueStr = new String(valueStr.getBytes(ISO_8859_1), "gbk");
            params.put(name, valueStr.toString());
        }

        // 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
        String outTradeNo = new String(request.getParameter(OUT_TRADE_NO).getBytes(ISO_8859_1), UTF_8);

        // 交易状态
        String tradeStatus = new String(request.getParameter("trade_status").getBytes(ISO_8859_1), UTF_8);
        // RSA签名解密
        // 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

        Order or = siteOrderService.getPayOrderByCode(outTradeNo);

        // 获取支付宝信息
        Pay p = null;
        if(or.getShippingProvince().contains("内蒙古")){
            p = payService.findByPayId(26L);
        }else{
            p = payService.findByPayId(25L);
        }
        // 设置商户号
        com.ningpai.common.util.alipay.config.AlipayConfig.partner = p.getApiKey();
        // 设置商户秘钥
        com.ningpai.common.util.alipay.config.AlipayConfig.key = p.getSecretKey();
        com.ningpai.common.util.alipay.config.AlipayConfig.seller_email = p.getPayAccount();

        if (AlipayNotify.verify(params)) {// 验证成功
            // ////////////////////////////////////////////////////////////////////////////////////////
            // 请在这里加上商户的业务逻辑程序代码

            // ——请根据您的业务逻辑来编写程序（以下代码仅作参考）——

            if ("TRADE_FINISHED".equals(tradeStatus)) {
                // 判断该笔订单是否在商户网站中已经做过处理
                // 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                // 如果有做过处理，不执行商户的业务程序

                if (or == null){
                    List<Order> orders= siteOrderService.queryOrderByOrderOldCode(outTradeNo);
                    for (int i = 0; i<orders.size(); i++){
                        //查询订单对应的收款单
                        Receivables receivables = this.receivablesService.queryByOrderCode(orders.get(i).getOrderCode());
                        if ("0".equals(orders.get(i).getOrderStatus())) {
                            // 更新订单状态
                            siteOrderService.payOrder(orders.get(i).getOrderId());
                            if (null != receivables) {
                                // 修改收款单订单支付状态为支付成功
                                receivables.setReceivablesTime(new Date());
                                this.receivablesService.updatePayStatus(receivables);
                                //支付成功直营店订单短信通知
                                siteOrderService.paySuccessSendSms(orders.get(i));
                                addNotice(orders.get(i).getCustomerId(), orders.get(i),"您的订单已支付完毕","已支付完毕，我们将及时为您处理！");
                                // 同步E店宝
                                //synOrderService.SynOrder(orders.get(i).getOrderId());
                            }
                        }
                    }
                }else{
                    //查询订单对应的收款单
                    Receivables receivables = this.receivablesService.queryByOrderCode(or.getOrderCode());
                    if ("0".equals(or.getOrderStatus())) {
                        // 更新订单状态
                        siteOrderService.paySuccessUpdateOrder(or.getOrderId(),"1",Long.valueOf(p.getPayType()));
                        if (null != receivables) {
                            // 修改收款单订单支付状态为支付成功
                            receivables.setReceivablesTime(new Date());
                            this.receivablesService.updatePayStatus(receivables);
                            //支付成功直营店订单短信通知
                            siteOrderService.paySuccessSendSms(or);
                            addNotice(or.getCustomerId(), or,"您的订单已支付完毕","已支付完毕，我们将及时为您处理！");
                            // 同步E店宝
                            //synOrderService.SynOrder(or.getOrderId());
                        }
                    }
                }
                // System.out.println(SUCCESS); // 请不要修改或删除
                // 注意：
                // 退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
            } else if ("TRADE_SUCCESS".equals(tradeStatus)) {
                // 判断该笔订单是否在商户网站中已经做过处理
                // 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                // 如果有做过处理，不执行商户的业务程序
                if (or == null){
                    List<Order> orders= siteOrderService.queryOrderByOrderOldCode(outTradeNo);
                    for (int i = 0; i<orders.size(); i++){
                        //查询订单对应的收款单
                        //Receivables receivables = this.receivablesService.queryByOrderCode(orders.get(i).getOrderCode());
                        if ("0".equals(orders.get(i).getOrderStatus())) {

                            // 更新订单状态
                            siteOrderService.paySuccessUpdateOrder(orders.get(i).getOrderId(),"1",Long.valueOf(p.getPayType()));

                            // 修改收款单订单支付状态为支付成功
                            Receivables receivables = new Receivables();
                            receivables.setReceivablesTime(new Date());
                            receivables.setOrderCode(outTradeNo);
                            receivablesService.updatePayStatus(receivables);
                            //支付成功直营店订单短信通知
                            siteOrderService.paySuccessSendSms(orders.get(i));
                            addNotice(orders.get(i).getCustomerId(), orders.get(i),"您的订单已支付完毕","已支付完毕，我们将及时为您处理！");
                            // 同步E店宝
                            //synOrderService.SynOrder(orders.get(i).getOrderId());

                            //如果货品中包含电子礼品卡则支付成功后激动该笔订单相应的卡号
                            for(OrderGoods og:or.getOrderGoodsList()){
                                if(og.getGoodsInfoName().indexOf("电子卡") != -1){
                                    GiftcardVo gc = new GiftcardVo();
                                    gc.setActiveFlag("1");
                                    gc.setActiveTime(new Date());
                                    gc.setOrderCode(or.getOrderCode());
                                    giftcardService.updateGiftcard(gc);

                                    //支付成功后发送将电子礼品卡账户卡号密码发送发送到指定的电子邮箱
                                    List<Giftcard> giftcards = this.giftcardService.selectGiftcardByOrderCode(or.getOrderCode());
                                    sendEmailUtils.sendGiftCardEmails(request,or.getGiftcardEmail(),giftcards);
                                }
                            }

                            //如果使用了礼品卡支付 需要更新礼品卡账户总金额
                            if(or.getGiftcardPrice() != null && or.getGiftcardPrice().compareTo(new BigDecimal(0)) > 0){
                                //通过订单生成tradeInfo交易记录
                                DepositInfo deposit = depositInfoService.queryDepositInfo(or.getCustomerId());
                                depositInfoService.updateDepositInfo(deposit,or,or.getCustomerId());
                            }

                        }
                    }
                }else{
                    //查询订单对应的收款单
                    //Receivables receivables = this.receivablesService.queryByOrderCode(or.getOrderCode());
                    if ("0".equals(or.getOrderStatus())) {

                        // 更新订单状态
                        siteOrderService.paySuccessUpdateOrder(or.getOrderId(),"1",Long.valueOf(p.getPayType()));

                        Receivables receivables = new Receivables();
                        receivables.setReceivablesTime(new Date());
                        receivables.setOrderCode(outTradeNo);
                        receivablesService.updatePayStatus(receivables);
                        //支付成功直营店订单短信通知
                        siteOrderService.paySuccessSendSms(or);
                        addNotice(or.getCustomerId(), or,"您的订单已支付完毕","已支付完毕，我们将及时为您处理！");
                        // 同步E店宝
                        //synOrderService.SynOrder(or.getOrderId());

                        //如果货品中包含电子礼品卡则支付成功后激动该笔订单相应的卡号
                        for(OrderGoods og:or.getOrderGoodsList()){
                            if(og.getGoodsInfoName().indexOf("电子卡") != -1){
                                GiftcardVo gc = new GiftcardVo();
                                gc.setActiveFlag("1");
                                gc.setActiveTime(new Date());
                                gc.setOrderCode(or.getOrderCode());
                                giftcardService.updateGiftcard(gc);

                                //支付成功后发送将电子礼品卡账户卡号密码发送发送到指定的电子邮箱
                                List<Giftcard> giftcards = this.giftcardService.selectGiftcardByOrderCode(or.getOrderCode());
                                sendEmailUtils.sendGiftCardEmails(request,or.getGiftcardEmail(),giftcards);
                            }
                        }

                        //如果使用了礼品卡支付 需要更新礼品卡账户总金额
                        try {
                            if(or.getGiftcardPrice() != null && or.getGiftcardPrice().compareTo(new BigDecimal(0)) > 0){
                                //通过订单生成tradeInfo交易记录
                                DepositInfo deposit = depositInfoService.queryDepositInfo(or.getCustomerId());
                                depositInfoService.updateDepositInfo(deposit,or,or.getCustomerId());
                            }
                        }catch (Exception e){
                            e.printStackTrace();
                        }
                    }
                }

                sendSucess(response, SUCCESS);
                // 注意：
                // 付款完成后，支付宝系统发送该交易状态通知
            }

            // ——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

            // System.out.println(SUCCESS); // 请不要修改或删除

            // ////////////////////////////////////////////////////////////////////////////////////////
        } else {// 验证失败
            System.out.println("fail");
        }

    }

    /**
     * 查询所有的支付方式
     *
     * @return 查询到的支付方式的列表
     */
    @RequestMapping("/queryAllPaySet")
    @ResponseBody
    public List<Object> queryAllPaySet() {
        return this.payService.queryAllPaySet();
    }

    public PayService getPayService() {
        return payService;
    }

    /**
     * 获取微信参数
     *
     * @param orderId
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("getmwxparam")
    @ResponseBody
    public Map<String, Object> getWXParam(Long orderId, HttpServletRequest request, HttpServletResponse response) {

        // 订单
        Order order = orderser.getPayOrder(orderId);

        // 微信配置
        Pay pay = null;
        // 查询使用的支付信息
        if(order.getShippingProvince().contains("内蒙古")){
            pay = payService.findByPayId(36L);
        }else{
            pay = payService.findByPayId(37L);
        }

        // 单笔订单 生成单笔的付款单信息
        this.getReceivables(pay, request, order);
        // 商品名称
        String goodsName = orderser.queryGoodsInfoName(orderId);
        return siteOrderService.getWXUrl(request, response, order, pay, goodsName);
    }

    /**
     * 根据支付的订单的数量 来设置订单的属性
     *
     * @param order
     *            订单对象
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
            // 给付款单信息设置是否支付成功 1失败  0成功
            receivables.setPayStatus("1");
            receivablesService.addReceivables(receivables);
        }
        /* 添加收款单信息 */
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
        // 给付款单信息设置是否支付成功 1失败  0成功
        receivables.setPayStatus("1");
        receivablesService.addReceivables(receivables);
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
    @Resource(name = "payService")
    public void setPayService(PayService payService) {
        this.payService = payService;
    }

    public ExpressConfBizImpl getExpressConfBizImpl() {
        return expressConfBizImpl;
    }

    @Resource(name = "expressConfBizImpl")
    public void setExpressConfBizImpl(ExpressConfBizImpl expressConfBizImpl) {
        this.expressConfBizImpl = expressConfBizImpl;
    }

    public ShoppingCartService getShoppingCartService() {
        return shoppingCartService;
    }

    @Resource(name = "ShoppingCartService")
    public void setShoppingCartService(ShoppingCartService shoppingCartService) {
        this.shoppingCartService = shoppingCartService;
    }

    public OrderMService getSiteOrderService() {
        return siteOrderService;
    }

    @Resource(name = "OrderMService")
    public void setSiteOrderService(OrderMService siteOrderService) {
        this.siteOrderService = siteOrderService;
    }

    public MarketingService getMarketingService() {
        return marketingService;
    }

    @Resource(name = "MarketingService")
    public void setMarketingService(MarketingService marketingService) {
        this.marketingService = marketingService;
    }

    public OrderService getOrderser() {
        return orderser;
    }

    @Resource(name = "OrderService")
    public void setOrderser(OrderService orderser) {
        this.orderser = orderser;
    }

    public GoodsProductService getGoodsProductService() {
        return goodsProductService;
    }

    @Resource(name = "GoodsProductService")
    public void setGoodsProductService(GoodsProductService goodsProductService) {
        this.goodsProductService = goodsProductService;
    }

    /**
     * 订单的跳转页面到自提点列表
     * @param request
     * @return
     */
    @RequestMapping("/deliverylist")
    public ModelAndView deliveryList(HttpServletRequest request) {
        //页面传过来的选中的一个自提点
        String dpId = request.getParameter("dpId");
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        CustomerAddress customerAddress = null;
        if (customerId != null) {
            customerAddress = addressService.queryDefaultAddr(customerId);
        }
        if (null == customerAddress) {
            customerAddress = addressService.selectByCIdFirst(customerId);
        }
        Map<String,Object> deliveryMap = new HashMap<>();
        if(customerAddress != null&&customerAddress.getCity() != null){
            List<DeliveryPoint> deliveries = deliveryPointService.selectByCityId(customerAddress.getCity().getCityId());
            deliveryMap.put("deliveries",deliveries);
        }
        ModelAndView mav = new ModelAndView("order/deliverylist");
        mav.addObject("deliveryMap",deliveryMap);
        mav.addObject("dpId",dpId);
        return seoService.getCurrSeo(mav);
    }


    /**
     * 检查礼品卡账户是否可用
     * @param request
     * @param orderId 订单id
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/depositpay")
    @ResponseBody
    public JSONObject depositPay(HttpServletRequest request, Long orderId) throws UnsupportedEncodingException {

        // 用户编号
        Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
        // 是否登录
        if (customerId == null || orderId == null) {
            // 返回登录页
            return null;
        }
        //获取支付密码
        Order order = orderService.orderDetail(orderId);
        if(order == null || !customerId.equals(order.getCustomerId())){
            // 返回购物车
            return null;
        }
        JSONObject depositInfo = null;
        try {
            depositInfo = depositInfoService.checkDepositPay(customerId,order.getOrderPrice(),"0");
        }catch (Exception e){
            e.printStackTrace();
        }

        return depositInfo;
    }

    /**
     * 订单列表页-预存款支付
     * @param request
     * @param payPassword
     * @param orderId
     * @return
     */
    @RequestMapping("/depositpayorder")
    @ResponseBody
    public JSONObject depositPayOrder(HttpServletRequest request, String payPassword, Long orderId){
        try {
            if (LoginUtil.checkLoginStatus(request)) {
                Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);

                Order order = orderser.queryOrderByCustomerIdAndOrderId(customerId,orderId);
                order.setPayId(5L);
                // 预存款配置
                Pay pay = payService.selectPayByType("5");
                JSONObject resultJson= depositInfoService.depositPay(order, customerId, payPassword);
                if("success".equals(resultJson.getString("return_code"))){
                    // 单笔订单 生成单笔的付款单信息
                    this.receivablesService.deleteByCode(order.getOrderCode());
                    /* 添加收款单信息 */
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
                    receivables.setPayAccount(pay.getPayAccount());
                    // 给收款单信息设置IP地址
                    // receivables.setPayIp(InetAddress.getLocalHost().getHostAddress());
                    // 设置生成时间
                    receivables.setPayTime(new Date());
                    // 设置付款时间
                    receivables.setReceivablesTime(new Date());
                    // 给收款单信息设置支付方式
                    receivables.setPayMode(pay.getPayName());
                    // 设置支付类型
                    receivables.setPayType("在线支付");
                    // 给收款单信息设置付款金额
                    receivables.setPayMoney(order.getOrderPrice());
                    receivables.setOrderCode(order.getOrderCode());
                    // 给付款单信息设置是否支付成功 1失败  0成功
                    receivables.setPayStatus("1");
                    receivablesService.addReceivables(receivables);

                    Map<String, Object> map = new HashMap<String, Object>();
                    //同时需要将订单使用的礼品卡金额同步到订单中
                    map.put("giftcardPrice", order.getOrderPrice());
                    map.put("orderId", orderId);
                    orderser.updategiftcardPrice(map);

                    addNotice(customerId,order,"您的订单已支付完毕","已支付完毕，我们将及时为您处理！");
                    //支付成功，更新订单到ERP
                    dstOrderService.synUpdateOrderToERP(orderId);

                }
                return resultJson;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 查询支付方式
     * @param request
     * @return
     */
    @RequestMapping("/querypayments")
    @ResponseBody
    public List<Object> queryPayments(HttpServletRequest request){
        if (LoginUtil.checkLoginStatus(request)) {
            // 运费模板
            //支付方式
            return payService.queryAllPaySet();
        }
        return null;
    }

    public void addNotice(Long customerId,Order orderT,String title,String content){
        OrderNotice record = new OrderNotice();
        int count = 0;
        List<OrderGoods> orderGoodsList = this.orderGoodsMapper.selectOrderGoodsList(orderT.getOrderId());
        record.setCustomerId(customerId);
        record.setOrderId(orderT.getOrderId());
        record.setNoticeTitle(title);
        if(orderGoodsList!=null &&orderGoodsList.size()>1){
            for(OrderGoods orderGoods:orderGoodsList){
                count+=orderGoods.getGoodsInfoNum();
            }
            record.setNoticeContent("您所购买的  "+orderGoodsList.get(0).getGoodsInfoName().substring(0,9)+"...  等"+count+"件商品"+content);
        }else{
            record.setNoticeContent("您所购买的  "+orderGoodsList.get(0).getGoodsInfoName().substring(0,9)+"...  "+content);
        }
        //record.setNoticeContent("您的订单 "+orderT.getOrderCode()+" 已经提交成功，我们将及时为您处理。");
        record.setIsRead("0");
        orderNoticeService.addNotice(record);
    }

    /**
     * 验证支付密码
     * @param request
     * @param payPrice
     * @return
     */
    @RequestMapping("/checkPayPassword")
    @ResponseBody
    public JSONObject checkPayPassword(HttpServletRequest request, BigDecimal payPrice, String payPassword) {
        JSONObject resultJson = new JSONObject();
        if (LoginUtil.checkLoginStatus(request)) {
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstantStr.CUSTOMERID);
            //支付密码验证
            resultJson = depositInfoService.checkPayPassword(payPassword, customerId,"0", payPrice);
        }
        return resultJson;
    }

}
