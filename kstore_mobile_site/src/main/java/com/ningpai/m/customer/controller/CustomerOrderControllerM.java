/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.m.customer.controller;

import com.ningpai.comment.bean.Comment;
import com.ningpai.comment.bean.Share;
import com.ningpai.comment.service.CommentServiceMapper;
import com.ningpai.community.bean.CommunityStore;
import com.ningpai.community.service.CommunityStoreService;
import com.ningpai.customer.bean.CustomerAddress;
import com.ningpai.m.backorder.service.ReturnGoodsService;
import com.ningpai.m.common.service.SeoService;
import com.ningpai.m.customer.service.CustomerAddressService;
import com.ningpai.m.customer.service.CustomerOrderService;
import com.ningpai.m.customer.service.OrderNoticeService;
import com.ningpai.m.customer.vo.CustomerAllInfo;
import com.ningpai.m.customer.vo.CustomerConstants;
import com.ningpai.m.customer.vo.OrderInfoBean;
import com.ningpai.m.order.service.OrderMService;
import com.ningpai.m.util.LoginUtil;
import com.ningpai.marketing.dao.RushCustomerMapper;
import com.ningpai.order.bean.Order;
import com.ningpai.m.customer.bean.OrderNotice;
import com.ningpai.order.bean.OrderGoods;
import com.ningpai.order.dao.OrderGoodsMapper;
import com.ningpai.order.dao.OrderMapper;
import com.ningpai.order.service.OrderCouponService;
import com.ningpai.order.service.SynOrderService;
import com.ningpai.other.util.CustomerConstantStr;
import com.ningpai.system.bean.DeliveryPoint;
import com.ningpai.system.bean.SystemsSet;
import com.ningpai.system.service.DeliveryPointService;
import com.ningpai.system.service.IsBackOrderService;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;
import com.ningpai.util.UploadUtil;
import com.ningpai.util.uploadimg.UploadImgJava;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.*;
import java.util.regex.Pattern;

/**
 * 手机端会员订单控制器
 *
 * @author qiyuanyuan
 *
 */
@Controller
public class CustomerOrderControllerM {
    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(CustomerOrderControllerM.class);

    private static  final String PARAMSTRING="paramString";
    // spring注解 会员订单service
    @Resource(name = "customerOrderServiceM")
    private CustomerOrderService customerOrderService;

    @Resource(name = "commentServiceMapper")
    private CommentServiceMapper commentServiceMapper;

    @Resource(name = "OrderCouponService")
    private OrderCouponService orderCouponService;

    @Resource(name="MReturnGoodsService")
    private ReturnGoodsService returnGoodsService;

    @Resource(name = "SeoService")
    private SeoService seoService;

    @Resource(name="IsBackOrderService")
    private IsBackOrderService isbackOrderService;

    @Resource(name="OrderMService")
    private OrderMService orderMService;

    @Resource(name = "OrderMapper")
    private OrderMapper orderMapper;

    @Resource(name = "OrderGoodsMapper")
    private OrderGoodsMapper orderGoodsMapper;

    @Resource(name = "SynOrderService")
    private SynOrderService synOrderService;

    @Resource(name = "RushCustomerMapper")
    private RushCustomerMapper rushCustomerMapper;

    @Resource(name = "customerAddressServiceM")
    private CustomerAddressService addressService;

    @Resource(name = "DeliveryPointService")
    private DeliveryPointService deliveryPointService;


    @Resource(name = "CommunityStoreService")
    private CommunityStoreService communityStoreService;

    /** Java上传工具类 */
    @Resource(name = "UploadImgJava")
    private  UploadImgJava uploadImgJava;

    /**
     * 跳转我的订单页面
     *
     * @param request
     * @return ModelAndview
     */
    @RequestMapping("/myorder")
    public ModelAndView queryAllOrders(HttpServletRequest request, PageBean pb, String date, String type, String paramString) {
        Map<String, Object> paramMap = null;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        ModelAndView mav = null;
        Long customerId = null;
        try {
            // 检查用户是否登录
            type = type==null?"0":type;
            if (LoginUtil.checkLoginStatus(request)) {
                paramMap = new HashMap<String, Object>();
                customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
                paramMap.put(CustomerConstants.CUSTOMERID, customerId);
                paramMap.put(CustomerConstants.DATE, date);
                paramMap.put(CustomerConstants.TYPE, type);
                paramMap.put(PARAMSTRING, paramString);
                pb.setUrl("/customer/myorder");
                resultMap.put(CustomerConstants.TYPE, type);
                resultMap.put(PARAMSTRING, paramString);
                resultMap.put(CustomerConstants.DATE, date);
                // 获取退款说明
                SystemsSet systemsSet = isbackOrderService.getIsBackOrder();
                // 是否允许退单
                resultMap.put("isBackOrder", systemsSet.getIsBackOrder());
                if(type != null && "6".equals(type)){
                    resultMap.put(CustomerConstants.PB, returnGoodsService.queryAllBackOrders(paramMap, pb));
                    mav = new ModelAndView(CustomerConstants.BACKORDER).addAllObjects(resultMap);
                }else {
                    resultMap.put(CustomerConstants.PB, customerOrderService.queryAllMyOrders(paramMap, pb));
                    mav = new ModelAndView(CustomerConstants.MYORDER).addAllObjects(resultMap);
                }
            } else {
                // 没登录的用户跳转到登录页面
                mav = new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
                mav.addObject("url","/customer/myorder.html");
            }
            return seoService.getCurrSeo(mav);
        } finally {
            mav = null;
            paramMap = null;
        }
    }


    /**
     * 跳转我的订单页面
     *
     * @param request
     * @return ModelAndview
     */
    @RequestMapping("/allmyorder")
    @ResponseBody
    public Map<String, Object> queryAllMyOrders(HttpServletRequest request, PageBean pb, String date, String type, String paramString) {
        Map<String, Object> paramMap = null;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        // 检查用户是否登录
        if (LoginUtil.checkLoginStatus(request)) {
            paramMap = new HashMap<String, Object>();
            Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
            paramMap.put(CustomerConstants.CUSTOMERID, customerId);
            paramMap.put(CustomerConstants.DATE, date);
            paramMap.put(CustomerConstants.TYPE, type);
            paramMap.put(PARAMSTRING, paramString);
            // 获取退款说明
            SystemsSet systemsSet = isbackOrderService.getIsBackOrder();
            // 是否允许退单
            resultMap.put("isBackOrder", systemsSet.getIsBackOrder());
            resultMap.put(CustomerConstants.TYPE, type);
            if(type != null && "6".equals(type)){
                resultMap.put(CustomerConstants.PB, returnGoodsService.queryAllBackOrders(paramMap, pb));
             }else{
               resultMap.put(CustomerConstants.PB, customerOrderService.queryAllMyOrders(paramMap, pb));
             }
        }
        return resultMap;
    }


    /**
     * 根据订单编号查询订单信息
     *
     * @param orderId
     *            订单编号
     * @return ModelAndView
     */
    @RequestMapping("/orderdetails")
    public ModelAndView queryOrderByOrderId(HttpServletRequest request, Long orderId) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        ModelAndView mav = null;
        try {
            if (LoginUtil.checkLoginStatus(request)) {
                Long customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
                OrderInfoBean orderInfoBean = (OrderInfoBean)customerOrderService.queryOrderByCustIdAndOrderId(orderId, customerId);

                CommunityStore communityStore = communityStoreService.selectVo(orderInfoBean.getCommunityStoreId());
                resultMap.put("order", orderInfoBean);
                resultMap.put("communityStore", communityStore);
                // 获取退款说明
                SystemsSet systemsSet = isbackOrderService.getIsBackOrder();
                // 是否允许退单
                resultMap.put("isBackOrder", systemsSet.getIsBackOrder());
                Long expressType = orderInfoBean.getOrderExpressType();
                if(1L==expressType){//自提,查用户收货地址和自提地址，否则的话，orderInfoBean里面的信息就是收货地址
                    DeliveryPoint deliveryPoint = deliveryPointService.getDeliveryPoint(orderInfoBean.getAddressId());
                    resultMap.put("deliveryPoint",deliveryPoint);
                    CustomerAddress customerAddress = null;
                    if (customerId != null) {
                        customerAddress = addressService.queryDefaultAddr(customerId);
                    }
                    if (null == customerAddress) {
                        customerAddress = addressService.selectByCIdFirst(customerId);
                    }
                    resultMap.put("shippingAddress",customerAddress);
                }
                mav = new ModelAndView(CustomerConstants.ORDERDETAIL).addAllObjects(resultMap);
            } else {
                mav = new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
            }
            return seoService.getCurrSeo(mav);
        } finally {
            mav = null;
            resultMap = null;
        }
    }


    /**
     * 跳转会员中心--评论页
     *
     * @param orderId
     *         订单id
     * @return mav
     */
    @RequestMapping("/tocomment")
    public ModelAndView toShare(HttpServletRequest request, Long orderId) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        ModelAndView mav = null;
        Long customerId = null;
        try {
            if (LoginUtil.checkLoginStatus(request)) {
                customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
                resultMap.put("order", customerOrderService.queryOrderByCustIdAndOrderId(orderId, customerId));

                mav = new ModelAndView("/customer/order_comment_list").addAllObjects(resultMap);
            } else {
                mav = new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
            }
            return seoService.getCurrSeo(mav);
        } finally {
            mav = null;
            resultMap = null;
        }
    }

    /**
     * 待评价商品详情页
     * @param goodsId
     *             货品id
     * @param orderId
     *              订单id
     * @return mav
     */
    @RequestMapping("/commentgoods")
    public ModelAndView commentGoods(HttpServletRequest request,Long goodsId,Long orderId,Long commentId){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        ModelAndView mav = null;
        Long customerId = null;
        try {
            if (LoginUtil.checkLoginStatus(request)) {
                customerId = (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID);
                resultMap.put("good", customerOrderService.selectByOrderIdAndGoodsId(customerId, goodsId, orderId,commentId));
                resultMap.put("cusId",customerId);
                mav = new ModelAndView("/customer/order_comment").addAllObjects(resultMap);
            } else {
                mav = new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
            }
            return seoService.getCurrSeo(mav);
        } finally {
            mav = null;
            resultMap = null;
        }
    }


    /**
     * 商品评论
     *
     * @param request
     * @return {@link ModelAndView}
     */
    @RequestMapping("/comment")
    public ModelAndView toViewComment(HttpServletRequest request, PageBean pageBean) {
        pageBean.setUrl("customer/comment");
        ModelAndView mav = null;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            resultMap.put(CustomerConstants.PB, commentServiceMapper.queryCustComment((Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID), pageBean));
            if (LoginUtil.checkLoginStatus(request)) {
                mav = new ModelAndView(CustomerConstants.COMMENT);
                mav.addAllObjects(resultMap);
            } else {
                mav = new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
            }
            return seoService.getCurrSeo(mav);
        } finally {
            resultMap = null;
        }
    }

    /**
     * 添加商品评论
     *
     * @param request
     *              请求
     * @param comment
     *              评论对象
     * @return int
     */
    @RequestMapping("/addgoodscomment")
    @ResponseBody
    public int addGoodsComment(HttpServletRequest request, @Valid Comment comment, Long orderId) {
       //初始化f值
        int f =0;
        //判断是否登陆
        if (LoginUtil.checkLoginStatus(request)) {
            //执行添加评论操作
            f =customerOrderService.addGoodsComment(request, comment, orderId);
        }
        //返回f
        return f;
    }

    /**
     * 取消订单
     *
     * @param request
     * @param pb
     *            页面数据
     * @param orderId
     *            订单编号
     * @return ModelAndView
     */
    @RequestMapping("/cancelorder")
    public ModelAndView cancelOrder(HttpServletRequest request, PageBean pb, Long orderId, String reason,String flag) {
        ModelAndView mav = null;
        int count=0;
        if(reason != null && !"".equals(reason)){
            if (!Pattern.compile("[^\\<\\>]+$").matcher(reason).find()) {
                throw new IllegalArgumentException();
            }
        }
        try {
            // 检查用户是否登录
            if (LoginUtil.checkLoginStatus(request)) {
                customerOrderService.cancelOrder(orderId, reason);
                //取消与订单绑定的要赠送的优惠券
                orderCouponService.cancelOrderCoupon(orderId);
                orderCouponService.modifyCouponStatusNew(orderId);
                //删除抢购的订单选中数量
                rushCustomerMapper.updateRushcustomerByOrderId(orderId);
                // 同步订单到Ｅ点宝
                synOrderService.SynOrder(orderId);
                //订单通知
                Order order=this.orderMapper.querySimpleOrder(orderId);
                List<OrderGoods> orderGoodsList = this.orderGoodsMapper.selectOrderGoodsList(orderId);
                OrderNotice record = new OrderNotice();
                record.setCustomerId((Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID));
                record.setOrderId(order.getOrderId());
                record.setNoticeTitle("您的订单已取消成功");
                if(orderGoodsList!=null &&orderGoodsList.size()>1){
                    for(OrderGoods orderGoods:orderGoodsList){
                        count+=orderGoods.getGoodsInfoNum();
                    }
                    record.setNoticeContent("您所购买的  "+orderGoodsList.get(0).getGoodsInfoName().substring(0,9)+"...  等"+count+"件商品订单已取消成功！");
                }else{
                    record.setNoticeContent("您所购买的  "+orderGoodsList.get(0).getGoodsInfoName().substring(0,9)+"...  订单已取消成功！");
                }
                //record.setNoticeContent("您的订单 " + order.getOrderCode() + " 已经取消成功，欢迎再次购买。");
                record.setIsRead("0");
                this.orderNoticeService.addNotice(record);
                // 控制跳转
                if("1".equals(flag)){//订单详情页
                    mav = new ModelAndView("redirect:/customer/detail-"+orderId+".html");
                }else{
                    mav = new ModelAndView("redirect:/customer/myorder.html");
                }
            } else {
                // 没登录的用户跳转到登录页面
                mav = new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
            }
            // 跳转订单页面
            return seoService.getCurrSeo(mav);
        } catch(Exception e){
            e.printStackTrace();
            mav=null;
            return seoService.getCurrSeo(mav);
        }finally {
            mav = null;
        }
    }
    @Resource(name="orderNoticeServiceM")
    private OrderNoticeService orderNoticeService;
    /**
     * 确认订单
     *
     * @param request
     * @param pb
     *            页面数据
     * @param orderId
     *            订单编号
     * @return ModelAndView
     */
    @RequestMapping("/comfirmofgooods")
    public ModelAndView comfirmofGoods(HttpServletRequest request, PageBean pb, Long orderId,String flag) {
        ModelAndView mav = null;
        int count=0;
        try {
            // 检查用户是否登录
            if (LoginUtil.checkLoginStatus(request)) {
                Order order = orderMService.getPayOrder(orderId);
                //订单选择货到付款，确认收货时 加上payTime（后台首页统计，货到付款的也应该算）
                if(order != null && order.getPayTime()==null){
                    // 支付时间
                    order.setPayTime(new Date());
                }
                order.setGetGoodsTime(new Date());
                order.setOrderStatus("3");
                //设置该订单曾经已完成过
                order.setFinishSturts("1");
                //确认收货
                orderMService.comfirmOrder(order, (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID));
                //根据订单id和用户id修改 已与订单绑定的优惠券的状态为已领取
                orderCouponService.modifyCouponByOrderIdAndCustomerId(orderId,(Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID));
                List<OrderGoods> orderGoodsList = this.orderGoodsMapper.selectOrderGoodsList(orderId);
//                orderMapper.updateOrderStatusByorderIdFortask(order);
//                orderCouponService.modifyCouponByOrderId(orderId, (Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID));
                //订单通知
                OrderNotice record = new OrderNotice();
                record.setCustomerId((Long) request.getSession().getAttribute(CustomerConstants.CUSTOMERID));
                record.setOrderId(order.getOrderId());
                record.setNoticeTitle("您的订单已确认收货");
                if(orderGoodsList!=null &&orderGoodsList.size()>1){
                    for(OrderGoods orderGoods:orderGoodsList){
                        count+=orderGoods.getGoodsInfoNum();
                    }
                    record.setNoticeContent("您所购买的  "+orderGoodsList.get(0).getGoodsInfoName().substring(0,9)+"...  等"+count+"件商品已确认收货，欢迎再次购买！");
                }else{
                    record.setNoticeContent("您所购买的  "+orderGoodsList.get(0).getGoodsInfoName().substring(0,9)+"...  已确认收货，欢迎再次购买！");
                }
                //record.setNoticeContent("您的订单 " + order.getOrderCode() + " 已经确认收货，欢迎再次购买");
                record.setIsRead("0");
                this.orderNoticeService.addNotice(record);
               if("1".equals(flag)){
                   mav = new ModelAndView("redirect:/customer/detail-"+orderId+".html");
               }else{
                   mav = new ModelAndView("redirect:/customer/myorder.html");
               }
            } else {
                // 没登录的用户跳转到登录页面
                mav = new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
            }
            // 跳转订单页面
            return seoService.getCurrSeo(mav);
        } finally {
            mav = null;
        }
    }

    /**
     * 批量添加商品评论
     *
     * @param request
     *              请求
     * @return int
     */
    @RequestMapping("/addgoodscommentBatch")
    public ModelAndView addgoodscommentBatch(HttpServletRequest request) {
        String[] orderIds = request.getParameterValues("orderId");
        String[] customerId = request.getParameterValues("customerId");
        String[] goodsId = request.getParameterValues("goodsId");
        String[] goodsName = request.getParameterValues("goodsName");
        String[] isAnonymous = request.getParameterValues("isAnonymous");
        String[] orderGoodsId = request.getParameterValues("orderGoodsId");
        String[] commentContent = request.getParameterValues("commentContent");
        String[] commentScore = request.getParameterValues("commentScore");
        String[] imageNameslist = request.getParameterValues("imageNames");
        List<Map> list = new ArrayList<Map>();
        for (int i = 0; i < orderIds.length; i++) {
            Comment comment = new Comment();
            comment.setCustomerId(Long.valueOf(customerId[i]));
            comment.setGoodsId(Long.valueOf(goodsId[i]));
            comment.setGoodsName(goodsName[i]);
            comment.setIsAnonymous(isAnonymous[i]);
            comment.setOrderGoodsId(Long.valueOf(orderGoodsId[i]));
            comment.setCommentContent(commentContent[i]);
            comment.setCommentScore(BigDecimal.valueOf(Long.parseLong(commentScore[i])));
            Map map = new HashMap();
            map.put("comment",comment);
            map.put("orderId",orderIds[i]);
            map.put("imageNames",imageNameslist[i]);
            list.add(map);
        }
        //初始化f值
        int f =0;
        ModelAndView mav = null;
        //判断是否登陆
        if (LoginUtil.checkLoginStatus(request)) {
            //执行添加评论操作
            f =customerOrderService.addgoodscommentBatch(request, list);
            int count = customerOrderService.queryOrderCountC(null, "4", Long.valueOf(customerId[0]));
            if(f>0) {
                mav = new ModelAndView("/customer/order_comment").addObject("isContinue",count);
            }else{
                mav = new ModelAndView(new RedirectView("/comment-"+orderIds[0]+".html"));
            }
        }else{
            // 没登录的用户跳转到登录页面
            mav = new ModelAndView(CustomerConstants.REDIRECTLOGINTOINDEX);
        }
        return mav;
    }


    /**
     * 晒单时，上传图片文件
     *
     * @param fileRequest
     * @param resp
     * @param orderGoodsId
     *            订单-商品Id
     * @throws java.io.IOException
     */
    @RequestMapping("share/upload")
    @ResponseBody
    public String uploadShareImg(MultipartHttpServletRequest fileRequest, HttpServletResponse resp, Long orderGoodsId) throws IOException {
        MultipartFile multipartFile = fileRequest.getFile("shareFile");
        String name = multipartFile.getName();
        Map map = null;
        try {
            map = uploadImgJava.uploadForABCSize(multipartFile);
        }catch(Exception e){
            e.printStackTrace();
        }
        return  map == null ? "" : map.get("oldimg").toString();
    }

    /**
     * 检查文件扩展名是否为图片
     *
     * @param fileName
     *            上传的文件的文件名
     * @return
     */
    private boolean checkExtendsName(String fileName) {
        // 非空验证 文件拓展名
        if (null != fileName) {
            LOGGER.info("检查文件扩展名【" + fileName + "】是否为图片");
        }
        if (fileName.indexOf(".") < 0) {
            return false;
        }
        String extend = fileName.substring(fileName.lastIndexOf(".") + 1);
        String[] extendNames = { "jpg", "jpeg", "bmp", "png", "gif" };
        for (String extendName : extendNames) {
            if (extend.equals(extendName)) {
                return true;
            }
        }
        return false;
    }
}
